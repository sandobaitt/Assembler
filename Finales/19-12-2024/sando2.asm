title 'Final 19-12-2024'
include 'emu8086.inc'
.model small
.stack
.data
                                               
    cadena db "Hola Mundo$"
    salida db 11 dup(?)
    
.code
    
    ; inicializo segmento de datos
    mov ax,@data
    mov ds,ax
    
    ; cargo e inicializo indices
    xor si, si
    xor di, di
    mov cx, 10 
    
    ; pido un caracter
    printn 'Ingrese el caracter que desea que no este en la salida'
    mov ah, 01h
    int 21h
    
    comparar:
        
        ; comparo elemento del vector con el caracter ingresado
        cmp al, cadena[si]
        je no_copio
        
    copiar: 
        
        mov dh, cadena[si]
        mov salida[di], dh
        inc di
        inc bx
        
    no_copio:
    
        inc si
        
        dec cx
        cmp cx, 0
        jne comparar

    ; agrego $ para recorrerlo
    mov salida[di], '$'
    
    printn ' '    
    mov ah, 09h            ; Servicio para imprimir cadena
    lea dx, salida        ; Carga la dirección del vector en DX
    int 21h
    
    mov ah,4ch
    int 21h
