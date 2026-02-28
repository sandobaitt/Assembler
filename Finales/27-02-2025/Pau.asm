;Realice un programa que permite analizar una cadena de longitud n almacenada en un vector y finalizada
;con $ y escriba el reverso en otro vector. Para finalizar, imprima por pantalla la cadena resultante

include 'emu8086.inc'

mov si, offset cadena
mov cant, 0

recorrer:

    cmp [si], 036
    je fin
    
    push [si]
    
    inc si
    inc cant
    
    loop recorrer
        
     
fin:
    mov cx, cant
    mov di, offset vector
    
    imprimir:
    
        pop ax
        mov [di], ax
        inc di
        
        mov dl, ax
        mov ah, 2h
        int 21h
        
        
        
        loop imprimir
        
    
    


ret

cadena db "Hola que tal$"
cant dw ?
vector db 50 dup(?)
