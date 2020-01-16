.macro putchar_console
	sw $t0,0($sp) # on stocke la valeur de $t0 dans $sp
	lui $t0,0xFFFF # on affecte ??? $t0 la valeur 0xFFFF
	sw $a0,0xC($t0) # on stocke la valeur de $a0 dans $t0 (ce qui l'affiche dans output simulator)
	lw $t0,0($sp) # on r???cup???re la valeur stock??? dans $sp
.end_macro 


.macro getchar_console
	sw $t0,0($sp)
	lui $t0,0xFFFF
boucle : 
	lw $v0,0($t0)
	beq $v0,$0,boucle
	lw $v0,4($t0)
	lw $v0,4($t0)
	lw $t0,0($sp)
.end_macro

.macro termine
	li $v0,10
	syscall
.end_macro



.data 
switch_debut:
        .word   retourne_5
        .word   retourne_6
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_3
        .word   retourne_1
        .word   retourne_0
        .word   retourne_2
        .word   retourne_0
        .word   retourne_4
        .word   retourne_0
        .word   retourne_18
        .word   retourne_19
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_11
        .word   retourne_0
        .word   retourne_12
        .word   retourne_0
        .word   retourne_0
        .word   retourne_13
        .word   retourne_20
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_14
        .word   retourne_10
        .word   retourne_0
        .word   retourne_0
        .word   retourne_16
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_21
        .word   retourne_17
        .word   retourne_15
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_8
        .word   retourne_0
        .word   retourne_0
        .word   retourne_13
        .word   retourne_20
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_14
        .word   retourne_10
        .word   retourne_0
        .word   retourne_0
        .word   retourne_16
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_21
        .word   retourne_17
        .word   retourne_15
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_0
        .word   retourne_7
        .word   retourne_0
        .word   retourne_9
        
switch_calcul:
        .word   default_switch_calcul
        .word   addition
        .word   soustraction
        .word   multiplication
        .word   division
        .word   modulo
        .word   et
        .word   ou
        .word   ou_excusif
        .word   non_ou
        .word   complement_2
        .word   decalage_gauche
        .word   decalage_non_signe_droite
        .word   decalage_signe_droite
        .word   inverser8bits
        .word   inverser16bits
        .word   switch_rotation_gauche
        .word   switch_rotation_droite
        .word   lire_n1
        .word   lire_n2
        .word   lire_base
        
menu:
        .asciiz  "\nn1 | n2 | base | resultat\n"
barre_droite:
        .asciiz  " | "
retour_chariot:
        .asciiz  " \n"
saisir_op:
        .asciiz  "Saisir une operation : "
end:
        .asciiz  "*Fin du programme* "
erreur_calcul:
        .asciiz  "*Erreur de calcul, recommencez !*\n"
saisir_n1:
        .asciiz  "Saisir n1 : "
erreur_n1:
        .asciiz  "\n*Erreur  : Le nombre saisi n'est pas valide dans la base donnee ! N1 est reinitialise a 0.* \n"
saisir_n2:
        .asciiz  "Saisir n2 : "
erreur_n2:
        .asciiz  "\n*Erreur  : Le nombre saisi n'est pas valide dans la base donnee ! N2 est reinitialise a 0.* \n"
saisir_base:
        .asciiz  "Saisir base : "
erreur_base:
        .asciiz  "\n *Erreur  : La base saisie n'est pas dans l'interval [2;16] ! La base est reinitialise a 10.*\n"
        

.text
	li $sp,0x7fffeffc
	jal main
	infini:
	beq $0,$0,infini

printString:
        addiu   $sp,$sp,-32
        sw      $ra,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        sw      $a0,32($fp)
        b       $L2
        

$L3:
        lw      $v0,32($fp)
        
        lb      $v0,0($v0)
        
        move    $a0,$v0
        putchar_console
        

        lw      $v0,32($fp)
        
        addiu   $v0,$v0,1
        sw      $v0,32($fp)
$L2:
        lw      $v0,32($fp)
        
        lb      $v0,0($v0)
        
        bne     $v0,$0,$L3
        

        
        move    $sp,$fp
        lw      $ra,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        j       $ra
        

readString:
# $a1 : adresse  tableau de caracteres 
	sw $v0,0($sp)
	sw $t1,-4($sp)
	sw $a0,-8($sp)
	sw $t2,-12($sp)
	sw $t3,-16($sp)
