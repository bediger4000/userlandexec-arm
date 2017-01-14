CC = gcc
CFLAGS = -fPIC -nostdlib -I.

OBJS = linux_close.o linux_exit.o linux_open.o linux_read.o linux_write.o \
	linux_mmap.o linux_munmap.o linux_stat.o memcpy.o \
	print.o errno.o strtoul.o file_size.o string.o linux_mprotect.o \
	linux_brk.o idiv0.o

all: crt.o libstatic.a

libstatic.a: $(OBJS)
	ar rcs libstatic.a $(OBJS)

crt.o: crt.c
linux_close.o: linux_close.s
linux_exit.o: linux_exit.s
linux_open.o: linux_open.s
linux_read.o: linux_read.s
linux_write.o: linux_write.s
linux_stat.o: linux_stat.s
linux_brk.o: linux_brk.s
linux_mmap.o: linux_mmap.s
linux_mprotect.o: linux_mprotect.s
linux_munmap.o: linux_munmap.s
print.o: print.c libstatic.h
errno.o: errno.c libstatic.h
strtoul.o: strtoul.c libstatic.h
file_size.o: file_size.c libstatic.h
string.o: string.c libstatic.h
memcpy.o: memcpy.c libstatic.h
idiv0.o: idiv0.s

clean:
	-rm -rf *.o *.a *core
