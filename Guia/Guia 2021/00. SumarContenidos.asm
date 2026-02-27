; Realice un programa Assembler que permita:
    ; sumar el contenido de las siguientes direcciones: 2Ah, 2Bh, 2Ch y 2Dh
    ; guardando el resultado en 2Eh.
; Cargar dichas direcciones previamente con los valores de operandos.

org 100h ; los primeros 256 bytes  estan reservados por el SO para el PSP (Program Segment Prefix)
             
; cargo valores a las posiciones             
             
mov al, 1
mov [2ah], al

mov al, 2
mov [2bh], al

mov al, 3
mov [2ch], al

mov al, 4
mov [2dh], al

; opero
                          
mov al, [2dh] ; esto es redundante, pero bueno, hay que ser fieles al enunciado
add al, [2ch]
add al, [2bh]
add al, [2ah]

mov [2eh], al
             
ret