readStringBoucle :
	getchar_console
	add $t1,$0,$v0 # on sauvegarde $v0(caractere venant d'être tapé dans $t1
	sb $v0,0($a0) # on stock $v0 à l'adresse de $a1
	addi $a0,$a0,1 # on incrémente $a1 
	lw $t2,-8($sp) 
	addi $t3,$a0,-1
	bne $t1,'\b',continue1 # si le caractere n'est pas backspace, b 'continue1'
	addi $a0,$a0,-1	# suppression du caractère backspace
	beq $t2,$t3,continue1 # si on est pas revenu au début de l'adresse (= la chaine est vide)
	addi $a0,$a0,-1 # suppression du caractere tapé avant backspace
continue1 :
	bne $t1,'\n',readStringBoucle # tant que la touche entrée n'est pas tapée
	sb $0,-1($a0) # remplacement de \n par \0
	lw $v0,0($sp)
	lw $t1,-4($sp)
	lw $a0,-8($sp)	
	lw $t2,-12($sp)
	lw $t3,-16($sp)
	jr $ra

forDigit :
	
	bgtz $a0,suite
	sub $a0,$0,$a0
suite :
	addi $v0,$a0,-10 # $v0 = $a0 - 10
	bltz $v0,forDigitFin # Si ($v0 <= 0) -> forDigitFin
	addi $v0,$v0,7 # $v0 = $v0 + 7
forDigitFin:
	add $v0,$v0,0x3A # $v0 = $v0 + '9'+1
	jr $ra

digit:
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        move    $v0,$a0
        sw      $a1,28($fp)
        sb      $v0,24($fp)
        lw      $v0,28($fp)
        
        slt     $v0,$v0,2
        bne     $v0,$0,$L13
        

        lw      $v0,28($fp)
        
        slt     $v0,$v0,17
        bne     $v0,$0,$L14
        

$L13:
        li      $v0,-1                 # 0xffffffffffffffff
        b       $L15
        

$L14:
        lb      $v0,24($fp)
        
        sw      $v0,8($fp)
        lw      $v0,8($fp)
        
        slt     $v0,$v0,97
        bne     $v0,$0,$L16
        

        lw      $v0,8($fp)
        
        slt     $v0,$v0,123
        beq     $v0,$0,$L16
        

        lw      $v0,8($fp)
        
        addiu   $v0,$v0,-32
        sw      $v0,8($fp)
$L16:
        lw      $v0,8($fp)
        
        slt     $v0,$v0,91
        beq     $v0,$0,$L17
        

        lw      $v0,8($fp)
        
        slt     $v0,$v0,65
        beq     $v0,$0,$L18
        

$L17:
        lw      $v0,8($fp)
        
        slt     $v0,$v0,48
        bne     $v0,$0,$L19
        

        lw      $v0,8($fp)
        
        slt     $v0,$v0,58
        bne     $v0,$0,$L18
        

$L19:
        li      $v0,-1                 # 0xffffffffffffffff
        b       $L15
        

$L18:
        lw      $v0,8($fp)
        
        slt     $v0,$v0,58
        bne     $v0,$0,$L20
        

        lw      $v0,8($fp)
        
        addiu   $v0,$v0,-55
        sw      $v0,8($fp)
        b       $L21
        

$L20:
        lw      $v0,8($fp)
        
        addiu   $v0,$v0,-48
        sw      $v0,8($fp)
$L21:
        lw      $v1,8($fp)
        lw      $v0,28($fp)
        
        slt     $v0,$v1,$v0
        bne     $v0,$0,$L22
        

        li      $v0,-1                 # 0xffffffffffffffff
        b       $L15
        

$L22:
        lw      $v0,8($fp)
$L15:
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        j       $ra
        

toInt : 
	# $a0 : nombre / $a1 : base / $a2 : adresse chaine res
	sw $ra,0($sp)
	sw $a0,-4($sp)
	sw $t0,-8($sp)
	bltz $a0,un # si $a0 positif on inverse et b 'un'
	sub $a0,$0,$a0 # sinon inversion et  b 'boucle1'
	b boucle1	
un:	
	addi $t0,$0,'-' # premier caractere = '-' 
	sb $t0,0($a2)	
	addi $a2,$a2,1 # incrémentation adresse

	
