# 📚 Assembler 8086

Este documento es una guía completa de fundamentos, registros y estructuras para la programación en Intel 8086 usando el emulador **emu8086**.

---

## 1. Introducción y Conceptos Básicos

### Comentarios
En emu8086, los comentarios se realizan después de un punto y coma `;`. [cite_start]No afectan el funcionamiento ni el código[cite: 2, 200].

### Referencia ASCII
[cite_start]Valores y símbolos más utilizados para el control de flujo y visualización[cite: 3, 201]:

| Valor | Símbolo | Uso Común |
| :--- | :--- | :--- |
| **10d** | Salto de línea | [cite_start]Baja el cursor a la siguiente fila[cite: 4, 202]. |
| **13d** | Retorno de carro | [cite_start]Mueve el cursor al inicio (Enter)[cite: 5, 203]. |
| **32d** | Espacio | [cite_start]Carácter de espacio en blanco[cite: 6, 204]. |
| **36d** | Signo $ | [cite_start]Identifica el fin de cadena para el servicio 09h[cite: 7, 205]. |
| **48d-57d** | Números '0'-'9' | [cite_start]Caracteres numéricos[cite: 8, 206]. |

> [!TIP]
> **Conversiones Pro:**
> [cite_start]* **Minúscula a MAYÚSCULA:** Restar 32d o 20h[cite: 12, 211].
> * **ASCII a Valor Numérico:** Restar 48d o 30h[cite: 14, 213].
> [cite_start]* **Valor Numérico a ASCII:** Sumar 48d o 30h[cite: 15, 214].

---

## 2. Arquitectura de Registros
[cite_start]Los registros generales son de 16 bits y se dividen en parte **Alta (High)** y **Baja (Low)**[cite: 16, 17, 215, 216].



### Registros Generales
* [cite_start]**AX (Acumulador):** Operaciones aritméticas[cite: 18, 217].
* [cite_start]**BX (Base):** Índice para direccionamiento de memoria[cite: 19, 218].
* [cite_start]**CX (Contador):** Registro para bucles (LOOP) y repeticiones[cite: 20, 219].
* [cite_start]**DX (Datos):** Multiplicación/División y direcciones E/S[cite: 21, 220].

### Registros Índice y Apuntadores
* [cite_start]**SI (Source Index):** Puntero de origen en copias de cadenas[cite: 24, 222].
* [cite_start]**DI (Destination Index):** Puntero de destino en copias de cadenas[cite: 25, 223].
* [cite_start]**SP (Stack Pointer):** Apunta al tope de la pila[cite: 28, 226].
* [cite_start]**BP (Base Pointer):** Apunta a la base de la pila[cite: 27, 225].

---

## 3. Estructura y Directivas del Código

### Formato Estándar
```assembly
.model small   ; Define el tamaño de los segmentos (64KB para código y 64KB para datos) [cite: 61, 62, 261, 263]
.stack 1024    ; Reserva espacio para la pila (LIFO) [cite: 64, 65, 265, 266]
.data          ; Segmento de datos para declarar variables [cite: 39, 237]
.code          ; Segmento de código principal [cite: 41, 239]
