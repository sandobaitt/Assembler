title 'Final 11-12-2025'
include 'emu8086.inc'
.model small
.stack
.data

    caracter db ?
.code

    mov dx, @DATA   
    mov ds , dx
    xor dx,dx
    xor cx, cx
    xor ax, ax
    
    ; primero que ingrese el caracter
    printn 'Ingrese un caracter'
    mov ah, 01h
    int 21h
    mov caracter, al  ; muevo el caracter a la variable creada
    printn ' '
    
    ; que ingrese la cadena hasta que llegue el enter
    printn 'Vaya ingresando una cadena de caracteres y termine con ENTER'
    
    cadena:
    
        mov ah, 01h
        int 21h
        cmp al, 13d
        je muestro
        
        cmp al, caracter
        jne cadena
        
    match:  ; Si llego aca, es porque al, es igual a caracter
    
        inc cx
        jmp cadena
        
    muestro:
        
        call clear_screen
        mov ax, cx
        print 'La cantidad que se registro con ese caracter es: '
        call print_num
        
    mov ax, 4ch
    int 21h
    
    define_print_num
    define_print_num_uns
    define_clear_screen
