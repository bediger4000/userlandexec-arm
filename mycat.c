#include <libstatic/libstatic.h>
#define BUFSIZ 1024
void
c_main(int ac, char **av, char **envp)
{
	int fd = linux_open(av[1], 0, 0);
	int cc;
	char buf[BUFSIZ];
	if (fd < 0) {
		print_string(1, "open() failed: ");
		print_long(1, errno);
		print_string(1, "\n");
		linux_exit(1);
	}
	errno = 0;
	while (0 < (cc = linux_read(fd, buf, sizeof(buf))))
		if (0 > linux_write(1, buf, cc)) {
			print_string(1, "write() failed: ");
			print_long(1, errno);
			print_string(1, "\n");
			linux_exit(1);
		}
	if (cc < 0) {
		print_string(1, "read() failed: ");
		print_long(1, errno);
		print_string(1, "\n");
		linux_exit(1);
	}
	linux_close(fd);
	linux_exit(0);
}
