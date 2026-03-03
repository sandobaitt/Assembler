title 'Final 20-02-2025'
include 'emu8086.inc'
.model small
.stack
.data

    numeros db 11 dup(?) ;Creo ambos de 10 posiciones (+1 para el $) ya que no se cuantos van a a haber de cada uno
    caracteres db 10 dup(?)
.code
    
    ; Inicializo segmento de datos
    mov dx, @data
    mov ds, dx
    
    ; Inicializo indices para vectores y cargo cx
    xor si, si
    xor di, di
    mov cx, 10d
    
    printn 'Ingrese sus 10 valores a continuacion'
    
    ingreso:
    
        mov ah, 01h
        int 21h
        
        cmp al, 48d   ; Comparo con 48d porque entre ese y 57d se encuentran los numeros
        jl no_numero
        
        cmp al, 57d
        jg no_numero
        
        mov numeros[si], al     ; Guardo si es numero
        inc si
         
        dec cx
        cmp cx, 0
        jne ingreso
        
        ; Una vez que termina cx, salto a mostrar
        jmp fin_ingreso    
    
        ; Guarda en el otro vector caso que no sea numero    
        no_numero:
        
            mov caracteres[di], al
            inc di
            
            dec cx
            cmp cx, 0
            jne ingreso
    
    fin_ingreso:
        
    ; Cargo un $ para saber que termino
    mov numeros[si], '$'
        
    ;Inicializo indice y registros para motsrar
    xor si, si
    xor dx, dx
    xor ax, ax
    
    ; Imprimo un salto de linea
    printn ' '
    
    printn 'Los numeros encontrados son: '    

    mostrar:
    
        mov dl, numeros[si] 
        
        cmp dl, '$'   ; Compruebo si termino
        je fin
        
        mov ah, 02h   ; Interrupcion para mostrar por caracter
        int 21h
        
        inc si
        jmp mostrar
        
    fin:
    
        mov ah, 4ch
        int 21h
