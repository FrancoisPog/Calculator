
#include <stdio.h>

void printString(char *s){
    while(*s!=(char)0){
        putchar(*s);
        s++;
    }
    //putchar('\n');
}
void readString(char *res){
    char c;
    
    do{
        c=getchar();
        *res=c;
        res++;
    }while(c!='\n');
    *(res-1)=(char)0;
}

char forDigit(int nombre,int base){
    // vérif base valide
    if(nombre >= base || base < 2 || base > 16){
        return '\0';
    }
    char res;
    // entier -> char
    if(nombre > 9){
		res = nombre - 10 + 'A';
	}else{
		res = nombre + '0';
	}

    return res;
}
int digit(char caractere,int base){
    // vérif base valide
    if(base < 2 || base > 16){
        return -1;
    }
    int res = (int)caractere;

    // minuscule -> majuscule
    if(res >= 'a' && res <= 'z'){
		res = res - 32;
	}
    // verif caractere valide
    if((res > 'Z' || res < 'A') && (res < '0' || res > '9')){
        return -1;
    }
    
    // ascii to int
	if(res > '9'){
		res = res + 10 - 'A';
	}else{
		res = res - '0';
	}

    //verif nombre et base cohérent
    if(res >= base){
        return -1;
    }

    return res; 
}
int toInt(int nombre,int base,char *res){
    int nombre1;

    // Vérif base valide et pointeur non NULL
    if(base < 2 || base > 16 || res == NULL){
        return 1;
    }

    // Si pos alors on inverse
	if(nombre >> 31 == 0){
    	nombre = -nombre;
    }else{ // Si neg alors le premier caractere est '-'
    	*res = '-';
    	res++;
    }

    nombre1 = nombre;

    //On place res au niveau du dernier caractere
    do{
    	nombre1 = nombre1/base;
    	res++;

    }while (nombre1 != 0);

    *res=(char)0; // affectation du dernier caractere 

    

    do{ // transformation de chaque chiffre en caractere et affectation dans res
    	res--;
        if(forDigit(-(nombre%base),base) == -1){
            return 1;
        }
    	*res = forDigit(-(nombre%base),base);
    	nombre = nombre/base;
    	
    }while(nombre != 0);

    return 0;
}

int parseInt(char *ch,int base,int *resultat){
    // Verif pointeurs et base
    if(ch == NULL || resultat == NULL || base > 16 || base < 2){
        return 1;
    }

    *resultat = 0; 
    char *chdebut = ch; // On stock le premier caractere
    
    if(*chdebut == '-' || *chdebut == '+'){ // Si chdebut est un caractere de signe alors on décale le pointeur de 1
    	ch++;
    }
   

    while(*ch != (char)0){
        if(digit(*ch,base)==-1){ // verif digit valide
            return 1;
        }

        if((*resultat < base * *resultat - digit(*ch,base))){ // Si on dépasse la valeur minimale d'un entier
            return 1;
        }

    	*resultat = base * *resultat - digit(*ch,base);
        
    	ch++;

       if(*chdebut != '-' && *resultat  == -2147483648){ // Si chdebut est '+' et que resultat dépasse la valeur max d'un entier
           return 1;
       }
        
    }

    if((*chdebut != '-')){
    	*resultat = -*resultat;
    }
  
    
    return 0;
}
int inverse8bits(int nbr){
    if(nbr <= 0xFF){
        return nbr;
    }

    if(nbr >> 16 == 0){ 
        int tmp = nbr >> 8; 
        
        nbr = (nbr << 8)&0x0000FF00; 
        
        nbr = nbr + tmp; 
        
        return nbr;
    }

    if(nbr >> 24 == 0){
        int tmp1 = (nbr << 16)&0x00FF0000;
        
        int tmp2 = (nbr>>16);
       
        nbr = nbr&0x000FF00;
        
        nbr = nbr + tmp1 + tmp2;
        
        return nbr;
    }

    int tmp = 0;
    //Inversion des deux octets de droite
    int tmp1 = nbr&0x0000FFFF;
    tmp = tmp1 >> 8; 
    tmp1 = (tmp1 << 8)&0x0000FF00; 
    tmp1 = tmp1 + tmp;

    //Inversion des deux octets de droite
    int tmp2 = (nbr >> 16)&0x0000FFFF;
    tmp = tmp2 >> 8; 
    tmp2 = (tmp2 << 8)&0x0000FF00; 
    tmp2 = tmp2 + tmp;

    //Inversion des deux "doubles octets" déjà inversés
    nbr = tmp2 + (tmp1<<16);
    return nbr;
}
int inverse16bits(int nbr){
    if(nbr <= 0xFFFF){
        return nbr;
    }

    int gauche = nbr >> 16;
    nbr = nbr << 16;
    nbr = nbr + gauche;
 
    return nbr;
}
int rotationGauche(int nbr){
    return ((nbr<<1)| ((unsigned)nbr >> 31));
}
int rotationDroite(int nbr){
    return (((unsigned)nbr>>1)| (nbr << 31));
}
int operation(char op){
    switch(op){
        case '+' : return 1;
        case '-' : return 2;
        case '*' : return 3;
        case '/' : return 4;
        case '%' : return 5;
        case '&' : return 6;
        case '|' : return 7;
        case '^' : return 8;
        case '~' : return 9;
        case 'i' :
        case 'I' : return 10;
        case '<' : return 11;
        case '>' : return 12;
        case 'a' :
        case 'A' : return 13;
        case 'h' :
        case 'H' : return 14;
        case 's' :
        case 'S' : return 15;
        case 'l' : 
        case 'L' : return 16;
        case 'r' : 
        case 'R' : return 17;
        case '1' : return 18;
        case '2' : return 19;
        case 'b' :
        case 'B' : return 20;
        case 'q' : 
        case 'Q' : return 21;
    }
    return 0;
}

