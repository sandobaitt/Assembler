title 'Final 27-02-2025'
include 'emu8086.inc'
.model small
.stack
.data

    cadena db 'El texto se encuentra escrito aqui$'
    reverso db 100 dup(?)
.code
    
    ; Inicializo segmento de datos
    mov dx, @data
    mov ds, dx
    
    ; Inicializo indices y cx
    xor si, si
    xor di, di
    mov cx, 0
    
    ; Para saber elementos a recorrer
    cant:
        
        cmp cadena[si], '$'
        je fin_cant
        
        inc si
        inc cx
        jmp cant
        
    fin_cant:
        
    ; Resguardo a cx, para cuando tenga que mostrar el reverso
    mov bx, cx
    
    ; Decremento un valor a si, porque era el del $
    dec si
     
    ; Copio el reverso
    rever:
        
        cmp cx, 0
        je mensaje
        
        mov dl, cadena[si]
        mov reverso[di], dl
        
        dec si
        inc di
        dec cx
        
        jmp rever
        
    mensaje:
     
        printn 'El reverso de la cadena almacenada en el vector es: '
        
    ; Recupero cantidad de elementos para mostar
    mov cx, bx
    xor si, si
        
    muestro:
        
        mov dl, reverso[si]
        mov ah, 02h
        int 21h
        
        inc si
        
        dec cx
        cmp cx, 0
        jne muestro
        
    mov ah, 4ch
    int 21h
