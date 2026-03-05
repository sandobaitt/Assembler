title 'Final 11-12-2025'
include 'emu8086.inc'
.model small
.stack
.data

    caracter db ?
.code
    
    ; Inicializo segmento de datos
    mov dx, @DATA   
    mov ds , dx 
    
    xor cx, cx
    xor ax, ax
    
    ; Primero que ingrese el caracter
    print 'Ingrese un caracter: '
    
    mov ah, 01h
    int 21h
    mov caracter, al  ; Muevo el caracter a la variable creada
    
    printn ' '
    
    ; Que ingrese la cadena hasta que llegue el enter
    printn 'Vaya ingresando una cadena de caracteres y termine con ENTER'
    
    cadena:
    
        mov ah, 01h
        int 21h
        
        cmp al, 13d   ; Comparo con 13d que es un ENTER
        je muestro
        
        cmp al, caracter
        jne cadena
        
    match:
    
        inc cx
        jmp cadena
        
    muestro:
        
        call clear_screen
        xor ax, ax
        mov ax, cx
        print 'La cantidad que se registro con ese caracter es: '
        call print_num
        
    mov ah, 4ch
    int 21h
    
    define_print_num
    define_print_num_uns
    define_clear_screen
