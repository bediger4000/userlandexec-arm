#include <stdio.h>
#include <stdlib.h>

extern int set_errno(int value);

int errno;

int
main(int ac, char **av, char **envp)
{
	int cc, v = atoi(av[1]);
	char **p = av;
	
	printf("errno at %p\n", (void *)&errno);
	printf("errno holds %d\n", errno);
	printf("setting errno to %d\n", v);
	cc = set_errno(v);
	printf("set_errno(%d) returns %d\n", cc, cc);
	printf("errno now holds %d\n", errno);
	for (; *p != NULL; ++p) {
		printf("%s\n", *p);
	}
	return 0;
}
