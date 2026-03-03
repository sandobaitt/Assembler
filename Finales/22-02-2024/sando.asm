title 'Final 22-02-2024'
include 'emu8086.inc'
.model small
.stack
.data

    vector db 20 dup(?)
    salida db 20 dup(?)

.code

    ; Inicializo segmento de datos
    mov dx, @data
    mov ds, dx
    
    ; Inicializo indice
    xor si, si
    
    ; Pido que ingrese cadena binaria
    
    print 'Ingrese cadena binaria y finalice con ENTER: '
    
    pido:
    
        mov ah, 01h
        int 21h
        
        cmp al, 13d
        je fin_pido
        
        mov vector[si], al
        inc si
        jmp pido
        
    fin_pido:
    
    printn ' '
    
    ; Inicializo cx para cantidad de elementos, si para recorrer y vector salida
    mov cx, si
    push cx
    xor si, si
        
    verifico:
    
        cmp vector[si], '1'
        je V
        
        cmp vector[si], '0'
        je F
        
        printn ' '
        printn 'Ingreso valores que no son binarios'
        jmp fin
        
    V:
    
        mov salida[si], 'V'
        inc si
        dec cx
        cmp cx, 0
        jne verifico
        jmp fin_copia
        
    F:
    
        mov salida[si], 'F'
        inc si
        dec cx
        cmp cx, 0
        jne verifico
   
    fin_copia:
    
        printn ' '
        printn 'Los valores binarios convertidos en V y F son: '
        pop cx
        xor si, si
        
    muestro:
        
        mov dl, salida[si]
        mov ah, 02h
        int 21h
        
        inc si
        dec cx
        cmp cx, 0
        jne muestro
        
    fin:
    
        mov ah, 4ch
        int 21h
