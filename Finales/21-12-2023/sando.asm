title 'Final 21-12-2023'
include 'emu8086.inc'
.model small
.stack 100h
.data

    num db ?
    multi db ?   
.code 
    ; Inicializo segmento de datos
    mov dx, @DATA
    mov ds, dx
    
    ; Pido numero para armar la tabla
    print 'Ingrese numero para la tabla del 1 al 10: '
    
    mov ah, 01h
    int 21h
    
    sub al, 48d     ; Convierto a numero
    mov num, al     ; Lo paso a num, para operar mejor
    
    printn ' '
    printn ' '
    
    ; Aca empiezo a preparar la tabla
    mov cx, 10      ; Las vueltas para cada numero
    mov multi, 1    ; Arranco multiplicando por 1
    
    tabla:
        ; Imprimo el numero ingresado
        mov dl, num
        add dl, 48d     ; Lo convierto a ASCII para mostrarlo
        mov ah, 02h
        int 21h
        
        print ' X '
        
        mov al, multi
        xor ah, ah      
        call print_num  ; Uso print_num porque llega hasta el 10 (dos digitos)

        print ' = '
    
        mov al, num
        mul multi       ;  El resultado queda en ax
        
        ; print_num ya tiene el numero multiplicado en ax para imprimir
        call print_num
        
        printn ' '
        
        ; Incremento el multiplicador
        inc multi
        dec cx
        cmp cx, 0
        jne tabla  
        
    mov ah, 4ch
    int 21h

    define_print_num
    define_print_num_uns
    end
