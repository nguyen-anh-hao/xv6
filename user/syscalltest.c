#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define N 100000

void test_syscall_speed() {
    int start_time, end_time;
    int i;

    // Đo thời gian cho N lần gọi system call trước khi tối ưu
    start_time = uptime();
    for (i = 0; i < N; i++) {
        getpid();  // Gọi một system call đơn giản
    }
    end_time = uptime();
    printf("Time for %d system calls: %d ticks\n", N, end_time - start_time);
}

int main() {
    test_syscall_speed();
    exit(0);
}
