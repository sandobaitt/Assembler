; Recorra un vector cargado con 10 elementos y 
; copiar el contenido en un segundo vector. 

include 'emu8086.inc' ; especifico que voy a usar una libreria

.model small       ; modelo de memoria
.stack 100h        ; segmento de pila, reserva los 256 bytes obligatorios

.data              ; Segmento de datos (Ambiente)
    vec1 dw 256, 10, 3, 7, 33, 255, 99, 101, 1111, 222
    vec2 dw 10 dup(0)                                   ; lo inicializo en 0     
 
.code               ; Segmento de codigo (Proceso)
    main proc
        ; en .small hay que "apuntar" DS al inicio de .data manualmente.     
        mov ax, @data   ; carga la direccion del segmento de datos en AX
        mov ds, ax      ; mueve esa direcciÃ³n a DS (no se puede directo a DS)
        
        lea si, [vec1]  ; lea ignora los corchetes (porque trabaja con direcciones)    
        lea di, vec2    ; di es el puntero del segundo vector
        
        mov cx,10
        for:
            mov ax, [si]
            mov [di], ax    
            
            add si, 2
            add di, 2
        loop for   
             
           
        ; retorno
        mov ah, 4ch
        int 21h        
    main endp

    ; pongo las funciones que traigo desde la libreria
    define_scan_num
    define_print_num
    define_print_num_uns  
end main
