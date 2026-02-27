; Dado dos numeros ingresados por teclado, 
; determinar cual es el mayor de ellos, y
; si este es multiplo del menor. 

; este se hace  mas facil si es con emu8086.inc

.model small       
.stack 100h       

.data             
    msg1 db 'Ingrese un numero', 10, 13, '$'    
    msg2  db 10, 13, 'Ingrese otro numero:', 10, 13, '$'
    
    msgc1 db 10, 13, 'El segundo numero es mayor', 10, 13, '$'
    msgn1 db 10, 13, 'El primer numero es mayor', 10, 13, '$'
    msgeq db 10, 13, 'Los numeros son iguales', 10, 13, '$'
    
    msgc2 db 10, 13, 'Son multiplos', 10, 13, '$'
    msgn2 db 10, 13, 'No son multiplos', 10, 13, '$'  
    
.code
    leer_numero proc
        push ax             ; guardamos registros para no romper nada afuera
        push cx
        push dx
        
        mov bx, 0           ; como vamos a usar bx, el resultado inicial debe ser 0
    
        leer_tecla:
            mov ah, 01h     ; lectura
            int 21h         
    
            cmp al, 13d     
            je fin_leer     ; si es enter, deja de leer
    
            sub al, 30h     ; pasaje ascii
            mov cl, al      
            mov ch, 0       
    
            mov ax, bx      
            mov dx, 10      
            mul dx          ; ax = ax * 10
            
            add ax, cx      
            mov bx, ax      
    
            jmp leer_tecla  
    
        fin_leer:
       
        pop dx              ; recuperamos los registros en orden inverso (porque es una pila)
        pop cx
        pop ax
        ret                
    leer_numero endp              
    main proc    
        mov ax, @data  
        mov ds, ax     
        
        ; num 1
        mov ah, 09h
        lea dx, msg1
        int 21h
        
        call leer_numero
        push bx
        
        ; num 2
        mov ah, 09h
        lea dx, msg2
        int 21h
        
        call leer_numero
        
        mov ax, bx
        pop bx
        
        ; a > b? 
         
        cmp ax, bx          
        ja c1               ; ax > bx
        jb n1               ; bx > ax  | No es necesario este salto, se podria hacer seguido de esta instruccion, pero bueno
        je eq               
        
        eq:
            lea dx, msgeq
            jmp end         ; sin esto, va a ejecutar los otros casos tambien  
           
        
        c1:                 
            lea dx, msgc1
            jmp prt
        
        
        n1:               
            xchg ax, bx     ; grande div chico   
            lea dx, msgn1
            

        prt: 
            push ax         ; stackeo el mas grande primero
            push bx
            mov ah, 09h
            int 21h 
         
        ; el mayor es multiplo del menor? 
        
        
        pop bx
        pop ax
        
        mov dx, 0
        div bx
        
        ; como son 16 bits, el resto queda en dx
        
        cmp dx, 0
        mov ah, 09h
        je c2
        
        ; n2
        
        lea dx, msgn2
        
        jmp end
        
        c2:
            lea dx, msgc2
     
        end:
            int 21h      
            mov ah, 4ch
            int 21h        
    main endp

   
end main                   
