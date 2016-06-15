#include <unistd.h>
#include <stdlib.h>

int main()
{
	// size_t is unsigned (error return)
	// size_t read(int fildes, void *buf, size_t nbytes);
	char buffer[128];
	// nread will have the number of bytes that read actually read
	// if there was an error, then nread will contain -1
	// if nothing was read, this will contain 0
	int nread;

	// reads up to 128 bytes of input from standard input 
	// (allowing you to pipe to it)
	// stores it in buffer character array of 128 bytes
	nread = read(0, buffer, 128);
	if (nread == -1)
		write(2, "A read error has occurred\n",26);

	if ((write(1,buffer,nread)) != nread)
		write(2, "A write error has occurred\n",27);

	exit (0);
}
