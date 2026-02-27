# BASICO Assembler

## ======== Introduccion ========

### == Comentarios ==
En emu8086 los comentarios que no afecten al funcionamiento y al codigo se hacen post un `;`.

### == ASCII ==
Valores mas usados son estos:

| Valor | Simbolo | Uso comun |
| :--- | :--- | :--- |
| 10d | Salto de linea | Baja el cursor a la siguiente fila. |
| 13d | Retorno de carro | Mueve el cursor al inicio (Enter). |
| 32d | Espacio | Caracter de espacio en blanco. |
| 36d | Signo $ | Fin de cadena para el servicio 09h. |
| 48d-57d | Numeros '0' a '9' | Caracteres numericos. |
| 65d-90d | Letras 'A' a 'Z' | Letras mayusculas. |
| 97d-122d | Letras 'a' a 'z' | Letras minusculas. |

**PRO TIPS:**
* **Para pasar de minuscula a MAYUSCULA:** Resto 32d en decimal o 20h en hexa (`sub al, 32` o `sub al, 20h`).
* **Para pasar de MAYUSCULA a minuscula:** Sumo 32d en decimal o 20h en hexa (`add al, 32` o `add al, 20h`).
* **De Caracter ASCII a Valor Numerico:** Resto 48d en decimal o 30h en hexa (`sub al, 48` o `sub al, 30h`).
* **De Valor Numerico a Caracter ASCII:** Sumo 48d en decimal o 30h en hexa (`add al, 48` o `add al, 30h`).

## ======== Registros ========

### Registros generales (16 bits en 8086)
Estos registros se pueden dividir en parte ALTA (High) y BAJA (Low)[cite: 345]. [cite_start]AX se divide en AH (bits 15-8) y AL (bits 7-0).

| Reg. | Nombre | Funcion Principal |
| :--- | :--- | :--- |
| **AX** | ACUMULADOR | Operaciones aritmeticas. |
| **BX** | BASE | Indice para direccionamiento de memoria. |
| **CX** | CONTADOR | Contador para bucles (LOOP) y repeticiones. |
| **DX** | DATOS | Multiplicacion/Division y direcciones E/S. |

### Registros Indice
Para trabajar con vectores y arreglos.

| Reg. | Nombre | Uso común |
| :--- | :--- | :--- |
| **SI** | FUENTE (Source) | Puntero de origen en copias de cadenas. |
| **DI** | DESTINO (Dest) | Puntero de destino en copias de cadenas. |

### Registros Apuntadores (Control de Pila e Instruccion)

| Reg. | Nombre | Función |
| :--- | :--- | :--- |
| **BP** | BASE (Base P.) | Apunta a la base de la pila (stack frame). |
| **SP** | PILA (Stack P.) | Apunta al tope de la pila (PUSH/POP). |
| **IP** | INSTRUCCIÓN | Direccion de la siguiente instruccion. |

### Diferentes tamaños de registros (Visualizacion de bits)
Para entender como los nombres cambian segun la capacidad:
* **64 bits:** `[ RAX ]` (Extendido - x64)
* **32 bits:** `[ EAX ]` (Extendido - x86)
* **16 bits:** `[ AX ]` <-- Este es el que usas en emu8086
* **8 bits:** `[ AH | AL ]` (Parte alta y baja)

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
    
    ; Inicializacion del segmento de datos (obligatorio en .model small)
    mov ax, @data
    mov ds, ax

        ; Instruccion 1...

    mov ah, 4ch    ; Para terminar el programa
    int 21h

    define_(procedimientos usados)

