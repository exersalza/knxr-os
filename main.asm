[org 0x7c00]

mov al, 1
mov cl, 2

call readDisk

jmp test

jmp $

%include "./printf.asm"
%include "./readDisk.asm"

TEST_STR: db "Welcome to Knxr-OS...", 0x0a, 0x0d, 0
DISK_ERR_MESSAGE: db "Disk Error", 0x0a, 0x0d, 0


times 510-($-$$) db 0
dw 0xaa55

test:
mov si, TEST_STR
call printf

times 512 db 0
