; Realice la multiplicacion de dos numeros ingresados por teclado, 
; que almacene el  resultado en la variable 'Result'
; e imprima el resultado por pantalla. 

include 'emu8086.inc' ; especifico que voy a usar una libreria

.model small       ; modelo de memoria
.stack 100h        ; segmento de pila, reserva los 256 bytes obligatorios

.data              ; Segmento de datos (Ambiente)
    Result dw ?
 
.code               ; Segmento de codigo (Proceso)
    main proc
        ; en .small hay que "apuntar" DS al inicio de .data manualmente.     
        mov ax, @data   ; carga la direccion del segmento de datos en AX
        mov ds, ax      ; mueve esa dirección a DS (no se puede directo a DS)
    
        ; ingresar numeros
        print 'ingrese el multiplicando'
        call scan_num    ; esto lee el numero completo, ahorrandome la conversion en ascii de char a int. Como es un procedure, precisa de un call antes
        
        
        printn ; salto de linea
        
        push cx
        
        print 'ingrese el multiplicador'
        call scan_num
        
        printn
        
        mov ax, cx
        
        pop cx
        
        mul cx
         
        print 'El resultado de la multiplicacion es:' 
        printn
         
        mov Result, ax ; solo porque pide guardarlo en result, sino directamente imprimiria el valor del ax
        
        call print_num
         
        ; retorno
        mov ah, 4ch
        int 21h        
    main endp

    ; pongo las funciones que traigo desde la libreria
    define_scan_num
    define_print_num
    define_print_num_uns  
end main
