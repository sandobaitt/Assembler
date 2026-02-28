;Recorrer un vector precargado de 10 elementos y determine cuales contenidos corresponden a numeros en ASCII
;Imprimir por pantalla dichos numeros

include 'emu8086.inc'

mov si, offset vector

mov cx, 10

recorrer:
    
    cmp [si], 048
    jl seguir
    
    cmp [si], 057
    jg seguir
    
    mov dl, [si]
    mov ah, 02h
    int 21h
    
    print " "
   
    
    jmp seguir
    
seguir:
   
    inc si
    loop recorrer    







ret


vector db "a", "3", "#", "0", "5", "k", ".", "}", "9", "1"
