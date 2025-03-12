	.file	"clear.c"
	.text
	.globl	a
	.bss
	.align 32
	.type	a, @object
	.size	a, 1073741824
a:
	.zero	1073741824
	.text
	.globl	clear1
	.type	clear1, @function
clear1:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	incl	-4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L3
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	clear1, .-clear1
	.globl	clear2
	.type	clear2, @function
clear2:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L5
.L6:
	movq	-8(%rbp), %rax
	movl	$0, (%rax)
	addq	$4, -8(%rbp)
.L5:
	movl	-28(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	cmpq	%rax, -8(%rbp)
	jb	.L6
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	clear2, .-clear2
	.globl	clear3
	.type	clear3, @function
clear3:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	clear3, .-clear3
	.section	.rodata
.LC0:
	.string	"clear1: %lf\n"
.LC1:
	.string	"clear2: %lf\n"
.LC2:
	.string	"clear3: %lf\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	call	omp_get_wtime@PLT
	vmovq	%xmm0, %rax
	movq	%rax, -8(%rbp)
	movl	$268435456, %esi
	leaq	a(%rip), %rax
	movq	%rax, %rdi
	call	clear1
	call	omp_get_wtime@PLT
	vmovq	%xmm0, %rax
	vmovq	%rax, %xmm2
	vsubsd	-8(%rbp), %xmm2, %xmm1
	vmovq	%xmm1, %rax
	vmovq	%rax, %xmm0
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	call	omp_get_wtime@PLT
	vmovq	%xmm0, %rax
	movq	%rax, -8(%rbp)
	movl	$268435456, %esi
	leaq	a(%rip), %rax
	movq	%rax, %rdi
	call	clear2
	call	omp_get_wtime@PLT
	vmovq	%xmm0, %rax
	vmovq	%rax, %xmm4
	vsubsd	-8(%rbp), %xmm4, %xmm3
	vmovq	%xmm3, %rax
	vmovq	%rax, %xmm0
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	call	omp_get_wtime@PLT
	vmovq	%xmm0, %rax
	movq	%rax, -8(%rbp)
	movl	$268435456, %esi
	leaq	a(%rip), %rax
	movq	%rax, %rdi
	call	clear3
	call	omp_get_wtime@PLT
	vmovq	%xmm0, %rax
	vmovq	%rax, %xmm6
	vsubsd	-8(%rbp), %xmm6, %xmm5
	vmovq	%xmm5, %rax
	vmovq	%rax, %xmm0
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