boucle1:
	div $a0,$a1 # n/base
	mflo $a0 # recup du quotient

	addi $a2,$a2,1 # incrémentation adresse
	bnez $a0,boucle1 # tant que $a0 != 0
	
	addi $t0,$0,0	
	sb $t0,0($a2) #stockage de \0 à la fin de la chaine
	lw $a0,-4($sp) # recup valeur initiale nb
boucle2 : 
	
	move $t1,$a0 # $t1 = nombre
	addi $a2,$a2,-1 # décrémentation adresse
	
	div $t1,$a1 # nb/base
	mfhi $t0 # recup reste
	move $a0,$t0 
	jal forDigit
	sb $v0,0($a2) # stockage du digit
	move $a0,$t1
	div $a0,$a1
	mflo $a0 # nb = nb/base
	bnez $a0,boucle2 # tant que nb != 0
	
	add $v0,$0,$0 # retourne 0
	lw $ra,0($sp) 
	lw $a0,-4($sp)
	lw $t0,-8($sp)
	jr $ra

parseInt:
        addiu   $sp,$sp,-48
        sw      $ra,44($sp)
        sw      $fp,40($sp)
        sw      $s1,36($sp)
        sw      $s0,32($sp)
        move    $fp,$sp
        sw      $a0,48($fp)
        sw      $a1,52($fp)
        sw      $a2,56($fp)
        lw      $v0,48($fp)
        
        beq     $v0,$0,$L33
        

        lw      $v0,56($fp)
        
        beq     $v0,$0,$L33
        

        lw      $v0,52($fp)
        
        slt     $v0,$v0,17
        beq     $v0,$0,$L33
        

        lw      $v0,52($fp)
        
        slt     $v0,$v0,2
        beq     $v0,$0,$L34
        

$L33:
        li      $v0,1                        # 0x1
        b       $L35
        

$L34:
        lw      $v0,56($fp)
        
        sw      $0,0($v0)
        lw      $v0,48($fp)
        
        sw      $v0,24($fp)
        lw      $v0,24($fp)
        
        lb      $v1,0($v0)
        li      $v0,45                 # 0x2d
        beq     $v1,$v0,$L36
        

        lw      $v0,24($fp)
        
        lb      $v1,0($v0)
        li      $v0,43                 # 0x2b
        bne     $v1,$v0,$L38
        

$L36:
        lw      $v0,48($fp)
        
        addiu   $v0,$v0,1
        sw      $v0,48($fp)
        b       $L38
        

$L41:
        lw      $v0,48($fp)
        
        lb      $v0,0($v0)
        lw      $a1,52($fp)
        move    $a0,$v0
        jal     digit
        

        move    $v1,$v0
        li      $v0,-1                 # 0xffffffffffffffff
        bne     $v1,$v0,$L39
        

        li      $v0,1                        # 0x1
        b       $L35
        

$L39:
        lw      $v0,56($fp)
        
        lw      $s0,0($v0)
        lw      $v0,56($fp)
        
        lw      $v1,0($v0)
        lw      $v0,52($fp)
        
        mult    $v1,$v0
        mflo    $s1
        lw      $v0,48($fp)
        
        lb      $v0,0($v0)
        lw      $a1,52($fp)
        move    $a0,$v0
        jal     digit
        

        subu    $v0,$s1,$v0
        slt     $v0,$s0,$v0
        beq     $v0,$0,$L40
        

        li      $v0,1                        # 0x1
        b       $L35
        

$L40:
        lw      $v0,56($fp)
        
        lw      $v1,0($v0)
        lw      $v0,52($fp)
        
        mult    $v1,$v0
        mflo    $s0
        lw      $v0,48($fp)
        
        lb      $v0,0($v0)
        lw      $a1,52($fp)
        move    $a0,$v0
        jal     digit
        

        subu    $v1,$s0,$v0
        lw      $v0,56($fp)
        
        sw      $v1,0($v0)
        lw      $v0,48($fp)
        
        addiu   $v0,$v0,1
        sw      $v0,48($fp)
        lw      $v0,24($fp)
        
        lb      $v1,0($v0)
        li      $v0,43                 # 0x2b
        bne     $v1,$v0,$L38
        

        lw      $v0,56($fp)
        
        lw      $v1,0($v0)
        li      $v0,-2147483648                  # 0xffffffff80000000
        bne     $v1,$v0,$L38
        

        li      $v0,1                        # 0x1
        b       $L35
        

