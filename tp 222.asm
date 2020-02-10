		org 0
		bsf status,5
		clrf trisa
		clrf trisb
		bsf trisa,1
		bsf trisa,2
		movlw b'10000110' ;timer
		movwf option
		bcf status,5 
		clrf 1ah ;limpieza del banco
		bcf porta,3 ;apagas el led (por las dudas)
		call mostrar 
inicio	btfss porta,1 ;pregunta para incrementar
		goto a
		call anti
		btfss porta,1
		goto a
		goto b
a		btfss porta,2 ;pregunta para decrecer
		goto inicio
		call anti
		btfss porta,2
		goto inicio
		goto prote
b		movlw d'99'
		subwf 1ah,w ;limite 99 
		btfsc status,z   ;pregunta si llego a 0
		goto inicio
r		incf 1ah,f
		call mostrar
		goto inicio
prote	movlw d'11' ;si es menor a 6 no puede contar
		subwf 1ah,w
		btfsc status,z
		goto inicio
		btfss status,c 
		goto inicio
dec		call dem1
		decf 1ah,f
		call mostrar
		btfss status,z
		goto dec
		bsf  porta,3 ;prende el led
e		btfss porta,1 ;bucle
		goto e
		bcf porta,3
		clrf 1Ah
		call anti
		goto r
anti	clrf 4dh ;limpio
		clrf 4eh
		movlw d'46' ;anti 35 mS
		movwf 4eh
no		decfsz 4dh,f ;Limite 0
		goto no
		decfsz 4eh,f
		goto no
		return
dem1	clrf 4fh
		movlw d'16' 
		movwf 4fh
bucletres	decfsz 4fh,f
		goto bucleuno
		goto bucledos
bucleuno	call dem
		goto bucletres
bucledos	return
dem		clrf tmr0
		movlw d'61' ;calculo de demora
		movwf tmr0
n		btfss intcon,2
		goto n
		bcf intcon,2
		return
mostrar	clrf 1ch
		clrf 2ch
		movfw 1ah
		movwf 1ch
decena	movlw d'10'
		subwf 1ch,w
		btfss status,c
		goto unidad
		incf 2ch,f
		movwf 1ch
		goto decena
unidad	rlf 2ch,f
		rlf 2ch,f
		rlf 2ch,f
		rlf 2ch,f
		movfw 1ch
		addwf 2ch,w
		movwf portb
		return
		end