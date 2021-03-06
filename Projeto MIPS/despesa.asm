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

printent:               .asciiz "entrou:"
printId:                .asciiz "Codigo de ID:"
printDia:               .asciiz " "
printMes:               .asciiz ""
printAno:               .asciiz ""
printGasto:             .asciiz " Gasto:R$"
printCategoria:         .asciiz " Categoria:"
printEpoch:             .asciiz "Epoch:"
printGastot:            .asciiz "Gasto total:" 

Ano:             	.asciiz "Ano:"
Mes:             	.asciiz "Mes:"
entradaDia:             .asciiz "Digite o dia:"
entradaMes:             .asciiz "Digite o mes:"
entradaAno:             .asciiz "Digite o ano:(MINIMO ANO DE 1970)"
entradaGasto:           .asciiz "Digite o gasto:"
entradaCategoria:       .asciiz "Digite a categoria:"
barra:                  .asciiz "/"
barraN:                 .asciiz "\n"
gastototal:             .asciiz "Gasto total realizado no m�s"


vetor:		.align 2	
.space 3600

categoria:		.align 2	
.space 160

aux:		.align 2	
.space 800
vetor_despesa:		.align 2	
.space 1600

vetordata:		.align 2	
.space 800
tamanho: .word 1
tamanhoaux: .word 1


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
sw $t7,tamanho #guardando tamanho do vetor na variavel.

li $v0,4
la $a0,barraN
syscall

j MENU

##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcLista:
beqz $s1,MENU
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
li $s3,0 #zerando $s2 para loop
beq $s1,$s2,MENU


li $v0,5  #entra com ID
syscall

add $t2,$v0,$zero
add $t2,$v0,$zero #salva Id no t2
loopExcluir:  #loop para encontrar o Id


lw $s2,0($t1)

lw $s2,0($t1)  #copia o Id do vetor para s2

add $s3,$s3,1 #for(i=1;i<s2;i++)
add $t1,$t1,36 # adicionando "36" para ir pra prox vetor
bne $t2,$s2,loopExcluir
beq $s2,$t2,f_exclui
bne $s1,$s3,loopExcluir #compara a entrada com o vetor
j MENU
f_exclui:
add $t1,$t1,-36 # adicionando "-36" para ir pra  vetor anterior

add $t7,$t7,-36
#reposiciona o ultimo registro no local da exclus�o

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

lw $s2,24($t7)
sw $s2,24($t1)

lw $s2,28($t7)
sw $s2,28($t1)

lw $s2,32($t7)
sw $s2,32($t1)

add $s1,$s1,-1

j MENU

##----------------------------------------------------------------------##

##----------------------------------------------------------------------##
funcExibirMensal:

##----------------------------------------------------------------------##

#CRIANDO VETOR AUX COM DADOS DO ORIGINAL
beqz $s1,MENU
la $t1,vetor
la $s7,vetordata#vetor para armzanar data 


Epoch:
lw $s5,tamanho
beq $t1,$s5,Print
add $t1,$t1,8
lw $t6,0($t1)#Carreganddo o mes em t6
add $t1,$t1,4
lw $t5,0($t1)#carregando o ano em t5

#calculando epoch
sub $t5,$t5,1950
mul $t5,$t5,12
add $t6,$t6,$t5
sub $t6,$t6,1

#Comparando posic�es de epoch
la $t4,aux #vetor aux em t4  
add $t4,$t4,4
lw $t3,0($t4)
beq $t3,0,Inserir#verifica se a epoch no vetor aux � vazia
beq $t6,$t3,Soma#comparando epoch
bne $t6,$t3,Avanca

Inserir:
#Guarda a epoch no vetor
sw $t6,0($t4)


#-------------------------Guardando o mes e ano ----------------------
sub $t1,$t1,4#indo para o mes
lw $t0,0($t1)#armazena mes em variavel
add $s7,$s7,4#posicao do mes em aux
sw $t0,0($s7)#coloca o mes num vet auxiliar
add $t1,$t1,4#posicao do ano no vetor original
lw $t0,0($t1)#armazena mes em variavel
add $s7,$s7,4#posicao do ano em aux
sw $t0,0($s7)#coloca o mes num vet auxiliar
#--------------------------------------------------------------------

