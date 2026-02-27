# 📚 BASICO Assembler - Guía Completa

## ======== Introduccion ========

### == Comentarios ==
[cite_start]En emu8086 los comentarios que no afecten al funcionamiento y al codigo se hacen post un `;`[cite: 329].

### == ASCII ==
[cite_start]Valores mas usados son estos[cite: 330]:

| Valor | Simbolo | Uso comun |
| :--- | :--- | :--- |
| 10d | Salto de linea | [cite_start]Baja el cursor a la siguiente fila[cite: 331]. |
| 13d | Retorno de carro | [cite_start]Mueve el cursor al inicio (Enter)[cite: 332]. |
| 32d | Espacio | [cite_start]Caracter de espacio en blanco[cite: 333]. |
| 36d | Signo $ | [cite_start]Fin de cadena para el servicio 09h[cite: 334]. |
| 48d-57d | Numeros '0' a '9' | [cite_start]Caracteres numericos[cite: 335]. |
| 65d-90d | Letras 'A' a 'Z' | [cite_start]Letras mayusculas[cite: 336]. |
| 97d-122d | Letras 'a' a 'z' | [cite_start]Letras minusculas[cite: 337]. |

**PRO TIPS:**
* [cite_start]**Para pasar de minuscula a MAYUSCULA:** Resto 32d en decimal o 20h en hexa (`sub al, 32` o `sub al, 20h`)[cite: 340].
* [cite_start]**Para pasar de MAYUSCULA a minuscula:** Sumo 32d en decimal o 20h en hexa (`add al, 32` o `add al, 20h`)[cite: 341].
* [cite_start]**De Caracter ASCII a Valor Numerico:** Resto 48d en decimal o 30h en hexa (`sub al, 48` o `sub al, 30h`)[cite: 342].
* [cite_start]**De Valor Numerico a Caracter ASCII:** Sumo 48d en decimal o 30h en hexa (`add al, 48` o `add al, 30h`)[cite: 343].

---

## ======== Registros ========

### Registros generales (16 bits en 8086)
[cite_start]Estos registros se pueden dividir en parte ALTA (High) y BAJA (Low)[cite: 345]. [cite_start]AX se divide en AH (bits 15-8) y AL (bits 7-0)[cite: 349].

| Reg. | Nombre | Funcion Principal |
| :--- | :--- | :--- |
| **AX** | ACUMULADOR | [cite_start]Operaciones aritmeticas[cite: 346]. |
| **BX** | BASE | [cite_start]Indice para direccionamiento de memoria[cite: 347]. |
| **CX** | CONTADOR | [cite_start]Contador para bucles (LOOP) y repeticiones[cite: 348]. |
| **DX** | DATOS | [cite_start]Multiplicacion/Division y direcciones E/S[cite: 348]. |

### Registros Indice
[cite_start]Para trabajar con vectores y arreglos[cite: 350].

| Reg. | Nombre | Uso común |
| :--- | :--- | :--- |
| **SI** | FUENTE (Source) | [cite_start]Puntero de origen en copias de cadenas[cite: 351]. |
| **DI** | DESTINO (Dest) | [cite_start]Puntero de destino en copias de cadenas[cite: 352]. |

### Registros Apuntadores (Control de Pila e Instruccion)

| Reg. | Nombre | Función |
| :--- | :--- | :--- |
| **BP** | BASE (Base P.) | [cite_start]Apunta a la base de la pila (stack frame)[cite: 354]. |
| **SP** | PILA (Stack P.) | [cite_start]Apunta al tope de la pila (PUSH/POP)[cite: 355]. |
| **IP** | INSTRUCCIÓN | [cite_start]Direccion de la siguiente instruccion[cite: 356]. |

### Diferentes tamaños de registros (Visualizacion de bits)
[cite_start]Para entender como los nombres cambian segun la capacidad[cite: 358]:
* **64 bits:** `[ RAX ]` (Extendido - x64)
* **32 bits:** `[ EAX ]` (Extendido - x86)
* **16 bits:** `[ AX ]` <-- Este es el que usas en emu8086
* **8 bits:** `[ AH | AL ]` (Parte alta y baja) [cite: 359]

---

## ======== Formato del codigo ========

```assembly
title 'el titulo'

include 'emu8086.inc' ; Librerias

.model small ; Declaracion del programa

.stack 1024  ; Segmento de pila por defecto

.data        ; Segmento de datos
    ; Todas las declaraciones -------------
    ; var 1
    ; var 2

.code        ; Segmento de codigo
    main PROC
        ; Inicializacion del segmento de datos (obligatorio en .model small)
        mov ax, @data
        mov ds, ax

        ; Instruccion 1...

    main ENDP   
end main
```

