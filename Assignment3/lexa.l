%{
#include "SymbolTable.h"
#include "y.tab.h"

using namespace std;

void yyerror(char*);
extern YYSTYPE yylval;

int lineCount = 1;
extern SymbolTable st;

FILE *fin, *logp, *tokf;
%}

NEWLINE \r?\n
WS [ \t\v\f\r]+
PROGRAM "PROGRAM"
THEN "THEN"
REAL "REAL"
IF "IF"
DO "DO"
VAR "VAR"
NOT "NOT"
WHILE "WHILE"
OF "OF"
END "END"
FUNCTION "FUNCTION"
ARRAY "ARRAY"
BEGIN "BEGIN"
PROCEDURE "PROCEDURE"
WRITE "WRITE"
ELSE "ELSE"
INTEGER "INTEGER"
LETTER [a-zA-Z]
DIGIT [0-9]
UNDERSCORE _
NUM {DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT}+(\.{DIGIT}+)?)?

ILL_NUM1 (\.|\.{3,})({DIGIT}+)?(E[+-]?{DIGIT}+({DIGIT}+)?)?
ILL_NUM2 ({NUM})\.{NUM}(\.|{NUM})*
ILL_NUM {ILL_NUM1}|{ILL_NUM2}

ID ({LETTER}|{UNDERSCORE})+({LETTER}|{UNDERSCORE}|{DIGIT})*
ILL_ID {DIGIT}+{ID}

MSEND \\\\(\r)?{NEWLINE}
VALID_STRING \"([^"\n]|{MSEND}|"\\\"")*\"
ILL_STRING \"([^"]|"\\\"")*\"
INCOMPLETE_STRING \"([^"\n]|"\\\"")*\n

VALID_COMMENT \{([^{}]*)\}
ILL_COMMENT \{[^{}]*\{[^}]*\}
INCOMPLETE_COMMENT \{([^}\n]*)\n

RELOP ([<>]?=?)|<>
ADDOP \+|\-|or
MULOP \*|\/|div|mod|and
ASSIGNOP :=
BRACKET1 [\[]
BRACKET2 [\]]
PAREN1 [(]
PAREN2 [)]
DOTDOT \.\.
COMMA ,
SEMICOLON ;
COLON :
DOT \.
UNRECO [@~]+
%%


{WS}        {
                //Do Nothing
            }
{NEWLINE}   {
                lineCount += 1;
//                cout << "OLSDJFOLSJIDF\n";
//{KEYWORD}	{
//				fprintf ( logp, "Line %d: Keyword \"%s\" is found.\n", lineCount, yytext);
//				fprintf ( tokf, "< %s >", yytext);
//			}
            }
            
{PROGRAM}	{
			return PROGRAM;
		}

{THEN}	{
			return THEN;
		}

{REAL}	{
			return REAL;
		}

{IF}	{
			return IF;
		}

{DO}	{
			return DO;
		}

{VAR}	{
			return VAR;
		}

{NOT}	{
			return NOT;
		}

{WHILE}	{
			return WHILE;
		}

{OF}	{
			return OF;
		}

{END}	{
			return END;
		}

{FUNCTION}	{
			return FUNCTION;
		}

{ARRAY}	{
			return ARRAY;
		}

{BEGIN}	{
			return BEGIN;
		}

{PROCEDURE}	{
			return PROCEDURE;
		}

{WRITE}	{
			return WRITE;
		}

{ELSE}	{
			return ELSE;
		}

{INTEGER}	{
			return INTEGER;
		}

