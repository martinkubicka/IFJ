CC=gcc
CFLAGS= -g -std=c11 -pedantic -Wall -Wextra

all: parser

run: parser
	./parser

memcheck: parser
	valgrind --leak-check=full -v --track-origins=yes ./parser < testFile.txt

parser: parser.o scanner.o bottomUp.o stack.o symtable.o frames.o
	$(CC) $(CFLAGS) parser.o scanner.o bottomUp.o stack.o symtable.o frames.o -o parser

parser.o: parser.c
	$(CC) $(CFLAGS) -c parser.c -o parser.o

bottomUp.o: bottomUp.c
	$(CC) $(CFLAGS) -c bottomUp.c -o bottomUp.o

stack.o: stack.c
	$(CC) $(CFLAGS) -c stack.c -o stack.o

scanner.o: scanner.c
	$(CC) $(CFLAGS) -c scanner.c -o scanner.o

symtable.o: symtable.c
	$(CC) $(CFLAGS) -c symtable.c -o symtable.o

frames.o: frames.c
	$(CC) $(CFLAGS) -c frames.c -o frames.o
clean:
	rm *.o parser