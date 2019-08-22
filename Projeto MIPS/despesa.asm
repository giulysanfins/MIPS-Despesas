.data
inicio: 		.asciiz "Controle de gastos pessoais!\n"
escolha:     		.asciiz "Escolha uma das opcoes abaixo:\n"
registroDespesa:	.asciiz "1) Registrar despesa:\n"
listaDespesa:   	.asciiz "2) Listar despesas:\n"
excluirDespesa: 	.asciiz "3) Excluir despesa:\n"
exibirGastoMensal:  	.asciiz "4) Exibir gasto mensal:\n"
exibirCategoria:  	.asciiz "5) Exibir gasto por categoria:\n"
exibirRanking:  	.asciiz "6) Exibir ranking de despesas:\n"
sair: 			.asciiz "7) Sair\n"


printId:                .asciiz "Codigo de ID:"
printDia:               .asciiz " "
printMes:               .asciiz ""
printAno:               .asciiz ""
printGasto:             .asciiz " Gasto:R$"
printCategoria:         .asciiz " Categoria:" 

entradaDia:             .asciiz "Digite o dia:"
entradaMes:             .asciiz "Digite o mes:"
entradaAno:             .asciiz "Digite o ano:"
entradaGasto:           .asciiz "Digite o gasto:"
entradaCategoria:       .asciiz "Digite a categoria:"
barra:                  .asciiz "/"
barraN:                 .asciiz "\n"

vetor:		.align 2	
.space 160

categoria:		.align 2	
.space 16

cont: .word 1


teste: .asciiz  "teste\n\n\n"
.text

##----------------------------------------------------------------------##
la  $t7,vetor    # o registrador $t7 contém o endereço do vetor
#li $s2,1 #setando s2 para 1 = finalidade loop print


MENU:

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0,	inicio # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, escolha # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, registroDespesa # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, listaDespesa # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, excluirDespesa # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, exibirGastoMensal # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, exibirCategoria # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, exibirRanking # Parametro (string a ser escrita)
syscall

li $v0, 4 # Codigo SysCall p/ escrever strings
la $a0, sair # Parametro (string a ser escrita)
syscall

##----------------------------------------------------------------------##

li $v0,5 #lendo escolha do usuario
syscall

add $t0,$zero,$v0 #passando valor pra temp

beq $t0,1,funcDespesa #menu 
beq $t0,2,funcLista 
beq $t0,3,funcExcluir 
beq $t0,4,funcExibirMensal 
beq $t0,5,funcExibirCategoria 
beq $t0,6,funcExibirDespesa 
beq $t0,7,Sair


##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcDespesa:
#li $v0,5 ##pegar ID
#2 loop n funfa


la  $t1,vetor    # o registrador $t1 contém o endereço do vetor

add $s1,$s1,1
sw $s1,0($t7)

li $v0,4
la $a0,barraN
syscall


li $v0,4
la $a0,entradaDia
syscall

li $v0,5 #lendo escolha do usuario: dia
syscall
sw $v0,4($t7)

li $v0,4
la $a0,entradaMes
syscall

li $v0,5 #lendo escolha do usuario: mes
syscall
sw $v0,8($t7)

li $v0,4
la $a0,entradaAno
syscall

li $v0,5 #lendo escolha do usuario: ano
syscall
sw $v0,12($t7)

li $v0,4
la $a0,entradaGasto
syscall

li $v0,5 #lendo escolha do usuario: gasto
syscall
sw $v0,16($t7)

li $v0,4
la $a0,entradaCategoria
syscall

la $a0,20($t7)
li $a1,15	#lendo categoria
li $v0,8
syscall

add $t7,$t7,36

li $v0,4
la $a0,barraN
syscall

j MENU

##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcLista:
la  $t1,vetor    # o registrador $t1 contém o endereço do vetor

li $s2,0 #zerando $s2 para loop
loopPrint:

li $v0,4
la $a0,printId
syscall

li $v0,1  #print id
lw $a0,0($t1)
syscall

li $v0,4
la $a0,printDia
syscall

li $v0,1   #print dia
lw $a0,4($t1)
syscall

li $v0,4
la $a0,barra
syscall

li $v0,4
la $a0,printMes
syscall

li $v0,1   #print mes
lw $a0,8($t1)
syscall

li $v0,4
la $a0,barra
syscall

li $v0,4
la $a0,printAno
syscall

li $v0,1   #print ano
lw $a0,12($t1)
syscall

 li $v0,4
la $a0,printGasto
syscall

li $v0,1 #print gasto
lw $a0,16($t1)
syscall 

li $v0,4
la $a0,printCategoria
syscall

li $v0,4  #print categoria
la $a0,20($t1)
syscall

li $v0,4
la $a0,barraN
syscall

add $s2,$s2,1 #for(i=1;i<s2;i++)
add $t1,$t1,36 # adicionando "36" para ir pra prox vetor
bne $s1,$s2,loopPrint 
 
j MENU

##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcExcluir:
la  $t1,vetor    # o registrador $t1 contém o endereço do vetor
li $s2,0 #zerando $s2 para loop


li $v0,5  #entra com ID
syscall

add $t2,$v0,$zero
loopExcluir:  #loop para encontrar o Id


lw $s2,0($t1)


add $t1,$t1,36 # adicionando "36" para ir pra prox vetor
bne $t2,$s2,loopExcluir
add $t1,$t1,-36 # adicionando "-36" para ir pra  vetor anterior

add $t7,$t7,-36
#reposiciona o ultimo registro no local da exclus�o
lw $s2,0($t7) 
sw $s2,0($t1)

lw $s2,4($t7)
sw $s2,4($t1)

lw $s2,8($t7)
sw $s2,8($t1)

lw $s2,12($t7)
sw $s2,12($t1)

lw $s2,16($t7)
sw $s2,16($t1)

lw $s2,20($t7)
sw $s2,20($t1)

add $s1,$s1,-1

j MENU

##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcExibirMensal:
##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcExibirCategoria:
##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcExibirDespesa:
##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
Sair:

##----------------------------------------------------------------------##
