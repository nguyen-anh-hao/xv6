#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main() {
    int num_pages = 5;                              // Số lượng trang cần kiểm tra
    uint64 addr = (uint64)sbrk(num_pages * 4096);   // Cấp phát bộ nhớ cho 5 trang
    char *pages = (char *)addr;                     // Trỏ đến vùng nhớ vừa cấp phát

    // Truy cập tất cả các trang để đặt bit PTE_A
    for (int i = 0; i < num_pages; i++) {
        pages[i * 4096] = 'A' + i; // Ghi vào đầu mỗi trang
    }

    // Khởi tạo bitmask kết quả
    uint64 bitmask = 0;

    // Gọi system call pgaccess
    if (pgaccess(addr, num_pages, &bitmask) == -1) {
        printf("pgaccess failed\n");
        exit(1);
    }

    // In kết quả bitmask
    printf("Access bitmask: 0x%ld\n", bitmask); // Kỳ vọng: 0x1F (nhị phân: 11111)

    // Kết thúc chương trình
    exit(0);
}
