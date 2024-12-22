
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	28e000ef          	jal	296 <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
    sleep(5);  // Let child exit before parent.
  exit(0);
  10:	4501                	li	a0,0
  12:	28c000ef          	jal	29e <exit>
    sleep(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	316000ef          	jal	32e <sleep>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  1e:	1141                	addi	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	addi	s0,sp,16
  extern int main();
  main();
  26:	fdbff0ef          	jal	0 <main>
  exit(0);
  2a:	4501                	li	a0,0
  2c:	272000ef          	jal	29e <exit>

0000000000000030 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  30:	1141                	addi	sp,sp,-16
  32:	e422                	sd	s0,8(sp)
  34:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  36:	87aa                	mv	a5,a0
  38:	0585                	addi	a1,a1,1
  3a:	0785                	addi	a5,a5,1
  3c:	fff5c703          	lbu	a4,-1(a1)
  40:	fee78fa3          	sb	a4,-1(a5)
  44:	fb75                	bnez	a4,38 <strcpy+0x8>
    ;
  return os;
}
  46:	6422                	ld	s0,8(sp)
  48:	0141                	addi	sp,sp,16
  4a:	8082                	ret

000000000000004c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4c:	1141                	addi	sp,sp,-16
  4e:	e422                	sd	s0,8(sp)
  50:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  52:	00054783          	lbu	a5,0(a0)
  56:	cb91                	beqz	a5,6a <strcmp+0x1e>
  58:	0005c703          	lbu	a4,0(a1)
  5c:	00f71763          	bne	a4,a5,6a <strcmp+0x1e>
    p++, q++;
  60:	0505                	addi	a0,a0,1
  62:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	fbe5                	bnez	a5,58 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  6a:	0005c503          	lbu	a0,0(a1)
}
  6e:	40a7853b          	subw	a0,a5,a0
  72:	6422                	ld	s0,8(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <strlen>:

uint
strlen(const char *s)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  7e:	00054783          	lbu	a5,0(a0)
  82:	cf91                	beqz	a5,9e <strlen+0x26>
  84:	0505                	addi	a0,a0,1
  86:	87aa                	mv	a5,a0
  88:	86be                	mv	a3,a5
  8a:	0785                	addi	a5,a5,1
  8c:	fff7c703          	lbu	a4,-1(a5)
  90:	ff65                	bnez	a4,88 <strlen+0x10>
  92:	40a6853b          	subw	a0,a3,a0
  96:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  98:	6422                	ld	s0,8(sp)
  9a:	0141                	addi	sp,sp,16
  9c:	8082                	ret
  for(n = 0; s[n]; n++)
  9e:	4501                	li	a0,0
  a0:	bfe5                	j	98 <strlen+0x20>

00000000000000a2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a2:	1141                	addi	sp,sp,-16
  a4:	e422                	sd	s0,8(sp)
  a6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  a8:	ca19                	beqz	a2,be <memset+0x1c>
  aa:	87aa                	mv	a5,a0
  ac:	1602                	slli	a2,a2,0x20
  ae:	9201                	srli	a2,a2,0x20
  b0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  b4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  b8:	0785                	addi	a5,a5,1
  ba:	fee79de3          	bne	a5,a4,b4 <memset+0x12>
  }
  return dst;
}
  be:	6422                	ld	s0,8(sp)
  c0:	0141                	addi	sp,sp,16
  c2:	8082                	ret

00000000000000c4 <strchr>:

char*
strchr(const char *s, char c)
{
  c4:	1141                	addi	sp,sp,-16
  c6:	e422                	sd	s0,8(sp)
  c8:	0800                	addi	s0,sp,16
  for(; *s; s++)
  ca:	00054783          	lbu	a5,0(a0)
  ce:	cb99                	beqz	a5,e4 <strchr+0x20>
    if(*s == c)
  d0:	00f58763          	beq	a1,a5,de <strchr+0x1a>
  for(; *s; s++)
  d4:	0505                	addi	a0,a0,1
  d6:	00054783          	lbu	a5,0(a0)
  da:	fbfd                	bnez	a5,d0 <strchr+0xc>
      return (char*)s;
  return 0;
  dc:	4501                	li	a0,0
}
  de:	6422                	ld	s0,8(sp)
  e0:	0141                	addi	sp,sp,16
  e2:	8082                	ret
  return 0;
  e4:	4501                	li	a0,0
  e6:	bfe5                	j	de <strchr+0x1a>

00000000000000e8 <gets>:

