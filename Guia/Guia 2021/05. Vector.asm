; Cargar un vector por teclado, con 10 elementos e  
; imprimir por pantalla los valores ingresados, 
; separados por comas. 

include 'emu8086.inc' ; especifico que voy a usar una libreria

.model small       ; modelo de memoria
.stack 100h        ; segmento de pila, reserva los 256 bytes obligatorios

.data              ; Segmento de datos (Ambiente)
    vec db 10*10 dup(?)  ; el dup reserva un vector de 10*10 posiciones sin nada y si..., es un vector de vectores
    
    str db 11, ?, 11 dup('$')  ; 20 chars (1 para el enter), aca el SO lee el byte, aca carga el byte posta
    
    
.code               ; Segmento de codigo (Proceso)
    main proc
        ; en .small hay que "apuntar" DS al inicio de .data manualmente.     
        mov ax, @data   
        mov ds, ax      
        
        ; como tengo ganas de hacer burplerias, voy a usar strings
        
        ; CARGA DE DATOS AL VECTOR
        lea di, vec ; le digo a di que apunte al vector
        mov dx, 10
        mov cx, 10  ; ciclo principal para el vector 
        forx:       ; for: 0 to 10
            push cx ; como voy a usar otro ciclo, resguardo
            
            mov cx, dx
            print 'Ingrese un string (10 chars como maximo)' 
            printn
            fory:               ; este loop se encarga de armar el string
                mov ah, 01h 
                int 21h
                
                cmp al, 0dh     ; comparo para ver si es enter, esto hace una resta temporal interna
                je fill         ; salta si la resta es 0 (zf = 1)
                
                
                mov [di], al    ; direccionamiento indirecto para guardar en el vector
                inc di          ; incrementa la direccion del puntero (se mueve un  char adelante)
             
            loop fory 
            jmp  skip           ; si el user SI cargo 10 chars, skipeo el fill
            
            fill:
                mov byte ptr [di], ' ' ; le dice al SO "agarra el  '$', a la dir a donde apunta DI, y guardalo ahi ocupando exactamente 1 byte"
                inc di                 
            
            loop fill
            
            skip:              
                pop cx          ; saco para que se autodecremente
   
            printn   
        loop forx  
        
        ; IMPRESION
        lea si, vec
        mov cx, 10
        forz:
            push cx
            mov cx, 10
            forw:
                mov ah, 02h     ; print char
                mov dl, [si]    ; dl = contenido de la mc en [si]
                int 21h             
                inc si                
            loop forw
            
            pop cx
            cmp cx, 1               ; cx = 1 implica q estamos en el ultimo elemento
            je halt
            
            print ', '
            loop forz
  
        halt:
            mov ah, 4ch
            int 21h        
    main endp
    
    ; pongo las funciones que traigo desde la libreria
    define_get_string
    define_print_string  
end main
