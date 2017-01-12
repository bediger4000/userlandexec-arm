#include <stdio.h>
#include <elf.h>
#include <sys/auxv.h>

char *printable_aux_type(long a_val);

/* There are all the types of aux vector elements in the getauxval(3)
 * man page 2017-01-10. Other types exist, according to elf.h */
int types[] = {
	AT_BASE, AT_CLKTCK, AT_DCACHEBSIZE, AT_EGID, AT_ENTRY, AT_EXECFD, AT_EXECFN,
	AT_GID, AT_HWCAP, AT_HWCAP2, AT_ICACHEBSIZE, AT_PAGESZ, AT_PHDR,
	AT_PHENT, AT_PHNUM, AT_RANDOM, AT_SECURE, AT_SYSINFO, AT_SYSINFO_EHDR,
	AT_UCACHEBSIZE, AT_UID

};

int
main(int ac, char **av)
{
	int N = sizeof(types)/sizeof(types[0]);
	int i;

	printf("ELF auxilliary vector\n");

	for (i = 0; i < N; ++i)
	{
		unsigned long val = getauxval(types[i]);
		if (0 != val)
		{
			printf("%d\t%s\t0x%lx\t%ld\n", i, printable_aux_type(types[i]), val, val);
			switch (types[i])
			{
			case AT_EXECFN:
			case AT_BASE_PLATFORM:
			case AT_PLATFORM:
				printf("\t\"%s\"\n", (char *)val);
				break;
			default:
				break;
			}
		}
	}
	
	return 0;
}

char *
printable_aux_type(long a_val)
{
	char *r = "Unknown";
	switch (a_val)
	{
	case AT_NULL:      r = "End of vector"; break;
	case AT_IGNORE:      r = "Entry should be ignored"; break;
	case AT_EXECFD:      r = "File descriptor of program"; break;
	case AT_PHDR:      r = "Program headers for program"; break;
	case AT_PHENT:      r = "Size of program header entry"; break;
	case AT_PHNUM:      r = "Number of program headers"; break;
	case AT_PAGESZ:      r = "System page size"; break;
	case AT_BASE:      r = "Base address of interpreter"; break;
	case AT_FLAGS:      r = "Flags"; break;
	case AT_ENTRY:      r = "Entry point of program"; break;
	case AT_NOTELF:     r = "Program is not ELF"; break;
	case AT_UID:     r = "Real uid"; break;
	case AT_EUID:     r = "Effective uid"; break;
	case AT_GID:     r = "Real gid"; break;
	case AT_EGID:     r = "Effective gid"; break;
	case AT_CLKTCK:     r = "Frequency of times()"; break;
	case AT_PLATFORM:     r = "String identifying platform. "; break;
	case AT_HWCAP:     r = "Machine dependent hints about processor capabilities. "; break;
	case AT_FPUCW:     r = "Used FPU control word. "; break;
	case AT_DCACHEBSIZE:     r = "Data cache block size. "; break;
	case AT_ICACHEBSIZE:     r = "Instruction cache block size. "; break;
	case AT_UCACHEBSIZE:     r = "Unified cache block size. "; break;
	case AT_IGNOREPPC:     r = "Entry should be ignored. "; break;
	case AT_SECURE:     r = "Boolean, was exec setuid-like? "; break;
/* The following ifdefs exist because apparently glibc starting
 * defining new auxillary types */
#ifdef AT_BASE_PLATFORM
	case AT_BASE_PLATFORM:    r= "String identifying real platforms."; break;
#endif
#ifdef AT_RANDOM
	case AT_RANDOM:     r = "Address of 16 random bytes. "; break;
#endif
#ifdef AT_EXECFN
	case AT_EXECFN:     r = "Filename of executable. "; break;
#endif
	case AT_SYSINFO:    r = "Address of VDSO"; break;
	case AT_SYSINFO_EHDR:  r = "Adress of vDSO"; break;
#ifdef AT_L1I_CACHESHAPE
	case AT_L1I_CACHESHAPE: r = "AT_L1I_CACHESHAPE"; break;
	case AT_L1D_CACHESHAPE: r = "AT_L1D_CACHESHAPE"; break;
	case AT_L2_CACHESHAPE:  r = "AT_L2_CACHESHAPE"; break;
	case AT_L3_CACHESHAPE:  r = "AT_L3_CACHESHAPE"; break;
#endif
	}
	return r;
}
