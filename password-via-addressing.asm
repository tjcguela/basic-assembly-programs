org 100H

.data
user_pw DB ?

; PROMPTS
prompt1 DB "ENTER PASSWORD: $"
prompt2 DB "YOUR INPUTTED PASSWORD: $"

wrong_prompt DB "[ERROR] WRONG PASSWORD!!$"
restart_prompt DB "[INFO] RESTARTING...$"
correct_prompt DB "[INFO] CORRECT PASSWORD!!$"
login_prompt DB "[INFO] LOGGING IN...$"


enterpw_prompt DB "ENTER PASSWORD: $"
verification_prompt DB "VERIFYING...$"

password DB "password123#$" ; change password here
user_input DB ?

.code
start:

MOV CX, 0000H 
LEA DX, prompt1
MOV AH, 09H
INT 21H

again:
LEA BX, user_input
get_input: MOV AH, 01H
           INT 21H
           
           MOV [BX], AL
           INC BX
           INC CX
           
           CMP AL, 0DH
           JNE get_input
           MOV [BX-1], '$'
           
MOV AH, 09H
LEA DX, prompt2
INT 21H
           
MOV AH, 09H
LEA DX, user_input
INT 21H

CALL newline

MOV BX, 0000H
LEA BX, user_input
LEA SI, password

LEA DX, verification_prompt
MOV AH, 09H
INT 21H
verify_password: MOV DL, [SI]
                 MOV AL, [BX]

                 CMP DL, AL
                 JNE restart
                 
                 INC BX
                 INC SI
                 
                 LOOP verify_password
                 
                 
CALL newline
success: MOV AH, 09H
         LEA DX, correct_prompt
         INT 21H
         
         CALL newline
         
         MOV AH, 09H
         LEA DX, login_prompt
         INT 21H
         
         INT 20H
         

newline: MOV AH, 02H
         MOV DL, 0AH
         INT 21H
        
         MOV AH, 02H
         MOV DL, 0DH
         INT 21H
        
         RET
         
         
restart: MOV CX, 0
         CALL newline   
         
         MOV AH, 09H
         LEA DX, wrong_prompt
         INT 21H
         
         CALL newline
         
         MOV AH, 09H
         LEA DX, restart_prompt
         INT 21H
         
         CALL newline
         CALL newline
         
         MOV AH, 09H
         LEA DX, prompt1
         INT 21H
         
         JMP again