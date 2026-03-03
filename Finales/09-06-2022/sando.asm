title 'Final 09-06-2022'
include 'emu8086.inc'
.model small
.stack
.data
.code

    printn 'Ingrese por pantalla una cadena y termine con ENTER'
    xor cx, cx
    
    toma:
    
        mov ah, 01h
        int 21h
        
        cmp al, 13d
        je muestro
        
        xor ah, ah
        push ax
        inc cx
        jmp toma
        
    muestro:
    
        xor ax, ax
        pop ax
        mov dl, al
        
        mov ah, 02h
        int 21h
        
        dec cx
        cmp cx, 0
        jne muestro
        
    mov ah, 4ch
    int 21h
