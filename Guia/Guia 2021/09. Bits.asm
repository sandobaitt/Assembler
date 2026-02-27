; Recorrer un vector que cuente la cantidad de contenidos que tengan ceros en 
; los bits 0, 1, 4 y 5. 
; Al finalizar debe mostrar por pantalla: 
; la cantidad y los valores que cumplen la condicion.

include 'emu8086.inc'

.model small       
.stack 100h        

.data              ; Segmento de datos (Ambiente)
    vec1 dw 1024, 16, 255, 256, 222, 7, 33, 404, 41, 81   
    cont dw 0      ; por las dudas aseguro 16 bits
    vec2 dw 10 dup(0)
.code               
    main proc       
        mov ax, @data   
        mov ds, ax      
    
        lea si, vec1
        lea di, vec2
        
        mov cx, 10
        for:
            push cx
            ; mov cx, 16      ; 16 porque es word
            mov ax, [si]    ; |0000|0000| --> por dar un ejemplo del contenido
          
            ; bit 0
            ror ax, 1       ; rota 1 a la derecha, mete el bit MENOS significativo en el carry
            jc vrf          ; cy = 1, salta
            
            ; bit 1
            ror ax, 1       
            jc vrf 
            
            ; skip de bits 2 y 3. Hice un loop porque... tenia ganas 
            mov cx, 2
            forb:
              ror ax, 1
            loop forb 
                      
            ; bit 4
            ror ax, 1       
            jc vrf          
            
            ; bit 5
            ror ax, 1       
            jc vrf 
                  
            ; SI cumple
            inc word ptr [cont]      
            mov ax, [si]          
            mov [di], ax
            add di, 2
                  
            ; NO cumple
            vrf:
                rol ax, 6   ; reset posicional
                   
            pop cx
            add si, 2
        loop for   
        
        cmp [cont], 0
        je end
           
        mov cx, [cont]
        lea si, vec2
        print 'Los numeros que cumplen con la condicion son:'
        printn
         
        forp:
            mov ax, [si]

            call print_num
            printn
            
            add si, 2
            
        loop forp
        
        print 'Esto implica un total de:'
        print
        mov ax, [cont]
        call print_num   
           
        ; retorno
        end:
            mov ah, 4ch
            int 21h        
    main endp

    ; pongo las funciones que traigo desde la libreria
    define_scan_num
    define_print_num
    define_print_num_uns  
end main
