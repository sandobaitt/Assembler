;Realice un programa en assembler para 8086 utilizando únicamente interrupciones (NO la librería emu8086) 
;donde se ingresen por teclado 10 dígitos y luego imprima por pantalla: el valor máximo, la cantidad de 
;números pares de la serie y la suma de todos los dígitos ingresados.

mov cx, 10
mov max, 0
mov suma, 0
mov cantpares, 0

ingresar:

    mov dx, offset msje
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    
    sub al, 30h 
    
    mov valor, al
    
    mov al, suma
    add al, valor
    mov suma, al
    
    mov al, valor
    mov bl, 2
    mov dl, 0
    div bl
    
    cmp ah, 0
    je par
    
    jmp mayor
            
par:

    inc cantpares 
    jmp mayor


mayor:

    mov al, valor
    cmp al, max
    jg esmayor
    
    jmp seguir
    
        
esmayor:
    
    mov al, valor 
    mov max, al
    
    jmp seguir
    
seguir:

    mov dl, 13
    mov ah, 02h
    int 21h

    mov dl, 10
    int 21h

    loop ingresar     


mov al, max
call imprimir_2_digitos

mov dl, 20h
mov ah, 02h
int 21h


mov al, cantpares
call imprimir_2_digitos

mov dl, 20h
mov ah, 02h
int 21h

mov al, suma
call imprimir_2_digitos

ret



imprimir_2_digitos:
    mov ah, 0
    mov bl, 10
    div bl
    
    mov bx, ax 
    
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h
    
    mov dl, bh
    add dl, 30h
    int 21h
    ret



msje db "Ingrese el digito: $"
max db ?
valor db ?
suma db ?
cantpares db ?
