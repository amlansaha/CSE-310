.MODEL SMALL

.STACK 100H

.data
x dw 0
y dw 0
q dw 0
c dw 0
temp0 dw 0
temp1 dw 0
temp2 dw 0
temp3 dw 0
temp4 dw 0
temp5 dw 0
temp6 dw 0
temp7 dw 0
temp8 dw 0
temp9 dw 0
temp10 dw 0
temp11 dw 0
temp12 dw 0
temp13 dw 0
temp14 dw 0
temp15 dw 0

.CODE

MAIN PROC
MOV AX,@DATA
MOV DS,AX
MOV ax, 4
mov x, ax



;Adding
MOV ax, 123
MOV bx, 432
ADD ax, bx
MOV temp0, ax

MOV ax, temp0
mov x, ax


mov ax, x
neg ax
MOV x, ax

MOV ax, x
mov x, ax

MOV ax, 7
mov y, ax



;Adding
MOV ax, 3
MOV bx, 2
ADD ax, bx
MOV temp1, ax



;Adding
MOV ax, temp1
MOV bx, 5
ADD ax, bx
MOV temp2, ax



;Adding
MOV ax, temp2
MOV bx, 6
ADD ax, bx
MOV temp3, ax



;SUBTRACTING
MOV ax, temp3
MOV bx, 2
SUB ax, bx
MOV temp4, ax




;MULTIPLYING
MOV ax, 1
MOV bx, 5
MUL bx
MOV temp5, ax


;SUBTRACTING
MOV ax, temp4
MOV bx, temp5
SUB ax, bx
MOV temp6, ax

MOV ax, temp6
mov x, ax



;BITWISE AND
MOV ax, 0
MOV bx, 4
AND ax, bx
MOV temp7, ax



;MULTIPLYING
MOV ax, temp7
MOV bx, 4
MUL bx
MOV temp8, ax




;REMINDER
MOV ax, 1
MOV bx, 5
MOV dx, 0
DIV bx
MOV temp9, dx


;Adding
MOV ax, temp8
MOV bx, temp9
ADD ax, bx
MOV temp10, ax

MOV ax, temp10
mov y, ax




END MAIN