char*
gets(char *buf, int max)
{
  e8:	711d                	addi	sp,sp,-96
  ea:	ec86                	sd	ra,88(sp)
  ec:	e8a2                	sd	s0,80(sp)
  ee:	e4a6                	sd	s1,72(sp)
  f0:	e0ca                	sd	s2,64(sp)
  f2:	fc4e                	sd	s3,56(sp)
  f4:	f852                	sd	s4,48(sp)
  f6:	f456                	sd	s5,40(sp)
  f8:	f05a                	sd	s6,32(sp)
  fa:	ec5e                	sd	s7,24(sp)
  fc:	1080                	addi	s0,sp,96
  fe:	8baa                	mv	s7,a0
 100:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 102:	892a                	mv	s2,a0
 104:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 106:	4aa9                	li	s5,10
 108:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 10a:	89a6                	mv	s3,s1
 10c:	2485                	addiw	s1,s1,1
 10e:	0344d663          	bge	s1,s4,13a <gets+0x52>
    cc = read(0, &c, 1);
 112:	4605                	li	a2,1
 114:	faf40593          	addi	a1,s0,-81
 118:	4501                	li	a0,0
 11a:	19c000ef          	jal	2b6 <read>
    if(cc < 1)
 11e:	00a05e63          	blez	a0,13a <gets+0x52>
    buf[i++] = c;
 122:	faf44783          	lbu	a5,-81(s0)
 126:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 12a:	01578763          	beq	a5,s5,138 <gets+0x50>
 12e:	0905                	addi	s2,s2,1
 130:	fd679de3          	bne	a5,s6,10a <gets+0x22>
    buf[i++] = c;
 134:	89a6                	mv	s3,s1
 136:	a011                	j	13a <gets+0x52>
 138:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 13a:	99de                	add	s3,s3,s7
 13c:	00098023          	sb	zero,0(s3)
  return buf;
}
 140:	855e                	mv	a0,s7
 142:	60e6                	ld	ra,88(sp)
 144:	6446                	ld	s0,80(sp)
 146:	64a6                	ld	s1,72(sp)
 148:	6906                	ld	s2,64(sp)
 14a:	79e2                	ld	s3,56(sp)
 14c:	7a42                	ld	s4,48(sp)
 14e:	7aa2                	ld	s5,40(sp)
 150:	7b02                	ld	s6,32(sp)
 152:	6be2                	ld	s7,24(sp)
 154:	6125                	addi	sp,sp,96
 156:	8082                	ret

0000000000000158 <stat>:

int
stat(const char *n, struct stat *st)
{
 158:	1101                	addi	sp,sp,-32
 15a:	ec06                	sd	ra,24(sp)
 15c:	e822                	sd	s0,16(sp)
 15e:	e04a                	sd	s2,0(sp)
 160:	1000                	addi	s0,sp,32
 162:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 164:	4581                	li	a1,0
 166:	178000ef          	jal	2de <open>
  if(fd < 0)
 16a:	02054263          	bltz	a0,18e <stat+0x36>
 16e:	e426                	sd	s1,8(sp)
 170:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 172:	85ca                	mv	a1,s2
 174:	182000ef          	jal	2f6 <fstat>
 178:	892a                	mv	s2,a0
  close(fd);
 17a:	8526                	mv	a0,s1
 17c:	14a000ef          	jal	2c6 <close>
  return r;
 180:	64a2                	ld	s1,8(sp)
}
 182:	854a                	mv	a0,s2
 184:	60e2                	ld	ra,24(sp)
 186:	6442                	ld	s0,16(sp)
 188:	6902                	ld	s2,0(sp)
 18a:	6105                	addi	sp,sp,32
 18c:	8082                	ret
    return -1;
 18e:	597d                	li	s2,-1
 190:	bfcd                	j	182 <stat+0x2a>

0000000000000192 <atoi>:

