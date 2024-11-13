build:
	as echo.s -o echo.o
	ld echo.o -o echo
	rm *.o
