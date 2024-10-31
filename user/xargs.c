#include "kernel/param.h"
#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    int index = 1;
    char *_argv[MAXARG];
    int _argc = 0;
    int n = 1;  // Số lượng tham số mỗi lần thực thi

    // Kiểm tra nếu có tham số "-n" và xác định số lượng đối số mỗi lần thực thi
    if (argc > 2 && strcmp(argv[1], "-n") == 0) {
        n = atoi(argv[2]);
        index = 3;
    }

    // Sao chép các tham số dòng lệnh ban đầu vào _argv
    for (int i = index; i < argc; i++) {
        _argv[_argc++] = argv[i];
    }

    // Đọc dữ liệu từ stdin và xử lý theo từng nhóm tham số
    char buffer[512];
    int buf_index = 0;
    int count = 0;
    char arg[128];  // Bộ đệm phụ để lưu từng đối số

    while (read(0, &buffer[buf_index], 1) == 1) {
        if (buffer[buf_index] == '\n') {
            buffer[buf_index] = 0;  // Kết thúc chuỗi

            // Sao chép dữ liệu từ buffer vào arg, rồi gán vào _argv
            strcpy(arg, buffer);
            _argv[_argc + count] = arg;
            count++;

            // Khi đã đủ n tham số, thực thi lệnh với các tham số này
            if (count == n) {
                _argv[_argc + count] = 0;  // Đảm bảo kết thúc danh sách bằng NULL

                if (fork() == 0) {          // Tạo tiến trình con
                    exec(_argv[0], _argv);  // Thực thi lệnh với đối số mới
                    fprintf(2, "exec failed\n");
                    exit(1);
                } else {
                    wait(0);  // Đợi tiến trình con hoàn tất
                }
                count = 0;  // Đặt lại số lượng tham số đã đọc
            }
            buf_index = 0;  // Reset lại chỉ số buffer
        } else {
            buf_index++;
        }
    }

    // Xử lý các tham số còn lại nếu không đủ n
    if (count > 0) {
        _argv[_argc + count] = 0;
        if (fork() == 0) {
            exec(_argv[0], _argv);
            fprintf(2, "exec failed\n");
            exit(1);
        } else {
            wait(0);
        }
    }

    exit(0);
}