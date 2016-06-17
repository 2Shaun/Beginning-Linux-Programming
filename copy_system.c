#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
// including unistd must be the first line because it defines POSIX flags
// that affect the other include files

int main()
{
	char c; 
	int in, out;

	// int open(const char *pathname, int flags, mode_t mode);
	// flags or oflags specify what to do with the file
	// opens file.in for read only
	in = open("file.in", O_RDONLY); 
	// creates & opens file.out for write only with -rw------- permissions
	// keep in mind that all modes will be affected by umask
	out = open("file.out", O_WRONLY|O_CREAT, S_IRUSR|S_IWUSR);
	
	// the amount of sys calls in this while loop is very costly
	// with a larger buffer than one byte, the calls to the kernel
	// would be minimized 
	while(read(in,&c,1) == 1)
		// flushes the buffer
		write(out,&c,1);
	// for a file of 1MB or 1000000 bytes, since each character is
	// 1 byte, that's over 2000000 system calls (1m reads and 1m writes)

	exit(0);
}
