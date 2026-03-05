title 'Final 01-08-2024'
include 'emu8086.inc'
.model small
.stack
.data

    numeros db 50 dup(?)
    caracteres db 50 dup(?)
.code
    
    ; Inicializo segmento de datos
    mov dx, @data
    mov ds, dx
    
    ; Inicializo indices para vectores y cargo cx
    xor si, si
    xor di, di
    
    printn 'Ingrese sus valores numericos o caracteres y termine con ENTER'
    
    ingreso:
    
        mov ah, 01h
        int 21h 
        
        cmp al, 13d
        je fin_ingreso  ; Comparo con 13d que es el ENTER para saber si termino
        
        cmp al, 48d     ; Comparo con 48d porque entre ese y 57d se encuentran los numeros
        jl caracter
        
        cmp al, 57d
        jg caracter
        
        mov numeros[si], al     ; Guardo si es numero
        inc si
         
        jmp ingreso   
    
        ; Guarda en el otro vector caso que no sea numero    
        caracter:
        
            mov caracteres[di], al
            inc di
            
            jmp ingreso
    
    fin_ingreso:
    
    ; Resguardo valores de indices para recorrer
    mov bx, si
    mov cx, di
    
    xor si, si
    xor di, di
    
    ; Imprimo un salto de linea
    printn ' '
    print 'Los numeros encontrados son: '    

    num:
    
        mov dl, numeros[si] 
        
        mov ah, 02h   ; Interrupcion para mostrar por caracter
        int 21h
        
        inc si
        dec bx
        cmp bx, 0
        jne num
        
    ; Imprimo un salto de linea
    printn ' '
    print 'Los caracteres encontrados son: '
    
    car:
    
        mov dl, caracteres[di] 
        
        mov ah, 02h   ; Interrupcion para mostrar por caracter
        int 21h
        
        inc di
        dec cx
        cmp cx, 0
        jne car    
        
    fin:
    
        mov ah, 4ch
        int 21h