int
atoi(const char *s)
{
 192:	1141                	addi	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 198:	00054683          	lbu	a3,0(a0)
 19c:	fd06879b          	addiw	a5,a3,-48
 1a0:	0ff7f793          	zext.b	a5,a5
 1a4:	4625                	li	a2,9
 1a6:	02f66863          	bltu	a2,a5,1d6 <atoi+0x44>
 1aa:	872a                	mv	a4,a0
  n = 0;
 1ac:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ae:	0705                	addi	a4,a4,1
 1b0:	0025179b          	slliw	a5,a0,0x2
 1b4:	9fa9                	addw	a5,a5,a0
 1b6:	0017979b          	slliw	a5,a5,0x1
 1ba:	9fb5                	addw	a5,a5,a3
 1bc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1c0:	00074683          	lbu	a3,0(a4)
 1c4:	fd06879b          	addiw	a5,a3,-48
 1c8:	0ff7f793          	zext.b	a5,a5
 1cc:	fef671e3          	bgeu	a2,a5,1ae <atoi+0x1c>
  return n;
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret
  n = 0;
 1d6:	4501                	li	a0,0
 1d8:	bfe5                	j	1d0 <atoi+0x3e>

00000000000001da <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1da:	1141                	addi	sp,sp,-16
 1dc:	e422                	sd	s0,8(sp)
 1de:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1e0:	02b57463          	bgeu	a0,a1,208 <memmove+0x2e>
    while(n-- > 0)
 1e4:	00c05f63          	blez	a2,202 <memmove+0x28>
 1e8:	1602                	slli	a2,a2,0x20
 1ea:	9201                	srli	a2,a2,0x20
 1ec:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1f0:	872a                	mv	a4,a0
      *dst++ = *src++;
 1f2:	0585                	addi	a1,a1,1
 1f4:	0705                	addi	a4,a4,1
 1f6:	fff5c683          	lbu	a3,-1(a1)
 1fa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1fe:	fef71ae3          	bne	a4,a5,1f2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 202:	6422                	ld	s0,8(sp)
 204:	0141                	addi	sp,sp,16
 206:	8082                	ret
    dst += n;
 208:	00c50733          	add	a4,a0,a2
    src += n;
 20c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 20e:	fec05ae3          	blez	a2,202 <memmove+0x28>
 212:	fff6079b          	addiw	a5,a2,-1
 216:	1782                	slli	a5,a5,0x20
 218:	9381                	srli	a5,a5,0x20
 21a:	fff7c793          	not	a5,a5
 21e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 220:	15fd                	addi	a1,a1,-1
 222:	177d                	addi	a4,a4,-1
 224:	0005c683          	lbu	a3,0(a1)
 228:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 22c:	fee79ae3          	bne	a5,a4,220 <memmove+0x46>
 230:	bfc9                	j	202 <memmove+0x28>

0000000000000232 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 232:	1141                	addi	sp,sp,-16
 234:	e422                	sd	s0,8(sp)
 236:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 238:	ca05                	beqz	a2,268 <memcmp+0x36>
 23a:	fff6069b          	addiw	a3,a2,-1
 23e:	1682                	slli	a3,a3,0x20
 240:	9281                	srli	a3,a3,0x20
 242:	0685                	addi	a3,a3,1
 244:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 246:	00054783          	lbu	a5,0(a0)
 24a:	0005c703          	lbu	a4,0(a1)
 24e:	00e79863          	bne	a5,a4,25e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 252:	0505                	addi	a0,a0,1
    p2++;
 254:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 256:	fed518e3          	bne	a0,a3,246 <memcmp+0x14>
  }
  return 0;
 25a:	4501                	li	a0,0
 25c:	a019                	j	262 <memcmp+0x30>
      return *p1 - *p2;
 25e:	40e7853b          	subw	a0,a5,a4
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret
  return 0;
 268:	4501                	li	a0,0
 26a:	bfe5                	j	262 <memcmp+0x30>

000000000000026c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 274:	f67ff0ef          	jal	1da <memmove>
}
 278:	60a2                	ld	ra,8(sp)
 27a:	6402                	ld	s0,0(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret

0000000000000280 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 280:	1141                	addi	sp,sp,-16
 282:	e422                	sd	s0,8(sp)
 284:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 286:	040007b7          	lui	a5,0x4000
 28a:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 28c:	07b2                	slli	a5,a5,0xc
}
 28e:	4388                	lw	a0,0(a5)
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret

0000000000000296 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 296:	4885                	li	a7,1
 ecall
 298:	00000073          	ecall
 ret
 29c:	8082                	ret

000000000000029e <exit>:
.global exit
exit:
 li a7, SYS_exit
 29e:	4889                	li	a7,2
 ecall
 2a0:	00000073          	ecall
 ret
 2a4:	8082                	ret

00000000000002a6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2a6:	488d                	li	a7,3
 ecall
 2a8:	00000073          	ecall
 ret
 2ac:	8082                	ret

00000000000002ae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2ae:	4891                	li	a7,4
 ecall
 2b0:	00000073          	ecall
 ret
 2b4:	8082                	ret

00000000000002b6 <read>:
.global read
read:
 li a7, SYS_read
 2b6:	4895                	li	a7,5
 ecall
 2b8:	00000073          	ecall
 ret
 2bc:	8082                	ret

00000000000002be <write>:
.global write
write:
 li a7, SYS_write
 2be:	48c1                	li	a7,16
 ecall
 2c0:	00000073          	ecall
 ret
 2c4:	8082                	ret

00000000000002c6 <close>:
.global close
close:
 li a7, SYS_close
 2c6:	48d5                	li	a7,21
 ecall
 2c8:	00000073          	ecall
 ret
 2cc:	8082                	ret

00000000000002ce <kill>:
.global kill
kill:
 li a7, SYS_kill
 2ce:	4899                	li	a7,6
 ecall
 2d0:	00000073          	ecall
 ret
 2d4:	8082                	ret

00000000000002d6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2d6:	489d                	li	a7,7
 ecall
 2d8:	00000073          	ecall
 ret
 2dc:	8082                	ret

