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

FILE *fp, *parseLog;

void yyerror(char *s)
{
	fprintf(stderr,"At Line %d, ERROR-> %s\n",lineCount+1,s);
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
            	
            	fprintf ( parseLog, "program → PROGRAM ID '(' identifier_list ')' SEMICOLON declarations subprogram_declarations compound_statement\n");
            }
//            |
//            statement
//            {
//            	cout << "statement program\n";
//            }
            ;
identifier_list:    ID
            {
            	fprintf ( parseLog, "identifier_list → ID\n");
           		$$ = $1;
            }
            |
            identifier_list COMMA ID
            {
	            fprintf ( parseLog, "identifier_list → identifier_list COMMA ID\n");
//	            cout << $1->symbol << " " << $3->symbol << "\n";
            }
            ;
            /*declarations → declarations VAR identifier_list COLON type
SEMICOLON | ε
*/
declarations: 	       
            {
            	fprintf ( parseLog, "declaration → ε\n");
            }
            |
            declarations VAR identifier_list COLON type SEMICOLON
            {
            	fprintf ( parseLog, "declarations → declarations VAR identifier_list COLON type SEMICOLON\n");
//            	cout << $2->symbol << endl;
            }
            ;
type:       standard_type
            {
            	fprintf ( parseLog, "type → standard_type\n");
           		$$ = $1;
            }
            |
            ARRAY BRACKET1 NUM DOTDOT NUM BRACKET2 OF standard_type
            {
            	fprintf ( parseLog, "type → ARRAY '[' NUM DOTDOT NUM ']' OF standard_type\n");
            }
            ;
standard_type:  INTEGER
            {
            	fprintf ( parseLog, "standard_type → INTEGER\n");
           		$$ = $1;
            }
            |
            REAL
            {
            	fprintf ( parseLog, "standard_type → REAL\n");
           		$$ = $1;
            }
            ;
subprogram_declarations:	           
            {
            	printf ("subprogram_declarations → ε");
            }
            |
            subprogram_declarations subprogram_declaration SEMICOLON
            {
            	fprintf ( parseLog, "subprogram_declarations → subprogram_declarations subprogram_declaration SEMICOLON\n");
            }
            ;
subprogram_declaration:	subprogram_head declarations compound_statement
            {
            	fprintf ( parseLog, "subprogram_declaration → subprogram_head declarations compound_statement\n");
            }
            ;
subprogram_head:    FUNCTION ID arguments COLON standard_type SEMICOLON
            {
            	fprintf ( parseLog, "subprogram_head → FUNCTION ID arguments COLON standard_type SEMICOLON\n");
            }
            |
            PROCEDURE ID arguments SEMICOLON
            {
            	fprintf ( parseLog, "subprogram_head → PROCEDURE ID arguments SEMICOLON\n");
            }
            ;
arguments:	        
            {
            	printf ("arguments → ε\n");
            }
            |
            PAREN1 parameter_list PAREN2
            {
            	printf ("arguments → '(' parameter_list ')'\n");
            }
            ;
parameter_list:	identifier_list COLON type
            {
            	fprintf ( parseLog, "parameter_list → identifier_list COLON type\n");
            }
            |
            parameter_list SEMICOLON identifier_list COLON type
            {
            	fprintf ( parseLog, "parameter_list → parameter_list SEMICOLON identifier_list COLON type\n");
            }
            ;
compound_statement:	BEGINNING optional_statements END
            {
            	fprintf ( parseLog, "compound_statement → BEGIN optional_statements END\n");
            }
            ;
optional_statements:	      
            {
            	fprintf ( parseLog, "optional_statements → ε\n");
            }
            |
            statement_list
            {
            	fprintf ( parseLog, "optional_statements → statement_list\n" );
           		$$ = $1;
            }
            ;
