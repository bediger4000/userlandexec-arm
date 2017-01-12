#include <libstatic/libstatic.h>
int fsz(char *filename);

int
c_main(int ac, char **av)
{
	char buf[256];
	unsigned long fs = file_size(av[1]);
	print_long(1, fs);
	print_string(1, "\n");
	to_hex(fs, buf);
	print_string(1, "0x");
	print_string(1, buf);
	print_string(1, "\n");
	linux_exit(0);
	return 0;
}
int
fsz(char *filename)
{
	char sbuf[144];
	int ret;

	if (0 > (ret = linux_stat(filename, (void *)&sbuf)))
	{
		print_string(2, "stat problem: ");
		print_long(2, errno);
		print_string(2, "\n");
	} else {
		int i;
		for (i = 0; i < 88; ++i) {
			print_hex(1, sbuf[i]);
			print_string(1, "\n");
		}
		ret = *((long int *)(&sbuf[20]));
	}

	return ret;
}