00000000000002de <open>:
.global open
open:
 li a7, SYS_open
 2de:	48bd                	li	a7,15
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2e6:	48c5                	li	a7,17
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2ee:	48c9                	li	a7,18
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2f6:	48a1                	li	a7,8
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <link>:
.global link
link:
 li a7, SYS_link
 2fe:	48cd                	li	a7,19
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 306:	48d1                	li	a7,20
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 30e:	48a5                	li	a7,9
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <dup>:
.global dup
dup:
 li a7, SYS_dup
 316:	48a9                	li	a7,10
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 31e:	48ad                	li	a7,11
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 326:	48b1                	li	a7,12
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 32e:	48b5                	li	a7,13
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 336:	48b9                	li	a7,14
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <bind>:
.global bind
bind:
 li a7, SYS_bind
 33e:	48f5                	li	a7,29
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 346:	48f9                	li	a7,30
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <send>:
.global send
send:
 li a7, SYS_send
 34e:	48fd                	li	a7,31
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <recv>:
.global recv
recv:
 li a7, SYS_recv
 356:	02000893          	li	a7,32
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 360:	02100893          	li	a7,33
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 36a:	02200893          	li	a7,34
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 374:	1101                	addi	sp,sp,-32
 376:	ec06                	sd	ra,24(sp)
 378:	e822                	sd	s0,16(sp)
 37a:	1000                	addi	s0,sp,32
 37c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 380:	4605                	li	a2,1
 382:	fef40593          	addi	a1,s0,-17
 386:	f39ff0ef          	jal	2be <write>
}
 38a:	60e2                	ld	ra,24(sp)
 38c:	6442                	ld	s0,16(sp)
 38e:	6105                	addi	sp,sp,32
 390:	8082                	ret

0000000000000392 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 392:	7139                	addi	sp,sp,-64
 394:	fc06                	sd	ra,56(sp)
 396:	f822                	sd	s0,48(sp)
 398:	f426                	sd	s1,40(sp)
 39a:	0080                	addi	s0,sp,64
 39c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 39e:	c299                	beqz	a3,3a4 <printint+0x12>
 3a0:	0805c963          	bltz	a1,432 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3a4:	2581                	sext.w	a1,a1
  neg = 0;
 3a6:	4881                	li	a7,0
 3a8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3ac:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3ae:	2601                	sext.w	a2,a2
 3b0:	00000517          	auipc	a0,0x0
 3b4:	4f850513          	addi	a0,a0,1272 # 8a8 <digits>
 3b8:	883a                	mv	a6,a4
 3ba:	2705                	addiw	a4,a4,1
 3bc:	02c5f7bb          	remuw	a5,a1,a2
 3c0:	1782                	slli	a5,a5,0x20
 3c2:	9381                	srli	a5,a5,0x20
 3c4:	97aa                	add	a5,a5,a0
 3c6:	0007c783          	lbu	a5,0(a5)
 3ca:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3ce:	0005879b          	sext.w	a5,a1
 3d2:	02c5d5bb          	divuw	a1,a1,a2
 3d6:	0685                	addi	a3,a3,1
 3d8:	fec7f0e3          	bgeu	a5,a2,3b8 <printint+0x26>
  if(neg)
 3dc:	00088c63          	beqz	a7,3f4 <printint+0x62>
    buf[i++] = '-';
 3e0:	fd070793          	addi	a5,a4,-48
 3e4:	00878733          	add	a4,a5,s0
 3e8:	02d00793          	li	a5,45
 3ec:	fef70823          	sb	a5,-16(a4)
 3f0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3f4:	02e05a63          	blez	a4,428 <printint+0x96>
 3f8:	f04a                	sd	s2,32(sp)
 3fa:	ec4e                	sd	s3,24(sp)
 3fc:	fc040793          	addi	a5,s0,-64
 400:	00e78933          	add	s2,a5,a4
 404:	fff78993          	addi	s3,a5,-1
 408:	99ba                	add	s3,s3,a4
 40a:	377d                	addiw	a4,a4,-1
 40c:	1702                	slli	a4,a4,0x20
 40e:	9301                	srli	a4,a4,0x20
 410:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 414:	fff94583          	lbu	a1,-1(s2)
 418:	8526                	mv	a0,s1
 41a:	f5bff0ef          	jal	374 <putc>
  while(--i >= 0)
 41e:	197d                	addi	s2,s2,-1
 420:	ff391ae3          	bne	s2,s3,414 <printint+0x82>
 424:	7902                	ld	s2,32(sp)
 426:	69e2                	ld	s3,24(sp)
}
 428:	70e2                	ld	ra,56(sp)
 42a:	7442                	ld	s0,48(sp)
 42c:	74a2                	ld	s1,40(sp)
 42e:	6121                	addi	sp,sp,64
 430:	8082                	ret
    x = -xx;
 432:	40b005bb          	negw	a1,a1
    neg = 1;
 436:	4885                	li	a7,1
    x = -xx;
 438:	bf85                	j	3a8 <printint+0x16>

