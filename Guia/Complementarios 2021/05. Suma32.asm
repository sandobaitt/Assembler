; Realice un programa que sume dos numeros hexadecimales de 32 bits previamente definidos. 
.model small       
.stack 100h        

.data             
    ; el valor maximo posible en 32 (double word) bits SIN signo
    num1 dd 0FFFFFFFFh  ; 4294967295
    num2 dd 12345678h   ; 305419896
    
    ; dato de color: como x86 trabaja con "little endian", este ultimo dato no se guarda asi en la MC. 
    ; se guarda "dado vuelta" en bloques de bytes: 78 56 34 12
    ; basicamente posiciona empezando desde el MENOS significativo
    
.code                  
    main proc       
        mov ax, @data  
        mov ds, ax     
        
        ; divido 32 bits en dos partes de 16. Es la misma logica que ax = ah + al
        mov ax, word ptr num1
        mov bx, word ptr [num1+2]     ; el +2 skipea los primeros 16 bits
         
        mov cx, word ptr num2
        mov dx, word ptr [num2+2]
        
        ; necesitamos todos los GPR para hacer esto
        
        add ax, cx                    ; add es un semisumador, NO considera al carry 
        adc bx, dx                    ; adc es una suma CON carry, porque justamente considera el carry 
                                      ; adc es basicamente elsumador completo en paralelo

        ; esta suma supera los 32 bits, asique se va a activar cf
        end:
            mov ah, 4ch
            int 21h        
    main endp 
end main
