#include <libstatic/libstatic.h>

int main(int ac, char **av, char **env);

void
c_main(int ac, char **av, char **env)
{
	int r = main(ac, av, env);
	linux_exit(r);
}

int
main(int ac, char **av, char **env)
{
	char buffer[32];
	int i;
/*
	if (env == NULL)
		linux_exit(1);
*/

	print_string(1, "argc holds ");
	print_long(1, ac);
	print_string(1, "\n");

	print_string(1, "argv holds ");
	to_hex((unsigned long)av, buffer);
	print_string(1, buffer);
	print_string(1, "\n");

	print_string(1, "env holds ");
	to_hex((unsigned long)env, buffer);
	print_string(1, buffer);
	print_string(1, "\n");

	print_string(1, "\nEnvironment:\n\t");
	for (i = 0; env[i]; ++i)
	{
		print_string(1, env[i]);
		print_string(1, "\n\t");
	}
	return 0;
}
