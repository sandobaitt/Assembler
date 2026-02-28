; Con este final aprobé! :)

mov cx, 8

ingresar:
    mov dx, offset msje
    mov ah, 09h
    int 21h
    
    mov ah, 01h           
    int 21h
    
    sub al, 30h
    
    add promedio, al
    
    cmp al, baja
    jl notamenor
       
    jmp controlaprobado
    
notamenor:
    mov baja, al
    jmp controlaprobado

controlaprobado:
    cmp al, 6
    jge aprobado 
    
    jmp fin      

aprobado:
    inc totalap
    jmp fin
    
fin: 
    ;salto de linea
    mov dl, 13
    mov ah, 02h
    int 21h

    mov dl, 10
    int 21h 
    
    loop ingresar 
    


mov dx, offset msjeprom
mov ah, 09h
int 21h

mov ah, 0
mov al, promedio
mov bl, 8
div bl


call imprimir

;salto
mov dl, 13
mov ah, 02h
int 21h

mov dl, 10
int 21h 

mov dx, offset msjetotalap
mov ah, 09h
int 21h

mov al, totalap
call imprimir

;salto
mov dl, 13
mov ah, 02h
int 21h

mov dl, 10
int 21h 

mov dx, offset msjemasbaja
mov ah, 09h
int 21h

mov al, baja
call imprimir




ret

imprimir:
    mov ah, 0
    mov bl, 10
    div bl
    
    mov bx, ax 
    
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h
    
    mov dl, bh
    add dl, 30h
    int 21h
    ret  


promedio db 0
totalap db 0
baja db 10 

msje db "Ingrese la calificacion: $" 
msjeprom db "Promedio del curso: $"
msjetotalap db "Total de alumnos aprobados: $"
msjemasbaja db "La calificacion mas baja fue: $"     
