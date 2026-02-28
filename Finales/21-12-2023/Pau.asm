;Realizar programa assembler 8086 que permita imprimir la tabla de multiplicar del valor ingresado por pantalla
;del 1 al 10.


include 'emu8086.inc'

mov dx, offset msje
mov ah, 09h
int 21h

call scan_num

mov valor, cx

    
printn

mov cont, 1

mov cx, 10

tabla:

    mov ax, valor
    
    call print_num
    
    print " x "
    
    mov ax, cont
    
    call print_num
    
    print " = "
    
    mov bx, valor
    mov ax, cont
    mul bx
    
    call print_num

    inc cont
    
    printn
    
    loop tabla



ret

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

valor dw ?
cont dw ?

msje db "Ingrese el valor: $" 
