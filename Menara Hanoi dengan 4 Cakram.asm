.model small
.stack 300H
.data
x dw 4
text db "Pindah dari pasak "
d1 db ?
text2 db " ke pasak "
d2 db ?
newline db 0AH, 0DH, '$'

.code
main proc
    
    mov ax, @data
    mov ds, ax

    mov ax, 1
    push ax
    mov ax, 3
    push ax
    mov ax, 2
    push ax
    mov ax, x
    push ax
    call solve
    
    mov ax, 4C00H
    int 21h


main endp

solve proc
   push bp
   mov bp, sp
   cmp word ptr ss:[bp+4], 0
   je down
   
   push word ptr ss:[bp+0AH]
   push word ptr ss:[bp+6]
   push word ptr ss:[bp+8]
   mov ax, word ptr ss:[bp+4]
   dec ax
   push ax
   call solve

   push word ptr ss:[bp+0AH]
   push word ptr ss:[bp+08]
   call print

   push word ptr ss:[bp+06H]
   push word ptr ss:[bp+8]
   push word ptr ss:[bp+0AH]
   mov ax, word ptr ss:[bp+4]
   dec ax
   push ax
   call solve

   pop bp
   ret 8
down:
   pop bp
   ret 8

solve endp

print proc
   push bp
   mov bp, sp
   mov d1, '0'
   mov al, byte ptr ss:[bp+06]
   add d1, al
   mov d2, '0'
   mov al, byte ptr ss:[bp+4]
   add d2, al
   lea dx, text
   mov ah, 09
   int 21h
   pop bp
   ret 4

endp
end