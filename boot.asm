; boot.asm (real mode, 512 байт)
[BITS 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Загрузить вторую часть (ядро) в 0x1000
    mov si, msg
    call print

    mov bx, 0x1000
    mov ah, 0x02     ; функция чтения секторов BIOS
    mov al, 1        ; 1 сектор
    mov ch, 0
    mov cl, 2        ; сектор 2
    mov dh, 0
    mov dl, 0x00     ; загрузка с первого диска
    int 0x13

    ; Переход в защищённый режим
    jmp 0x1000:0     ; переход к загруженному коду

print:
    mov ah, 0x0E
.next:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .next
.done:
    ret

msg db "Booting kernel...", 0

times 510-($-$$) db 0
dw 0xAA55
