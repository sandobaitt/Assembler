title 'final 19-12-2024'
include 'emu8086.inc'
.model small
.stack
.data

    vector db '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
    salida db 10 dup(?)
    
.code

    ; inicializar segmento de datos
    mov ax, @data
    mov ds, ax
    
    ; inicializo indice y contador
    xor si, si
    xor di, di
    mov cx, 10
    xor bx, bx
    
    printn 'Ingrese un numero que no quiere que este'
    mov ah, 01h
    int 21h ; en al se guarda el caracter
    
    comparar:
        
        ; comparo elemento del vector con el caracter ingresado
        cmp al, vector[si]
        jne copiar
        
        jmp no_copio
        
    copiar: 
        
        mov dh, vector[si]
        mov salida[di], dh
        inc di
        inc bx
        
    no_copio:
    
        inc si
        
        dec cx
        cmp cx, 0
        jne comparar     
    
    xor di, di
    printn ' '
    print 'Vector resultante: '    
    mostrar:
        
        mov al, salida[di]
        sub al, 48d
        xor ah, ah
        call print_num
        
        putc ' ' 
        
        inc di
        dec bx
        cmp bx, 0
        jne mostrar
        
    mov ah, 4ch
    int 21h
    
    define_print_num
    define_print_num_uns 
