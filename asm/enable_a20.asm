enable_a20:
    call a20_wait_input
    mov al,KYBD_DISABLE_PS2 ; disable keyword to write to a20
    out KYBD_CMDPORT,al

    call a20_wait_input
    mov al,KYBD_READ        ; read control output port 
    out KYBD_CMDPORT,al     

    call a20_wait_output
    in al, KYBD_DPORT       
    push eax

    call a20_wait_input
    mov al, KYBD_WRITE      ; write command output port
    out KYBD_CMDPORT,al

    call a20_wait_input
    pop eax
    or al,2                 ; bit 2 is a20 bit
    out KYBD_DPORT,al       ; set a2O bit


    call a20_wait_input
    mov al, KYBD_ENABLE_PS2
    out KYBD_CMDPORT,al     ; enable the keyboard

    call a20_wait_input
    ret


a20_wait_input:
    in al, KYBD_CMDPORT
    test al,2               ; wait until bit 2 (output buffer) is 0
    jnz a20_wait_input
    ret

a20_wait_output:
    in al, KYBD_CMDPORT
    test al,1               ; wait until bit 1 (output buffer) is 1
    jz a20_wait_output
    ret


KYBD_DISABLE_PS2    equ 0xad
KYBD_ENABLE_PS2     equ 0xae
KYBD_CMDPORT        equ 0x64
KYBD_DPORT          equ 0x60
KYBD_READ           equ 0xd0
KYBD_WRITE          equ 0xd1
