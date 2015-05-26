bison -d -y parsea.y
g++ -w -c -o parsea.o y.tab.c
flex lexa.l
g++ -fpermissive -w -c -o test.o lex.yy.c
#g++ -o demoCompiler test.o parse.o -lfl -ly
#./demoCompiler f.txt