```


## ======== title ========
Es opcional. Para ponerle nombre a tu ejercicio:
`title 'el nombre que quieras'`


## ======== include ========

### == 'emu8086.inc' ==
Coleccion de macros (instrucciones que expanden a multiples lineas de codigo) y procedimientos que actuan como una capa de abstraccion sobre las interrupciones de BIOS y DOS. Su uso principal es reducir la complejidad visual del codigo y evitar errores comunes al manipular registros para tareas basicas de entrada y salida.

**Macros vs. Procedimientos**

* **Macros:** Atajos que el ensamblador expande en el codigo. Nunca se usa la instrucción `CALL` con ellas.
    * `print 'texto'`: Imprime una cadena en la posicion actual.
    * `printn 'texto'`: Igual que PRINT, pero añade un salto de linea automatico.
    * `putc char`: Imprime un solo caracter (puede ser un registro como dl o una constante).
    * `gotoxy col, fila`: Mueve el cursor a coordenadas especificas.

* **Procedimientos:** Bloques de codigo mas complejos que viven al final del programa. SIEMPRE se usan con `CALL` para ejecutarlos y se definen al final del archivo.
    * `scan_num`: Lee un número del teclado y lo guarda en `cx`.
    * `print_num`: Imprime el valor numerico contenido en `ax`.
    * `print_num_uns`: Igual que el anterior, pero para numeros sin signo.
    * `clear_screen`: Borra toda la pantalla de la consola.

Para definir procedimientos se lo hace debajo de la interrupcion del final del codigo (`mov ah, 4ch` / `int 21h`):
```assembly
define_clear_screen
```


## ======== .model ========
Define el tamaño de los segmentos de datos y de codigo que se va a utilizar.
Sintaxis: `.model [tamaño]`

| Nombre | Definicion |
| :--- | :--- |
| **tiny** | El codigo y los datos deben caber en un solo segmento de 64 KB. |
| **small** | Es el más usado. El código tiene su propio segmento (64 KB) y los datos el suyo (64 KB). |
| **medium** | El codigo puede ser muy grande (varios segmentos), pero los datos deben caber en uno solo. |
| **large** | Tanto el codigo como los datos pueden ocupar varios segmentos. |


## ======== .stack ========
Sintaxis: `.stack [tamaño en bytes]` 
Si pones solo `.stack`, el ensamblador reserva automaticamente 1024 bytes.

La pila es una estructura LIFO (Last In, First Out). En 8086, la pila crece hacia abajo en la memoria, por lo que al meter datos, el puntero `sp` disminuye.
* **PUSH (Empujar):** Guarda un valor de 16 bits en la pila y resta 2 a SP.
* **POP (Sacar):** Recupera el último valor guardado, lo pone en un registro y suma 2 a SP.

Uso principal: Preservar registros. Si se va a usar `ax` en un procedimiento pero no queremos perder su valor original, se hace un `push ax` al inicio y un `pop ax` al final.


## ======== .data ========

### Tamaños de variables
| Nombre | Definicion | Rango |
| :--- | :--- | :--- |
| **db** | define byte: Reserva 8 bits | 0 a 255 (decimal). |
| **dw** | define word: Reserva 16 bits | 0 a 65 535 (decimal). |
| **dd** | define double word: Reserva 32 bit | 0 a 4 294 967 295. |

### Ejemplos de definiciones en .data
```assembly
var1 db 200d 
var2 dw 60000d
var3 dd 90000d
var4 db ?    ; Si no tengo un contenido todavia
```

### Ejemplos de error (overflow)
* `err1 db 256d` ; error: el máximo es 255, 256 requiere 9 bits.
* `err2 dw 65536d` ; error: el máximo es 65 535.

### Otros usos
* **Vectores con valores:** Se definen separando valores por comas.
    `precios db 10, 20, 30, 40` ; Crea una lista de 4 bytes contiguos.
* **Vectores vacios:**
    `vector2 db 10 dup(?)` ; Crea 10 espacios de 1 byte cada uno sin valor inicial.
* **Cadenas de texto:** Se encierran en comillas.
    `saludo db "hola$"` ; El $ sirve para que la interrupción 09h sepa dónde termina el texto.


## ======== .code ========

### == Operadores aritmeticos ==
| Reg. | Funcion | Ejemplo | Resultado en |
| :--- | :--- | :--- | :--- |
| **ADD** | Suma | `add ax, bx` | ax = ax + bx |
| **SUB** | Resta | `sub bx, ax` | bx = bx - ax |
| **INC** | Incremento (+1) | `inc si` | Registro + 1 |
| **DEC** | Decremento (-1) | `dec cx` | Registro - 1 |
| **MUL** | Multiplicacion | `mul bx` | ax (o dx:ax) |
| **DIV** | Division | `div bx` | al=cociente, ah=resto |

### == Operadores logicos ==
| Reg. | Logica | Uso Comun / Ejemplo |
| :--- | :--- | :--- |
| **AND** | 1 y 1 = 1 | Filtros y mascaras de bits. |
| **OR** | 1 o X = 1 | Encender bits especificos. |
| **XOR** | Diferentes = 1 | Poner a 0 un registro (`xor ax, ax`). |
| **NOT** | Invierte (0->1) | Complemento a 1 del valor. |

### == Etiquetas y saltos ==
En ensamblador se leen las instrucciones de arriba hacia abajo. Para romper ese orden, se usan etiquetas y saltos.

* **Etiquetas:** Se escriben en minusculas seguidas de dos puntos (ej: `etiqueta1:`). Sirven como puntos de referencia para los saltos; no ocupan espacio en la memoria final.
* **Comparacion (cmp):** Paso previo a un salto condicional. Compara dos valores restandolos internamente para activar banderas (`cmp al, 13d`).

**Saltos Condicionales (Solo se ejecutan si el resultado de cmp cumple la condición):**
| Reg. | Significado | Condición de Salto (tras CMP) |
| :--- | :--- | :--- |
| **JE** | Jump if Equal | Salta si los valores son iguales. |
| **JNE** | Jump Not Equal | Salta si son diferentes. |
| **JG** | Jump if Greater | Salta si el primero es mayor. |
| **JGE** | J. Greater Equal | Salta si es mayor o igual. |
| **JL** | Jump if Less | Salta si el primero es menor. |
| **JLE** | J. Less Equal | Salta si es menor o igual. |
| **JA** | Jump Above | Superior (para números sin signo). |
| **JB** | Jump Below | Inferior (para números sin signo). |

* **Salto Incondicional (jmp):** Salta a la etiqueta indicada sin evaluar ninguna condición (`jmp Etiqueta1`).

### == Vectores ==
A diferencia de otros lenguajes, no se accede de forma estatica a un vector. Se usa un registro de indice para "señalar" la posición.
* **Indice si (Source Index):** Se usa tradicionalmente para leer un vector de origen.
* **Indice di (Destination Index):** Se usa para escribir en un vector de destino.

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
| **OFFSET** | Estatica (Fija) | El compilador la calcula ANTES de que el programa se ejecute. (Ej: `mov dx, offset vector`). No acepta indices. |
| **LEA** | Dinamica (Variable)| El procesador (CPU) la calcula MIENTRAS el programa esta corriendo. (Ej: `lea dx, mi_vector[si]`). |

### == Bucles ==

**1. Condicional o manual:** Es el que se construye usando etiquetas y saltos condicionales. Se usa cuando no sabemos cuántas veces se repetirá el proceso (como leer un teclado hasta que presionen "Enter").
```assembly
esperar_punto:
    mov ah, 01h          ; servicio para leer un caracter
    int 21h              ; el caracter queda en al
    cmp al, "."          ; ¿el usuario escribio un punto? 
    je salir_del_bucle   ; si es igual (je), saltamos al final 
    jmp esperar_punto    ; si no fue punto, saltamos al inicio para repetir 