statement_list: statement
            {
            	fprintf ( parseLog, "statement_list → statement\n");
           		$$ = $1;
            }
            |
            statement_list SEMICOLON statement
            {
            	fprintf ( parseLog, "statement_list → statement_list SEMICOLON statement\n");
            	$$->code = $1->code+";";
            	$$->code = $3->code;
            }
            ;
statement:  variable ASSIGNOP expression
            {
            	fprintf ( parseLog, "statement → variable ASSIGNOP expression\n");
            	
            }
            |
            procedure_statement
            {
            	fprintf ( parseLog, "statement → procedure_statement\n");
           		$$ = $1;
            }
            |
            compound_statement
            {
            	fprintf ( parseLog, "statement → compound_statement\n");
           		$$ = $1;
            }
            |
            IF expression THEN statement %prec IFX
            {
	            fprintf ( parseLog, "statement → IF expression THEN statement\n");
            }
            |
            IF expression THEN statement ELSE statement
            {
	            fprintf ( parseLog, "statement → IF expression THEN statement ELSE statement\n");
            }
            |
            WHILE expression DO statement
            {
            	fprintf ( parseLog, "statement → WHILE expression DO statement\n");
            }
            |
            WRITE PAREN1 ID PAREN2
            {
            	fprintf ( parseLog, "statement → write '(' ID ')'\n");
            }
            ;
variable:   ID
            {
	            fprintf ( parseLog, "variable → ID\n");
           		$$ = $1;
            }
            |
            ID BRACKET1 expression BRACKET2
            {
            	fprintf ( parseLog, "variable → ID '[' expression ']'\n");
            }
            ;
procedure_statement:    ID
            {
           		fprintf ( parseLog, "procedure_statement → ID\n" );
           		$$ = $1;
            }
            |
            ID PAREN1 expression_list PAREN2
            {
           		fprintf ( parseLog, "procedure_statement → ID '(' expression_list ')'\n" );            	
            }
            ;
expression_list:	expression
            {
            	fprintf ( parseLog, "expression_list → expression\n");
            	$$ = $1;
            }
            |
            expression_list COMMA expression
            {
            	fprintf ( parseLog, "expression_list → expression_list COMMA expression\n");
            }
            ;
expression: simple_expression
            {
            	fprintf ( parseLog, "expression → simple_expression\n");
            	$$ = $1;
            }
            |
            simple_expression RELOP simple_expression
            {
            	fprintf ( parseLog, "expression → simple_expression RELOP simple_expression\n");
            }
            ;
simple_expression:  term
            {
            	fprintf ( parseLog, "simple_expression → term\n");
            	$$ = $1;
            }
            |
            simple_expression ADDOP term
            {
            	fprintf ( parseLog, "simple_expression → simple_expression ADDOP term\n");
            }
            |
            ADDOP term
            {
            	if ( $1->symbol != "+" && $1->symbol != "-" )	yyerror(" only '+' or '-' sign can be used here.");
            	fprintf ( parseLog, "simple_expression → sign term\n");
            }
            ;
term:       factor
            {
            	fprintf ( parseLog, "term → factor\n");
            	$$ = $1;
            }
            |
            term MULOP factor
            {
            	fprintf ( parseLog, "term → term MULOP factor\n");
            }
            ;
factor:     ID
            {
            	fprintf ( parseLog, "factor → ID\n");
            	$$ = $1;
            }
            |
            ID PAREN1 expression_list PAREN2
            {
            	fprintf ( parseLog, "factor → ID '(' expression_list ')'\n");
            }
            |
            NUM
            {
            	fprintf ( parseLog, "factor → NUM\n");
            	$$ = $1;
            }
            |
            PAREN1 expression PAREN2
            {
            	fprintf ( parseLog, "factor → '(' expression ')'\n");
            }
            |
            NOT factor
            {
            	fprintf ( parseLog, "factor → NOT factor\n");
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
	parseLog = fopen("parseLog", "w");
	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}
	
	yyin=fp;
	yyparse();
	fclose(fp);
	fclose(parseLog);
	return 0;
}