---

## ======== title ========
[cite_start]Es opcional[cite: 373]. Para ponerle nombre a tu ejercicio:
`title 'el nombre que quieras'`

---

## ======== include ========

### == 'emu8086.inc' ==
[cite_start]Coleccion de macros (instrucciones que expanden a multiples lineas de codigo) y procedimientos que actuan como una capa de abstraccion sobre las interrupciones de BIOS y DOS[cite: 374, 375]. [cite_start]Su uso principal es reducir la complejidad visual del codigo y evitar errores comunes al manipular registros para tareas basicas de entrada y salida[cite: 376, 377].

**Macros vs. Procedimientos**

* **Macros:** Atajos que el ensamblador expande en el codigo. [cite_start]Nunca se usa la instrucción `CALL` con ellas[cite: 379, 380].
    * [cite_start]`print 'texto'`: Imprime una cadena en la posicion actual[cite: 380].
    * [cite_start]`printn 'texto'`: Igual que PRINT, pero añade un salto de linea automatico[cite: 381].
    * [cite_start]`putc char`: Imprime un solo caracter (puede ser un registro como dl o una constante)[cite: 382].
    * [cite_start]`gotoxy col, fila`: Mueve el cursor a coordenadas especificas[cite: 383].

* **Procedimientos:** Bloques de codigo mas complejos que viven al final del programa. [cite_start]SIEMPRE se usan con `CALL` para ejecutarlos y se definen al final del archivo[cite: 384, 385, 386].
    * [cite_start]`scan_num`: Lee un número del teclado y lo guarda en `cx`[cite: 386].
    * [cite_start]`print_num`: Imprime el valor numerico contenido en `ax`[cite: 386].
    * [cite_start]`print_num_uns`: Igual que el anterior, pero para numeros sin signo[cite: 386].
    * [cite_start]`clear_screen`: Borra toda la pantalla de la consola[cite: 386].

[cite_start]Para definir procedimientos se lo hace debajo de la interrupcion del final del codigo (`mov ah, 4ch` / `int 21h`)[cite: 388]:
```assembly
define_clear_screen
```

---

## ======== .model ========
[cite_start]Define el tamaño de los segmentos de datos y de codigo que se va a utilizar[cite: 390].
Sintaxis: `.model [tamaño]`

| Nombre | Definicion |
| :--- | :--- |
| **tiny** | [cite_start]El codigo y los datos deben caber en un solo segmento de 64 KB[cite: 391]. |
| **small** | Es el más usado. [cite_start]El código tiene su propio segmento (64 KB) y los datos el suyo (64 KB)[cite: 391, 392]. |
| **medium** | [cite_start]El codigo puede ser muy grande (varios segmentos), pero los datos deben caber en uno solo[cite: 392]. |
| **large** | [cite_start]Tanto el codigo como los datos pueden ocupar varios segmentos[cite: 393]. |

---

## ======== .stack ========
[cite_start]Sintaxis: `.stack [tamaño en bytes]` [cite: 394]
[cite_start]Si pones solo `.stack`, el ensamblador reserva automaticamente 1024 bytes[cite: 394].

La pila es una estructura LIFO (Last In, First Out). [cite_start]En 8086, la pila crece hacia abajo en la memoria, por lo que al meter datos, el puntero `sp` disminuye[cite: 395, 396, 397].
* [cite_start]**PUSH (Empujar):** Guarda un valor de 16 bits en la pila y resta 2 a SP[cite: 397].
* [cite_start]**POP (Sacar):** Recupera el último valor guardado, lo pone en un registro y suma 2 a SP[cite: 397].

Uso principal: Preservar registros. [cite_start]Si se va a usar `ax` en un procedimiento pero no queremos perder su valor original, se hace un `push ax` al inicio y un `pop ax` al final[cite: 398, 399].

---

## ======== .data ========

### Tamaños de variables
| Nombre | Definicion | Rango |
| :--- | :--- | :--- |
| **db** | define byte: Reserva 8 bits | [cite_start]0 a 255 (decimal)[cite: 400]. |
| **dw** | define word: Reserva 16 bits | [cite_start]0 a 65 535 (decimal)[cite: 401]. |
| **dd** | define double word: Reserva 32 bit | [cite_start]0 a 4 294 967 295[cite: 401]. |

