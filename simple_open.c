#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

/*
establishes an access path to the file
the file descriptor always chooses the lowest non-negative integer availible
making it predictable
the file descriptor that it returns can be used for other system calls
		     file,     actions to be taken on opening the file
examples of oflags:
O_RDONLY
O_WRONLY
O_RDWR
O_APPEND	place written data at end of file
O_TRUNC		set length of file to zero
O_CREAT		creates file with permissions given in mode
O_EXCL		+ O_CREAT if file already exists, open fails
int open(const char *path, int oflags); 
int open(const char *path, int oflags, mode_t mode);

permissions are set by using the bitwise OR operator with different parameters
open (“myfile”, O_CREAT, S_IRUSR|S_IXOTH);
creates a file called myfile with read permissions for the owner and execute
permissions for others
-r--------
---------x
-r-------x
*/


