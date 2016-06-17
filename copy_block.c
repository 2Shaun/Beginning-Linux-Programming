#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

int main()
{
	// the buffer is much larger than 1 char (1B)
	// 1KB
	char block[1024];
	int in, out;
	int nread;

	in = open("file.in", O_RDONLY);
	out = open("file.out", O_WRONLY|O_CREAT, S_IRUSR|S_IWUSR);
	// now that we are reading/writing 1KB at time instead of 1B
	// there are only 2000 system calls
	while((nread = read(in,block,sizeof(block))) > 0)
		write(out,block,nread);

	exit(0);
}
