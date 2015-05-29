%{
#include <iostream>
#include <cstdio>
#include <cstring>

#include "symbol_table.h"
#include "y.tab.h"
extern YYSTYPE yylval;

using namespace std;

extern SymbolTable s;


int lineCount = 0;
FILE *token;
FILE *log;



%}

WS [ \t\v\f]+

PROGRAM "program"
THEN "then"
REAL "real"
ELSE "else"
IF "if"
BEGIN1 "begin"
END "end"
PROCEDURE "procedure"
VAR "var"
WHILE "while"
OF "of"
ARRAY "array"
FUNCTION "function"
WRITE "write"
DO "do"
INTEGER "integer"
NOT "not"

NEWLINE (\r\n)|(\n)


RELOP "<"|"<="|">"|">="|"="|"<>"
ADDOP "+"|"-"|"or"
MULOP "*"|"/"|"div"|"mod"|"and"
ASSIGNOP ":="
BRACKET1 "["
BRACKET2 "]"
PAREN1 "("
PAREN2 ")"
DOTDOT ".."
COMMA ","
SEMICOLON ";"
DOT "."



MULTI_STRING  \"([^\n\"]|\\\\{NEWLINE})*\"
ILL_STRING \"([^\"\\]|{NEWLINE})*\"
UNFINISHED_STRING \"([^\"])*


COMMENT \{[^\{\}]*\}
ILL_COMMENT \{([^\{]*(\{)+[.]*)\}
UNFINISHED_COMMENT \{[^}]*


COLON ":"
LETTER [a-zA-Z]
DIGIT [0-9]
UNDERSCORE [_]

ID ({LETTER}|{UNDERSCORE})+({LETTER}|{UNDERSCORE}|{DIGIT})*
ILLFORMED_ID ({NUM}+{ID}+)

NUM {DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT}+(\.{DIGIT}+)?)?
ILLFORMED_NUM ((\.{DIGIT}+)(E[+-]?{DIGIT}+(\.{DIGIT}+)?)?)|({NUM}\.{DIGIT}*)|({DIGIT}+(\.{DIGIT}+)?(E[+-]?)?)


DOT_ [^\.]

%%
{WS}        {
                //Do Nothing
            }
{NEWLINE}   {
                lineCount += 1;
            }

{COMMENT}		{
					int i=0;
					while(yytext[i]!='\0')
					{
						if(yytext[i]=='\n')lineCount++;
						i++;
					}
				}







{MULTI_STRING} {
					//fprintf(log,"\n\nLine %d : String <%s> is found.\n",lineCount+1, yytext);
					int i=0;
					while(yytext[i]!='\0')
					{
						if(yytext[i]=='\n')lineCount++;
						i++;
					}					
					
				}

				
{PROGRAM} 	{
				return PROGRAM;	
			}
{THEN}		{
				return THEN;
			}

{REAL}		{
				return REAL;
			}

{IF}		{
				return IF;
			}

{ELSE}		{
				return ELSE;
			}

{BEGIN1}	{
				return BEGIN1;
			}			

{END}		{
				return END;
			}

{PROCEDURE}	{
				return PROCEDURE;
			}
			
{VAR}		{
				return VAR;
			}

{WHILE}		{
				return WHILE;
			}

{OF}		{
				return OF;
			}


{ARRAY}		{
				return ARRAY;
			}
			
{FUNCTION}	{
				return FUNCTION;
			}

{WRITE}		{
				return WRITE;
			}

{DO}		{
				return DO;
			}

{INTEGER}	{
				return INTEGER;
			}

{NOT}     	{
				return NOT;
			}


            

 
{RELOP}     {
				
				bool a=s.lookup(yytext);
                if(!a)
                {
                		
					Symbol_Info str;
					str.key=yytext;
					str.type="RELOP";
                	s.insert(str);
                }
               yylval=(YYSTYPE)s.uplook(yytext);
				return RELOP;
			}



{ADDOP}		{
				
				bool a=s.lookup(yytext);
                if(!a)
                {
                		
					Symbol_Info str;
					str.key=yytext;
					str.type="ADDOP";
                	s.insert(str);
                }
                yylval=(YYSTYPE)s.uplook(yytext);
				return ADDOP;
			}

{MULOP}		{
				
			
				bool a=s.lookup(yytext);
                if(!a)
                {
                	
					Symbol_Info str;
					str.key=yytext;
					str.type="MULOP";
                	s.insert(str);
                }
               yylval=(YYSTYPE)s.uplook(yytext);
				return MULOP;
			}



{ASSIGNOP}	{
				return ASSIGNOP;
			}	

{BRACKET1}	{
				
				return BRACKET1;
			}
{BRACKET2}	{
				
				return BRACKET2;
			}

{PAREN1}     {
				return PAREN1;
			}

{PAREN2}     {
				return PAREN2;
			}
				
{DOTDOT}    {
				return DOTDOT;
			}

{COMMA}		{
				return COMMA;
			}

{SEMICOLON}	{
				return SEMICOLON;
			}

{COLON}     {
				return COLON;
			}

{DOT} 		 {
				return DOT;
			}
            
{ID}        {
				
             
                bool a=s.lookup(yytext);
                if(!a)
                {
					Symbol_Info str;
					str.key=yytext;
					str.type="IDENTIFIER";
                	s.insert(str);
                }
                 yylval=(YYSTYPE)s.uplook(yytext);
				return ID;
            }
            


{NUM}       {
               
            
                bool a=s.lookup(yytext);
                if(!a)
                {
                		
					Symbol_Info str;
					str.key=yytext;
					str.type="NUMBER";
                	s.insert(str);
                }
                 yylval=(YYSTYPE)s.uplook(yytext);
				return NUM;
            }


%%

/*int main(int argc, char **argv)
{
	FILE *infp = fopen(argv[1], "r");
	token= fopen(argv[2],"w");
	log= fopen(argv[3],"w");
    yyin = infp;
    yylex();
    fclose (infp);
    fclose (token);
    fprintf(log,"\n\nTotal Line = %d \n",lineCount);
     fclose (log);
    return 0;
}*/
