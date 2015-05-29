bison -d -y upstart.y
echo 1;
g++ -w -c -o upstart.o y.tab.c
echo 2;
flex startup.l
echo 3;
g++ -fpermissive -w -c -o startup.o lex.yy.c
echo 4;
g++ -o myCompiler startup.o upstart.o -lfl -ly
echo 5;
./myCompiler f.txt