### Ejemplos de definiciones en .data
```assembly
var1 db 200d 
var2 dw 60000d
var3 dd 90000d
var4 db ?    ; Si no tengo un contenido todavia
```

### Ejemplos de error (overflow)
* [cite_start]`err1 db 256d` ; error: el máximo es 255, 256 requiere 9 bits[cite: 404, 405].
* [cite_start]`err2 dw 65536d` ; error: el máximo es 65 535[cite: 405, 406].

### Otros usos
* **Vectores con valores:** Se definen separando valores por comas.
    `precios db 10, 20, 30, 40` ; Crea una lista de 4 bytes contiguos[cite: 407, 408].
* **Vectores vacios:**
    `vector2 db 10 dup(?)` ; Crea 10 espacios de 1 byte cada uno sin valor inicial[cite: 408].
* **Cadenas de texto:** Se encierran en comillas.
    `saludo db "hola$"` ; El $ sirve para que la interrupción 09h sepa dónde termina el texto[cite: 408, 409].

---

## ======== .code ========

### == Operadores aritmeticos ==
| Reg. | Funcion | Ejemplo | Resultado en |
| :--- | :--- | :--- | :--- |
| **ADD** | Suma | [cite_start]`add ax, bx` | ax = ax + bx [cite: 410] |
| **SUB** | Resta | [cite_start]`sub bx, ax` | bx = bx - ax [cite: 411] |
| **INC** | Incremento (+1) | `inc si` | [cite_start]Registro + 1 [cite: 411] |
| **DEC** | Decremento (-1) | `dec cx` | [cite_start]Registro - 1 [cite: 411, 412] |
| **MUL** | Multiplicacion | [cite_start]`mul bx` | ax (o dx:ax) [cite: 412] |
| **DIV** | Division | [cite_start]`div bx` | al=cociente, ah=resto [cite: 412] |

### == Operadores logicos ==
| Reg. | Logica | Uso Comun / Ejemplo |
| :--- | :--- | :--- |
| **AND** | 1 y 1 = 1 | [cite_start]Filtros y mascaras de bits[cite: 414]. |
| **OR** | 1 o X = 1 | [cite_start]Encender bits especificos[cite: 414]. |
| **XOR** | Diferentes = 1 | [cite_start]Poner a 0 un registro (`xor ax, ax`)[cite: 415]. |
| **NOT** | Invierte (0->1) | [cite_start]Complemento a 1 del valor[cite: 415]. |

### == Etiquetas y saltos ==
En ensamblador se leen las instrucciones de arriba hacia abajo. [cite_start]Para romper ese orden, se usan etiquetas y saltos[cite: 416, 417].

* **Etiquetas:** Se escriben en minusculas seguidas de dos puntos (ej: `etiqueta1:`). [cite_start]Sirven como puntos de referencia para los saltos; no ocupan espacio en la memoria final[cite: 418, 419].
* **Comparacion (cmp):** Paso previo a un salto condicional. [cite_start]Compara dos valores restandolos internamente para activar banderas (`cmp al, 13d`)[cite: 422, 423].

**Saltos Condicionales (Solo se ejecutan si el resultado de cmp cumple la condición):**
| Reg. | Significado | Condición de Salto (tras CMP) |
| :--- | :--- | :--- |
| **JE** | Jump if Equal | [cite_start]Salta si los valores son iguales[cite: 426]. |
| **JNE** | Jump Not Equal | [cite_start]Salta si son diferentes[cite: 426]. |
| **JG** | Jump if Greater | [cite_start]Salta si el primero es mayor[cite: 426]. |
| **JGE** | J. Greater Equal | [cite_start]Salta si es mayor o igual[cite: 427]. |
| **JL** | Jump if Less | [cite_start]Salta si el primero es menor[cite: 427]. |
| **JLE** | J. Less Equal | [cite_start]Salta si es menor o igual[cite: 427, 428]. |
| **JA** | Jump Above | [cite_start]Superior (para números sin signo)[cite: 428]. |
| **JB** | Jump Below | [cite_start]Inferior (para números sin signo)[cite: 428]. |

* [cite_start]**Salto Incondicional (jmp):** Salta a la etiqueta indicada sin evaluar ninguna condición (`jmp Etiqueta1`)[cite: 429].

### == Vectores ==
A diferencia de otros lenguajes, no se accede de forma estatica a un vector. [cite_start]Se usa un registro de indice para "señalar" la posición[cite: 431, 432].
* [cite_start]**Indice si (Source Index):** Se usa tradicionalmente para leer un vector de origen[cite: 433].
* [cite_start]**Indice di (Destination Index):** Se usa para escribir en un vector de destino[cite: 434].

