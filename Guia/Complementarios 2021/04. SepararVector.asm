; Separar en dos arreglos los 
; numeros pares e impares 
; leidos de un arreglo previamente definido en memoria.

.model small       
.stack 100h        

.data             
    vec dw 222, 256, 255, 8421, 2421, 777, 7, 33, 404, 511
    vecp dw 10 dup(?)
    veci dw 10 dup(?)
.code              
    main proc       
        mov ax, @data  
        mov ds, ax     
                
        lea bp, vec             ; si bien es el puntero del stack, mas abajo cobra sentido
        lea si, vecp            ; si se encarga de los pares
        lea di, veci            ; di se encarga de los impares
        
        mov bx, 2               ; por eso use arriba bp y no bx. Otra forma es "al revez", usas bx como tercer puntero, y guardas bx en el stack antes de cargar el divisor
        
        mov cx, 10
        for:
            mov ax, ds:[bp]     ; fuerzo a que bp apunte a datos, y no al stack
            xor dx, dx
            div bx              ; aca yo hice esto para jugar con bp, pero tranquilamente podes usar test 
                                ; (la diferencia entre pares e impares es que el ultimo bit es 0 o 1, respectivamente)
                                ; y evaluar con jz/jnz que se fija en las flags 
           
            mov ax, ds:[bp]
           
            cmp dx, 0           ; al ser 16 bits, el resto queda en dx
            je par
            jne impar
            
            par:   
                mov [si], ax
                add si, 2
                jmp mover    
            
            impar:
                mov [di], ax
                add di, 2
                
            mover:  
                add bp, 2                
        loop for
       
        end:
            mov ah, 4ch
            int 21h        
    main endp 
end main
