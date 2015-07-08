ARCH=i586-elf
TOOLCHAIN_DIR=~/development/xgcc/bin
TARGET=bin/mojo.bin

TOOLCHAIN_AS=${TOOLCHAIN_DIR}/${ARCH}-as
TOOLCHAIN_CC=${TOOLCHAIN_DIR}/${ARCH}-gcc
TOOLCHAIN_LD=${TOOLCHAIN_DIR}/${ARCH}-ld

CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra -Iinclude
LDFLAGS=-ffreestanding -O3 -nostdlib -lgcc
LDSCRIPT=config/linker.ld

ODIR=bin/obj

CC=${TOOLCHAIN_CC} ${CFLAGS}
AS=${TOOLCHAIN_AS}
LD=${TOOLCHAIN_LD} ${CFLAGS LDFLAGS}

OFILES=${ODIR}/boot.o ${ODIR}/gdt.o ${ODIR}/kentry.o

boot.o:
	${AS} boot/boot.s -o ${ODIR}/boot.o

gdt.o:
	${CC} -c kernel/init/gdt.c -o ${ODIR}/gdt.o

kentry.o: boot.o gdt.o
	${CC} -c kernel/kentry.c -o ${ODIR}/kentry.o
	
all: boot.o kentry.o
	${CC} ${LDFLAGS} -T ${LDSCRIPT} $(OFILES) -o ${TARGET}
	
clean:
	rm -rf ${ODIR}/*
	rm -f ${TARGET}
