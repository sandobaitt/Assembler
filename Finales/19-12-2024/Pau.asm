;Realizar un programa Assembler 8086 que permita recorrer un vector precargado de 10 elementos y copiar a un 
;segundo vector, los contenidos diferentes a uno ingresado por teclado.

include 'emu8086.inc'

mov tam, 0

mov cx, 10
mov si, offset vector
mov di, offset vector2

ingresar:

    mov dx, offset msje
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    printn
    
    mov cont, 0
    recorrer:     
        
        cmp al, [si]
        je finrecorrido
        
        inc cont
        inc si
        cmp cont, 10
        jl recorrer
        
        jmp fin
            

    
        
finrecorrido:   
    mov si, offset vector
    jmp continuar            
 
    
fin:
    mov [di],al
    inc di
    mov si, offset vector
    
    inc tam
    
    jmp continuar

continuar:
    loop ingresar        
        

mov cx, 10
mov si, offset vector
mov di, offset vector2
print "Vector original: "
imprimir:
    
    mov dl, [si]
    mov ah, 02h
    int 21h
    
    print " "
    
    inc si 
    
    loop imprimir
    
xor cx, cx
mov cl, tam
printn
print "Vector distinto: "

cmp tam, 0
jg imprimir2

ret
    
imprimir2:
    mov dl, [di]
    mov ah, 02h
    int 21h
    
    print " "
    
    inc di     
        
    loop imprimir2


ret

vector db "2","k","{","d","9","h","-","%","l","s"
msje db "Ingrese un valor: $"
vector2 db 10 dup(?)
cont db ?

tam db ?
