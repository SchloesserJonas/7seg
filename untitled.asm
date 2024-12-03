cseg at 0h
ajmp init

ORG 100H

init:
	mov P1, #0ffh
	mov P2, #00h
	mov P3, #0ffh

main:
	; Lese Eingabe in Binär aus und konvertiere zu 1 = an und 0 = aus
	MOV A,P1
	cpl A

	; Lade vorherige Eingabe aus Speicher
	MOV B, 0x10
	
	; speichere Eingabe zwischen
	MOV 0x10, A

	; Wenn Eingabe != letzte Eingabe Ziffern neu berechnen, sonst direkt anzeigen
	CJNE A, B, CALCULATEDIGITS
	SJMP DISPLAY
	
	jmp main


CALCULATEDIGITS:
	; Errechne Hunderterstelle
	MOV R0, #100
	ACALL DIVIDE
	MOV R3, B

	; Errechne Zehnerstelle
	MOV R0, #10
	ACALL DIVIDE
	MOV R2, B

	; Schreibe Rest in 1er Stelle
	MOV R1, A
	
	SJMP main

DISPLAY:
	; DPTR mit Lookup Tabelle laden
	MOV DPTR, #NUMLOOKUPTABLE

	; Eingänge für alle Segmente ausschalten
	MOV P3, #0ffh

	; Hunderter setzen
	MOV A, R3
	MOVC A, @A+DPTR
	MOV P2, A
	CPL P3.2
	CPL P3.2

	; Zehner setzen
	MOV A, R2
	MOVC A, @A+DPTR
	MOV P2, A
	CPL P3.1
	CPL P3.1

	; Einer Setzen
	MOV A, R1
	MOVC A, @A+DPTR
	MOV P2, A
	CPL P3.0
	CPL P3.0

	SJMP main

DIVIDE:
	CLR C
	MOV B, #0

DIV_LOOP:
	CLR C
	SUBB A, R0
	JC DIV_DONE
	INC B
	SJMP DIV_LOOP
DIV_DONE:
	ADD A, R0
	RET


org 300h
NUMLOOKUPTABLE:
	db 00000011b ;0
	db 10011111b ;1
	db 00100101b ;2
	db 00001101b ;3
	db 10011001b ;4
	db 01001001b ;5
	db 01000001b ;6
	db 00011111b ;7
	db 00000001b ;8
	db 00001001b ;9

END
