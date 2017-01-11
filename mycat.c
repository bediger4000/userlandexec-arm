#include <libstatic/libstatic.h>
#define BUFSIZ 1024
void
c_main(int ac, char **av, char **envp)
{
	int fd = linux_open(av[1], 0, 0);
	int cc;
	char buf[BUFSIZ];
	if (fd < 0) {
		linux_exit(1);
	}
	while (0 < (cc = linux_read(fd, buf, sizeof(buf))))
		linux_write(1, buf, cc);
	linux_close(fd);
	linux_exit(0);
}