#zerando registrador t6 para guardar gasto em aux: 
add $t6,$zero,$zero
add $t1,$t1,4#posicao do gasto
lw  $t6,0($t1)
add $t4,$t4,4#andando 1 posicao para guardar gasto
sw $t4,tamanhoaux #guardando tamanho do vetor aux na variavel.
sw $t6,0($t4)#gasto guardado em aux
add $t1,$t1,20#Indo para a proxima posicao do vetor

j Epoch

Soma:

add $t1,$t1,4#Pegando prox posicao do vetor original = custo
lw $t5,0($t1)#jogando o dado para o registrador
add $t4,$t4,4#Pegando prox posicao do vetor aux = custo
sw $t4,tamanhoaux #guardando tamanho do vetor aux na variavel.
lw $t6,0($t4)#jogando o dado para o registrador
add $t6,$t6,$t5
sw $t6,0($t4)#armazenando o custo somado no vetor aux. 
add $t1,$t1,20#Indo para a proxima posicao do vetor



j Epoch

Avanca:
add $t4,$t4,8
lw $t3,0($t4)
beq $t3,0,Inserir#verifica se a epoch no vetor aux � vazia
beq $t6,$t3,Soma#comparando epoch
bne $t6,$t3,Avanca

j Epoch

#Printando custo e Epoch:
Print:
lw $s6,tamanhoaux 
la $t4,aux #vetor aux em t4
la $s7,vetordata#vetor para armzanar data 


Printe:
beq $t4,$s6,ZERA

add $t4,$t4,4
add $s7,$s7,4

li $v0,4
la $a0,Mes
syscall

li $v0,1   #print Mes
lw $a0,0($s7)
syscall

li $v0,4
la $a0,barraN
syscall

add $s7,$s7,4
#printando ano
li $v0,4
la $a0,Ano
syscall

li $v0,1   #print Ano
lw $a0,0($s7)
syscall

li $v0,4
la $a0,barraN
syscall

add $t4,$t4,4
 
li $v0,4
la $a0,printGastot
syscall

li $v0,1   #print Gasto total
lw $a0,0($t4)
syscall

li $v0,4
la $a0,barraN
syscall

j Printe

ZERA:
la $t4,aux #vetor aux em t4
j jMENU
ZERANDOAUX:
beq $t4,$s6,jMENU
sw $zero,0($t4)
add $t4,$t4,4
j ZERANDOAUX

jMENU:
j MENU
#li $v0,1   #print mes
#sub $a0,$t6,0
#syscall

##----------------------------------------------------------------------##
funcExibirCategoria:
##----------------------------------------------------------------------##
beqz $s1,MENU
la $t1,vetor
la $t8,vetor_despesa
add $s2,$zero,$zero
li $s4,0
li $t6,0


loop1:
	
	la $t8,vetor_despesa
	add $s0,$zero,$zero
	
	beqz $s4,end_loop2
	loop2:
	add $s3,$zero,$t1
	add $s5,$zero,$t8
	strcmp:
	

# string compare loop (just like strcmp)
cmploop:
		lb $t2,20($s3)                   # get next char from str1
		lb $t3,0($s5)                   # get next char from str2
		
			sge $t0,$t2,65
			sleu $t5,$t2,90
			and $t0,$t0,$t5
	
			bnez $t0,convert11
			j end_convert11
			
			convert11:
			add $t2,$t2,32
			end_convert11:
			
	
			sge $t0,$t3,65
			sleu $t5,$t3,90
			and $t0,$t0,$t5
			
			bnez $t0,convert22
			j end_convert22
			convert22:
			
			add $t3,$t3,32
			end_convert22:
		
		
		bne $t2,$t3,cmpne               # are they different? if yes, fly

		beq $t2,$zero,cmpeq             # at EOS? yes, fly (strings equal)

		addi $s5,$s5,1                   # point to next char
		addi $s3,$s3,1                   # point to next char
		j cmploop

