.data
    nr_ex: .space 4
    nr_nod: .space 4
    x: .space 4
    leg: .space 4
    linii: .space 4
    col: .space 4
    k: .space 4
    i: .space 4
    j: .space 4
    vecfz: .space 400
    matr: .space 40000
    matr1: .space 40000
    matrres: .space 40000
    formatScanf: .asciz "%ld"
    formatPrintf: .asciz "%ld "
    Newline: .asciz "\n"



.text

matrix_mult:

	pushl %ebp
	mov %esp, %ebp
	movl $0, %edx
	movl 20(%ebp), %eax
	mull 20(%ebp)
	subl $4, %esp
	movl %eax, -4(%ebp)
	subl $4, %esp
	subl $4, %esp
	movl $0, %ebx
	lea 16(%ebp), %edi
	lea 8(%ebp), %esi
	lea 12(%ebp), %ecx
	movl $0, -8(%ebp)
	pushl %eax
	movl 20(%ebp), %eax 
	movl %eax, -12(%ebp)
	popl %eax

	
 for:
	cmpl $0, -4(%ebp)
	 je next
	for1:
	 cmpl $0, -12(%ebp)
		 je cont
	 movl (%esi,%ebx,4), %eax
	 movl $0, %edx
	 mull (%ecx,%ebx,4)
	 addl %eax, -8(%ebp)
	 
	 pushl %ebx
	 incl %ebx
	 movl (%esi, %ebx, 4), %eax
	 decl %ebx
	 movl $0, %edx
	 pushl %eax
	 pushl %edx
	 movl $4, %eax
	 mull -16(%ebp)
	 addl %eax, %ebx
	 popl %edx
	 popl %eax
	 mull (%ecx, %ebx, 4)
	 addl %eax, -8(%ebp)
	 popl %ebx

	 decl -12(%ebp)
	 jmp for1

cont:
	pushl %eax
        movl -8(%ebp), %eax
	movl %eax, (%edi,%ebx,4)
	popl %eax
	incl %ebx
	decl -4(%ebp)
	jmp for
	
next:
	movl %edi, %eax
	addl $12, %esp
	popl %ebp
	ret
	


.global main
main:
    push $nr_ex
    push $formatScanf
    call scanf
    pop %ebx
    pop %ebx

    push $nr_nod
    push $formatScanf
    call scanf
    pop %ebx
    pop %ebx

    mov $0, %ebx
    lea vecfz, %edi
    


cit_leg:
    cmp %ebx, nr_nod
    jle main1
    push %edi
    push $formatScanf
    call scanf
    pop %ecx
    pop %ecx
    addl $4, %edi
    inc %ebx
    jmp cit_leg

main1:
    lea vecfz, %edi
    movl $0, %ebx
    movl $0, x
    movl nr_nod, %ecx
    movl $0, %eax
    jmp constru_mat


constru_mat:
    cmpl x, %ecx
    je et_afisare
     movl (%edi, %eax, 4), %ebx
cit_leg1:
    cmpl $0, %ebx
        je continue

    pusha
    pushl $leg
    pushl $formatScanf
    call scanf
    pop %edx
    pop %edx
    popa

    pusha
    

    movl x, %eax
    movl $0, %edx
    mull nr_nod
    addl leg, %eax
    lea matr, %edi
    movl $1, (%edi, %eax, 4)


    popa

    subl $1, %ebx
    jmp cit_leg1
    
continue:   
    incl x
    movl x, %eax
    jmp constru_mat
    
    
    


et_afisare:
    cmpl $2, nr_ex
	je main2
    movl $0, linii
    loop_linii:
        movl linii, %ecx
        cmpl %ecx, nr_nod
        je exit

            movl $0, col
    loop_col:
        movl col, %ecx
        cmp %ecx, nr_nod
        je continue1

        movl linii, %eax
        movl $0, %edx
        mull nr_nod
        addl col, %eax

        lea matr, %edi
        movl (%edi, %eax, 4), %ebx

        pushl %ebx
        pushl $formatPrintf
        call printf
        pop %ebx
        pop %ebx
        

        incl col
        jmp loop_col
    continue1:

        pushl $Newline
        call printf
        popl %ebx
        
        pushl $0
        call fflush
        popl %ebx

        incl linii
        jmp loop_linii

main2:
	
	push $k
	push $formatScanf
	call scanf
	popl %ebx
	popl %ebx


	push $i
	push $formatScanf
	call scanf
	popl %ebx
	popl %ebx        
    

	push $j
	push $formatScanf
	call scanf
	popl %ebx
	popl %ebx


	lea matr, %edi
	movl %edi, matr1



calc_drum:
	cmpl $0, k
	 je afis_drum

 	pusha
	pushl nr_nod
	pushl $matrres
	pushl $matr1
	pushl $matr
	call matrix_mult
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	popa




	movl %eax, matr1
	
	
	
	subl $1, k
	jmp calc_drum



afis_drum:
	movl %eax, %edi	
	movl i, %eax
	movl $0, %edx
	mull nr_nod
	addl j, %eax

	pusha
	push (%edi,%eax,4)
	push $formatPrintf
	call printf
	pop %edx
	pop %edx
	popa

	push $Newline
	call printf
	pop %edx

	pusha
	push $0
	call fflush
	pop %edx
	popa
	

exit: 

    mov $1, %eax
    xor %ebx, %ebx
    int $0x80