$L38:
        lw      $v0,48($fp)
        
        lb      $v0,0($v0)
        
        bne     $v0,$0,$L41
        

        lw      $v0,24($fp)
        
        lb      $v1,0($v0)
        li      $v0,45                 # 0x2d
        beq     $v1,$v0,$L42
        

        lw      $v0,56($fp)
        
        lw      $v0,0($v0)
        
        subu    $v1,$0,$v0
        lw      $v0,56($fp)
        
        sw      $v1,0($v0)
$L42:
        move    $v0,$0
$L35:
        move    $sp,$fp
        lw      $ra,44($sp)
        lw      $fp,40($sp)
        lw      $s1,36($sp)
        lw      $s0,32($sp)
        addiu   $sp,$sp,48
        j       $ra
        

inverse8bits:
        addiu   $sp,$sp,-40
        sw      $fp,36($sp)
        move    $fp,$sp
        sw      $a0,40($fp)
        lw      $v0,40($fp)
        
        slt     $v0,$v0,256
        beq     $v0,$0,boucle1_inv8
        

        lw      $v0,40($fp)
        b       fin_inv8
        

boucle1_inv8:
        lw      $v0,40($fp)
        
        sra     $v0,$v0,16
        bne     $v0,$0,boucle2_inv8
        

        lw      $v0,40($fp)
        
        sra     $v0,$v0,8
        sw      $v0,8($fp)
        lw      $v0,40($fp)
        
        sll     $v0,$v0,8
        andi    $v0,$v0,0xffff
        sw      $v0,40($fp)
        lw      $v1,40($fp)
        lw      $v0,8($fp)
        
        addu    $v0,$v1,$v0
        sw      $v0,40($fp)
        lw      $v0,40($fp)
        b       fin_inv8
        

boucle2_inv8:
        lw      $v0,40($fp)
        
        sra     $v0,$v0,24
        bne     $v0,$0,boucle3_inv8
        

        lw      $v0,40($fp)
        
        sll     $v1,$v0,16
        li      $v0,16711680       # 0xff0000
        and     $v0,$v1,$v0
        sw      $v0,12($fp)
        lw      $v0,40($fp)
        
        sra     $v0,$v0,16
        sw      $v0,16($fp)
        lw      $v0,40($fp)
        
        andi    $v0,$v0,0xff00
        sw      $v0,40($fp)
        lw      $v1,40($fp)
        lw      $v0,12($fp)
        
        addu    $v1,$v1,$v0
        lw      $v0,16($fp)
        
        addu    $v0,$v1,$v0
        sw      $v0,40($fp)
        lw      $v0,40($fp)
        b       fin_inv8
        

boucle3_inv8:
        sw      $0,20($fp)
        lw      $v0,40($fp)
        
        andi    $v0,$v0,0xffff
        sw      $v0,24($fp)
        lw      $v0,24($fp)
        
        sra     $v0,$v0,8
        sw      $v0,20($fp)
        lw      $v0,24($fp)
        
        sll     $v0,$v0,8
        andi    $v0,$v0,0xffff
        sw      $v0,24($fp)
        lw      $v1,24($fp)
        lw      $v0,20($fp)
        
        addu    $v0,$v1,$v0
        sw      $v0,24($fp)
        lw      $v0,40($fp)
        
        srl     $v0,$v0,16
        sw      $v0,28($fp)
        lw      $v0,28($fp)
        
        sra     $v0,$v0,8
        sw      $v0,20($fp)
        lw      $v0,28($fp)
        
        sll     $v0,$v0,8
        andi    $v0,$v0,0xffff
        sw      $v0,28($fp)
        lw      $v1,28($fp)
        lw      $v0,20($fp)
        
        addu    $v0,$v1,$v0
        sw      $v0,28($fp)
        lw      $v0,24($fp)
        
        sll     $v1,$v0,16
        lw      $v0,28($fp)
        
        addu    $v0,$v1,$v0
        sw      $v0,40($fp)
        lw      $v0,40($fp)
fin_inv8:
        move    $sp,$fp
        lw      $fp,36($sp)
        addiu   $sp,$sp,40
        j       $ra
        

inverse16bits:
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        sw      $a0,24($fp)
        lw      $v1,24($fp)
        li      $v0,65536                    # 0x10000
        slt     $v0,$v1,$v0
        beq     $v0,$0,boucle1_inv16
        

        lw      $v0,24($fp)
        b       boucle2_inv16
        

