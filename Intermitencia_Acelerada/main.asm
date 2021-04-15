/*******************************************************************
	
	Autor: Javier Plaza Sisqués

********************************************************************/


.CSEG
SER R16																	;Inicializamos R16 con todo unos
OUT DDRD, R16															;Establecemos todos los pines del puerto D como salida

CLR R16																	;Guardamos todo ceros en R16
OUT PORTD, R16															;Sacamos por los puertos el valor de R16

main:

	LDI R17, 101														;Guardamos en el registro 17 el valor 101
	
	bucle:
		SER R16															;Establecemos el registro 16 con todo unos
		OUT PORTD, R16													;Sacamos el valor del registro 16 por los puertos D
		
		PUSH R17														;Metemos el valor de R17 en la pila
		CALL delay_10													;Llamamos a la función delay de 10ms
		POP R17															;Sacamos el valor de R17 de la pila

		CLR R16															;Ponemos el valor de R16 a cero
		OUT PORTD, R16													;Sacamos el valor del registro 16 por los puertos D

		PUSH R17														;Metemos el valor de R17 en la pila
		CALL delay_10													;Llamamos a la función delay de 10ms
		POP R17															;Sacamos el valor de R17 de la pila

		DEC R17															;Decrementamos R17
		CPI R17, 0														;Comparamos R17 con cero
		BRNE bucle														;Si no es igual volvemos al bucle
	
	RJMP main															;Hacemos un salto relativo a la etiqueta main

	



/*******************************************************************
	
	Funciones

********************************************************************/

delay_10:
	PUSH YH															;Copia de seguridad del registro YH
	PUSH YL															;Copia de seguridad del registro YL
	IN YL, SPL														
	IN YH, SPH														
	PUSH R0															;Copia de seguridad del registro R0
	

	PUSH R20														;Copia de seguridad del registro 20
	PUSH R21														;Copia de seguridad del registro 21
	PUSH R22														;Copia de seguridad del registro 22
	
	LDD R0, Y + 5													;Guardamos en el R0 el valor que haya en la pila desde Y + 5

repeticiones:
	timer:
		; Assembly code auto-generated
		; by utility from Bret Mulvey
		; Delay 160 000 cycles
		; 10ms at 16 MHz

			ldi  r20, 208
			ldi  r21, 202
		L1: 
			dec  r21
			brne L1
			dec  r20
			brne L1
			nop

		CP R31, R30
		BRNE timer 
	
	DEC R0															;Decrementamos R0
	BRNE repeticiones												;Si no es cero vamos a repeticiones

	
	POP R22															;Restauración del registro 22
	POP R21															;Restauración del registro 21
	POP R20															;Restauración del registro 20
	POP R0															;Restauración del registro 0
	POP YL															;Restauración del registro YL
	POP YH															;Restauración del registro YH
	RET																;RET es el equivalente al return, antes deberemos de haber guardado el PC (Program Counter)	

