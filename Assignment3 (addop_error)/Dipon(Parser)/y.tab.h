/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    NUM = 259,
    COLON = 260,
    RELOP = 261,
    ADDOP = 262,
    MULOP = 263,
    ASSIGNOP = 264,
    BRACKET1 = 265,
    BRACKET2 = 266,
    PAREN1 = 267,
    PAREN2 = 268,
    DOTDOT = 269,
    COMMA = 270,
    SEMICOLON = 271,
    DOT = 272,
    PROGRAM = 273,
    THEN = 274,
    REAL = 275,
    ELSE = 276,
    IF = 277,
    BEGIN1 = 278,
    END = 279,
    PROCEDURE = 280,
    VAR = 281,
    WHILE = 282,
    OF = 283,
    ARRAY = 284,
    FUNCTION = 285,
    WRITE = 286,
    DO = 287,
    INTEGER = 288,
    NOT = 289,
    IFX = 290
  };
#endif
/* Tokens.  */
#define ID 258
#define NUM 259
#define COLON 260
#define RELOP 261
#define ADDOP 262
#define MULOP 263
#define ASSIGNOP 264
#define BRACKET1 265
#define BRACKET2 266
#define PAREN1 267
#define PAREN2 268
#define DOTDOT 269
#define COMMA 270
#define SEMICOLON 271
#define DOT 272
#define PROGRAM 273
#define THEN 274
#define REAL 275
#define ELSE 276
#define IF 277
#define BEGIN1 278
#define END 279
#define PROCEDURE 280
#define VAR 281
#define WHILE 282
#define OF 283
#define ARRAY 284
#define FUNCTION 285
#define WRITE 286
#define DO 287
#define INTEGER 288
#define NOT 289
#define IFX 290

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
