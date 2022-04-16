gdt_start:
gdt_null:
    dd 0x0
    dd 0x0
gdt_code:
    ; flags : ( present )1 ( privilege )00 ( descriptor type )1 -> 1001 b
    ; type flags : ( code )1 ( conforming )0 ( readable )1 ( accessed )0 -> 1010 b
    ; more flags : ( granularity )1 (32 - bit default )1 (64 - bit seg )0 ( AVL )0 -> 1100 b
    dw 0xffff           ; limit bits 0-15
    dw 0x0              ; base bytes 0-1
    db 0x0              ; base byte 2
    db 0b10011010       ; flags + type flags
    db 0b11001111       ; more flags + limit bits 16-18
    db 0x0              ; base byte 3

gdt_data:
    ; Same as code segment except for the type flags :
    ; type flags : ( code )0 ( expand down )0 ( writable )1 ( accessed )0 -> 0010 b
    dw 0xffff           ; limit bytes 0-1
    dw 0x0              ; base bytes 0-1
    db 0x0              ; base byte 2
    db 0b10010010       ; flags + type flags
    db 0b11001111       ; more flags + limit bits 16-18
    db 0x0              ; base byte 3
gdt_end:


gdt_descriptor:
    dw gdt_start - gdt_end - 1 ; -1 because offset
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start