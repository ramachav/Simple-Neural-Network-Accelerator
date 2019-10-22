#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
#include "kann_data.h"
#include "kann.h"
#define ECE695R 1

#if ECE695R
#include "io.h"
#include "altera_avalon_performance_counter.h"
#include "altera_up_avalon_video_pixel_buffer_dma.h"
#include "altera_up_avalon_video_character_buffer_with_dma.h"
#define USE_VGA_DISPLAY 1
#define ECE695R_USE_PERFORMANCE_COUNTER 1
#if ECE695R_USE_PERFORMANCE_COUNTER
#define PERF_REGION_INFERENCE 1
#endif
#define NUM_TEST_IMAGES 100
#endif

int main(int argc, char *argv[])
{
	kann_t *ann;
	kann_data_t *x, *y;
	char *fn_in = 0, *fn_out = 0;
	int c, mini_size = 64, max_epoch = 20, max_drop_streak = 10, seed = 131, n_h_fc = 128, n_h_flt = 32, n_threads = 1;
	float lr = 0.001f, dropout = 0.2f, frac_val = 0.1f;

#if ECE695R
	char *test_images = "/mnt/rozipfs/mnist-test-100.knd";
	fn_in = "/mnt/rozipfs/mnist-cnn.kan";

	alt_up_pixel_buffer_dma_dev *pb = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");
	alt_up_char_buffer_dev* cb = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma_0");
	alt_up_pixel_buffer_dma_clear_screen(pb, 0);
	alt_up_char_buffer_clear(cb);
#else
	while ((c = getopt(argc, argv, "i:o:m:h:f:d:s:t:v:")) >= 0) {
		if (c == 'i') fn_in = optarg;
		else if (c == 'o') fn_out = optarg;
		else if (c == 'm') max_epoch = atoi(optarg);
		else if (c == 'h') n_h_fc = atoi(optarg);
		else if (c == 'f') n_h_flt = atoi(optarg);
		else if (c == 'd') dropout = atof(optarg);
		else if (c == 's') seed = atoi(optarg);
		else if (c == 't') n_threads = atoi(optarg);
		else if (c == 'v') frac_val = atof(optarg);
	}

	if (argc - optind == 0 || (argc - optind == 1 && fn_in == 0)) {
		FILE *fp = stdout;
		fprintf(fp, "Usage: mnist-cnn [-i model] [-o model] [-t nThreads] <x.knd> [y.knd]\n");
		return 1;
	}
#endif

	kad_trap_fe();
	kann_srand(seed);
	if (fn_in) {
		printf("[INFO] Loading model from %s...\n", fn_in);
		ann = kann_load(fn_in);
	} else {
		kad_node_t *t;
		t = kad_feed(4, 1, 1, 28, 28), t->ext_flag |= KANN_F_IN;
		t = kad_relu(kann_layer_conv2d(t, n_h_flt, 3, 3, 1, 1, 0, 0)); // 3x3 kernel; 1x1 stride; 0x0 padding
		t = kad_relu(kann_layer_conv2d(t, n_h_flt, 3, 3, 1, 1, 0, 0));
		t = kad_max2d(t, 2, 2, 2, 2, 0, 0); // 2x2 kernel; 2x2 stride; 0x0 padding
		t = kann_layer_dropout(t, dropout);
		t = kann_layer_dense(t, n_h_fc);
		t = kad_relu(t);
		t = kann_layer_dropout(t, dropout);
		ann = kann_new(kann_layer_cost(t, 10, KANN_C_CEB), 0);
	}

#if ECE695R
	printf("[INFO] Loading test images from %s...\n", test_images);
	x = kann_data_read(test_images); // kann_data_t x;
	assert(x->n_col == 28 * 28);
	y = 0; // force-run inference

#if USE_VGA_DISPLAY
	unsigned short *pixel_buffer = (unsigned short*) pb->buffer_start_address;
	int pixel_buffer_index, image_row, image_col, row, col;
	int box_width = 64;
	int box_height = 48;
	int images_per_row = 640 / box_width;
	int images_per_col = 480 / box_height;
	for (image_col = 0; image_col < images_per_col; image_col++) {
		for (image_row = 0; image_row < images_per_row; image_row++) {
			int image_index = (image_col * images_per_row) + image_row;
			if (image_index >= x->n_row) break;
			float *image = x->x[image_index];
			alt_up_char_buffer_draw(cb, x->rname[image_index][strlen(x->rname[image_index])-1],
					((image_row * box_width + 28) >> 3), ((image_col * box_height) >> 3));
			pixel_buffer_index = (image_col * box_height * 640) + (image_row * box_width);
			for (row = 0; row < 28; row++) {
				for (col = 0; col < 28; col++) {
					int pixel_index = (row * 28) + col;
					unsigned int pixel_grayscale = (unsigned int) (image[pixel_index] * 255.0f);
					unsigned short pixel_rgb565 = ((pixel_grayscale & 0xF8) << 11) | ((pixel_grayscale & 0xFC) << 5) | (pixel_grayscale & 0xF8);
					IOWR_16DIRECT(pixel_buffer, pixel_buffer_index << 1, pixel_rgb565);
					pixel_buffer_index++;
				}
				pixel_buffer_index += (640 - 28);
			}
		}
	}
#endif

#else
	x = kann_data_read(argv[optind]); // kann_data_t x;
	assert(x->n_col == 28 * 28);
	y = argc - optind >= 2? kann_data_read(argv[optind+1]) : 0;
#endif

	if (y) { // training
		assert(y->n_col == 10);
		if (n_threads > 1) kann_mt(ann, n_threads, mini_size);
		kann_train_fnn1(ann, lr, mini_size, max_epoch, max_drop_streak, frac_val, x->n_row, x->x, y->x);
		if (fn_out) kann_save(fn_out, ann);
		kann_data_free(y);
	} else { // inference
		int i, j, n_out;
		int num_correct_classifications = 0;
		kann_switch(ann, 0);
		n_out = kann_dim_out(ann); // n_out: num_classes (0-9)
		assert(n_out == 10);

#if ECE695R
		int number_of_images_to_process = (NUM_TEST_IMAGES < x->n_row)? NUM_TEST_IMAGES : x->n_row;
#if USE_VGA_DISPLAY
		int number_of_images_on_screen = images_per_row * images_per_col;
		number_of_images_to_process = (number_of_images_to_process < number_of_images_on_screen)? number_of_images_to_process : number_of_images_on_screen;
#endif
		printf("[INFO] Starting classification of %d test images...\n", number_of_images_to_process);

#if ECE695R_USE_PERFORMANCE_COUNTER
		PERF_RESET(alt_get_performance_counter_base());
		PERF_START_MEASURING(alt_get_performance_counter_base());
		PERF_BEGIN(alt_get_performance_counter_base(), PERF_REGION_INFERENCE);
#endif

#if USE_VGA_DISPLAY
		for (image_col = 0; image_col < images_per_col; image_col++) {
			for (image_row = 0; image_row < images_per_row; image_row++) {
				const float *y;
				int image_index = (image_col * images_per_row) + image_row;
				if (number_of_images_to_process <= image_index) break;
				y = kann_apply1(ann, x->x[image_index]); // x->x[i]: each image as an array of float
				int golden = x->rname[image_index][strlen(x->rname[image_index])-1] - '0'; // golden label parsed from x->rname[i]
				int inferred = 0; // class which has the max score
				float max = y[0];
				for (j = 1; j < n_out; j++) {
					if (y[j] > max) {
						inferred = j;
						max = y[j];
					}
				}
				if (golden == inferred) num_correct_classifications++;
				printf("[INFO] Image[%d] classified as %d (should be %d)\n", image_index, inferred, golden);
				alt_up_char_buffer_draw(cb, inferred + '0', ((image_row * box_width + 28) >> 3), ((image_col * box_height) >> 3) + 2);
			}
		}
#else
		for (i = 0; i < number_of_images_to_process; i++) {
			const float *y;
			y = kann_apply1(ann, x->x[i]); // x->x[i]: each image as an array of float
			int golden = x->rname[i][strlen(x->rname[i])-1] - '0'; // golden label parsed from x->rname[i]
			int inferred = 0; // class which has the max score
			float max = y[0];
			for (j = 1; j < n_out; j++) {
				if (y[j] > max) {
					inferred = j;
					max = y[j];
				}
			}
			if (golden == inferred) num_correct_classifications++;
			printf("[INFO] Image[%d] classified as %d (should be %d)\n", i, inferred, golden);
		}
#endif

#else
		for (i = 0; i < x->n_row; ++i) {
			const float *y;
			y = kann_apply1(ann, x->x[i]);
			if (x->rname) printf("%s\t", x->rname[i]);
			for (j = 0; j < n_out; ++j) {
				if (j) putchar('\t');
				printf("%.3g", y[j] + 1.0f - 1.0f);
			}
			putchar('\n');
		}
#endif
#if ECE695R_USE_PERFORMANCE_COUNTER
		PERF_END(alt_get_performance_counter_base(), PERF_REGION_INFERENCE);
#endif
		printf("[RESULT] %d out of %d images (%0.2f%%) classified correctly\n", num_correct_classifications, number_of_images_to_process, (float) num_correct_classifications / (float) number_of_images_to_process * 100.0f);

#if ECE695R_USE_PERFORMANCE_COUNTER
		PERF_STOP_MEASURING(alt_get_performance_counter_base());
		perf_print_formatted_report(alt_get_performance_counter_base(), alt_get_cpu_freq(), 2, "inference", "display");
#endif
	}

	kann_data_free(x);
	kann_delete(ann);
	return 0;
}
