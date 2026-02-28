;Realizar programa Assembler 8086 que permita el ingreso de un carácter y una cadena de caracteres tipeadas 
;por pantalla. Al presionar ENTER deberá indicar la cantidad de coincidencias de dicho carácter en la misma.

include 'emu8086.inc'


mov dx, offset texto
mov ah, 09h
int 21h

mov ah, 01h
int 21h
 
mov car, al

printn
print "Ingrese la cadena (presione ENTER cuando finalize): "

mov dx,offset string
mov ah,0Ah
int 21h

mov si, offset string 

mov cx, 30
recorrer:
 
    mov al, [si]
    cmp al, car
    je sumar
    
    jmp seguir
    

sumar:
    inc cant
    jmp seguir
    
seguir:
    inc si
    loop recorrer
    
fin:
    printn
    print "La cantidad de coincidencias es: "
    
    mov ax, cant
    call print_num


ret

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS


car db ?
cant dw ?

string db 30, ?, 30 dup ('$')

texto db "Ingrese un caracter: $"