boucle1_inv16:
        lw      $v0,24($fp)
        
        sra     $v0,$v0,16
        sw      $v0,8($fp)
        lw      $v0,24($fp)
        
        sll     $v0,$v0,16
        sw      $v0,24($fp)
        lw      $v1,24($fp)
        lw      $v0,8($fp)
        
        addu    $v0,$v1,$v0
        sw      $v0,24($fp)
        lw      $v0,24($fp)
boucle2_inv16:
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        j       $ra
        

rotationGauche:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $a0,8($fp)
        lw      $v0,8($fp)
        
        sll     $v0,$v0,1
        move    $v1,$v0
        lw      $v0,8($fp)
        
        srl     $v0,$v0,31
        or      $v0,$v1,$v0
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $ra
        

rotationDroite:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $a0,8($fp)
        lw      $v0,8($fp)
        
        srl     $v0,$v0,1
        lw      $v1,8($fp)
        
        sll     $v1,$v1,31
        or      $v0,$v0,$v1
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $ra
        

###### OPERATION #######
operation:
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        move    $v0,$a0 #$v0 : op_char
        sb      $v0,8($fp) # $fp + 8 : op_char
        lb      $v0,8($fp)
        
        # Si l'operation n'est pas valide, on retourne 0
        addiu   $v0,$v0,-37 # $v0 = $v0 -37 ( 37 = ASCII('%'))
        sltu    $v1,$v0,90 # $v1 = 1 si $v0 < 90 ; $v0 = 0 sinon ( 126 = ASCII(tilde))
        beq     $v1,$0,retourne_0 
        
	
	# branchement a l'adresse switch + $v0*4 (4 car diff???rence entre deux lignes d'instructions)
        sll     $v1,$v0,2
        lui     $v0,%hi(switch_debut)
        addiu   $v0,$v0,%lo(switch_debut)
        addu    $v0,$v1,$v0
        lw      $v0,0($v0)
        
        j       $v0 
        


retourne_1:
        li      $v0,1                        # 0x1
        b       fin_switch
        

retourne_2:
        li      $v0,2                        # 0x2
        b       fin_switch
        

retourne_3:
        li      $v0,3                        # 0x3
        b       fin_switch
        

retourne_4:
        li      $v0,4                        # 0x4
        b       fin_switch
        

retourne_5:
        li      $v0,5                        # 0x5
        b       fin_switch
        

retourne_6:
        li      $v0,6                        # 0x6
        b       fin_switch
        

retourne_7:
        li      $v0,7                        # 0x7
        b       fin_switch
        

retourne_8:
        li      $v0,8                        # 0x8
        b       fin_switch
        

retourne_9:
        li      $v0,9                        # 0x9
        b       fin_switch
        

retourne_10:
        li      $v0,10                 # 0xa
        b       fin_switch
        

retourne_11:
        li      $v0,11                 # 0xb
        b       fin_switch
        

retourne_12:
        li      $v0,12                 # 0xc
        b       fin_switch
        

retourne_13:
        li      $v0,13                 # 0xd
        b       fin_switch
        

retourne_14:
        li      $v0,14                 # 0xe
        b       fin_switch
        

retourne_15:
        li      $v0,15                 # 0xf
        b       fin_switch
        

retourne_16:
        li      $v0,16                 # 0x10
        b       fin_switch
        

retourne_17:
        li      $v0,17                 # 0x11
        b       fin_switch
        

retourne_18:
        li      $v0,18                 # 0x12
        b       fin_switch
        

retourne_19:
        li      $v0,19                 # 0x13
        b       fin_switch
        

retourne_20:
        li      $v0,20                 # 0x14
        b       fin_switch
        

retourne_21:
        li      $v0,21                 # 0x15
        b       fin_switch
        

retourne_0:
        move    $v0,$0
fin_switch:
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $ra
        

###### CALCUL #####
calcul:
        addiu   $sp,$sp,-32
        sw      $ra,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        sw      $a0,32($fp) # $fp + 32 : n1
        sw      $a1,36($fp) # $fp + 36 : n2
        sw      $a2,40($fp) # $fp + 40 ; resultat
        sw      $a3,44($fp) # $fp + 44 : operation
        lw      $v0,40($fp)
        
        # si l'adresse de resultat est valide (!=0) on va au debut du switch de calcul
        bne     $v0,$0,debut_switch_calcul
        
	# sinon on va a la fin du switch de calcul en retournant 1
        li      $v0,1                        # 0x1
        b       fin_calcul
        