salir_del_bucle:
```

**2. Contador:** Mas eficiente cuando sabemos exactamente el numero de repeticiones. Utiliza el registro `cx` como contador. Al ejecutar la instruccion `loop`, el procesador resta 1 a `cx` automaticamente. Si `cx` no es cero, vuelve a la etiqueta; si es cero, continua con la siguiente línea.
```assembly
mov cx, 10d          ; queremos repetir 10 veces
inicio_bucle:
    ; instrucciones a repetir
loop inicio_bucle    ; decrementa cx y salta a inicio_bucle si cx > 0
```

**3. Indices:** Se usa para recorrer cadenas o arreglos combinando registros como `si` y `di`.

### == Interrupciones ==
Para usar uno, hay que tener en cuenta estos tres pasos:
1.  `ah`: Se pone el numero del servicio especifico.
2.  Registros de datos: Se prepara la información necesaria.
3.  `int`: Ejecutas la instruccion.

**Servicios comunes:**
| Serv. | Funcion | Registro Clave / Preparacion |
| :--- | :--- | :--- |
| **01h** | Leer Caracter | Resultado queda en AL. |
| **02h** | Imprimir Caracter | Poner el caracter en DL antes. |
| **09h** | Imprimir Cadena | Direccion en DX (debe terminar en $). |
| **0Ah** | Leer Cadena | Poner direccion del buffer en DX. |
| **4Ch** | Terminar Prog. | Obligatorio para salida limpia. |

### == Procedimientos ==
* `proc`: Indica el inicio de un procedimiento.
* `endp`: Indica el final del procedimiento.
* `call`: Se usa para saltar al procedimiento y ejecutarlo.
* `ret`: le dice al procesador que regrese al lugar exacto donde lo llamaron.

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
