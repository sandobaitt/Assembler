```asm
; Realice un programa que sume dos numeros enteros, ingresados por teclado.
; NOTA: es redundante lo de "enteros", ya que 8086 no tiene soporte para decimales. Para poder usar numeros (con flotante o fija) se precesisaba de un coprocesador (como el 8087).
org 100h

mov ah, 01h    ; codigo para leer del teclado
int 21h        ; interrupcion (el ascii queda en al)
sub al, 48     ; al restar 48 pasa de ascii al entero real
mov n1, al     ; n1 = numero del teclado       

mov ah, 01h
int 21h
sub al, 48
mov n2, al

; para sumar voy a usar ambas partes del acumulador porque, al ser un caracter, la entrada siempre sera 1 byte
mov al, n1   ; al = n1
mov ah, n2   ; ah = n2
add al, ah   ; al = n1 + n2
mov suma, al
                              
mov ah, 0    ; limpio la parte alta del acumulador                           
                                                    
ret      

n1 db ? ; el '?' es para reservar espacio de memoria
n2 db ?
suma db ?
