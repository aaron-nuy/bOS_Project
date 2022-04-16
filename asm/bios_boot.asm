org 0x7c00

mov [diskNum],dl

lab:
    jmp $


read_from_disk:
    mov ah,2 ; God knows
    mov al,1 ; Number of sectors to read 
    mov ch,0 ; Cylinder
    mov cl,2 ; Sector
    mov dh,0 ; Head
    mov dl, [diskNum] ; Drive number
    mov bx, 0x7e00 ; Load location
    int 0x13
    ret
; al character read
read_char:
    mov ah,0x0
    int 0x16
    ret
; al register to print
print_reg:
    mov ah,0x0e
    int 0x10
    ret

; ebx char pointer
printf:
    mov ah, 0x0e
    cmp byte [ebx],0
    je return
    mov al, [ebx]
    int 0x10
    inc ebx
    jmp printf

; ebx address to read from
; ecx how much i need to read
print_mem_hex:
    mov ah, 0x0e
    cmp ecx,0
    jle return
    dec ecx
    mov al, [ebx]
    call byte_to_hex
    inc ebx
    jmp print_mem_hex


; al byte
byte_to_hex:
    mov ah, 0x0e
    pusha
    mov al,'0'
    int 0x10
    mov al,'x'
    int 0x10
    popa

    pusha
    mov dl,al
    shr dl,4

    mov ebx,table
    add bl,dl

    mov al,[ebx]
    int 0x10
    popa

    pusha
    mov dl,al
    shl dl,4
    shr dl,4

    mov ebx,table
    add bl,dl

    mov al,[ebx]
    int 0x10
    popa

    pusha
    mov al,' '
    int 0x10
    popa

    ret
    
return:
    ret

string:
    db 'LOOK AT THIS NULL TERMINATED STRING',0
table:
    db '0123456789ABCDEF',0
diskNum:
    db '0'
times 510-($-$$) db 0x0
dw 0xaa55
