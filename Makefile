CC = gcc
CFLAGS = -Wno-implicit-function-declaration
DEBUG_CFLAGS = -Wno-implicit-function-declaration -DDEBUG

clac: calc.tab.c lex.yy.c
	$(CC) $(CFLAGS) -o calc calc.tab.c lex.yy.c -lfl -lm

debug: calc.tab.c lex.yy.c
	$(CC) $(DEBUG_CFLAGS) -o calc calc.tab.c lex.yy.c -lfl -lm

calc.tab.c: calc.y
	bison -d calc.y

lex.yy.c: calc.l
	flex calc.l 

clean:
	rm -f calc calc.tab.c calc.tab.h lex.yy.c

test:
	bash test.sh

.PHONY: clean test debug
