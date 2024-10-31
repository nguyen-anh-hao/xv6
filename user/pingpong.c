#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

int main() {
    int pipe1[2];    // Pipe để gửi từ cha sang con
    int pipe2[2];    // Pipe để gửi từ con về cha
    char buffer[1];  // Bộ đệm chứa byte ping/pong
    int pid;

    // Tạo hai pipe
    if (pipe(pipe1) < 0 || pipe(pipe2) < 0) {
        fprintf(2, "Error: Unable to create pipes\n");
        exit(1);
    }

    // Fork tiến trình
    pid = fork();

    if (pid < 0) {
        // Nếu fork thất bại
        fprintf(2, "Error: Forking failed\n");
        exit(1);
    } else if (pid == 0) {
        // Tiến trình con
        // Đóng đầu ghi của pipe gửi từ cha
        close(pipe1[1]);
        // Đóng đầu đọc của pipe gửi về cha
        close(pipe2[0]);

        // Đọc thông điệp từ cha qua pipe1
        if (read(pipe1[0], buffer, 1) != 1) {
            fprintf(2, "Error: Child failed to read message from parent\n");
            exit(1);
        }

        // In ra thông điệp "Ping nhận được" cùng với PID của con
        printf("%d: received ping\n", getpid());

        // Chuyển byte khác (ví dụ: 'B') cho cha qua pipe2
        buffer[0] = 'B';
        write(pipe2[1], buffer, 1);

        // Đóng đầu ghi của pipe sau khi sử dụng
        close(pipe2[1]);
        exit(0);
    } else {
        // Tiến trình cha
        // Đóng đầu đọc của pipe gửi từ con
        close(pipe2[1]);
        // Đóng đầu đọc của pipe gửi từ cha
        close(pipe1[0]);

        // Gửi thông điệp đầu tiên (ví dụ: 'A') sang tiến trình con qua pipe1
        buffer[0] = 'A';
        write(pipe1[1], buffer, 1);

        // Đóng đầu ghi của pipe sau khi gửi tin nhắn
        close(pipe1[1]);

        // Đợi tiến trình con gửi lại thông điệp qua pipe2
        if (read(pipe2[0], buffer, 1) != 1) {
            fprintf(2, "Error: Parent failed to receive message from child\n");
            exit(1);
        }

        // In ra thông điệp "Pong nhận được" cùng với PID của cha
        printf("%d: received pong\n", getpid());

        // Đợi tiến trình con hoàn thành
        wait(0);

        // Đóng đầu đọc của pipe sau khi đã sử dụng
        close(pipe2[0]);
        exit(0);
    }
}