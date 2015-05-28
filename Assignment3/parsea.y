%{
#include "SymbolTable.h"
#define YYSTYPE SymbolInfo*
#include <bits/stdc++.h>

using namespace std;
	
SymbolTable st;
int yyparse(void);
int yylex(void);
extern FILE *yyin;
extern int lineCount;

set<string> datalist;
set<string>::iterator dlist;
class mypair{
public:
	string s;
	int v;
};

FILE *fp;

void yyerror(char *s)
{
	fprintf(stdout,"At Line %d, ERROR-> %s\n",lineCount+1,s);
	return;
}
%}

%token PROGRAM THEN REAL IF DO VAR NOT WHILE OF END FUNCTION ARRAY BEGINNING PROCEDURE WRITE ELSE INTEGER LETTER DIGIT UNDERSCORE NUM ILL_NUM ID ILL_ID VALID_STRING ILL_STRING INCOMPLETE_STRING VALID_COMMENT ILL_COMMENT INCOMPLETE_COMMENT RELOP ADDOP MULOP ASSIGNOP BRACKET1 BRACKET2 PAREN1 PAREN2 DOTDOT COMMA SEMICOLON COLON DOT UNRECO AND OR

%left ADDOP

%left MULOP


%nonassoc IFX
%nonassoc ELSE


%%


program:    PROGRAM ID PAREN1 identifier_list PAREN2 SEMICOLON declarations subprogram_declarations compound_statement
            {
            	
            	printf ( "qwepoiert");
            }
            |
            statement
            {
            	cout << "statement program\n";
            }
            ;
identifier_list:    ID
            {
            	printf ( "id list: \n");
            	cout << $1->symbol << "\n";
            }
            |
            identifier_list COMMA ID
            {
	            printf ( "id list, id:\n");
	            cout << $1->symbol << " " << $3->symbol << "\n";
            }
            ;
            /*declarations → declarations VAR identifier_list COLON type
SEMICOLON | ε
*/
declarations: 	       
            {
            	printf ( "declaration → ε\n");
            }
            |
            declarations VAR identifier_list COLON type SEMICOLON
            {
            	printf( "declarations...");
            	cout << $2->symbol << endl;
            }
            ;
type:       standard_type
            {
            }
            |
            ARRAY BRACKET1 NUM DOTDOT NUM BRACKET2 OF standard_type
            {
            }
            ;
standard_type:  INTEGER
            {
            }
            |
            REAL
            {
            }
            ;
subprogram_declarations:	           
            {
            	printf ("subprog dec→ ε");
            }
            |
            subprogram_declarations subprogram_declaration SEMICOLON
            {
            	printf ( "subprog_dec subprog_dec semic\n");
            }
            ;
subprogram_declaration:	subprogram_head declarations compound_statement
            {
            	printf ( "subprog_head dec comp_stmnt\n");
            }
            ;
subprogram_head:    FUNCTION ID arguments COLON standard_type SEMICOLON
            {
            }
            |
            PROCEDURE ID arguments SEMICOLON
            {
            }
            ;
arguments:	        
            {
            }
            |
            PAREN1 parameter_list PAREN2
            {
            }
            ;
parameter_list:	identifier_list COLON type
            {
            }
            |
            parameter_list SEMICOLON identifier_list COLON type
            {
            }
            ;
compound_statement:	BEGINNING optional_statements END
            {
            }
            ;
optional_statements:	      
            {
            }
            |
            statement_list
            {
            }
            ;
statement_list: statement
            {
            }
            |
            statement_list SEMICOLON statement
            {
            }
            ;
statement:  variable ASSIGNOP expression
            {
            	cout << "var assn expr"<<endl;
            }
            |
            procedure_statement
            {
            	cout << "proc stat"<<endl;
            }
            |
            compound_statement
            {
            }
            |
            IF expression THEN statement %prec IFX
            {
            }
            |
            IF expression THEN statement ELSE statement
            {
            }
            |
            WHILE expression DO statement
            {
            	
            }
            |
            WRITE PAREN1 ID PAREN2
            {
            }
            ;
variable:   ID
            {
            }
            |
            ID BRACKET1 expression BRACKET2
            {
            }
            ;
procedure_statement:    ID
            {
            }
            |
            ID PAREN1 expression_list PAREN2
            {
            }
            ;
expression_list:	expression
            {
            }
            |
            expression_list COMMA expression
            {
            }
            ;
expression: simple_expression
            {
            }
            |
            simple_expression RELOP simple_expression
            {
            }
            ;
simple_expression:  term
            {
            	cout << $1->symbol<<endl;
            	cout << "habijabi henten\n";
            }
            |
            ADDOP term
            {
            }
            |
            simple_expression ADDOP term
            {
            	
            }
            ;
term:       factor
            {
            }
            |
            term MULOP factor
            {}
            ;
factor:     ID
            {
            	
            }
            |
            ID PAREN1 expression_list PAREN2
            {
            }
            |
            NUM
            {
            	
            }
            |
            PAREN1 expression PAREN2
            {
            }
            |
            NOT factor
            {
            }
            ;

            
            
%%
int main(int argc,char *argv[])
{

	if(argc!=2)
	{
		printf("Usage: ./<programname> <input_file>\n");
		printf("Try Again\n");
		exit(1);
	}

	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}
	
	yyin=fp;
	yyparse();
	return 0;
}

