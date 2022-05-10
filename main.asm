[org 0x7c00]
[bits 16]

section .text
	global main

main:
cli
jmp 0x0000:ZeroSeg
ZeroSeg:
	xor ax, ax
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov sp, main
  cld
sti

push ax
xor ax, ax
int 0x13
pop ax

mov al, 1
mov cl, 2
mov dx, [0x7c00 + 510]

mov ax, 0x2400
int 0x15

mov si, ANDRE
call printf
;call readDisk
call testA20
mov dx, ax
call printh
;jmp test

call enableA20
mov dx, ax
call printh

jmp $

%include "./printf.asm"
%include "./readDisk.asm"
%include "./printh.asm"
%include "./testa20.asm"
%include "./enablea20.asm"

TEST_STR: db "Welcome to Knxr-OS...", 0x0a, 0x0d, 0
DISK_ERR_MESSAGE: db "Disk Error", 0x0a, 0x0d, 0
ANDRE: db "Andre Stinkt...", 0x0a, 0x0d, 0

times 510-($-$$) db 0
dw 0xaa55

test:
mov si, TEST_STR
call printf

times 512 db 0
