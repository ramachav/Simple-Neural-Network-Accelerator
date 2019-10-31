CC=			gcc
CFLAGS=		-g -Wall -Wextra -Wc++-compat -O2 -pg
CFLAGS_LIB=	#-ansi -pedantic -Wno-long-long # ANSI C does not have inline which affects performance a little bit
CPPFLAGS=	-DHAVE_PTHREAD
INCLUDES=	-I.
EXE=		examples/mlp examples/mnist-cnn examples/inspect examples/textgen examples/rnn-bit \
			examples/ae examples/vae
LIBS=		-lpthread -lz -lm

PROFS=		mlp_prof ae_prof vae_prof textgen_prof rnn-bit_prof inspect_prof mnist-cnn_prof
NEEDEDPROFS=	mlp_prof mnist-cnn_prof
ifdef CBLAS
	CPPFLAGS+=-DHAVE_CBLAS
	INCLUDES+=-I$(CBLAS)/include
	LIBS=-fopenmp -pthread -L$(CBLAS)/lib -lopenblas -lz -lm
endif

.SUFFIXES:.c .o
.PHONY:all clean depend

.c.o:
		$(CC) -c $(CFLAGS) $(INCLUDES) $(CPPFLAGS) $< -o $@

all:kautodiff.o kann.o kann_extra/kann_data.o $(EXE)

all_prof: $(PROFS)

relevant_prof: $(NEEDEDPROFS)

kautodiff.o:kautodiff.c
		$(CC) -c $(CFLAGS) $(CFLAGS_LIB) $(INCLUDES) $(CPPFLAGS) -o $@ $<

kann.o:kann.c
		$(CC) -c $(CFLAGS) $(CFLAGS_LIB) $(INCLUDES) $(CPPFLAGS) -o $@ $<

kann_extra/kann_data.o:kann_extra/kann_data.c
		$(CC) -c $(CFLAGS) -DHAVE_ZLIB $< -o $@

examples/mlp:examples/mlp.o kautodiff.o kann.o kann_extra/kann_data.o
		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

examples/ae:examples/ae.o kautodiff.o kann.o kann_extra/kann_data.o
		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

examples/vae:examples/vae.o kautodiff.o kann.o kann_extra/kann_data.o
		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

examples/textgen:examples/textgen.o kautodiff.o kann.o
		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

examples/rnn-bit:examples/rnn-bit.o kautodiff.o kann.o
		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

examples/inspect:examples/inspect.o kautodiff.o kann.o
		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

examples/mnist-cnn:examples/mnist-cnn.o kautodiff.o kann.o kann_extra/kann_data.o
		$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

mlp_prof:
		mkdir mlp_profiling
		./examples/mlp -i trained_models/mnist-mlp.kan trained_models/mnist-test-100.knd > mlp_profiling/mnist-mlp.txt
		mv gmon.out mlp_profiling/
		gprof examples/mlp mlp_profiling/gmon.out > mlp_profiling/mlp_profile.txt 
		cp mlp_profiling/mlp_profile.txt ../../Profiling-Reports/mlp_profile.txt

ae_prof: 
		mkdir ae_profiling
		./examples/ae -i trained_models/mnist-cnn.kan trained_models/mnist-test-100.knd > ae_profiling/ae.txt 
		mv gmon.out ae_profiling/
		gprof examples/ae ae_profiling/gmon.out > ae_profiling/ae_profile.txt
		cp ae_profiling/ae_profile.txt ../../Profiling-Reports/ae_profile.txt

vae_prof:
		mkdir vae_profiling
		./examples/vae -i trained_models/mnist-cnn.kan trained_models/mnist-test-100.knd > vae_profiling/vae.txt 
		mv gmon.out vae_profiling/
		gprof examples/vae vae_profiling/gmon.out > vae_profiling/vae_profile.txt
		cp vae_profiling/vae_profile.txt ../../Profiling-Reports/vae_profile.txt

textgen_prof:
		mkdir textgen_profiling
		./examples/textgen -i trained_models/mnist-cnn.kan trained_models/mnist-test-100.knd > textgen_profiling/textgen.txt 
		mv gmon.out textgen_profiling/
		gprof examples/textgen textgen_profiling/gmon.out > textgen_profiling/textgen_profile.txt
		cp textgen_profiling/textgen_profile.txt ../../Profiling-Reports/textgen_profile.txt

rnn-bit_prof:
		mkdir rnn-bit_profiling
		./examples/rnn-bit -i trained_models/mnist-cnn.kan trained_models/mnist-test-100.knd > rnn-bit_profiling/rnn-bit.txt 
		mv gmon.out rnn-bit_profiling/
		gprof examples/rnn-bit rnn-bit_profiling/gmon.out > rnn-bit_profiling/rnn-bit_profile.txt
		cp rnn-bit_profiling/rnn-bit_profile.txt ../../Profiling-Reports/rnn-bit_profile.txt

inspect_prof:
		mkdir inspect_profiling
		./examples/inspect -i trained_models/mnist-cnn.kan trained_models/mnist-test-100.knd > inspect_profiling/inspect.txt 
		mv gmon.out inspect_profiling/
		gprof examples/inspect inspect_profiling/gmon.out > inspect_profiling/inspect_profile.txt
		cp inspect_profiling/inspect_profile.txt ../../Profiling-Reports/inspect_profile.txt

mnist-cnn_prof:
		mkdir mnist-cnn_profiling
		./examples/mnist-cnn -i trained_models/mnist-cnn.kan trained_models/mnist-test-100.knd > mnist-cnn_profiling/mnist-cnn.txt 
		mv gmon.out mnist-cnn_profiling/
		gprof examples/mnist-cnn mnist-cnn_profiling/gmon.out > mnist-cnn_profiling/mnist-cnn_profile.txt
		cp mnist-cnn_profiling/mnist-cnn_profile.txt ../../Profiling-Reports/mnist-cnn_profile.txt

clean:
		rm -fr *.o */*.o a.out */a.out *.a *.dSYM */*.dSYM $(EXE) 
		rm -rf mlp_profiling ae_profiling vae_profiling textgen_profiling rnn-bit_profiling inspect_profiling mnist-cnn_profiling

depend:
		(LC_ALL=C; export LC_ALL; makedepend -Y -- $(CFLAGS) $(DFLAGS) -- *.c kann_extra/*.c examples/*.c)

# DO NOT DELETE

kann.o: kann.h kautodiff.h
kautodiff.o: kautodiff.h
kann_extra/kann_data.o: kann_extra/kseq.h kann_extra/kann_data.h
examples/ae.o: kann.h kautodiff.h kann_extra/kann_data.h
examples/inspect.o: kann.h kautodiff.h
examples/mlp.o: kann.h kautodiff.h kann_extra/kann_data.h
examples/mnist-cnn.o: kann_extra/kann_data.h kann.h kautodiff.h
examples/rnn-bit.o: kann.h kautodiff.h
examples/textgen.o: kann.h kautodiff.h
examples/vae.o: kann.h kautodiff.h kann_extra/kann_data.h
