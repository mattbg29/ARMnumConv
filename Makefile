All: multTwo fibNumber
LIB=libConversions.o
CC=gcc

multTwo: multTwo.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

fibNumber: fibNumber.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
