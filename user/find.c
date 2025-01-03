#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
	char *p;

	// Find first character after last slash.
	for(p=path+strlen(path); p >= path && *p != '/'; p--)
		;
	p++;

	return p;
}

void
find(char *path, char *targetname) 
{
	char buf[512], *p;
	int fd;
	struct dirent de;
	struct stat st;

	if (!strcmp(fmtname(path), targetname)) {
		printf("%s\n", path);
	}

	// Mở thư mục
	if ((fd = open(path, O_RDONLY)) < 0) {
		fprintf(2, "find: cannot open [%s], fd=%d\n", path, fd);
		return;
	}

	// Lấy thông tin về thư mục
	if (fstat(fd, &st) < 0) {
		fprintf(2, "find: cannot stat %s\n", path);
		close(fd);
		return;
	}

	// Nếu không phải là thư mục, dừng lại
	if (st.type != T_DIR) {
		close(fd);
		return;
	}

	// st.type == T_DIR
	
	if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
		printf("find: path too long\n");
		close(fd);
		return;
	}

	// Đọc từng entry trong thư mục
	strcpy(buf, path);
	p = buf+strlen(buf);
	*p++ = '/';
	while (read(fd, &de, sizeof(de)) == sizeof(de)) {
		// Entry khong hop le thi bo qua
		if (de.inum == 0)
			continue;

		// Xây dựng đường dẫn đầy đủ
		memmove(p, de.name, DIRSIZ);
		p[DIRSIZ] = 0;
		
		if (!strcmp(de.name, ".") || !strcmp(de.name, "..")) // Bỏ qua "." và ".."
			continue;

		find(buf, targetname);
	}
	close(fd);
}

int
main(int argc, char *argv[])
{
	if(argc < 3){
		fprintf(2, "usage: find path filename\n");
		exit(1);
	}

	find(argv[1], argv[2]);

	exit(0);
}