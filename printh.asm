printh:

mov si, HEX_PATTERN

mov bx, dx
shr bx, 12
mov bx, [bx + HEX_TABLE]
mov [HEX_PATTERN + 2], bl

mov bx, dx

shr bx, 8
mov bx, [bx + HEX_TABLE]
mov [HEX_PATTERN + 2], bl

call printf

ret

HEX_PATTERN: db '0x****', 0x0a, 0x0d, 0
HEX_TABLE: db '0123456789ABCDEF'
