#include <libstatic/libstatic.h>

extern long errno;

int
c_main(int ac, char **av)
{
	int fd;
	errno = 0;
	fd = linux_open(av[1], 0, 0);
	if (0 > fd) {
		print_string(1, "Failed to open ");
		print_string(1, av[1]);
		print_string(1, ", errno = ");
		print_long(1, errno);
		print_string(1, "\n");
		print_string(1, "fd = ");
		print_long(1, fd);
		print_string(1, "\n");
	} else {
		print_string(1, "Successful open()\n");
		linux_close(fd);
	}
	linux_exit(0);
	return 0;
}
