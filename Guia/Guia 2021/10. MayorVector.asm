; Realizar un programa que recorre un vector de posiciones de memoria; y 
; encuentra el mayor valor y 
; lo muestre por pantalla.

include 'emu8086.inc' ; especifico que voy a usar una libreria

.model small       ; modelo de memoria
.stack 100h        ; segmento de pila, reserva los 256 bytes obligatorios

.data              ; Segmento de datos (Ambiente)
    vec dw 222, 256, 255, 8421, 2421, 777, 7, 33, 404, 511
.code               ; Segmento de codigo (Proceso)
    main proc
        ; en .small hay que "apuntar" DS al inicio de .data manualmente.     
        mov ax, @data   ; carga la direccion del segmento de datos en AX
        mov ds, ax      ; mueve esa direcciÃ³n a DS (no se puede directo a DS)
    
        mov ax, 0
        lea si, vec
        
        mov cx, 10
        for:
        
            cmp [si], ax
            jb skip       ; jump if below, [si] < bx
            
            mov ax, [si]  ; [si] > bx
            
            skip:
            
            add si, 2
        
        loop for
               
        ; mov ax, bx
        ; call print_num
        
        ; para imprimir SIN la libreria, voy a usar el algoritmo de Horner
        mov bx, 10
        mov cx, 0     ; lo reinicio porque voy a hacer un ciclo antinatural
        
        divn:
            mov dx, 0
            div bx      ; dx:ax div bx
            
            push dx     ; mando el resto al stack
            inc cx      ; incremento justamente para que sea antinatural
            
            cmp ax,0
            jne divn     ; si cociente <> 0, hay que seguir diviendo
            
        forp:
            pop dx
            
            add dl, 30h
            
            mov ah, 02h
            int 21h    
        loop forp
            
        ; retorno
        mov ah, 4ch
        int 21h        
    main endp

    ; pongo las funciones que traigo desde la libreria
    define_scan_num
    define_print_num
    define_print_num_uns  
end main
