; Recorrer un vector y
; contar la cantidad de valores IMPARES. 
; Imprimir resultado por pantalla. 

include 'emu8086.inc' ; especifico que voy a usar una libreria

.model small       ; modelo de memoria
.stack 100h        ; segmento de pila, reserva los 256 bytes obligatorios

.data              ; Segmento de datos (Ambiente)
  vec dw 12, 10, 3, 7, 33, 255, 99, 101, 1111, 222 
  cont db 0
.code               ; Segmento de codigo (Proceso)
    main proc  
        mov ax, @data   
        mov ds, ax     
        
        lea si, vec
        mov bx, 2
        
        mov cx, 10
        for:
            mov ax, [si]
            mov dx, 0                  ; siempre hay que limpiar dx antes de un div para asi evitar un overflow
            div bx
            
            cmp dx, 1                  ; div: x 2 da 1 si x es impar
            jne sum                    ; si NO es igual a 1 hago un salto condicional
          
             
            inc byte ptr [cont]        ; incrementa en 1 
             
            sum:
                
            add si, 2                  ; como son 16 bits, debo desplazarme 2 veces
            
        loop for
        
        mov al, cont
        mov ah, 0                      ; limpio por las dudas
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
