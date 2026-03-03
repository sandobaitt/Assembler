title 'Final 18-12-2025'
include 'emu8086.inc'
.model small
.stack
.data

    vector db 100 dup(?)
.code

    ; Inicializo segmento de datos
    mov dx, @DATA   
    mov ds , dx
    
    ; Inicializo indice
    xor si, si
    
    ; Que ingrese la cadena hasta que llegue el enter
    printn 'Vaya ingresando una cadena de caracteres y termine con ENTER'
    
    cadena:
    
        mov ah, 01h
        int 21h
        
        cmp al, 13d
        je inicializo
        
        mov vector[si], al
        inc si
        
        jmp cadena
        
    inicializo: ; Preparo indice para recorrer nuevamente y preparo pantalla
        
        mov cx, si  ; Para saber cantidad de iteraciones
        xor si, si
        call clear_screen
        print 'Los valores en ascci de cada letra es: '
        printn ' '
        
    muestro:
        
        xor ax, ax
        mov al, vector[si]
        inc si
        call print_num      
        printn 'd'          ; Pongo una d, para saber que esta representado en decimal
        
        dec cx
        cmp cx, 0
        jne muestro
        
    mov ax, 4ch
    int 21h
    
    define_print_num
    define_print_num_uns
    define_clear_screen
