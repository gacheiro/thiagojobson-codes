global _start

section .text

_start:
	mov rax, 1	;write(
	mov rdi, 1	;	STDOUT_FILENO,
	mov rsi, msg	;	"Displaying 9 stars\n",
	mov rdx, len	;	sizeof("Displaying 9 stars\n"),
	syscall		;);
	
	mov rax, 1	;write "*********"
	mov rdi, 1
	mov rsi, s2
	mov rdx, 9
	syscall
			
	mov rax, 60	;exit
	mov rdi, 0
	syscall

section .data
	msg db 'Displaying 9 stars', 10
	len equ $ - msg
	s2 times 9 db '*'

