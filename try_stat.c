#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>

int main()
{
// used to store data from stat
struct stat statbuf;
mode_t modes;

stat("/home/tommy/Beginning-Linux-Programming/tracks.cdb",&statbuf);
// st_mode contains the file permissions and file-type information
modes = statbuf.st_mode;
//node = statbuf.st_ino;

//  test for dir macro 	     bitwise & with -rwx------
if(!S_ISDIR(modes) && (modes & S_IRWXU) == S_IRWXU)
	printf("This file is not a dir and only the User can read, write, and execute.");

return 0;
}
