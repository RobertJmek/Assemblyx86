.data
	a: .long 54
	b: .long 5
	c: .long 15
	min: .space 4
.text
.global main
main:
	mov a, %eax
	mov b, %ebx
	mov c, %ecx
	cmp %eax, %ebx
	jb et1
	jmp et2
et1:
	mov %ebx, min
	jmp et3
et2:
	mov %eax, min
et3:
	mov min, %eax
	cmp %eax, %ecx
	jb et4
	jmp exit
et4:
	mov %ecx, min
	jmp exit
exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80