cmpeq:		# incrementa o gasto 
	lw $s6,16($t1)
	lw $s7,16($t8)
	add $s6,$s6,$s7
	sw $s6,16($t8) 
	addi $t5,$zero,1
	j end_loop1

cmpne:
	addi $t5,$zero,0
	
	add $s0,$s0,1
	add $t8,$t8,20
	
	bne $s4,$s0,loop2
	
	end_loop2: #adiciona a categoria caso no vetor_despesa
	
	lw $s2,16($t1)
	sw $s2,16($t8)

	lw $s2,20($t1)
	sw $s2,0($t8)

	lw $s2,24($t1)
	sw $s2,4($t8)

	lw $s2,28($t1)
	sw $s2,8($t8)

	lw $s2,32($t1)
	sw $s2,12($t8)

	add $s4,$s4,1
	
	end_loop1:
	add $t6,$t6,1	
	add $t1,$t1,36		
	bne $s1,$t6,loop1
	la $t8,vetor_despesa
	li $t6,0
	li $s0,1
	li $t0,87
	sub $s5,$s4,1
	beqz $s5,print
	bubble_sort: #algoritmo de ordena��o decrescente
	b_loop1: 
		la $t8,vetor_despesa
		la $t1,vetor_despesa
		add $t1,$t1,20
		li $t6,0
		b_loop2:
			add $t3,$zero,$t1
			add $t2,$zero,$t8
			ccmp:
			
			lb $s2,0($t2) 
			lb $t5,0($t3)
			
			sge $t0,$s2,65
			sleu $s3,$s2,90
			and $t0,$t0,$s3
			
			add $s3,$s2,$zero
			bnez $t0,convert1
			j end_convert1
			
			convert1:
			add $s3,$s3,32
			add $s2,$s3,$zero
			end_convert1:
			
	
			
			sge  $t0,$t5,65
			sleu $s3,$t5,90
			and $t0,$t0,$s3
			
			add $s3,$t5,$zero
			bnez $t0,convert2
			j end_convert2
			convert2:
			add $s3,$s3,32
			add $t5,$s3,$zero
			end_convert2:
			
			
			
			bgt $s2,$t5,troca  
			bne $s2,$t5,end_troca
			beq $s2,$zero,end_troca            # at EOS? yes, fly (strings equal)

			addi $t3,$t3,1                   # point to next char
			addi $t2,$t2,1                   # point to next char
			j ccmp
			
			
		
			end_troca:
			add $t1,$t1,20
			add $t8,$t8,20
			add $t6,$t6,1
			bne $s5,$t6,b_loop2 
			
	end_bloop1:	
	add $s0,$s0,1
	bne $s4,$s0,b_loop1
	la $t8,vetor_despesa
	li $t6,0
	li $s0,0
	print: #printa o vetor_despesa
	
	
	print_loop: 
	

	

	li $v0,4  #print categoria
	la $a0,0($t8)
	syscall
	

	li $v0,11 #print gasto
	li $a0,82
	syscall 
	
	li $v0,11 #print gasto
	li $a0,36
	syscall 
	
	li $v0,1 #print gasto
	lw $a0,16($t8)
	syscall 
	
	

	li $v0,4
	la $a0,barraN
	syscall
	add $s0,$s0,1
	add $t8,$t8,20
	beqz $s5,MENU
	bne $s4,$s0,print
j MENU


troca: #troca as posi��es entre as posi��es i e i+1
	lw $s2,0($t8)
	lw $t5,0($t1)
	sw $t5,0($t8)
	sw $s2,0($t1)
	
	lw $s2,4($t8)
	lw $t5,4($t1)
	sw $t5,4($t8)
	sw $s2,4($t1)
	
	lw $s2,8($t8)
	lw $t5,8($t1)
	sw $t5,8($t8)
	sw $s2,8($t1)
	
	lw $s2,12($t8)
	lw $t5,12($t1)
	sw $t5,12($t8)
	sw $s2,12($t1)
	
	lw $s2,16($t8)
	lw $t5,16($t1)
	sw $t5,16($t8)
	sw $s2,16($t1)
	j end_troca
	
