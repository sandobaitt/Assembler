title 'Final 28-04-2022'
include 'emu8086.inc'
.model small
.stack
.data

    vector db 10, 55, 120, 5, 200, 33, 12, 99, 150, 4, 250, 1
    salida db 12 dup(?)
    
    num db ?

.code

    ; Inicializo segmento de datos
    mov ax, @data
    mov ds, ax
    
    print 'Ingrese numero de referencia (0-255) y ENTER: '
    xor bx, bx
    
    leer_digito:
        mov ah, 01h
        int 21h
        
        cmp al, 13d
        je fin_lectura
        
        sub al, 48d    
        xor ah, ah
        
        push ax         ; Guardar el digito hasta que lo necesite
        
        ; Total = (Total * 10) + Nuevo_Digito
        mov ax, bx      
        mov cx, 10
        mul cx          ; ax = bx * 10
        mov bx, ax      ; Guardo resultado parcial en bx
        
        pop ax          ; Recupero el digito
        add bx, ax      ; Sumamos: (Total * 10) + Digito
        
        jmp leer_digito
        
    fin_lectura:
        mov num, bl ; Guardamos el numero final en la variable (max 255)
        printn ' '
        
        xor si, si
        xor di, di
        mov cx, 12      ; Longitud del vector
        
    comparar:
        mov al, vector[si]
        
        cmp al, num
        jbe no_es_mayor
        
        mov salida[di], al
        inc di             
        
    no_es_mayor:
        inc si
        dec cx
        cmp cx, 0
        jne comparar
        
    print 'Los numeros mayores son: '
        
    cmp di, 0
    je ninguno
    
    mov cx, di      ; Cantidad de numeros a imprimir
    xor si, si
    
    imprimir_loop:
        mov al, salida[si]
        xor ah, ah      
        call print_num
        
        putc ' '        ; Espacio
        
        inc si
        dec cx
        cmp cx, 0
        jne imprimir_loop
        jmp fin
    
    ninguno:
        print 'Ninguno.'
    
    fin:
        mov ah, 4ch
        int 21h
    
    define_print_num
    define_print_num_uns
