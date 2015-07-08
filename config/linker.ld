OUTPUT_FORMAT("elf32-i386")
ENTRY(start)

SECTIONS
{
	. = 0x100000; /* start at 1MB */

	_kspace_saddr = .;
	
	.text BLOCK(4K):
	{
		*(.multiboot) 	/* add the multiboot header */
		*(.text)
	}

	.rodata BLOCK(4K):
	{
		*(.rodata)		/* read only data */
					/* eg. strings */
	}

	.data BLOCK(4K): /* initialized data */
	{
		*(.data)
	}

	.bss BLOCK(4K): /* uninitialized data */
	{
		*(COMMON)
		*(.bss)		/* labels, globs */
		*(.comment)
		*(.boot_stack)
	}


	_kspace_eaddr = .;
}