{LETTER}	{
			st.insert("LETTER",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return LETTER;
		}

{DIGIT}	{
			st.insert("DIGIT",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return DIGIT;
		}

{UNDERSCORE}	{
			st.insert("UNDERSCORE",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return UNDERSCORE;
		}

{NUM}	{
			st.insert("NUM",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return NUM;
		}

{RELOP}	{
			st.insert("RELOP",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return RELOP;
		}

{ADDOP}	{
			st.insert("ADDOP",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return ADDOP;
		}

{MULOP}	{
			st.insert("MULOP",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return MULOP;
		}

{ASSIGNOP}	{
			st.insert("ASSIGNOP",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return ASSIGNOP;
		}

{BRACKET1}	{
			st.insert("BRACKET1",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return BRACKET1;
		}

{BRACKET2}	{
			st.insert("BRACKET2",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return BRACKET2;
		}

{PAREN1}	{
			st.insert("PAREN1",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return PAREN1;
		}

{PAREN2}	{
			st.insert("PAREN2",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return PAREN2;
		}

{DOTDOT}	{
			st.insert("DOTDOT",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return DOTDOT;
		}

{COMMA}	{
			st.insert("COMMA",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return COMMA;
		}

{SEMICOLON}	{
			st.insert("SEMICOLON",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return SEMICOLON;
		}

{COLON}	{
			st.insert("COLON",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return COLON;
		}

{DOT}	{
			st.insert("DOT",yytext);
			yylval=(YYSTYPE)st.uplook(yytext);
			return DOT;
		}
{ID}        {
//                cout<<"IDENTIFIER"<<endl;
				st.insert("ID",yytext);
				yylval=(YYSTYPE)st.uplook(yytext);
				return ID;
//				fprintf(logp, "Line %d: \"%s\" is found.\n", lineCount, yytext);
//                bool flag = st.insert("ID", yytext);
//                if (!flag)	fprintf(logp, "\"%s\" already exists.\n", yytext);
//                fprintf (logp, "\nSymbol Table: \n-------------\n");
//                st.dump(logp);
//                fprintf(logp, "\n");
//                fprintf(tokf, "< ID, %s >", yytext);
            }
{VALID_STRING}	{
				int nl = 0, i = 0;
				char *str = new char [strlen(yytext)+1];
				yytext++;
				while(*yytext != '\0')	{
					if ( yytext[0] == '\\' )	{
						if ( yytext[1] == '\\' )	{
							yytext++;
							if(yytext[1] == '\r' && yytext[2] == '\n' )	{
								yytext+= 2;
								nl++;
							}
							else if (yytext[1] == '\n')	{
								yytext++;
								nl++;
							}
						}
						else if (yytext[1] == 'n')	{
							yytext++;
							*yytext = '\n';
						}
						else if (yytext[1] == 't')	{
							yytext++;
							*yytext = '\t';
						}
						else if (yytext[1] == 'v')	{
							yytext++;
							*yytext = '\v';
						}
						else if (yytext[1] == 'f')	{
							yytext++;
							*yytext = '\f';
						}
						else if (yytext[1] == 'r')	{
							yytext++;
							*yytext = '\r';
						}
						else if (yytext[1] == '\"')	{
							yytext++;
							*yytext = '\"';
						}
						else if (yytext[1] == '\'')	{
							yytext++;
							*yytext = '\'';
						}
					}
					str[i] = *yytext;
					yytext++;
					i++;
//					cout << "PPP: " << i << endl;
				}
				str[i-1] = '\0';	//hence last double quotation mark(") of yytext will be ignored
				fprintf ( logp, "Line %d: String \"%s\" is found.\n", lineCount, str);
				lineCount+= nl;
			}
{ILL_STRING}	{
				fprintf(logp, "Line %d: ERROR... Ill-formed string is found.\n", lineCount);
				while ( *yytext!='\0')	{
					if(yytext[0]=='\n')	lineCount++;
					yytext++;
				}
			}			
{INCOMPLETE_STRING}	{
				fprintf(logp, "Line %d: ERROR... Incomplete string is found.\n", lineCount);
				int l = strlen(yytext);
				if(yytext[l-1]=='\n')	lineCount++;
			}	
{VALID_COMMENT}	{
				fprintf ( logp, "Line %d: Comment %s is found.\n", lineCount, yytext);
				while(*yytext != '\0')	{
					if(*yytext == '\n')	lineCount++;
					yytext++;
				}
			}
{ILL_COMMENT}	{
				fprintf(logp, "Line %d: ERROR... Ill-formed comment is found.\n", lineCount);
				int l = strlen(yytext);while(*yytext != '\0')	{
					if(*yytext == '\n')	lineCount++;
					yytext++;
				}
			}
{INCOMPLETE_COMMENT}	{
				fprintf(logp, "Line %d: ERROR... Incomplete comment is found.\n", lineCount);
				int l = strlen(yytext);
				if(yytext[l-1]=='\n')	lineCount++;

			}
{ILL_ID}			{
				fprintf(logp, "Line %d: ERROR... Ill-formed identifier \"%s\" is found.\n", lineCount, yytext);
			}
{ILL_NUM}			{
				fprintf(logp, "Line %d: ERROR... Ill-formed number \"%s\" is found.\n", lineCount, yytext);
			}
{UNRECO}	{
				fprintf(logp, "Line %d: ERROR... Unrecognised charcters %s are found.\n", lineCount, yytext);
			}
[^ \t\v\f\r\n]	{
				fprintf(logp, "Line %d: ERROR... Unknown lexical error is found.\n", lineCount);
			}
%%

int main(int argc, char **argv)
{
	fin = fopen(argv[1], "r");
	tokf = fopen(argv[2], "w");
	logp = fopen(argv[3], "w");
	yyin = fin;
    yylex();
    fprintf(logp, "Total line: %d\n", --lineCount );
//    cout << lineCount<<endl;
    fclose(fin);
    fclose(tokf);
    fclose(logp);
    return 0;
}