debut_switch_calcul:
        lw      $v0,44($fp) # recup op
        
        # si op n'est pas inferieur a 21, on va au default du switch
        sltu    $v0,$v0,21
        beq     $v0,$0,default_switch_calcul
        
	
	
        lw      $v0,44($fp)# recup op
        
        sll     $v1,$v0,2 # $v1 = op * 4
        lui     $v0,%hi(switch_calcul)
        addiu   $v0,$v0,%lo(switch_calcul) #$v0 = adresse de switch calcul
        addu    $v0,$v1,$v0 # $v0 = $v0 + $v1
        lw      $v0,0($v0) #recup adresse du switch
        
        j       $v0 # branchement a switch calul
        


addition:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        addu    $v1,$v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

soustraction:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        subu    $v1,$v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

multiplication:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        mult    $v1,$v0
        lw      $v0,40($fp)
        mflo    $v1
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

division:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        bne     $v0,$0,cinq
        b default_switch_calcul
cinq:
        div     $v1,$v0
        mflo    $v1
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

modulo:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        bne     $v0,$0,six
        b default_switch_calcul
six:    
        div     $v1,$v0
        mfhi    $v0
        move    $v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

et:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        and     $v1,$v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

ou:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        or      $v1,$v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

ou_excusif:
        lw      $v1,32($fp)
        lw      $v0,36($fp)
        
        xor     $v1,$v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

non_ou:
        lw      $v0,32($fp)
        
        nor     $v1,$0,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

complement_2:
        lw      $v0,32($fp)
        
        subu    $v1,$0,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

decalage_gauche:
        lw      $v0,32($fp)
        
        sll     $v1,$v0,1
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

decalage_non_signe_droite:
        lw      $v0,32($fp)
        
        srl     $v0,$v0,1
        move    $v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

decalage_signe_droite:
        lw      $v0,32($fp)
        
        sra     $v1,$v0,1
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

inverser8bits:
        lw      $a0,32($fp)
        jal     inverse8bits
        

        move    $v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

inverser16bits:
        lw      $a0,32($fp)
        jal     inverse16bits
        

        move    $v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

switch_rotation_gauche:
        lw      $a0,32($fp)
        jal     rotationGauche
        

        move    $v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

switch_rotation_droite:
        lw      $a0,32($fp)
        jal     rotationDroite
        

        move    $v1,$v0
        lw      $v0,40($fp)
        
        sw      $v1,0($v0)
        b       retourne_0_switch_calcul
        

lire_n1:
        move    $v0,$0
        b       fin_calcul
        

lire_n2:
        move    $v0,$0
        b       fin_calcul
        

lire_base:
        move    $v0,$0
        b       fin_calcul
        

default_switch_calcul:
        li      $v0,1                        # 0x1
        b       fin_calcul
        

retourne_0_switch_calcul:
        move    $v0,$0
fin_calcul:
        move    $sp,$fp
        lw      $ra,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        j       $ra
        

##### CALCULATRICE #######
calculatrice:
        addiu   $sp,$sp,-88
        sw      $ra,84($sp) 
        sw      $fp,80($sp)
        move    $fp,$sp
        sw      $a0,88($fp) # $fp + 88 : n1
        sw      $a1,92($fp) # $fp + 92 : n2 
        sw      $a2,96($fp) # $fp + 96 : resultat
        sw      $a3,100($fp) # $fp + 100 : base
