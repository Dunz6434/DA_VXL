MOTOR_IN1  BIT P1.1 ; Chân Input 1 Motor A
MOTOR_IN2  BIT P1.2 ; Chân Input 2 Motor A
MOTOR_IN3  BIT P1.3 ; Chân Input 3 tor B
MOTOR_IN4  BIT P1.4 ; Chân Input 4 Motor B
ENA BIT P1.0 ; Chân bam xung A
ENB BIT P1.5 ; Chân bam xung B
IR BIT P3.4 ;TÍN HIEU HONG NGOAI
COUNT_INT EQU R7 ;bien dem 
PWM_DUTYA EQU 30h
PWM_DUTYB EQU 31h
BTN_RIGHT BIT P2.0 ;nut nhan chon che do re huong

ORG 0000h 
	JMP MAIN
ORG 000BH ; ngat Timer 0 dieu khien chân bam xung A 
	JMP RUN1 
ORG 001BH ; ngat Timer 1 dieu khien chân bam xung B
	JMP RUN2

MAIN:
	MOV P3, #0D
	MOV PWM_DUTYA, #35 ; cho toc do ban dau cua motor ben trai la 35
	MOV PWM_DUTYB, #35 ; cho toc do ban dau cua motor ben phai la 35
	SETB EA
	SETB ET0
	SETB ET1
	MOV TMOD, #22H ; Timer 0 va Timer 1 che do tu dong nap lai
	MOV TH0, #(-100)
	MOV TH1, #(-100)
	SETB TR0
	SETB TR1
	CALL DELAY
	MAIN_LOOP:
	JB IR, CONTROL_TURN ; neu tin hieu hong ngoai = 1 thi nhay toi ham dieu khien re
	MOV P3, #0FFH
	CALL FORWARD
	JMP MAIN_LOOP
	
RUN1:
	INC COUNT_INT
	CJNE COUNT_INT, #100, NT0A
	MOV COUNT_INT, #0
	NT0A:
		MOV A, COUNT_INT
		CJNE A, PWM_DUTYA, NT1A
	NT1A:MOV ENA, C
RETI

RUN2:
	INC COUNT_INT
	CJNE COUNT_INT, #100, NT0B
	MOV COUNT_INT, #0
	NT0B:
		MOV A, COUNT_INT
		CJNE A, PWM_DUTYB, NT1B
	NT1B:MOV ENB, C
RETI

CONTROL_TURN: ; ham dieu khien re
	MOV PWM_DUTYA, #35
	MOV PWM_DUTYB, #35
	CALL BACKWARD 
	CLR P3.2
	JB IR, $ ; neu tin hieu hong ngoai = 1 thi xe tiep tuc lui
	JNB BTN_RIGHT, TURN_RIGHT ; neu nut re phai duoc nhan thi nhay toi ham re phai
	TURN_LEFT: ;hàm re trái
	MOV PWM_DUTYA, #0
	MOV PWM_DUTYB, #35
	JMP EXIT
	TURN_RIGHT: ;hàm re phai
	MOV PWM_DUTYA, #35
	MOV PWM_DUTYB, #0
	EXIT:
	CALL FORWARD
	CALL DELAY
	JB IR, CONTROL_TURN
	MOV PWM_DUTYA, #35
	MOV PWM_DUTYB, #35 
	JMP MAIN_LOOP
	
BACKWARD: ; ham xe chay lui
   CLR MOTOR_IN1
   SETB MOTOR_IN2
   CPL MOTOR_IN3
   SETB MOTOR_IN4
RET

FORWARD: ; ham xe chay toi
   SETB MOTOR_IN1
   CLR MOTOR_IN2
   SETB MOTOR_IN3
   CLR MOTOR_IN4
RET

DELAY: ; ham delay 0.25s
   MOV R3, #2
   L0:MOV R4, #250
   L1:MOV R5, #250
   DJNZ R5, $
   DJNZ R4, L1
   DJNZ R3, L0
RET

END
