; Realizar un programa que permita separar en dos arreglos los caracteres ingresados por pantalla: un arreglo
; con solo numeros y otro arreglo que contenga letras o cualquier otro caracter. El proceso debera terminar
; al presionar ENTER imprimiendo el contenido de ambos arreglos resultantes     

include 'emu8086.inc'

mov si, offset numeros
mov di, offset letras

mov tamnum, 0
mov tamlet, 0

mov cx, 50

ingresar:

    mov dx, offset msje
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    
    printn
    
    cmp al, 0DH
    je fin
    
    cmp al, 48d
    jl letra
    
    cmp al, 57d
    jg letra
    
    mov [si], al
    inc si
    inc tamnum
    
    jmp continua
    


letra:  

    mov [di], al
    inc di       
    inc tamlet

    jmp continua
    

continua:
    loop ingresar
    
    
fin:
    printn
    mov si, offset numeros
    print "Numeros: "
    
    mov cx, tamnum
    
    mostrar1:
    
        mov dl, [si]
        mov ah, 2h
        int 21h
        print " " 
                   
        inc si 
        loop mostrar1        
         
        
    mov di, offset letras
    
    mov cx, tamlet
    
    printn
    
    print "Caracteres: "
        
    mostrar2:
    
        mov dl, [di]
        mov ah, 2h
        int 21h
        print " " 
        
        inc di
        
        loop mostrar2        
         
        


ret

DEFINE_PRINT_NUM_UNS        
DEFINE_PRINT_NUM


msje db "Ingrese algo: $"
numeros db 50 dup(?)
letras db 50 dup(?)
tamnum dw ?
tamlet dw ?


