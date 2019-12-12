#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <stdio.h>
#include "kann.h"
#include "kann_data.h"

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
#define NUM_TEST_IMAGES 100	//10
#endif

static kann_t *model_gen(int n_in, int n_out, int loss_type, int n_h_layers, int n_h_neurons, float h_dropout)
{
	int i;
	kad_node_t *t;
	t = kann_layer_input(n_in);
	for (i = 0; i < n_h_layers; ++i)
		t = kann_layer_dropout(kad_relu(kann_layer_dense(t, n_h_neurons)), h_dropout);
	return kann_new(kann_layer_cost(t, n_out, loss_type), 0);
}

int main(int argc, char *argv[])
{
	int max_epoch = 50, mini_size = 64, max_drop_streak = 10, loss_type = KANN_C_CEB;
	int i, j, c, n_h_neurons = 64, n_h_layers = 1, seed = 11, n_threads = 1;
	kann_data_t *in = 0;
	kann_t *ann = 0;
	char *out_fn = 0, *in_fn = 0;
	float lr = 0.001f, frac_val = 0.1f, h_dropout = 0.0f;

#if ECE695R
	char *test_images = "/mnt/rozipfs/mnist-test-100.knd";
	in_fn = "/mnt/rozipfs/mnist-mlp.kan";

	alt_up_pixel_buffer_dma_dev *pb = alt_up_pixel_buffer_dma_open_dev("/dev/video_pixel_buffer_dma_0");
	alt_up_char_buffer_dev* cb = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma_0");
	alt_up_pixel_buffer_dma_clear_screen(pb, 0);
	alt_up_char_buffer_clear(cb);

#else
	while ((c = getopt(argc, argv, "n:l:s:r:m:B:o:i:d:v:Mt:")) >= 0) {
		if (c == 'n') n_h_neurons = atoi(optarg);
		else if (c == 'l') n_h_layers = atoi(optarg);
		else if (c == 's') seed = atoi(optarg);
		else if (c == 'i') in_fn = optarg;
		else if (c == 'o') out_fn = optarg;
		else if (c == 'r') lr = atof(optarg);
		else if (c == 'm') max_epoch = atoi(optarg);
		else if (c == 'B') mini_size = atoi(optarg);
		else if (c == 'd') h_dropout = atof(optarg);
		else if (c == 'v') frac_val = atof(optarg);
		else if (c == 'M') loss_type = KANN_C_CEM;
		else if (c == 't') n_threads = atoi(optarg);
	}
	if (argc - optind < 1) {
		FILE *fp = stdout;
		fprintf(fp, "Usage: mlp [options] <in.knd> [truth.knd]\n");
		fprintf(fp, "Options:\n");
		fprintf(fp, "  Model construction:\n");
		fprintf(fp, "    -i FILE     read trained model from FILE []\n");
		fprintf(fp, "    -o FILE     save trained model to FILE []\n");
		fprintf(fp, "    -s INT      random seed [%d]\n", seed);
		fprintf(fp, "    -l INT      number of hidden layers [%d]\n", n_h_layers);
		fprintf(fp, "    -n INT      number of hidden neurons per layer [%d]\n", n_h_neurons);
		fprintf(fp, "    -d FLOAT    dropout at the hidden layer(s) [%g]\n", h_dropout);
		fprintf(fp, "    -M          use multi-class cross-entropy (binary by default)\n");
		fprintf(fp, "  Model training:\n");
		fprintf(fp, "    -r FLOAT    learning rate [%g]\n", lr);
		fprintf(fp, "    -m INT      max number of epochs [%d]\n", max_epoch);
		fprintf(fp, "    -B INT      mini-batch size [%d]\n", mini_size);
		fprintf(fp, "    -v FLOAT    fraction of data used for validation [%g]\n", frac_val);
		fprintf(fp, "    -t INT      number of threads [%d]\n", n_threads);
		return 1;
	}
	
	if (argc - optind == 1 && in_fn == 0) {
		fprintf(stderr, "ERROR: please specify a trained model with option '-i'.\n");
		return 1;
	}
#endif

	kad_trap_fe();
	kann_srand(seed);
	if (in_fn) {
		printf("[INFO] Loading model from %s...\n", in_fn);
		ann = kann_load(in_fn);
		assert(kann_dim_in(ann) == 28 * 28);
	}
#if ECE695R
	printf("[INFO] Loading test images from %s...\n", test_images);
	in = kann_data_read(test_images); // kann_data_t x;
	assert(in->n_col == 28 * 28);
#endif

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
			if (image_index >= in->n_row) break;
			float *image = in->x[image_index];
			alt_up_char_buffer_draw(cb, in->rname[image_index][strlen(in->rname[image_index])-1],
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

	if (0) { // train
		kann_data_t *out;
		out = kann_data_read(argv[optind+1]);
		assert(in->n_row == out->n_row);
		if (ann) assert(kann_dim_out(ann) == out->n_col);
		else ann = model_gen(in->n_col, out->n_col, loss_type, n_h_layers, n_h_neurons, h_dropout);
		if (n_threads > 1) kann_mt(ann, n_threads, mini_size);
		kann_train_fnn1(ann, lr, mini_size, max_epoch, max_drop_streak, frac_val, in->n_row, in->x, out->x);
		if (out_fn) kann_save(out_fn, ann);
		kann_data_free(out);
	} else { // apply
		int num_correct_classifications = 0;
		int n_out;
		kann_switch(ann, 0);
		n_out = kann_dim_out(ann);

		int number_of_images_to_process = (NUM_TEST_IMAGES < in->n_row)? NUM_TEST_IMAGES : in->n_row;
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
				y = kann_apply1(ann, in->x[image_index]); // in->x[i]: each image as an array of float
				int golden = in->rname[image_index][strlen(in->rname[image_index])-1] - '0'; // golden label parsed from in->rname[i]
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
			y = kann_apply1(ann, in->x[i]); // in->x[i]: each image as an array of float
			int golden = in->rname[i][strlen(in->rname[i])-1] - '0'; // golden label parsed from in->rname[i]
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

#if ECE695R_USE_PERFORMANCE_COUNTER
		PERF_END(alt_get_performance_counter_base(), PERF_REGION_INFERENCE);
#endif
		printf("[RESULT] %d out of %d images (%0.2f%%) classified correctly\n", num_correct_classifications, number_of_images_to_process, (float) num_correct_classifications / (float) number_of_images_to_process * 100.0f);

#if ECE695R_USE_PERFORMANCE_COUNTER
		PERF_STOP_MEASURING(alt_get_performance_counter_base());
		perf_print_formatted_report(alt_get_performance_counter_base(), alt_get_cpu_freq(), 1, "inference - Software");
#endif
	}

	kann_delete(ann);
	kann_data_free(in);
	return 0;
}
