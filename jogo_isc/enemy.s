# l�gica da dificuldade do player 2

.macro CPU_PLAYER() # verifica o n�vel atual e escolhe a respecitva dificuldade
	beqz s10,T_DIFFICULTY_1	# NOVICE
	
	li t0,3
	blt s10,t0,T_DIFFICULTY_1
	
	la t0,CONT_DIFFICULTY_2
	jr t0

T_DIFFICULTY_1: # 1ST DAN - 2ND DAN
	DIFFICULTY_1()
	la t0,END
	jr t0

CONT_DIFFICULTY_2: 
	li t0,7
	blt s10,t0,T_DIFFICULTY_2
	
	la t0,CONT_DIFFICULTY_3
	jr t0
	
T_DIFFICULTY_2: # 3RD DAN - 6TH DAN
	DIFFICULTY_2()
	la t0,END
	jr t0

CONT_DIFFICULTY_3:
	la t0,T_DIFFICULTY_3
	jr t0

T_DIFFICULTY_3: # >= 7TH DAN
	DIFFICULTY_3()
	la t0,END
	jr t0

END:
.end_macro

.macro DIFFICULTY_1()
	VER_DIST()
	li t0,35
	blt a0,t0,ATQ

	la t0,P2_ANDA
	jr t0
	
ATQ:	PUNCH_P2()
	DEFEAT_P1()
	FINISH_P2()
	addi s7,s7,1
	YIN_YANG()
	
	li t0,4
	bgeu s7,t0,T1_GAME_OVER
	
	la t0,P2_RESET
	jr t0
T1_GAME_OVER:
	la t0,T2_GAME_OVER
	jr t0
	
	# se nao estiver perto o suficiente, anda na direcao do player
P2_ANDA:blt s5,s1,T_P2_DIR
	la t0,P2_ESQ
	jr, t0
	
T_P2_DIR:
	la t0,P2_DIR
	jr, t0
	
P2_ESQ:	WALK_P2_ESQ()
	la t0,P2_FIM
	jr, t0
P2_DIR: WALK_P2_DIR()
	la t0,P2_FIM
	jr, t0
P2_RESET:
	la t0,RESET
	jr, t0
P2_FIM: 
.end_macro

.macro DIFFICULTY_2()
	VER_DIST()
	li t0,35
	blt a0,t0,T_ATQ
	la t0,P2_ANDA
	jr t0
	
T_ATQ:	
	li t0,2
	rem t1,s0,t0
	beqz t1,P2_SOCO
	la t0,P2_CHUTE
	jr t0
P2_SOCO:	
	PUNCH_P2()
	DEFEAT_P1()
	FINISH_P2()
	addi s7,s7,1
	YIN_YANG()

	la t0,P2_FIM
	jr t0
P2_CHUTE:
	KICK_P2()
	DEFEAT_P1()
	FINISH_P2()
	addi s7,s7,1
	YIN_YANG()
	
	
	
	la t0,P2_FIM
	jr t0
	# se nao estiver perto o suficiente, anda na direcao do player
P2_ANDA:blt s5,s1,T_P2_DIR
	la t0,P2_ESQ
	jr, t0
	
T_P2_DIR:
	la t0,ENCERRA
	jr, t0
	
P2_ESQ:	WALK_P2_ESQ()
	la t0,ENCERRA
	jr, t0
P2_DIR: WALK_P2_DIR()


P2_FIM: 
	li t0,4
	bgeu s7,t0,T1_GAME_OVER
	
	la t0,P2_RESET
	jr t0
	
T1_GAME_OVER:
	la t0,T2_GAME_OVER
	jr t0
	
P2_RESET:
	la t0,RESET
	jr, t0
ENCERRA:
	
.end_macro

.macro DIFFICULTY_3()
	VER_DIST()
	li t0,35
	blt a0,t0,T_ATQ
	la t0,P2_ANDA
	jr t0
	
T_ATQ:	
	li t0,2
	rem t1,s0,t0
	beqz t1,P2_SOCO
	la t0,P2_CHUTE
	jr t0
P2_SOCO:	
	PUNCH_P2()
	DEFEAT_P1()
	FINISH_P2()
	addi s7,s7,1
	YIN_YANG()
	
	la t0,FIM
	jr t0
P2_CHUTE:
	KICK_P2()
	DEFEAT_P1()
	FINISH_P2()
	addi s7,s7,1
	YIN_YANG()
	
	la t0,FIM
	jr t0
	# se nao estiver perto o suficiente, anda na direcao do player
P2_ANDA:blt s5,s1,T_P2_DIR
	la t0,P2_ESQ
	jr, t0
	
T_P2_DIR:
	la t0,P2_DIR
	jr, t0
	
P2_ESQ:	WALK_P2_ESQ()
	la t0,P2_FIM
	jr, t0
P2_DIR: WALK_P2_DIR()

P2_FIM: 
	li t0,2
	rem t1,s0,t0
	bnez t1,P2_PULO

	la t0,ENCERRA
	jr, t0
P2_PULO:	
	beqz s6,PULO_DIR
	la t0,PULO_ESQ
	jr, t0
PULO_DIR:
	JUMP_P2_RIGHT()
	la t0,ENCERRA
	jr, t0
PULO_ESQ:	
	JUMP_P2_LEFT()
	la t0,ENCERRA
	jr, t0
FIM: 
	li t0,4
	bgeu s7,t0,T1_GAME_OVER
	
	la t0,P2_RESET
	jr t0
	
T1_GAME_OVER:
	la t0,T2_GAME_OVER
	jr t0
	
P2_RESET:
	la t0,RESET
	jr, t0
ENCERRA:
.end_macro
