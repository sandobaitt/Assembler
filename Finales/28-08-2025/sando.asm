title 'Final 28-08-2025'
include 'emu8086.inc'
.model small
.stack
.data

    num db 10100111b
.code                      
    
    ; Inicializo segmento de datos
    mov dx, @data
    mov ds, dx
    
    ; Inicializo
    mov cx, 3
    
    extraigo:
        
        xor ax, ax
        mov al, num
        and al, 111b
        
        push ax     ; Guardo valor en la pila
        
        shr num, 3  ; Desplazo a derecha y se rellena desde izquierda con 0s
        
        dec cx
        cmp cx, 0
        jne Extraigo
    
    print 'El numero binario a octal es: '
    mov cx, 3
    
    muestro:    
    
        pop ax
        add al, 48d
        mov dl, al
        
        mov ah, 02h
        int 21h
        
        xor ax, ax
        dec cx
        cmp cx, 0
        jne muestro
      
        
    mov ah, 4ch
    int 21h
