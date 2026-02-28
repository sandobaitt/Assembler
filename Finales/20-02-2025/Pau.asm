;Realizar un programa que permite ingresar por teclado 10 caracteres y separe en dos vectores. Colocar en un 
;vector los digitos y en otro vector, el resto de los caracteres. Para finalizar debera imprimir el vector 
;de numeros 

include 'emu8086.inc'

mov si, offset digitos
mov di, offset resto
mov cx, 10
mov tam, 0

ingresar:

    mov dx, offset msje
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    printn
    
    cmp al, 048
    jl caracter
    
    cmp al, 057
    jg caracter
    
    mov [si], al
    inc si
    inc tam
    
    jmp seguir



caracter:
    mov [di], al
    inc di
    
    jmp seguir
 

seguir:
    loop ingresar
    

printn    

mov si, offset digitos
print "Vector de numeros: "

mov cx, tam
mostrar:
    
    mov dl, [si]
    mov ah, 02h
    int 21h
    
    print " "
    
    inc si
    
    loop mostrar    
    

ret

msje db "Ingrese un caracter: $"
digitos db 10 dup(?)
resto db 10 dup (?)
tam dw ?
