ORG 100H

.data
array dw 0031H, 0033H, 0035H, 0037H, 0039H
length db 5
sum db ?
tens db ?
units db ?

.code
start: MOV CL, length ; initialize
       MOV SI, 0
       MOV AX, 0

LEA BX, array
MOV SI, BX
MOV tens, 00H
loop_start: MOV AX, [SI]
            SUB AL, 30H
            
            ADD DL, AL
            
            INC SI
            INC SI
            LOOP loop_start
            
get_digits: SUB DL, 0AH
            ADD tens, 01H
            
            CMP DL, 0AH 
            JGE get_digits
            
            MOV units, DL

get_sum: LEA BX, sum
         
         MOV DL, tens
         ADD DL, 30H
         MOV [BX], DL
         
         MOV DL, units
         ADD DL, 30H
         MOV [BX+1], DL
        
         
print_sum: LEA BX, sum

           MOV AH, 02H
           MOV DL, [BX]
           INT 21H
           
           MOV DL, [BX+1]
           INT 21H

store_in_reg: LEA BX, sum
              
              MOV AH, [BX] ; get tens digit
              SUB AH, 30H
              
              MOV AL, [BX+1] ; get units digit
              SUB AL, 30H
              
              MOV DS, AX ; store in DS in the form 0205 
           
         
           
                                   
            
            
            
            
            
            
            
                   
