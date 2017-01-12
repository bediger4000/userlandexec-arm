#include <libstatic.h>

int
file_size(char *filename)
{
	char sbuf[144];
	unsigned long ret;

	if (0 > (long)(ret = linux_stat(filename, (void *)&sbuf)))
	{
		print_string(2, "stat problem: ");
		print_long(2, errno);
		print_string(2, "\n");
	} else {
		ret = *(long *)(sbuf+20);
	}

	return ret;
}
