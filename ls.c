#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

char buf[512];
struct stat st;
struct dirent dirent;

int
main(int argc, char *argv[])
{
  int fd;
  uint off;
  uint sz;

  if(argc > 1){
    puts("Usage: ls\n");
    exit();
  }

  fd = open(".", 0);
  if(fd < 0){
    printf(2, "ls: cannot open .\n");
    exit();
  }
  if (fstat(fd, &st) < 0) {
    printf(2, "ls: cannot open .\n");
    exit();
  }
  if (st.st_type != T_DIR) {
    printf(2, "ls: . is not a dir\n");
  }
  sz = st.st_size;
  for(off = 0; off < sz; off += sizeof(struct dirent)) {
    if (read(fd, &dirent, sizeof(struct dirent)) != sizeof(struct dirent)) {
      printf(1, "ls: read error\n");
      break;
    }
    if (dirent.inum != 0) {
      if (stat (dirent.name, &st) < 0)  {
	printf(1, "stat: failed\n");
	break;
      }
      printf(1, "%s t %d ino %d sz %d\n", dirent.name, st.st_type, 
	     dirent.inum, st.st_size);
    }
  }
  close(fd);

  exit();
}