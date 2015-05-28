bison -d -y parse.y
g++ -w -c -o parse.o y.tab.c
flex lex.l
g++ -fpermissive -w -c -o test.o lex.yy.c
g++ -o demoCompiler test.o parse.o -lfl -ly
./demoCompiler f.txt
