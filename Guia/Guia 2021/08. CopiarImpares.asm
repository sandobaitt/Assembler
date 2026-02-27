; Recorrer un vector y 
; copiarlo a un segundo vector, 
; solo los contenidos impares del primer vector. 

include 'emu8086.inc' ; especifico que voy a usar una libreria

.model small       ; modelo de memoria
.stack 100h        ; segmento de pila, reserva los 256 bytes obligatorios

.data              ; Segmento de datos (Ambiente)
    vec1 dw 10, 255, 222, 256, 777, 7, 33, 404, 1111, 101
    vec2 dw 10 dup(0)   
 
.code               ; Segmento de codigo (Proceso)
    main proc
        ; en .small hay que "apuntar" DS al inicio de .data manualmente.     
        mov ax, @data   ; carga la direccion del segmento de datos en AX
        mov ds, ax      ; mueve esa direcciÃ³n a DS (no se puede directo a DS)
        
        lea si, vec1
        lea di, vec2
        mov bx, 2
        
        mov cx, 10
        for:
            mov dx, 0
            mov ax, [si]
            div bx
            
            cmp dx, 0   ; al ser 16 bits, el resto se guarda en dx
            je skip     ; si es 0, no lo cargo
            
            mov ax, [si]
             
            ; estos dos de abajo sirven si queres ver que funciona (pero el enunciado no pide) 
            ; call print_num
            ; printn
            
            mov [di], ax
            
            add di, 2
            
            skip:       ; NO hago add aca porque no se cumplio la condicion (no debo cargar nada)
           
            add si, 2

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