int calcul(int n1,int n2,int *resultat,int operation){
    if(resultat == NULL){
        return 1;
    }
    switch(operation){
        case 1 : *resultat = n1+n2;
        break;
        case 2 : *resultat = n1-n2;
        break;
        case 3 : *resultat = n1*n2;
        break;
        case 4 : *resultat = n1/n2;
        break;
        case 5 : *resultat = n1%n2;
        break;
        case 6 : *resultat = n1&n2;
        break;
        case 7 : *resultat = n1|n2;
        break;
        case 8 : *resultat = n1^n2;
        break;
        case 9 : *resultat = ~n1;
        break;
        case 10 : *resultat = ((n1 ^ -1)+1) ;
        break;
        case 11 : *resultat = n1<<1;
        break;
        case 12 : *resultat = (int)((unsigned)n1>>1);
        break;
        case 13 : *resultat = n1 >> 1 ;
        break;
        case 14 : *resultat = inverse8bits(n1);
        break;
        case 15 : *resultat = inverse16bits(n1);
        break;
        case 16 : *resultat = rotationGauche(n1);
        break;
        case 17 : *resultat = rotationDroite(n1);
        break;
        case 18 : {
            return 0;
        }break;
        case 19 : {
            return 0;
        }break;
        case 20 : {
            return 0;
        }break;
        default : return 1;

    }
    return 0;
}



void calculatrice(int n1,int n2,int resultat,int base){
    

    while(1){
        // Affichage du menu et des valeurs de n1, n2, base et resultat
        printString("\nn1 | n2 | base | resultat \n");
        char tmp_str[12];
        toInt(n1,base,tmp_str);
        printString(tmp_str);
        printString(" | ");

        toInt(n2,base,tmp_str);
        printString(tmp_str);
        printString(" | ");

        toInt(base,10,tmp_str);
        printString(tmp_str);
        printString(" | ");

        toInt(resultat,base,tmp_str);
        printString(tmp_str);
        printString("\n");
        
        printString("Saisir une operation : ");
        int op;

        // Saisie de l'opération (boucle car getchar peu fiable)
        do{
            op = operation(getchar());
        }while(op==0);
        
       

        // Sorti du programme si la saisie est 'q' ou 'Q'
        if(op == 21){
            printString("*Fin du programme*\n");
            return;
        }
        printString("\n");
        
        // Calcul du résultat
        if(calcul(n1,n2,&resultat,op)==1){
            printString("*Erreur de calcul, recommencez !*\n");
        };

        if(op == 18){ // Saisie de n1
            printString("Saisir n1 : ");
            char tmp[12];
            tmp[0] = (char)0;
            do{
                readString(tmp);
            }while(tmp[0]==(char)0);

            if(parseInt(tmp,base,&n1) == 1){
                printString("Erreur  : Le nombre saisi n'est pas valide dans la base donnee ! N1 est réinitialise à 0. \n");
                n1 = 0;
            }
            continue;
        }
        if(op == 19){ // Saisie de n2
            printString("Saisir n2 : ");
            char tmp[12];
            tmp[0] = (char)0;
            do{
                readString(tmp);
            }while(tmp[0]==(char)0);

            if(parseInt(tmp,base,&n2)){
                printString("*Erreur  : Le nombre saisi n'est pas valide dans la base donnee ! N2 est reinitialise à 0.* \n");
                n2 = 0;
            }
            continue;
        }
        if(op == 20){ // Saisie de la base
            printString("Saisir base : ");
            char tmp[12];
            tmp[0] = (char)0;
            do{
                readString(tmp);
            }while(tmp[0]==(char)0);
            parseInt(tmp,10,&base);

            if(base > 16 || base < 2){
                printString("*Erreur  : La base saisie n'est pas dans l'interval [2;16] ! La base est reinitialise à 10.* \n");
                base = 10;
            }
            continue;
        }
    }
}


int main (){

    calculatrice(5,10,0,10);
   
    return 0;
}