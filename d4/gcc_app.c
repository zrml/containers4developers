#include <stdio.h>

void main()
{
	printf("|--------------------------------------|\n");
	printf(" The app displays the compiler version\n");
	printf("|--------------------------------------|\n\n");
	printf("This app was compiled by gcc compiler version %s\n", __VERSION__);
}
