###############################################
#  Programa de exemplo para Syscall MIDI      #
#  ISC Abr 2018				      #
#  Marcus Vinicius Lamar		      #
###############################################
.macro chute()
.data
TAMANHO: .word 1
NOTAS:	40, 300
.text
	la s0,TAMANHO		# define o endere�o do n�mero de notas
	lw a6,0(s0)		# le o numero de notas
	la s0,NOTAS		# define o endere�o das notas
	li t0,0			# zera o contador de notas
	li a2,127		# define o instrumento
	li a3,200		# define o volume

LOOP:	beq t0,a6, FIM		# contador chegou no final? ent�o  v� para FIM
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a dura��o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	addi s0,s0,8		# incrementa para o endere�o da pr�xima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP			# volta ao loop
	
FIM:
.end_macro