000000000000043a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 43a:	711d                	addi	sp,sp,-96
 43c:	ec86                	sd	ra,88(sp)
 43e:	e8a2                	sd	s0,80(sp)
 440:	e0ca                	sd	s2,64(sp)
 442:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 444:	0005c903          	lbu	s2,0(a1)
 448:	26090863          	beqz	s2,6b8 <vprintf+0x27e>
 44c:	e4a6                	sd	s1,72(sp)
 44e:	fc4e                	sd	s3,56(sp)
 450:	f852                	sd	s4,48(sp)
 452:	f456                	sd	s5,40(sp)
 454:	f05a                	sd	s6,32(sp)
 456:	ec5e                	sd	s7,24(sp)
 458:	e862                	sd	s8,16(sp)
 45a:	e466                	sd	s9,8(sp)
 45c:	8b2a                	mv	s6,a0
 45e:	8a2e                	mv	s4,a1
 460:	8bb2                	mv	s7,a2
  state = 0;
 462:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 464:	4481                	li	s1,0
 466:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 468:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 46c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 470:	06c00c93          	li	s9,108
 474:	a005                	j	494 <vprintf+0x5a>
        putc(fd, c0);
 476:	85ca                	mv	a1,s2
 478:	855a                	mv	a0,s6
 47a:	efbff0ef          	jal	374 <putc>
 47e:	a019                	j	484 <vprintf+0x4a>
    } else if(state == '%'){
 480:	03598263          	beq	s3,s5,4a4 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 484:	2485                	addiw	s1,s1,1
 486:	8726                	mv	a4,s1
 488:	009a07b3          	add	a5,s4,s1
 48c:	0007c903          	lbu	s2,0(a5)
 490:	20090c63          	beqz	s2,6a8 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 494:	0009079b          	sext.w	a5,s2
    if(state == 0){
 498:	fe0994e3          	bnez	s3,480 <vprintf+0x46>
      if(c0 == '%'){
 49c:	fd579de3          	bne	a5,s5,476 <vprintf+0x3c>
        state = '%';
 4a0:	89be                	mv	s3,a5
 4a2:	b7cd                	j	484 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4a4:	00ea06b3          	add	a3,s4,a4
 4a8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4ac:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4ae:	c681                	beqz	a3,4b6 <vprintf+0x7c>
 4b0:	9752                	add	a4,a4,s4
 4b2:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4b6:	03878f63          	beq	a5,s8,4f4 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 4ba:	05978963          	beq	a5,s9,50c <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4be:	07500713          	li	a4,117
 4c2:	0ee78363          	beq	a5,a4,5a8 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4c6:	07800713          	li	a4,120
 4ca:	12e78563          	beq	a5,a4,5f4 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4ce:	07000713          	li	a4,112
 4d2:	14e78a63          	beq	a5,a4,626 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 4d6:	07300713          	li	a4,115
 4da:	18e78a63          	beq	a5,a4,66e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 4de:	02500713          	li	a4,37
 4e2:	04e79563          	bne	a5,a4,52c <vprintf+0xf2>
        putc(fd, '%');
 4e6:	02500593          	li	a1,37
 4ea:	855a                	mv	a0,s6
 4ec:	e89ff0ef          	jal	374 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4f0:	4981                	li	s3,0
 4f2:	bf49                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 4f4:	008b8913          	addi	s2,s7,8
 4f8:	4685                	li	a3,1
 4fa:	4629                	li	a2,10
 4fc:	000ba583          	lw	a1,0(s7)
 500:	855a                	mv	a0,s6
 502:	e91ff0ef          	jal	392 <printint>
 506:	8bca                	mv	s7,s2
      state = 0;
 508:	4981                	li	s3,0
 50a:	bfad                	j	484 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 50c:	06400793          	li	a5,100
 510:	02f68963          	beq	a3,a5,542 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 514:	06c00793          	li	a5,108
 518:	04f68263          	beq	a3,a5,55c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 51c:	07500793          	li	a5,117
 520:	0af68063          	beq	a3,a5,5c0 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 524:	07800793          	li	a5,120
 528:	0ef68263          	beq	a3,a5,60c <vprintf+0x1d2>
        putc(fd, '%');
 52c:	02500593          	li	a1,37
 530:	855a                	mv	a0,s6
 532:	e43ff0ef          	jal	374 <putc>
        putc(fd, c0);
 536:	85ca                	mv	a1,s2
 538:	855a                	mv	a0,s6
 53a:	e3bff0ef          	jal	374 <putc>
      state = 0;
 53e:	4981                	li	s3,0
 540:	b791                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 542:	008b8913          	addi	s2,s7,8
 546:	4685                	li	a3,1
 548:	4629                	li	a2,10
 54a:	000ba583          	lw	a1,0(s7)
 54e:	855a                	mv	a0,s6
 550:	e43ff0ef          	jal	392 <printint>
        i += 1;
 554:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 556:	8bca                	mv	s7,s2
      state = 0;
 558:	4981                	li	s3,0
        i += 1;
 55a:	b72d                	j	484 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 55c:	06400793          	li	a5,100
 560:	02f60763          	beq	a2,a5,58e <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 564:	07500793          	li	a5,117
 568:	06f60963          	beq	a2,a5,5da <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 56c:	07800793          	li	a5,120
 570:	faf61ee3          	bne	a2,a5,52c <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 574:	008b8913          	addi	s2,s7,8
 578:	4681                	li	a3,0
 57a:	4641                	li	a2,16
 57c:	000ba583          	lw	a1,0(s7)
 580:	855a                	mv	a0,s6
 582:	e11ff0ef          	jal	392 <printint>
        i += 2;
 586:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 588:	8bca                	mv	s7,s2
      state = 0;
 58a:	4981                	li	s3,0
        i += 2;
 58c:	bde5                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 58e:	008b8913          	addi	s2,s7,8
 592:	4685                	li	a3,1
 594:	4629                	li	a2,10
 596:	000ba583          	lw	a1,0(s7)
 59a:	855a                	mv	a0,s6
 59c:	df7ff0ef          	jal	392 <printint>
        i += 2;
 5a0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a2:	8bca                	mv	s7,s2
      state = 0;
 5a4:	4981                	li	s3,0
        i += 2;
 5a6:	bdf9                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 5a8:	008b8913          	addi	s2,s7,8
 5ac:	4681                	li	a3,0
 5ae:	4629                	li	a2,10
 5b0:	000ba583          	lw	a1,0(s7)
 5b4:	855a                	mv	a0,s6
 5b6:	dddff0ef          	jal	392 <printint>
 5ba:	8bca                	mv	s7,s2
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	b5d9                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5c0:	008b8913          	addi	s2,s7,8
 5c4:	4681                	li	a3,0
 5c6:	4629                	li	a2,10
 5c8:	000ba583          	lw	a1,0(s7)
 5cc:	855a                	mv	a0,s6
 5ce:	dc5ff0ef          	jal	392 <printint>
        i += 1;
 5d2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d4:	8bca                	mv	s7,s2
      state = 0;
 5d6:	4981                	li	s3,0
        i += 1;
 5d8:	b575                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5da:	008b8913          	addi	s2,s7,8
 5de:	4681                	li	a3,0
 5e0:	4629                	li	a2,10
 5e2:	000ba583          	lw	a1,0(s7)
 5e6:	855a                	mv	a0,s6
 5e8:	dabff0ef          	jal	392 <printint>
        i += 2;
 5ec:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ee:	8bca                	mv	s7,s2
      state = 0;
 5f0:	4981                	li	s3,0
        i += 2;
 5f2:	bd49                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 5f4:	008b8913          	addi	s2,s7,8
 5f8:	4681                	li	a3,0
 5fa:	4641                	li	a2,16
 5fc:	000ba583          	lw	a1,0(s7)
 600:	855a                	mv	a0,s6
 602:	d91ff0ef          	jal	392 <printint>
 606:	8bca                	mv	s7,s2
      state = 0;
 608:	4981                	li	s3,0
 60a:	bdad                	j	484 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 60c:	008b8913          	addi	s2,s7,8
 610:	4681                	li	a3,0
 612:	4641                	li	a2,16
 614:	000ba583          	lw	a1,0(s7)
 618:	855a                	mv	a0,s6
 61a:	d79ff0ef          	jal	392 <printint>
        i += 1;
 61e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 620:	8bca                	mv	s7,s2
      state = 0;
 622:	4981                	li	s3,0
        i += 1;
 624:	b585                	j	484 <vprintf+0x4a>
 626:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 628:	008b8d13          	addi	s10,s7,8
 62c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 630:	03000593          	li	a1,48
 634:	855a                	mv	a0,s6
 636:	d3fff0ef          	jal	374 <putc>
  putc(fd, 'x');
 63a:	07800593          	li	a1,120
 63e:	855a                	mv	a0,s6
 640:	d35ff0ef          	jal	374 <putc>
 644:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 646:	00000b97          	auipc	s7,0x0
 64a:	262b8b93          	addi	s7,s7,610 # 8a8 <digits>
 64e:	03c9d793          	srli	a5,s3,0x3c
 652:	97de                	add	a5,a5,s7
 654:	0007c583          	lbu	a1,0(a5)
 658:	855a                	mv	a0,s6
 65a:	d1bff0ef          	jal	374 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 65e:	0992                	slli	s3,s3,0x4
 660:	397d                	addiw	s2,s2,-1
 662:	fe0916e3          	bnez	s2,64e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 666:	8bea                	mv	s7,s10
      state = 0;
 668:	4981                	li	s3,0
 66a:	6d02                	ld	s10,0(sp)
 66c:	bd21                	j	484 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 66e:	008b8993          	addi	s3,s7,8
 672:	000bb903          	ld	s2,0(s7)
 676:	00090f63          	beqz	s2,694 <vprintf+0x25a>
        for(; *s; s++)
 67a:	00094583          	lbu	a1,0(s2)
 67e:	c195                	beqz	a1,6a2 <vprintf+0x268>
          putc(fd, *s);
 680:	855a                	mv	a0,s6
 682:	cf3ff0ef          	jal	374 <putc>
        for(; *s; s++)
 686:	0905                	addi	s2,s2,1
 688:	00094583          	lbu	a1,0(s2)
 68c:	f9f5                	bnez	a1,680 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 68e:	8bce                	mv	s7,s3
      state = 0;
 690:	4981                	li	s3,0
 692:	bbcd                	j	484 <vprintf+0x4a>
          s = "(null)";
 694:	00000917          	auipc	s2,0x0
 698:	20c90913          	addi	s2,s2,524 # 8a0 <malloc+0x100>
        for(; *s; s++)
 69c:	02800593          	li	a1,40
 6a0:	b7c5                	j	680 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 6a2:	8bce                	mv	s7,s3
      state = 0;
 6a4:	4981                	li	s3,0
 6a6:	bbf9                	j	484 <vprintf+0x4a>
 6a8:	64a6                	ld	s1,72(sp)
 6aa:	79e2                	ld	s3,56(sp)
 6ac:	7a42                	ld	s4,48(sp)
 6ae:	7aa2                	ld	s5,40(sp)
 6b0:	7b02                	ld	s6,32(sp)
 6b2:	6be2                	ld	s7,24(sp)
 6b4:	6c42                	ld	s8,16(sp)
 6b6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6b8:	60e6                	ld	ra,88(sp)
 6ba:	6446                	ld	s0,80(sp)
 6bc:	6906                	ld	s2,64(sp)
 6be:	6125                	addi	sp,sp,96
 6c0:	8082                	ret

00000000000006c2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6c2:	715d                	addi	sp,sp,-80
 6c4:	ec06                	sd	ra,24(sp)
 6c6:	e822                	sd	s0,16(sp)
 6c8:	1000                	addi	s0,sp,32
 6ca:	e010                	sd	a2,0(s0)
 6cc:	e414                	sd	a3,8(s0)
 6ce:	e818                	sd	a4,16(s0)
 6d0:	ec1c                	sd	a5,24(s0)
 6d2:	03043023          	sd	a6,32(s0)
 6d6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6da:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6de:	8622                	mv	a2,s0
 6e0:	d5bff0ef          	jal	43a <vprintf>
}
 6e4:	60e2                	ld	ra,24(sp)
 6e6:	6442                	ld	s0,16(sp)
 6e8:	6161                	addi	sp,sp,80
 6ea:	8082                	ret

00000000000006ec <printf>:

void
printf(const char *fmt, ...)
{
 6ec:	711d                	addi	sp,sp,-96
 6ee:	ec06                	sd	ra,24(sp)
 6f0:	e822                	sd	s0,16(sp)
 6f2:	1000                	addi	s0,sp,32
 6f4:	e40c                	sd	a1,8(s0)
 6f6:	e810                	sd	a2,16(s0)
 6f8:	ec14                	sd	a3,24(s0)
 6fa:	f018                	sd	a4,32(s0)
 6fc:	f41c                	sd	a5,40(s0)
 6fe:	03043823          	sd	a6,48(s0)
 702:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 706:	00840613          	addi	a2,s0,8
 70a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 70e:	85aa                	mv	a1,a0
 710:	4505                	li	a0,1
 712:	d29ff0ef          	jal	43a <vprintf>
}
 716:	60e2                	ld	ra,24(sp)
 718:	6442                	ld	s0,16(sp)
 71a:	6125                	addi	sp,sp,96
 71c:	8082                	ret

000000000000071e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 71e:	1141                	addi	sp,sp,-16
 720:	e422                	sd	s0,8(sp)
 722:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 724:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 728:	00001797          	auipc	a5,0x1
 72c:	8d87b783          	ld	a5,-1832(a5) # 1000 <freep>
 730:	a02d                	j	75a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 732:	4618                	lw	a4,8(a2)
 734:	9f2d                	addw	a4,a4,a1
 736:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 73a:	6398                	ld	a4,0(a5)
 73c:	6310                	ld	a2,0(a4)
 73e:	a83d                	j	77c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 740:	ff852703          	lw	a4,-8(a0)
 744:	9f31                	addw	a4,a4,a2
 746:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 748:	ff053683          	ld	a3,-16(a0)
 74c:	a091                	j	790 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74e:	6398                	ld	a4,0(a5)
 750:	00e7e463          	bltu	a5,a4,758 <free+0x3a>
 754:	00e6ea63          	bltu	a3,a4,768 <free+0x4a>
{
 758:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75a:	fed7fae3          	bgeu	a5,a3,74e <free+0x30>
 75e:	6398                	ld	a4,0(a5)
 760:	00e6e463          	bltu	a3,a4,768 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	fee7eae3          	bltu	a5,a4,758 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 768:	ff852583          	lw	a1,-8(a0)
 76c:	6390                	ld	a2,0(a5)
 76e:	02059813          	slli	a6,a1,0x20
 772:	01c85713          	srli	a4,a6,0x1c
 776:	9736                	add	a4,a4,a3
 778:	fae60de3          	beq	a2,a4,732 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 77c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 780:	4790                	lw	a2,8(a5)
 782:	02061593          	slli	a1,a2,0x20
 786:	01c5d713          	srli	a4,a1,0x1c
 78a:	973e                	add	a4,a4,a5
 78c:	fae68ae3          	beq	a3,a4,740 <free+0x22>
    p->s.ptr = bp->s.ptr;
 790:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 792:	00001717          	auipc	a4,0x1
 796:	86f73723          	sd	a5,-1938(a4) # 1000 <freep>
}
 79a:	6422                	ld	s0,8(sp)
 79c:	0141                	addi	sp,sp,16
 79e:	8082                	ret

00000000000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	7139                	addi	sp,sp,-64
 7a2:	fc06                	sd	ra,56(sp)
 7a4:	f822                	sd	s0,48(sp)
 7a6:	f426                	sd	s1,40(sp)
 7a8:	ec4e                	sd	s3,24(sp)
 7aa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ac:	02051493          	slli	s1,a0,0x20
 7b0:	9081                	srli	s1,s1,0x20
 7b2:	04bd                	addi	s1,s1,15
 7b4:	8091                	srli	s1,s1,0x4
 7b6:	0014899b          	addiw	s3,s1,1
 7ba:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7bc:	00001517          	auipc	a0,0x1
 7c0:	84453503          	ld	a0,-1980(a0) # 1000 <freep>
 7c4:	c915                	beqz	a0,7f8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c8:	4798                	lw	a4,8(a5)
 7ca:	08977a63          	bgeu	a4,s1,85e <malloc+0xbe>
 7ce:	f04a                	sd	s2,32(sp)
 7d0:	e852                	sd	s4,16(sp)
 7d2:	e456                	sd	s5,8(sp)
 7d4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7d6:	8a4e                	mv	s4,s3
 7d8:	0009871b          	sext.w	a4,s3
 7dc:	6685                	lui	a3,0x1
 7de:	00d77363          	bgeu	a4,a3,7e4 <malloc+0x44>
 7e2:	6a05                	lui	s4,0x1
 7e4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7e8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7ec:	00001917          	auipc	s2,0x1
 7f0:	81490913          	addi	s2,s2,-2028 # 1000 <freep>
  if(p == (char*)-1)
 7f4:	5afd                	li	s5,-1
 7f6:	a081                	j	836 <malloc+0x96>
 7f8:	f04a                	sd	s2,32(sp)
 7fa:	e852                	sd	s4,16(sp)
 7fc:	e456                	sd	s5,8(sp)
 7fe:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 800:	00001797          	auipc	a5,0x1
 804:	81078793          	addi	a5,a5,-2032 # 1010 <base>
 808:	00000717          	auipc	a4,0x0
 80c:	7ef73c23          	sd	a5,2040(a4) # 1000 <freep>
 810:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 812:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 816:	b7c1                	j	7d6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 818:	6398                	ld	a4,0(a5)
 81a:	e118                	sd	a4,0(a0)
 81c:	a8a9                	j	876 <malloc+0xd6>
  hp->s.size = nu;
 81e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 822:	0541                	addi	a0,a0,16
 824:	efbff0ef          	jal	71e <free>
  return freep;
 828:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 82c:	c12d                	beqz	a0,88e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 830:	4798                	lw	a4,8(a5)
 832:	02977263          	bgeu	a4,s1,856 <malloc+0xb6>
    if(p == freep)
 836:	00093703          	ld	a4,0(s2)
 83a:	853e                	mv	a0,a5
 83c:	fef719e3          	bne	a4,a5,82e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 840:	8552                	mv	a0,s4
 842:	ae5ff0ef          	jal	326 <sbrk>
  if(p == (char*)-1)
 846:	fd551ce3          	bne	a0,s5,81e <malloc+0x7e>
        return 0;
 84a:	4501                	li	a0,0
 84c:	7902                	ld	s2,32(sp)
 84e:	6a42                	ld	s4,16(sp)
 850:	6aa2                	ld	s5,8(sp)
 852:	6b02                	ld	s6,0(sp)
 854:	a03d                	j	882 <malloc+0xe2>
 856:	7902                	ld	s2,32(sp)
 858:	6a42                	ld	s4,16(sp)
 85a:	6aa2                	ld	s5,8(sp)
 85c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 85e:	fae48de3          	beq	s1,a4,818 <malloc+0x78>
        p->s.size -= nunits;
 862:	4137073b          	subw	a4,a4,s3
 866:	c798                	sw	a4,8(a5)
        p += p->s.size;
 868:	02071693          	slli	a3,a4,0x20
 86c:	01c6d713          	srli	a4,a3,0x1c
 870:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 872:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 876:	00000717          	auipc	a4,0x0
 87a:	78a73523          	sd	a0,1930(a4) # 1000 <freep>
      return (void*)(p + 1);
 87e:	01078513          	addi	a0,a5,16
  }
}
 882:	70e2                	ld	ra,56(sp)
 884:	7442                	ld	s0,48(sp)
 886:	74a2                	ld	s1,40(sp)
 888:	69e2                	ld	s3,24(sp)
 88a:	6121                	addi	sp,sp,64
 88c:	8082                	ret
 88e:	7902                	ld	s2,32(sp)
 890:	6a42                	ld	s4,16(sp)
 892:	6aa2                	ld	s5,8(sp)
 894:	6b02                	ld	s6,0(sp)
 896:	b7f5                	j	882 <malloc+0xe2>
