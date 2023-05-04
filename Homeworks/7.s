.data
n: .long 3
v: .long 5, 6
nr: .long 0
.text
divizibil_cu_2:
	pushl %ebp
	movl 8(%ebp), %edi
	addl 12(%ebp), %edi
	movl %edi, %eax
	movl $0, %edx
	movl $2, %ebx
	divl %ebx
	popl %ebp
	ret
.global main
main:
	mov $1, %edx
	lea v, %esi
	subl $1, n
loop:
	cmp n, %edx
	jg exit
	movl (%esi, %edx, 4), %eax
	movl -4(%esi, %edx, 4), %ebx
	push %edx
	push %eax
	push %ebx
	call divizibil_cu_2
	pop %ebx
	pop %ebx

	add %edx, nr
	pop %edx
	inc %edx
	jmp loop
exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80