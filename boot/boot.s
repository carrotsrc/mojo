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

.global __pp_gdt
.global start

start:
	lgdt __pp_gdt
	ljmp $0x08, $start_hi
	
start_hi:
	mov	$0x10, %eax		# we reload the segments here
	mov	%eax, %ds
	mov	%eax, %es
	mov	%eax, %fs
	mov	%eax, %gs
	mov	%eax, %ss

	movl	$stack_top, %esp # mov the stack into the stack pointer register (32bit)
	mov	0x44, %eax
	push	%ebx
	call	kmain # run the kernel code

	# here we have returned from kernel_main
hang:
	hlt
	jmp	hang

# Raw global descriptor table
.section .ppinit

__pp_gdt:
	.short __pp_gdt_end - __pp_gdt_gates -1
	.long __pp_gdt_gates

__pp_gdt_gates:
	.byte 0x00, 0x00	# limit
	.byte 0x00, 0x00	# base lo
	.byte 0x00		# base mid
	.byte 0x00		# access
	.byte 0x00		# granularity
	.byte 0x00		# base hi

	.byte 0xFF, 0xFF	# limit
	.byte 0x00, 0x00	# base lo
	.byte 0x00		# base mid
	.byte 0x9a		# access
	.byte 0xcf		# granularity
	.byte 0x40		# base hi

	.byte 0xFF, 0xFF	# limit
	.byte 0x00, 0x00	# base lo
	.byte 0x00		# base mid
	.byte 0x92		# access
	.byte 0xcf		# granularity
	.byte 0x40		# base hi
__pp_gdt_end:
