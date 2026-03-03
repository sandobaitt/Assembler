title 'Final 19-02-2026'
include 'emu8086.inc'
.model small
.stack
.data

    vector db 10 dup(?)   ; vector para guardar 10 digitos
    mayor_num db ?        ; numero mayor
    cant db ?             ; cantidad de pares
    sumando db ?          ; suma de los elementos del vector

.code
    
    ; Inicializo segmento de datos
    mov dx, @data
    mov ds, dx
    
    ; Inicializo indice y contador
    xor si, si
    mov cx, 10
    
    ; ------------------------------
    ; ------- Pido Valores ---------
    ; ------------------------------
    
    print 'Ingrese 10 valores numericos: '
    
    ; Bucle para guardar valores
    pido:
        
        ; Pido valor
        mov ah, 01h
        int 21h
        
        ; Lo convierto a entero para poder operar
        sub al, 48d 
        
        ; Guardo valor en el vector
        mov vector[si], al
        
        ; Incremento indice para otra posicion
        inc si
        dec cx
        cmp cx, 0
        jne pido 
    
    ; ------------------------------
    ; ----------- Pares ------------
    ; ------------------------------
    
    printn ' '
    ; Inicializo valores para las operaciones
    xor ax, ax    
    xor si, si
    mov cx, 10
    
    pares:
        
        xor ax, ax
        mov al, vector[si]
        
        resta:
            
            cmp al, 0  ; A 0 lo considero par
            je par
             
            sub al, 2
            cmp al, 0
            je par
            
            cmp al, 1
            je impar
            
            jmp resta
            
            par:
            
                add cant, 1d    ; Si es par, a cant le sumo 1
                
            impar:
            
                inc si
                dec cx
                cmp cx, 0
                jne pares
                
    ; ------------------------------
    
    print 'La cantidad de numeros pares es: '
    
    xor ax, ax
    xor cx, cx
    xor bx, bx
    mov al, cant
    
    ; Division --> al div bl => al = cociente y ah = resto
    mov bl, 10d
    mov ah, 0
    div bl
    
    ; Resguardo para mostrar 
    mov dh, ah  ; resto
    mov dl, al  ; cociente
               
    ; Muestro cociente           
    add dl, 48d ; convierto a caracter para mostrar con la interrupcion
    mov ah, 02h ; interrupcion para mostrar caracter lo que tiene dl
    int 21h
    
    ; Muestro resto
    mov dl, dh
    add dl, 48d ; convierto a caracter para mostrar con la interrupcion
    mov ah, 02h ; interrupcion para mostrar caracter lo que tiene dl
    int 21h
     
    ; ------------------------------
    ; ----------- Mayor ------------
    ; ------------------------------ 

    xor ax, ax
    xor dx, dx     
    xor si, si
    mov cx, 10
    mov mayor_num, 0
    
    mayor:
    
        mov al, vector[si]
        
        cmp mayor_num, al   ; Comparo mayor_num con el valor del vector en esa posicion
        jb num_m            ; Si es menor, es porque al es mas grande
        jmp controlo
        
        num_m:
                    
            mov mayor_num, al   ; Asigno nuevo valor mayor
            
        controlo:
            
            inc si
            dec cx
            cmp cx, 0
            jne mayor
            
    ; ------------------------------------
        
    printn ' '
    print 'El numero mas grande es: '
    
    xor ax, ax
    xor dx, dx
    xor cx, cx
    xor bx, bx
    mov bl, mayor_num
    
    mov dl, mayor_num
    add dl, 48d
    
    mov ah, 02h
    int 21h
    
    ; ------------------------------
    ; ----------- Mayor ------------
    ; ------------------------------
        
    xor si, si          
    mov cx, 10
    xor bx, bx
    mov sumando, 0    ; Asigno a sumando 0
                
    suma:
    
        mov al, vector[si]       
        add sumando, al     ; Le sumo el valor de al a sumando
                    
        inc si
        dec cx
        cmp cx, 0
        jne suma
    
    ; ------------------------------------
    
    printn ' '    
    print 'La suma de los valores es: '  
    
    xor ax, ax
    xor dx, dx
    xor bx, bx
    mov al, sumando
    
    ; Division --> al div bl => al = cociente y ah = resto
    mov bl, 10d
    mov ah, 0
    div bl
    
    ; Resguardo para mostrar 
    mov dh, ah  ; resto
    mov dl, al  ; cociente
               
    ; Muestro cociente           
    add dl, 48d ; convierto a caracter para mostrar con la interrupcion
    mov ah, 02h ; interrupcion para mostrar caracter lo que tiene dl
    int 21h
    
    ; Muestro resto
    mov dl, dh
    add dl, 48d ; convierto a caracter para mostrar con la interrupcion
    mov ah, 02h ; interrupcion para mostrar caracter lo que tiene dl
    int 21h
