.data
	x: .long 16
	y: .long 10
	s1: .long 1
	s2: .long 1
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
	add s1, %eax

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
