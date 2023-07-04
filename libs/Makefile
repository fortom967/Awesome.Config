DEPS = glib-2.0
FLAGS = $(shell pkg-config --libs --cflags $(DEPS))

all:
	$(CC) src/*.c $(FLAGS) -fPIC -shared -o lib.so
