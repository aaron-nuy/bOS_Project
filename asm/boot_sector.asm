[bits 16]
[org 0x7c00]
; read from disk
mov [BOOT_DISK],dl
xor ax,ax
mov ds,ax
mov es,ax

mov ah,0x02 ; God knows
mov al,0x05 ; Number of sectors to read 
mov ch,0x0 ; Cylinder
mov cl,0x02 ; Sector
mov dh,0x0 ; Head
mov dl,[BOOT_DISK] ; Drive number
mov bx,[KERNEL_LOCATION] ; Load location
int 0x13

cli                         ; clear interrupts
call enable_a20             ; enable a20 gate
lgdt [gdt_descriptor]       ; load gdt

mov eax,cr0
or eax,0b1                  ; notify cpu that protected mode has been loaded
mov cr0,eax                 

jmp CODE_SEG:start_protected_mode    ; far jump to flush pipeline

%include "asm/gdt.asm"
%include "asm/enable_a20.asm"

[bits 32]
start_protected_mode:
    mov ax, DATA_SEG
    mov ds,ax
    mov ss,ax   
    mov es,ax           ; update segment registers
    mov fs,ax
    mov gs,ax

    mov ebp,0x90000     ; update stack
    mov esp,ebp

    xor eax,eax
    call cls
    jmp [KERNEL_LOCATION]

cls:
    mov word [VRAM_LOC+eax],0x7700
    add eax,2
    cmp eax,0xf9f
    jl cls
    ret

VRAM_LOC equ 0xb8000
KERNEL_LOCATION equ 0x1000

BOOT_DISK: db 0

times 510-($-$$) db 0
dw 0xaa55

