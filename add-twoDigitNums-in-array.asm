ORG 100H

.data

sum_prompt db ?
arr2 dw 0035H, 3130H, 3135H, 3230H, '$' ; 5, 10, 15, 20 in ascii

;housekeeping
sum dw ?
;sum_prompt db "Result: $"
msg1 db "Hello world$"
result_msg db "Result: $", 0
.code
;initialization      
MOV DX, 0000H
MOV CX, 0000H
LEA BX, arr2

start: MOV AX, [BX]
       
       CMP AH, 30H
       JG add_tens
       
       CMP AL, 24H
       JE start_store
       
       
add_units: CMP AL, 30H
           JE add_0
           
           SUB AL, 30H
           ADD DL, AL
           
           CMP DL, 0AH
           JGE add_units2
       
           INC BX
           INC BX
           
           JMP start
           
add_units2: INC CL
            SUB DL, 0AH
            
            INC BX
            INC BX
            
            JMP start

add_0: INC BX
       INC BX
       
       JMP start

add_tens: SUB AH, 30H
          ADD CL, AH
                
          JMP add_units
          
start_store:LEA BX, sum
store_ans: MOV DS, DX ;preserve units digit
           MOV DX, 0000H
           
           MOV DL, CL
           ADD DL, 30H ; get tens digit
           MOV [BX], DX ; store tens digit
           
           MOV DX, 0000H
           MOV DX, DS
           
           MOV DH, 00H
           ADD DL, 30H
           
           MOV [BX+2], DX
           MOV [BX+4], '$'

create_prompt: MOV BX, 5050H
             
               MOV [BX], 'R'
               MOV [BX+1], 'e'
               MOV [BX+2], 's'
               MOV [BX+3], 'u'
               MOV [BX+4], 'l'
               MOV [BX+5], 't'
               MOV [BX+6], ':'
               MOV [BX+7], ' '
               MOV [BX+8], '$'
               
print_prompt: MOV BX, 5050H

              MOV AH, 02H
              MOV DX, [5050H]
              INT 21H
              
              MOV AH, 02H
              MOV DX, [5051H]
              INT 21H
              
              MOV AH, 02H
              MOV DX, [5052H]
              INT 21H
              
              MOV AH, 02H
              MOV DX, [5053H]
              INT 21H
              
              MOV AH, 02H
              MOV DX, [5054H]
              INT 21H
              
              MOV AH, 02H
              MOV DX, [5055H]
              INT 21H
              
              MOV AH, 02H
              MOV DX, [5056H]
              INT 21H
              
              MOV AH, 02H
              MOV DX, [5057H]
              INT 21H
              
                                    

LEA BX, sum
print_digits2: MOV DX, [BX]
               MOV AH, 02H
               INT 21H
               
               MOV DX, [BX+2]
               MOV AH, 02H
               INT 21H
               
               INT 20H 
