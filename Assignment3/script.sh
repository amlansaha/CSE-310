#! /usr/bin/env sh
flex lexa.l
g++ lex.yy.c -lfl
./a.out in1.txt token.txt log_file.txt
