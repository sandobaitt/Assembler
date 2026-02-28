; Realizar programa que permita ingresar una cadena binaria y almacenarla en memoria. Dicha cadena debera 
; ser barrida y generar un nuevo vector donde: si el caracter es 0 guarda una F y si es 1 guarde una V. 
; Al final del proceso imprimir en pantalla el vector resultante.

include 'emu8086.inc'

printn "Cuando desee dejar de ingresar presione ENTER"

mov tam, 0
mov si, offset vector
mov di, offset cadena

mov cx, 50
ingresar:

    mov dx, offset msje
    mov ah, 09h
    int 21h
            
    mov ah, 01h
    int 21h
    
    cmp al, 0dh
    je fin
    
    printn
    
    mov [di], al
    inc di
    
    cmp al, 48d
    je cero
    
    mov [si], "V"
    
    jmp continuar
    
cero:

    mov [si], "F"
    jmp continuar
    
continuar:
    
    inc si
    inc tam
    loop ingresar

fin:
    printn
    mov si, offset vector
            
    mov cx, tam
    mostrar:
        mov dl, [si]
        mov ah, 02h
        int 21h
        
        print " "
        
        inc si
        
        loop mostrar
    

ret

DEFINE_SCAN_NUM 

msje db "Ingrese 0 o 1: $" 
vector db 50 dup (?)
cadena db 50 dup (?)
tam dw ?
