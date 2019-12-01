DATA SEGMENT
  MES1 DB 'SCORE[<60]      : ','$'
  MES2 DB 'SCORE[<60-69]   : ','$'
  MES3 DB 'SCORE[<70-79]   : ','$'
  MES4 DB 'SCORE[<80-89]   : ','$'
  MES5 DB 'SCORE[<90-99]   : ','$'
  MES6 DB 'SCORE[=100]     : ','$'
  MES7 DB 'TOTAL NUMBER    : ','$'
  RESULT DB 92,85,74,81,70,68,65,78,54,43
         DB 94,100,83,88,79,83,79,69,62,60
  TOTAL DB 00
  S5  DB 00
  S6  DB 00
  S7  DB 00
  S8  DB 00
  S9  DB 00
  S10 DB 00
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:MOV AX,DATA
      MOV DS,AX
      MOV SI,OFFSET RESULT
      MOV CX,20 ;ѭ����ʮ��
;�ȽϺ���ת����Ӧ��Ŵ�
 COMP:MOV AL,[SI]
      CMP AL,60
      JB FIVE
      CMP AL,70
      JB SIX
      CMP AL,80
      JB SEVEN
      CMP AL,90
      JB EIGHT
      CMP AL,100
      JB NINE
      CMP AL,100
      JE TEN
      JMP NEXT
;������ʹ����Ӧ�ı�������1
 FIVE:MOV AL,[S5]
      ADD AL,01
      DAA
      MOV [S5],AL
      JMP NEXT
  SIX:MOV AL,[S6]
      ADD AL,01
      DAA
      MOV [S6],AL
      JMP NEXT
SEVEN:MOV AL,[S7]
      ADD AL,01
      DAA
      MOV [S7],AL
      JMP NEXT
EIGHT:MOV AL,[S8]
      ADD AL,01
      DAA
      MOV [S8],AL
      JMP NEXT
 NINE:MOV AL,[S9]
      ADD AL,01
      DAA
      MOV [S9],AL
      JMP NEXT
  TEN:MOV AL,[S10]
      ADD AL,01
      DAA
      MOV [S10],AL
 NEXT:MOV AL,[TOTAL]	;TOTAL���ı�������1
      ADD AL,01		;�ӷ�У��
      DAA
      MOV [TOTAL],AL
      INC SI
      LOOP COMP

      MOV DX,OFFSET MES1	;��ʾMES1
      MOV AH,09H
      INT 21H
      MOV AL,[S5]
      MOV CX,2
      MOV AH,09H
      MOV BL, 100B	;�������������2���ַ���ʾ��ɫ
      INT 10H
      CALL DISP
      MOV DX,OFFSET MES2	;��ʾMES2
      MOV AH,09H
      INT 21H
      MOV AL,[S6]
      MOV CX,2
      MOV AH,09H
      MOV BL, 010B	;�������������2���ַ���ʾ��ɫ
      INT 10H
      CALL DISP
      MOV DX,OFFSET MES3	;��ʾMES3
      MOV AH,09H
      INT 21H
      MOV AL,[S7]
      MOV CX,2
      MOV AH,09H
      MOV BL, 001B	;�������������2���ַ���ʾ��ɫ
      INT 10H
      CALL DISP
      MOV DX,OFFSET MES4	;��ʾMES4
      MOV AH,09H
      INT 21H
      MOV AL,[S8]
      MOV CX,2
      MOV AH,09H
      MOV BL, 011B	;�������������2���ַ���ʾ��ɫ
      INT 10H
      CALL DISP
      MOV DX,OFFSET MES5	;��ʾMES5
      MOV AH,09H
      INT 21H
      MOV AL,[S9]
      MOV CX,2
      MOV AH,09H
      MOV BL, 110B	;�������������2���ַ���ʾ��ɫ
      INT 10H
      CALL DISP
      MOV DX,OFFSET MES6	;��ʾMES6
      MOV AH,09H
      INT 21H
      MOV AL,[S10]
      MOV CX,2
      MOV AH,09H
      MOV BL, 101B	;�������������2���ַ���ʾ��ɫ
      INT 10H
      CALL DISP
      MOV DX,OFFSET MES7	;��ʾMES7
      MOV AH,09H
      INT 21H
      MOV AL,[TOTAL]
      MOV CX,2
      MOV AH,09H
      MOV BL, 01110000B	;�������������2���ַ�Ϊ�׵׺���
      INT 10H
      CALL DISP
      MOV AX,4C00H
      INT 21H
;�ӳ���DISP������ʾAL�м�¼�Ĵ���������λΪʮλ������λΪ��λ��
 DISP PROC NEAR
      PUSH CX	;����CX
      MOV BL,AL
      AND AL,0F0H	;����λ��0
      MOV CL,04
      ROR AL,CL	;������λ
      ADD AL,30H	;ת��ΪASCII��
      CMP AL,30H
      JNE output
      MOV AL,20H
output:MOV DL,AL
      MOV AH,02H
      INT 21H	;���ʮλ
      MOV AL,BL
      AND AL,0FH	;����λ��0
      ADD AL,30H	;ת��ΪASCII��
      MOV DL,AL
      MOV AH,2
      INT 21H	;�����λ
      MOV DL,0DH
      MOV AH,2
      INT 21H
      MOV DL,0AH
      MOV AH,2
      INT 21H	;�������
      POP CX	;�ָ�CX
      RET		;���ص��ô�
  DISP ENDP
CODE ENDS
END START