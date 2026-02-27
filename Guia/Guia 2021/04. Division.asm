; Realice la division entera de dos numeros ingresados por teclado. 
; Imprima el resultado por pantalla y 
; guarde en variables el cociente y resto.

include 'emu8086.inc' ; especifico que voy a usar una libreria

.model small       ; modelo de memoria
.stack 100h        ; segmento de pila, reserva los 256 bytes obligatorios

.data              ; Segmento de datos (Ambiente)
  res dw ?
  coc dw ?    
 
.code               ; Segmento de codigo (Proceso)
    main proc
        ; en .small hay que "apuntar" DS al inicio de .data manualmente.     
        mov ax, @data   ; carga la direccion del segmento de datos en AX
        mov ds, ax      ; mueve esa dirección a DS (no se puede directo a DS)
    
        print 'Ingrese el dividendo'
        call scan_num       
        push cx
          
        printn  
          
        print 'Ingrese el divisor'
        call scan_num
        mov bx, cx
          
        printn       
          
        pop cx
        mov ax, cx
                
        mov dx, 0           ; limpio dx por si las dudivas
        div bx              ; como uso 16 bits, el resultado se separa entre el ax y el dx
        mov coc, ax
        mov res, dx
        
        print 'El cociente es:'
        mov ax, coc
        printn 
        
        call print_num 
        printn
        
        print 'El resto es:'
        mov ax, res
        printn
          
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
