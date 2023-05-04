.data
	n: .long 31
.text
.global main
main:
	movl $31, %eax
	movl $30, %ecx
	movl $0, %edx
	movl $0, %ebx
etloop:
	div %ecx
	movl $31, %eax
	cmpl %edx, $0
	je egal
	loop etloop
	jmp exit
egal:
	addl $1, %ebx
exit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80
