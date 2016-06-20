#include <stdio.h>
#include <stdlib.h>

int main()
{
	int c;
	// the FILE structure maintains its own buffer
	// therefore this program is much faster than the purely
	// system level program
	// only when its internal buffer is full
	// does it go to the kernel
	FILE *in, *out;

	in = fopen("file.in", "r");
	out = fopen("file.out", "w");

	while((c = fgetc(in)) != EOF)
		fputc(c,out);

	exit(0);
}