boucle_calc:
	# affichage du menu
        lui     $v0,%hi(menu) 
        addiu   $a0,$v0,%lo(menu)
        jal     printString
        

	# chargement de n1 dans $v0 et de la base dans $v1
        lw      $v0,88($fp)
        lw      $v1,100($fp)
        addiu   $a0,$fp,28
        move    $a2,$a0
        move    $a1,$v1
        move    $a0,$v0
        jal     toInt # transfo n1 int -> string
        
	
	#affichage de n1
        addiu   $v0,$fp,28
        move    $a0,$v0
        jal     printString
        
	
	#affichage barre droite
        lui     $v0,%hi(barre_droite)
        addiu   $a0,$v0,%lo(barre_droite)
        jal     printString
        
	
	# chargement de n2 dans $v0 et de la base dans $v1
        lw      $v0,92($fp)
        lw      $v1,100($fp)
        addiu   $a0,$fp,28
        move    $a2,$a0
        move    $a1,$v1
        move    $a0,$v0
        jal     toInt # transfo n2 int -> string
        

	#affichage de n2
        addiu   $v0,$fp,28
        move    $a0,$v0
        jal     printString
        
	
	#afichage barre droite
        lui     $v0,%hi(barre_droite)
        addiu   $a0,$v0,%lo(barre_droite)
        jal     printString
        

	# chargement de la base dans $v0
        lw      $v0,100($fp)
        addiu   $v1,$fp,28
        move    $a2,$v1
        li      $a1,10                 
        move    $a0,$v0
        jal     toInt # transfo base int -> string
        
	
	#affichage base
        addiu   $v0,$fp,28
        move    $a0,$v0
        jal     printString
        
	
	#affichage barre droite
        lui     $v0,%hi(barre_droite)
        addiu   $a0,$v0,%lo(barre_droite)
        jal     printString
        
	
	# chargement du resultat dans $v0 et de la base dans $v1
        lw      $v0,96($fp)
        lw      $v1,100($fp)
        addiu   $a0,$fp,28
        move    $a2,$a0
        move    $a1,$v1
        move    $a0,$v0
        jal     toInt # transfo resultat int -> char
        
	
	#affichage du resultat
        addiu   $v0,$fp,28
        move    $a0,$v0
        jal     printString
        
	
	# retour a la ligne
        lui     $v0,%hi(retour_chariot)
        addiu   $a0,$v0,%lo(retour_chariot)
        jal     printString
        
	
	# demander la saisie de l'op???ration
        lui     $v0,%hi(saisir_op)
        addiu   $a0,$v0,%lo(saisir_op)
        jal     printString
        

saisie_op:
	# saisie de l'op???ration
        getchar_console
        
	
	# appelle de la fonction op???ration
        sll     $v0,$v0,24
        sra     $v0,$v0,24
        move    $a0,$v0
        jal     operation
        

	# Si operation retourne 0, alors on retourne a la saise de l'operation
        sw      $v0,24($fp) # $fp + 24 : op
        lw      $v0,24($fp)
        
        beq     $v0,$0,saisie_op
        
	
	# si operation ne retourne pas 21 ('q'), alors on va au calcul
        lw      $v1,24($fp)
        li      $v0,21                 # 0x15
        bne     $v1,$v0,fonction_calcul
        
	
	# fin du programme
        lui     $v0,%hi(end)
        addiu   $a0,$v0,%lo(end)
        jal     printString
        

        b       sortie_calc
        

fonction_calcul:
	# retour a la ligne
        lui     $v0,%hi(retour_chariot)
        addiu   $a0,$v0,%lo(retour_chariot)
        jal     printString
        
	
	# appelle de la fonction calcul
        lw      $v0,88($fp) #n1
        lw      $v1,92($fp) #n2
        addiu   $a0,$fp,96 #resultat
        lw      $a3,24($fp) # op
        move    $a2,$a0
        move    $a1,$v1
        move    $a0,$v0
        jal     calcul
        
	
	# si calcul retourne 0, on va a la saisie de n1
        beq     $v0,$0,fonction_saisie_n1
        

        lui     $v0,%hi(erreur_calcul)
        addiu   $a0,$v0,%lo(erreur_calcul)
        jal     printString
        

fonction_saisie_n1:
	# si op != 18 alors on va a la saisie de n2
        lw      $v1,24($fp)
        li      $v0,18                 
        bne     $v1,$v0,fonction_saisie_n2
        
	
	# demander la saisie de n1
        lui     $v0,%hi(saisir_n1)
        addiu   $a0,$v0,%lo(saisir_n1)
        jal     printString
        

        sb      $0,40($fp) # $fp + 40 : tmp / tmp[0] = \0
boucle_saisie_n1:
	#saisie de n1
        addiu   $v0,$fp,40
        move    $a0,$v0
        jal     readString
        
	#si tmp[0] = \0, on retourne a la boucle n1
        lb      $v0,40($fp)
        
        beq     $v0,$0,boucle_saisie_n1
        
	
	# n1 prend la valeur de tmp
        lw      $v1,100($fp) # recup base
        addiu   $v0,$fp,40 # $v0 : tmp
        addiu   $a2,$fp,88 # $a2 : n1
        move    $a1,$v1
        move    $a0,$v0
        jal     parseInt
        
 	
 	# si $v0 = 0 on retourne a boucle_calc
        beq     $v0,$0,boucle_calc
        
	
	# sinon on affiche le message d'erreur 
	sw $0,88($fp)
        lui     $v0,%hi(erreur_n1)
        addiu   $a0,$v0,%lo(erreur_n1)
        jal     printString
        
	# on retourne a boucle_calc
        b       boucle_calc
        

