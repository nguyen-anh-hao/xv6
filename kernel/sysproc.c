#include "types.h"
#include "riscv.h"
#include "param.h"
#include "defs.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return wait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;


  argint(0, &n);
  if(n < 0)
    n = 0;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}


extern pte_t *walk(pagetable_t pagetable, uint64 va, int alloc);
#ifdef LAB_PGTBL
int sys_pgaccess(void) {
    uint64 start_va;          // Địa chỉ ảo bắt đầu
    int num_pages;            // Số lượng trang cần kiểm tra
    uint64 user_bitmask_addr; // Địa chỉ bộ đệm trong không gian người dùng
    uint64 curr_va;           // Địa chỉ ảo hiện tại trong vòng lặp
    uint64 bitmask = 0;       // Lưu kết quả bitmask
    uint64 bit_position = 1;  // Vị trí bit hiện tại (khởi đầu là bit thấp nhất)

    struct proc *curr_proc = myproc(); // Tiến trình hiện tại

    // Lấy tham số từ người dùng
    argaddr(0, &start_va);          // Lấy địa chỉ ảo bắt đầu
    argint(1, &num_pages);          // Lấy số lượng trang
    argaddr(2, &user_bitmask_addr); // Lấy địa chỉ bộ đệm
    

    // Kiểm tra giới hạn số trang (tối đa 64 trang để đảm bảo bitmask không vượt 64 bit)
    if (num_pages > 64) {
        return -1;
    }

    // Duyệt qua từng trang
    for (curr_va = start_va; curr_va < start_va + PGSIZE * num_pages; curr_va += PGSIZE) {
        // Tìm mục PTE (Page Table Entry) của địa chỉ hiện tại
        pte_t *pte = walk(curr_proc->pagetable, curr_va, 0);

        if (pte && (*pte & PTE_A)) { // Nếu bit PTE_A được bật (trang đã được truy cập)
            printf("Page 0x%ld: Accessed\n", curr_va);
            bitmask |= bit_position; // Đánh dấu trạng thái của trang trong bitmask
            *pte &= ~PTE_A;          // Xóa bit PTE_A để ghi nhận trạng thái mới
        } else {
            printf("Page 0x%ld: Not accessed\n", curr_va);
        }

        bit_position <<= 1; // Dịch vị trí bit sang trái cho trang tiếp theo
    }

    // Sao chép kết quả bitmask ra không gian người dùng
    if (copyout(curr_proc->pagetable, user_bitmask_addr, (char *)&bitmask, sizeof(bitmask)) < 0) {
        return -1; // Trả về lỗi nếu không sao chép được
    }

    return 0; // Thành công
}
#endif

// #ifdef LAB_PGTBL
int
sys_kpgtbl(void)
{
  struct proc *p;  

  p = myproc();
  vmprint(p->pagetable);
  return 0;
}
// #endif


uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64 sys_pgpte(void) {
    // Đây là phần xử lý logic cho system call
    // Thay đổi nội dung theo yêu cầu bài tập
    // printf("sys_pgpte called\n");
    return 0; // Trả về giá trị giả định
}
