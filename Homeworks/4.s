.data
	x: .long 256
	y: .long 1
	s1: .long 1
	s2: .long 1
	text: .asciz "PASS\n"
	text1: .asciz "FAIL\n"
.text
.global main
main:
	mov $0, %edx
	mov $16, %ebx
	mov x, %eax
	divl %ebx
	mov %eax, s1

	mov y, %eax
	mul %ebx
	mov %eax, s2
	
	mov %eax, s1
	mov %ebx, s2
	cmp  %eax, %ebx
	je et

	mov $4, %eax
	mov $1, %ebx
	mov $text1, %ecx
	mov $5, %edx
	int $0x80

	jmp exit
et:
	mov $4, %eax
	mov $1, %ebx
	mov $text, %ecx
	mov $5, %edx
	int $0x80

exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
