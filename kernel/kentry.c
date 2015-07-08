#include "init/gdt.h"

int kmain() {
	// The entry point for the kernel
	gdt_init();
	return 0;
}