fonction_saisie_n2:
	# si le resultat de l'operation n'est pas egal a 19 on va a la saisie de la base
        lw      $v1,24($fp)
        li      $v0,19                 # 0x13
        bne     $v1,$v0,fonction_saisie_base
        
	
	#demander la saisie de n2
        lui     $v0,%hi(saisir_n2)
        addiu   $a0,$v0,%lo(saisir_n2)
        jal     printString
        

        sb      $0,52($fp) # $fp + 52 : tmp
boucle_saisie_n2:
	# saisie de n2
        addiu   $v0,$fp,52
        move    $a0,$v0
        jal     readString
        
	
	#si tmp[0] = \0 on retourne a la saisie de n2
        lb      $v0,52($fp)
        
        beq     $v0,$0,boucle_saisie_n2
        
	
	# n1 prend la valeur de tmp
        lw      $v1,100($fp) #recup base
        addiu   $a0,$fp,92 # $a0 : n2
        addiu   $v0,$fp,52	#$v0 : tmp
        move    $a2,$a0
        move    $a1,$v1
        move    $a0,$v0
        jal     parseInt
        
	
	# si la saisie est correcte on retourne a boucle_calc
        beq     $v0,$0,boucle_calc
        
	
	# sinon o affiche message erreur n2
	sw $0,92($fp)
        lui     $v0,%hi(erreur_n2)
        addiu   $a0,$v0,%lo(erreur_n2)
        jal     printString
        
	
	#on retourne a boucle calc
        b       boucle_calc
        

fonction_saisie_base:
	# si le resultat de l'operation n'est pas 20, on retourne a boucle calc
        lw      $v1,24($fp) # recup op
        li      $v0,20                 
        bne     $v1,$v0,boucle_calc
        
	
	# demander la saisie de la base
        lui     $v0,%hi(saisir_base)
        addiu   $a0,$v0,%lo(saisir_base)
        jal     printString
        

        sb      $0,64($fp) # $fp + 64 : tmp
boucle_saisie_base:
	# saisie de la base
        addiu   $v0,$fp,64
        move    $a0,$v0
        jal     readString
        
	
	# si tmp[0] = \0 on retourne a la saisie de la base
        lb      $v0,64($fp)
        
        beq     $v0,$0,boucle_saisie_base
        
	
	# base prend la valeur de tmp
        addiu   $v1,$fp,100 #recup baqe
        addiu   $v0,$fp,64 # $v0 : tmp
        move    $a2,$v1 
        li      $a1,10      #argument base = 10          
        move    $a0,$v0
        jal     parseInt # transfo base string -> int
        
	
	# si la saisie est incorrecte, on va a la fonction erreur base
        lw      $v0,100($fp)
        
        slt     $v0,$v0,17
        beq     $v0,$0,fonction_erreur_base
        
	
	# sinon on retourne a boucle_calc
        lw      $v0,100($fp)
        
        slt     $v0,$v0,2
        beq     $v0,$0,boucle_calc
        

fonction_erreur_base:
	# affichage du message d'erreur
        lui     $v0,%hi(erreur_base)
        addiu   $a0,$v0,%lo(erreur_base)
        jal     printString
        
	
	# reinitialisation de la base a 10
        li      $v0,10                 # 0xa
        sw      $v0,100($fp)
        b       boucle_calc
        

sortie_calc:
	# restauration des registres sauvegard???s
        move    $sp,$fp
        lw      $ra,84($sp)
        lw      $fp,80($sp)
        addiu   $sp,$sp,88
        j       $ra
        

main:
        addiu   $sp,$sp,-32
        sw      $ra,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        li      $a3,10                 # $a3 : base
        move    $a2,$0		       # $a2 : resultat
        li      $a1,10                 # $a1 : n2
        li      $a0,5                  # $a0 : n1
        jal     calculatrice
        

        move    $v0,$0
        move    $sp,$fp
        lw      $ra,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        j       $ra
        
