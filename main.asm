[org 0x7c00]

mov al, 1
mov cl, 2

call readDisk

jmp test

jmp $

printf:
	pusha
	str_loop:
		mov al, [si]
		cmp al, 0
		jne print_char
		popa
		ret

	print_char:
		mov ah, 0x0e
		int 0x10
		add si, 1
		jmp str_loop

readDisk:
	pusha
	mov ah, 0x02
	mov dl, 0x80
	mov ch, 0
	mov dh, 0
	;mov al, 1
	;mov cl, 2

	push bx
	mov bx, 0
	mov es, bx
	pop bx
	mov bx, 0x7c00 + 512

	int 0x13

	jc readDisk_error
	popa
	ret

	readDisk_error:
		mov si, DISK_ERR_MESSAGE
		call printf
		jmp $

TEST_STR: db "Welcome to Knxr-OS...", 0x0a, 0x0d, 0
DISK_ERR_MESSAGE: db "Disk Error", 0x0a, 0x0d, 0


times 510-($-$$) db 0
dw 0xaa55

test:
mov si, TEST_STR
call printf

times 512 db 0
