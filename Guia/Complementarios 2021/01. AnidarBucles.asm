; Realice un programa que anide 3 bucles. 
; Se debera poder definir la cantidad de iteraciones de cada bucle, e 
; imprimir en pantalla un indicador numerico de cada iteracion. 

include 'emu8086.inc' 

.model small       
.stack 100h        

.data  
    c1 dw ?
    c2 dw ?
    c3 dw ?
    msg1 db 'Ingrese el tope del primer ciclo', 10, 13, '$'
    msg2 db 10, 13, 'Ingrese el tope del segundo ciclo', 10, 13, '$'
    msg3 db 10, 13, 'Ingrese el tope del tercer ciclo', 10, 13, '$'   
 
.code
    horner proc
        ; resguardo
        push ax
        push bx
        push cx
        push dx
    
       
        mov cx, 0       ; cx cuenta los digitos apilados
        mov bx, 10      ; bx es el divisor (base 10)
    
    horner_dividir:
        mov dx, 0       ; limpia dx para evitar un overflow
        div bx          ; dx:ax div bx
        
        push dx         
        inc cx          
        
        test ax, ax     
        jnz horner_dividir ; si el cociente no es cero, dar otra vuelta
    
        
    horner_imprimir:
        pop dx          
        
        add dl, 30h     ; pasaje de numero a caracter (ascii)
        
        mov ah, 02h     ; 02h imprime un char que este en dl
        int 21h
        
        loop horner_imprimir
    
       
        pop dx
        pop cx
        pop bx
        pop ax
        
        ret
    horner endp
 
    leer_numero proc
        push ax             
        push cx
        push dx
        
        mov bx, 0           
        
        leer_tecla:
            mov ah, 01h     
            int 21h         
        
            cmp al, 13d     
            je fin_leer     
        
            sub al, 30h     
            mov cl, al      
            mov ch, 0       
        
            mov ax, bx      
            mov dx, 10      
            mul dx          
            
            add ax, cx      
            mov bx, ax      
        
            jmp leer_tecla  
        
        fin_leer:
        
        pop dx             
        pop cx
        pop ax
        ret                
    leer_numero endp
     
    
        
    main proc 
        mov ax, @data   
        mov ds, ax
       
        ; obener valor ciclo 1    
        mov ah, 09h
        lea dx, msg1
        int 21h
       
      
        call leer_numero 
        mov [c1], bx
                   
        ; obener valor ciclo 2      
        mov ah, 09h
        lea dx, msg2
        int 21h
        
        call leer_numero
        mov [c2], bx 
               
        ; obener valor ciclo 3                
        mov ah, 09h
        lea dx, msg3
        int 21h
        
        call leer_numero
        mov [c3], bx              
        
        ; ciclo 1
        mov cx, [c1]
        for1:
            push cx
            mov ax, cx
            call horner
            mov cx, [c2]
            for2:
                push cx
                mov ax, cx
                call horner
                
                mov cx, [c3]
                for3:
                    mov ax, cx
                    call horner
                loop for3
                pop cx
            loop for2
            pop cx    
        loop for1          
           
        ; retorno
        mov ah, 4ch
        int 21h        
    main endp 
end main
