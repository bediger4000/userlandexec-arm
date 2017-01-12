#include <stdio.h>

int
main(int ac, char **av, char **env)
{
	int i;

	printf("argc holds %d\n", ac);
	printf("argv holds %p\n", (void *)av);
	printf("env holds  %p\n", env);

	printf("\nEnvironment:\n");
	for (i = 0; env[i]; ++i)
	{
		printf("%p \"%s\"\n", env[i], env[i]);
	}
	return 0;
}
