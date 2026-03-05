title 'Final 26-02-2026'
include 'emu8086.inc'
.model small
.stack
.data

    suma db 0d
    aprob db 0d
    min db 9d
    alumnos db 8 dup(?)
.code
    
    ; Inicializo segmento de datos
    mov dx, @DATA
    mov ds, dx
    
    mov cx, 8
    xor si, si
    
    ; Uso libreria solo para imprimir mensajes, eso dejan
    print 'Ingrese 8 notas: '
    
    pedir:
        
        ; pedir caracter
        mov ah, 01h
        int 21h
        
        ; convierto a entero
        sub al, 48d
        
        ; copio al vector
        mov alumnos[si], al
        
        inc si
        dec cx
        cmp cx, 0
        jne pedir
    
    ; ===== PROMEDIO =====
    
    printn ' '
    xor si, si
    xor ax, ax
    mov cx, 8
        
    promedio:
    
        mov bl, alumnos[si]
        add suma, bl            ; Sumo para despues dividir
        
        inc si
        dec cx
        cmp cx, 0
        jne promedio
        
    xor bl, bl
    mov al, suma
    mov bl, 8d
    
    ; Division -> al = cociente / ah = resto 
    div bl
    ; Resguardo para mostrar
    mov dl, al
    mov dh, ah
    
    ; Mostrar
    print 'El promedio es: '
    
    add dl, 48d
    mov ah, 02h
    int 21h
    
    putc ','
    
    mov dl, dh
    add dl, 48d
    mov ah, 02h
    int 21h
    
    ; ===== APROBADOS =====
    
    printn ' '
    xor si, si
    xor bx, bx
    xor ax, ax
    mov cx, 8
    
    aprobados:
    
        mov bl, alumnos [si]
        cmp bl, 5
        jb menor     ; Si es menor a 5 no incrementa los aprobados
        
        inc aprob
        
        menor:
        
            inc si
            dec cx
            cmp cx, 0
            jne aprobados       
    
    xor bl, bl
    mov al, aprob
    mov bl, 10
    
    ; Division -> al = cociente / ah = resto 
    div bl
    ; Resguardo para mostrar
    mov dl, al
    mov dh, ah
    
    ; Mostrar
    print 'La cantidad de alumnos aprobados es: '
    
    add dl, 48d
    mov ah, 02h
    int 21h
    
    mov dl, dh
    add dl, 48d
    mov ah, 02h
    int 21h
    
    ; ===== CALIF. BAJA =====
    
    printn ' '
    xor si, si
    xor bx, bx
    xor ax, ax
    mov cx, 8
    
    baja:
    
        mov bl, alumnos[si]
        cmp bl, min
        jg nomin
        
        mov min, bl
        
        nomin:
        
             inc si
             dec cx
             cmp cx, 0
             jne baja
             
    print 'La calificacion mas baja es: '
    mov dl, min
    add dl, 48d
    mov ah, 02h
    int 21h
