%{
	#include "symbol_table.h"
	#define YYSTYPE Node*
	#include <bits/stdc++.h>
	
	using namespace std;
	
	SymbolTable s;
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
	bool operator<(mypair mp1,mypair mp2)
	{
	 	return mp1.s<mp2.s;
	}

	set<mypair> myarraylist;
	set<mypair>::iterator alist;
	
	FILE *fp;


	void yyerror(char *s)
	{
		fprintf(stdout,"At Line %d, ERROR-> %s\n",lineCount+1,s);
		return;
	}
%}

%token ID NUM COLON RELOP ADDOP MULOP ASSIGNOP BRACKET1 BRACKET2 PAREN1 PAREN2 DOTDOT COMMA SEMICOLON DOT PROGRAM THEN REAL ELSE IF BEGIN1 END PROCEDURE VAR WHILE OF ARRAY FUNCTION WRITE DO INTEGER NOT 

%left ADDOP

%left MULOP


%nonassoc IFX
%nonassoc ELSE


%%






program:    PROGRAM ID PAREN1 identifier_list PAREN2 SEMICOLON declarations subprogram_declarations compound_statement
            {
            	cout << "habijabi program\n";
            }
            ;
identifier_list:    ID
            {
            }
            |
            identifier_list COMMA ID
            {
            }
            ;
            /*declarations → declarations VAR identifier_list COLON type
SEMICOLON | ε
*/
declarations: 	       
            {
            }
            |
            declarations VAR identifier_list COLON type SEMICOLON
            {
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
            }
            |
            subprogram_declarations subprogram_declaration SEMICOLON
            {
            }
            ;
subprogram_declaration:	subprogram_head declarations compound_statement
            {
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
compound_statement:	BEGIN1 optional_statements END
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
            	
            }
            |
            procedure_statement
            {
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
