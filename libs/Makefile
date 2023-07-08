DEPS = glib-2.0 lua libnl-route-3.0 libnl-3.0 pam
FLAGS = $(shell pkg-config --libs --cflags $(DEPS))

all:
	$(CC) src/*.c $(FLAGS) -fPIC -shared -o lib.so -ggdb
