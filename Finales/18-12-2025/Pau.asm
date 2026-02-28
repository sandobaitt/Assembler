;Realizar Programa assembler que permita ingresar una cadena alfanumérica por pantalla. Al presionar 
;Enter deberá generar un nuevo vector que contenga los valores ASCII de cada carácter ingresado e imprimirlo 
;por pantalla.     


include 'emu8086.inc'

print "Ingresar cadena: "

mov dx,offset string
mov ah,0Ah
int 21h

mov si, offset string
inc si
inc si

mov di, offset vector

mov cx, 30
recorrer:

    mov al,[si]
    mov [di], al
    
    inc si
    inc di
    
    loop recorrer

mov di, offset vector


printn
mostrar:
   
    
    mov al, [di]
    mov ah,0
    call print_num
    
    print " "
    
    inc di
    
    cmp [di],"$"
    jne mostrar    
    



ret


string db 30, ?, 30 dup ('$')
vector db 30 dup(?)          

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
