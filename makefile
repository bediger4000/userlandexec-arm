CC = gcc
CFLAGS = -I. -g -Wall -Wextra -std=gnu99 -nostdlib -fPIC

all: dyn_unmap_run hw env_test margs args2 elfauxv elfauxv_dynamic \
	example ulexec.so mycat

mycat: mycat.o libstatic/libstatic.h libstatic/crt.o libstatic/libstatic.a
	gcc -I. -g -std=gnu99 -nostdlib \
		libstatic/crt.o mycat.o -o mycat  -Llibstatic -lstatic
mycat.o: mycat.c
	gcc -fPIC -I. -g -Wall -std=gnu99 -nostdlib -c  mycat.c

stt: stt.o libstatic/libstatic.h libstatic/crt.o
	gcc -I. -g -std=gnu99 -nostdlib stt.o libstatic/crt.o  -Llibstatic -lstatic
stt.o: stt.c
	gcc -fPIC -I. -g -Wall -std=gnu99 -nostdlib -c  stt.c

oc: oc.c libstatic/libstatic.h libstatic/crt.o
	gcc -fPIC -I. -g -Wall -std=gnu99 -nostdlib -c  oc.c
	gcc -fPIC -I. -g -std=gnu99 -nostdlib \
		-o oc libstatic/crt.o oc.o   -Llibstatic -lstatic

dyn_unmap_run: dyn_unmap_run.c load_elf.o map_file.o stack_fix.o ulexec.h libstatic/libstatic.h libstatic/crt.o libstatic/libstatic.a
	gcc -I. -g -Wall -std=gnu99 -nostdlib -fPIC   -c  dyn_unmap_run.c
	gcc -I. -g -std=gnu99 -nostdlib \
		libstatic/crt.o dyn_unmap_run.o load_elf.o map_file.o stack_fix.o -o dyn_unmap_run -Llibstatic -lstatic

ulexec.so: ulexec.c load_elf.o map_file.o stack_fix.o ulexec.h  unmap.o \
		libstatic/libstatic.h libstatic/libstatic.a
	gcc -I. -g -Wall -std=gnu99 -nostdlib -fPIC   -c  ulexec.c
	gcc -fPIC -shared -I. -g -std=gnu99 -nostdlib \
		ulexec.o load_elf.o map_file.o unmap.o stack_fix.o -o ulexec.so -Llibstatic -lstatic

env_test: env_test.o libstatic/libstatic.a libstatic/crt.o
	gcc -g -I. -std=gnu99 -nostdlib -fPIC \
		libstatic/crt.o env_test.o -o env_test \
		-Llibstatic -lstatic
env_test.o: env_test.c
	gcc -g -I. -std=gnu99 -nostdlib -fPIC -c env_test.c

errno_set: errno_set.c set_errno.s
	cc -fPIC -g -Wall -Wextra -o errno_set errno_set.c set_errno.s

margs: margs.o libstatic/crt.o libstatic/libstatic.a
	gcc -g -I. -std=gnu99 -nostdlib -fPIC \
		libstatic/crt.o margs.o -o margs \
		-Llibstatic -lstatic
	chmod ugo-x margs
margs.o: margs.c
	gcc -g -I. -std=gnu99 -nostdlib -fPIC -c margs.c

hw: hw.c libstatic/libstatic.a libstatic/crt.o
	gcc -I. -g -Wall -std=gnu99 -nostdlib -fPIC   -c hw.c
	gcc -I. -g -std=gnu99 -nostdlib \
		libstatic/crt.o hw.o -o hw -Llibstatic -lstatic
	chmod ugo-x hw

elfauxv: elfauxv.o libstatic/libstatic.a libstatic/crt.o
	gcc -I. -g -std=gnu99 -nostdlib \
		libstatic/crt.o elfauxv.o -o elfauxv -Llibstatic -lstatic
	chmod ugo-x elfauxv
elfauxv.o: elfauxv.c
	gcc -I. -g -std=gnu99 -nostdlib -fPIC -c elfauxv.c

getaux: getaux.c
	gcc -fPIC -g -Wall -Wextra -o getaux getaux.c

args2: args2.c
	gcc -I. -g -Wall -Wextra -o args2 args2.c
	chmod ugo-x args2

example: example.c
	gcc -fPIC -I. -g -Wall -Wextra -o example example.c -ldl

elfauxv_dynamic: elfauxv_dynamic.c
	gcc -I. -g -Wall -Wextra -o elfauxv_dynamic elfauxv_dynamic.c
	chmod ugo-x elfauxv_dynamic

libstatic/libstatic.a:
	cd libstatic; make

libstatic/crt.o:
	cd libstatic; make

load_elf.o: load_elf.c ulexec.h libstatic/libstatic.h
map_file.o: map_file.c ulexec.h libstatic/libstatic.h
unmap.o: unmap.c ulexec.h libstatic/libstatic.h
places.o: places.c ulexec.h libstatic/libstatic.h
elfauxv.o: elfauxv.c ulexec.h libstatic/libstatic.h
stack_fix.o: stack_fix.c ulexec.h libstatic/libstatic.h

clean:
	-rm -rf *.o *.a *core 
	-rm -rf margs hw args2 env_test dyn_unmap_run mycat stt getaux
	-rm -rf elfauxv elfauxv_dynamic hw example ulexec.so errno_set
	cd libstatic; make clean
