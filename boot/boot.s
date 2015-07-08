.set ALIGN, 1<<0	# set bit 0- alignment
.set MEMINFO, 1<<1	# set bit 1- memory information
.set FLAGS, ALIGN|MEMINFO
.set MAGIC, 0x1BADB002
.set CHECKSUM, -(MAGIC+FLAGS)
.set MB_HDR_ADDR, 0x101000
.set MB_LDR_ADDR, 0x100000

# Set the multiboot header
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# Setup the stack
.section .boot_stack
stack_bottom:
.skip 16384
stack_top:

.global start
.extern _gp

start:
	movl	$stack_top, %esp # mov the stack into the stack pointer register (32bit)
	mov	0x44, %eax
	push	%ebx
	#call	kmain # run the kernel code

	# here we have returned from kernel_main
hang:
	hlt
	jmp	hang

.global gdt_reload

gdt_reload:
	cli
	lgdt	_gp			# reload the gdt pointer
	ljmp 	$0x08,$gdt_rld_seg	# far jump to [codeseg:gdt_rld_seg]

gdt_rld_seg:
	mov	$0x10, %ax		# we reload the segments here
	mov	%eax, %ds
	mov	%eax, %es
	mov	%eax, %fs
	mov	%eax, %gs
	mov	%eax, %ss
	ret