##----------------------------------------------------------------------##
funcExibirDespesa:
##----------------------------------------------------------------------##
beqz $s1,MENU
la $t1,vetor
la $t8,vetor_despesa
add $s2,$zero,$zero
li $s4,0
li $t6,0

loop11:
	
	la $t8,vetor_despesa
	add $s0,$zero,$zero
	
	beqz $s4,end_loop22
	loop22:
	add $s3,$zero,$t1
	add $s5,$zero,$t8
	strcmp1:

# string compare loop (just like strcmp)
cmploop1:
		lb $t2,20($s3)                   # get next char from str1
		lb $t3,0($s5)                   # get next char from str2
		bne $t2,$t3,cmpne1               # are they different? if yes, fly

		beq $t2,$zero,cmpeq1             # at EOS? yes, fly (strings equal)

		addi $s5,$s5,1                   # point to next char
		addi $s3,$s3,1                   # point to next char
		j cmploop1

cmpeq1:		# incrementa o gasto 
	lw $s6,16($t1)
	lw $s7,16($t8)
	add $s6,$s6,$s7
	sw $s6,16($t8) 
	addi $t5,$zero,1
	j end_loop11

cmpne1:
	addi $t5,$zero,0
	
	add $s0,$s0,1
	add $t8,$t8,20
	
	bne $s4,$s0,loop22
	
	end_loop22: #adiciona a categoria caso no vetor_despesa
	
	lw $s2,16($t1)
	sw $s2,16($t8)

	lw $s2,20($t1)
	sw $s2,0($t8)

	lw $s2,24($t1)
	sw $s2,4($t8)

	lw $s2,28($t1)
	sw $s2,8($t8)

	lw $s2,32($t1)
	sw $s2,12($t8)

	add $s4,$s4,1
	
	end_loop11:
	add $t6,$t6,1	
	add $t1,$t1,36		
	bne $s1,$t6,loop11
	la $t8,vetor_despesa
	li $t6,0
	li $s0,1
	sub $s5,$s4,1
	beqz $s5,print1
	bubble_sort1: #algoritmo de ordena??o decrescente
	b_loop11: 
		la $t8,vetor_despesa
		la $t1,vetor_despesa
		add $t1,$t1,20
		li $t6,0
		b_loop22:
			lw $s2,16($t8) 
			lw $t5,16($t1)
			blt $s2,$t5,troca1  #verifica se i < i+1, se sim faz a troca
			
			end_troca1:
			add $t1,$t1,20
			add $t8,$t8,20
			add $t6,$t6,1
			bne $s5,$t6,b_loop22
			
		
	add $s0,$s0,1
	bne $s4,$s0,b_loop11
	la $t8,vetor_despesa
	li $t6,0
	li $s0,0
	print1: #printa o vetor_despesa
	
	
	print_loop1: 

	li $v0,4  #print categoria
	la $a0,0($t8)
	syscall

	li $v0,11 #print gasto
	li $a0,82
	syscall 
	
	li $v0,11 #print gasto
	li $a0,36
	syscall 
	
	li $v0,1 #print gasto
	lw $a0,16($t8)
	syscall 

	li $v0,4
	la $a0,barraN
	syscall
	add $s0,$s0,1
	add $t8,$t8,20
	beqz $s5,MENU
	bne $s4,$s0,print1
j MENU

troca1: #troca as posi??es entre as posi??es i e i+1
	lw $s2,0($t8)
	lw $t5,0($t1)
	sw $t5,0($t8)
	sw $s2,0($t1)
	
	lw $s2,4($t8)
	lw $t5,4($t1)
	sw $t5,4($t8)
	sw $s2,4($t1)
	
	lw $s2,8($t8)
	lw $t5,8($t1)
	sw $t5,8($t8)
	sw $s2,8($t1)
	
	lw $s2,12($t8)
	lw $t5,12($t1)
	sw $t5,12($t8)
	sw $s2,12($t1)
	
	lw $s2,16($t8)
	lw $t5,16($t1)
	sw $t5,16($t8)
	sw $s2,16($t1)
	j end_troca1
	

	
##----------------------------------------------------------------------##
Sair:

##----------------------------------------------------------------------##