Se inicializan siempre los que se vayan a usar:
```assembly
xor si, si       ; empezamos en la posicion 0 del origen
xor di, di       ; empezamos en la posicion 0 del destino
mov cx, 10d      ; contador para recorrer 10 elementos
```
Para mover datos de un vector se usan registros intermedios, gereralmente `al`, `bl` o `dl`:
```assembly
mov bl, vector1[si] ; Paso dato al registro
mov vector2[di], bl ; Paso el registro al nuevo vector
```

### == Direccionamiento ==
| Comando | Tipo de Operacion | Cuando se calcula la direccion |
| :--- | :--- | :--- |
| **OFFSET** | Estatica (Fija) | El compilador la calcula ANTES de que el programa se ejecute. (Ej: `mov dx, offset vector`). [cite_start]No acepta indices[cite: 441, 442, 445, 446]. |
| **LEA** | Dinamica (Variable)| El procesador (CPU) la calcula MIENTRAS el programa esta corriendo. (Ej: `lea dx, mi_vector[si]`) [cite_start][cite: 443, 448, 449, 450]. |

### == Bucles ==

**1. Condicional o manual:** Es el que se construye usando etiquetas y saltos condicionales. [cite_start]Se usa cuando no sabemos cuántas veces se repetirá el proceso (como leer un teclado hasta que presionen "Enter")[cite: 451, 452, 453].
```assembly
esperar_punto:
    mov ah, 01h          ; servicio para leer un caracter
    int 21h              ; el caracter queda en al
    cmp al, "."          ; ¿el usuario escribio un punto? 
    je salir_del_bucle   ; si es igual (je), saltamos al final 
    jmp esperar_punto    ; si no fue punto, saltamos al inicio para repetir 
salir_del_bucle:
```

**2. Contador:** Mas eficiente cuando sabemos exactamente el numero de repeticiones. [cite_start]Utiliza el registro `cx` como contador[cite: 460, 461]. Al ejecutar la instruccion `loop`, el procesador resta 1 a `cx` automaticamente. [cite_start]Si `cx` no es cero, vuelve a la etiqueta; si es cero, continua con la siguiente línea[cite: 462, 463, 464].
```assembly
mov cx, 10d          ; queremos repetir 10 veces
inicio_bucle:
    ; instrucciones a repetir
loop inicio_bucle    ; decrementa cx y salta a inicio_bucle si cx > 0
```

**3. [cite_start]Indices:** Se usa para recorrer cadenas o arreglos combinando registros como `si` y `di`[cite: 468].

### == Interrupciones ==
[cite_start]Para usar uno, hay que tener en cuenta estos tres pasos[cite: 479]:
1.  [cite_start]`ah`: Se pone el numero del servicio especifico[cite: 480].
2.  [cite_start]Registros de datos: Se prepara la información necesaria[cite: 481].
3.  [cite_start]`int`: Ejecutas la instruccion[cite: 482].

**Servicios comunes:**
| Serv. | Funcion | Registro Clave / Preparacion |
| :--- | :--- | :--- |
| **01h** | Leer Caracter | [cite_start]Resultado queda en AL[cite: 483]. |
| **02h** | Imprimir Caracter | [cite_start]Poner el caracter en DL antes[cite: 483, 484]. |
| **09h** | Imprimir Cadena | [cite_start]Direccion en DX (debe terminar en $)[cite: 484]. |
| **0Ah** | Leer Cadena | [cite_start]Poner direccion del buffer en DX[cite: 484]. |
| **4Ch** | Terminar Prog. | [cite_start]Obligatorio para salida limpia[cite: 484, 485]. |

### == Procedimientos ==
* [cite_start]`proc`: Indica el inicio de un procedimiento[cite: 512].
* `endp`: Indica el final del procedimiento[cite: 512].
* [cite_start]`call`: Se usa para saltar al procedimiento y ejecutarlo[cite: 512].
* [cite_start]`ret`: le dice al procesador que regrese al lugar exacto donde lo llamaron[cite: 512, 513].

**Como usarlo:**
```assembly
un_nombre proc
    ; instrucciones
    ret              ; vuelve a donde fue llamado
un_nombre endp

main proc
    ; ... instrucciones antes...
    call un_nombre   ; ejecuta el salto y vuelve aquí
    ; ... instrucciones despues ...
main endp
```
