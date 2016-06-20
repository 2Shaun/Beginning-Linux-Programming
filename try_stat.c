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
	if(!S_ISDIR(modes) && (modes & S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH) == 
			S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH)
		printf("This file is not a directory. The user has read and write permissions. The group has read and write permissions. Others have read permissions.\n");
	else
		printf("Well I guess not then.\n");

	return 0;
}
