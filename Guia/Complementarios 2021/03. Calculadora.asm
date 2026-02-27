; Realizar un programa que funcione como calculadora de 2 numeros enteros, y 
; permita realizar las 4 operaciones basicas. 
; Se debe ingresar por teclado los numeros y la operacion a realizar. 
; Luego imprimir por pantalla el resultado obtenido. 

.model small       
.stack 100h        

.data             
    opcion db ?
    msg1 db 'Ingrese el primer operando', 10, 13, '$'
    msg2 db 10, 13, 'Ingrese el segundo operando', 10, 13, '$'
    
    msgo db 10, 13, 'Seleccione una operacion:', 10, 13, '1. Suma', 10, 13, '2. Resta', 10, 13, '3. Multiplicacion', 10, 13, '4. Division', 10, 13, '$'       
    msge db 10, 13, 'ERROR: debe elegir una operacion disponible. Reintente ingresando una opcion valida:', 10, 13, '$'
    msgr db 10, 13, 'El resultado de la operacion es: ', 10, 13, '$'
    msged db 10, 13, 'ERROR: no se puede dividir por 0', 10, 13, '$'
.code  
    ; horner y leer_numero es el dulce que arme para no usar emu8086.inc   
    horner proc
        push ax
        push bx
        push cx
        push dx
        mov cx, 0     
        mov bx, 10      
    
        horner_dividir:
            mov dx, 0       
            div bx          
            push dx         
            inc cx               
            test ax, ax     
            jnz horner_dividir 
        horner_imprimir:
            pop dx          
            add dl, 30h     
            mov ah, 02h     
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
        
        ; captura de operandos
        mov ah, 09h
        lea dx, msg1
        int 21h  
        
        call leer_numero
        
        push bx   
           
        mov ah, 09h
        lea dx, msg2
        int 21h
        
        call leer_numero
        
        push bx
        
        ; mostrar menu
        mov ah, 09h
        lea dx, msgo
        int 21h
        
        ; como estoy sumamente gaga, voy a hacer un control de errores
        call leer_numero
        cmp bx, 4
        ja reintento 
        
        cmp bx, 1
        jb reintento
          
        jmp continuar
         
        ; limpieza
        mov ax, 0
        mov dx, 0     
        
        reintento:
            mov ah, 09h
            lea dx, msge
            int 21h
            
            call leer_numero
            cmp bx, 4
            ja reintento
            jb continuar    S
        
        ; case of    
        continuar:
            cmp bx, 1
            je suma
            
            cmp bx, 2
            je resta
            
            cmp bx, 3
            je producto
            
            cmp bx, 4
            je division      
         
        ; operaciones 
        suma: 
            pop ax      ; use la pila porque es mas practico y no tengo que reservar memoria directamente
            pop dx      ; no interesa quien es mas grande en la suma
            add ax, dx 
            jmp end
       
       resta: 
            pop ax      ; da igual como los saque porque controlo abajo
            pop dx
            cmp ax, dx
            ja nada     ; para no trabajar con negativos :)
            
            xchg ax, dx
                
            nada:
                sub ax, dx
                jmp end
       
       producto:
            pop ax      ; en el producto tampoco importa quien es mas grande
            pop dx
            mul dx
            jmp end
       
       division:
            pop bx
            pop ax      ; OHIO!!! aca manda lo otro a dx
                   
            xor dx, dx  ; es lo mismo que hacer mov dx, 0, pero bueno, burplerias
            cmp bx, 0
            je errord 
             
            div bx
            jmp end 
            
            errord:
                mov ah, 09h
                lea dx, msged
                int 21h
                
                mov ah, 4ch
                int 21h
     
        end:
            push ax
            ; imprimo el resultado
            mov ah, 09h
            lea dx, msgr
            int 21h
            
            pop ax
            call horner            
                 
            mov ah, 4ch
            int 21h        
    main endp 
end main
