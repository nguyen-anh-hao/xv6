
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	1a0000ef          	jal	1c8 <atoi>
  2c:	2d8000ef          	jal	304 <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	29c000ef          	jal	2d4 <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	89058593          	addi	a1,a1,-1904 # 8d0 <malloc+0xfa>
  48:	4509                	li	a0,2
  4a:	6ae000ef          	jal	6f8 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	284000ef          	jal	2d4 <exit>

0000000000000054 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  5c:	fa5ff0ef          	jal	0 <main>
  exit(0);
  60:	4501                	li	a0,0
  62:	272000ef          	jal	2d4 <exit>

0000000000000066 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  66:	1141                	addi	sp,sp,-16
  68:	e422                	sd	s0,8(sp)
  6a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6c:	87aa                	mv	a5,a0
  6e:	0585                	addi	a1,a1,1
  70:	0785                	addi	a5,a5,1
  72:	fff5c703          	lbu	a4,-1(a1)
  76:	fee78fa3          	sb	a4,-1(a5)
  7a:	fb75                	bnez	a4,6e <strcpy+0x8>
    ;
  return os;
}
  7c:	6422                	ld	s0,8(sp)
  7e:	0141                	addi	sp,sp,16
  80:	8082                	ret

0000000000000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	1141                	addi	sp,sp,-16
  84:	e422                	sd	s0,8(sp)
  86:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  88:	00054783          	lbu	a5,0(a0)
  8c:	cb91                	beqz	a5,a0 <strcmp+0x1e>
  8e:	0005c703          	lbu	a4,0(a1)
  92:	00f71763          	bne	a4,a5,a0 <strcmp+0x1e>
    p++, q++;
  96:	0505                	addi	a0,a0,1
  98:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	fbe5                	bnez	a5,8e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  a0:	0005c503          	lbu	a0,0(a1)
}
  a4:	40a7853b          	subw	a0,a5,a0
  a8:	6422                	ld	s0,8(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strlen>:

uint
strlen(const char *s)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	cf91                	beqz	a5,d4 <strlen+0x26>
  ba:	0505                	addi	a0,a0,1
  bc:	87aa                	mv	a5,a0
  be:	86be                	mv	a3,a5
  c0:	0785                	addi	a5,a5,1
  c2:	fff7c703          	lbu	a4,-1(a5)
  c6:	ff65                	bnez	a4,be <strlen+0x10>
  c8:	40a6853b          	subw	a0,a3,a0
  cc:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret
  for(n = 0; s[n]; n++)
  d4:	4501                	li	a0,0
  d6:	bfe5                	j	ce <strlen+0x20>

00000000000000d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d8:	1141                	addi	sp,sp,-16
  da:	e422                	sd	s0,8(sp)
  dc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  de:	ca19                	beqz	a2,f4 <memset+0x1c>
  e0:	87aa                	mv	a5,a0
  e2:	1602                	slli	a2,a2,0x20
  e4:	9201                	srli	a2,a2,0x20
  e6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ee:	0785                	addi	a5,a5,1
  f0:	fee79de3          	bne	a5,a4,ea <memset+0x12>
  }
  return dst;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret

00000000000000fa <strchr>:

char*
strchr(const char *s, char c)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	addi	s0,sp,16
  for(; *s; s++)
 100:	00054783          	lbu	a5,0(a0)
 104:	cb99                	beqz	a5,11a <strchr+0x20>
    if(*s == c)
 106:	00f58763          	beq	a1,a5,114 <strchr+0x1a>
  for(; *s; s++)
 10a:	0505                	addi	a0,a0,1
 10c:	00054783          	lbu	a5,0(a0)
 110:	fbfd                	bnez	a5,106 <strchr+0xc>
      return (char*)s;
  return 0;
 112:	4501                	li	a0,0
}
 114:	6422                	ld	s0,8(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret
  return 0;
 11a:	4501                	li	a0,0
 11c:	bfe5                	j	114 <strchr+0x1a>

000000000000011e <gets>:

char*
gets(char *buf, int max)
{
 11e:	711d                	addi	sp,sp,-96
 120:	ec86                	sd	ra,88(sp)
 122:	e8a2                	sd	s0,80(sp)
 124:	e4a6                	sd	s1,72(sp)
 126:	e0ca                	sd	s2,64(sp)
 128:	fc4e                	sd	s3,56(sp)
 12a:	f852                	sd	s4,48(sp)
 12c:	f456                	sd	s5,40(sp)
 12e:	f05a                	sd	s6,32(sp)
 130:	ec5e                	sd	s7,24(sp)
 132:	1080                	addi	s0,sp,96
 134:	8baa                	mv	s7,a0
 136:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 138:	892a                	mv	s2,a0
 13a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 13c:	4aa9                	li	s5,10
 13e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 140:	89a6                	mv	s3,s1
 142:	2485                	addiw	s1,s1,1
 144:	0344d663          	bge	s1,s4,170 <gets+0x52>
    cc = read(0, &c, 1);
 148:	4605                	li	a2,1
 14a:	faf40593          	addi	a1,s0,-81
 14e:	4501                	li	a0,0
 150:	19c000ef          	jal	2ec <read>
    if(cc < 1)
 154:	00a05e63          	blez	a0,170 <gets+0x52>
    buf[i++] = c;
 158:	faf44783          	lbu	a5,-81(s0)
 15c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 160:	01578763          	beq	a5,s5,16e <gets+0x50>
 164:	0905                	addi	s2,s2,1
 166:	fd679de3          	bne	a5,s6,140 <gets+0x22>
    buf[i++] = c;
 16a:	89a6                	mv	s3,s1
 16c:	a011                	j	170 <gets+0x52>
 16e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 170:	99de                	add	s3,s3,s7
 172:	00098023          	sb	zero,0(s3)
  return buf;
}
 176:	855e                	mv	a0,s7
 178:	60e6                	ld	ra,88(sp)
 17a:	6446                	ld	s0,80(sp)
 17c:	64a6                	ld	s1,72(sp)
 17e:	6906                	ld	s2,64(sp)
 180:	79e2                	ld	s3,56(sp)
 182:	7a42                	ld	s4,48(sp)
 184:	7aa2                	ld	s5,40(sp)
 186:	7b02                	ld	s6,32(sp)
 188:	6be2                	ld	s7,24(sp)
 18a:	6125                	addi	sp,sp,96
 18c:	8082                	ret

000000000000018e <stat>:

int
stat(const char *n, struct stat *st)
{
 18e:	1101                	addi	sp,sp,-32
 190:	ec06                	sd	ra,24(sp)
 192:	e822                	sd	s0,16(sp)
 194:	e04a                	sd	s2,0(sp)
 196:	1000                	addi	s0,sp,32
 198:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19a:	4581                	li	a1,0
 19c:	178000ef          	jal	314 <open>
  if(fd < 0)
 1a0:	02054263          	bltz	a0,1c4 <stat+0x36>
 1a4:	e426                	sd	s1,8(sp)
 1a6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a8:	85ca                	mv	a1,s2
 1aa:	182000ef          	jal	32c <fstat>
 1ae:	892a                	mv	s2,a0
  close(fd);
 1b0:	8526                	mv	a0,s1
 1b2:	14a000ef          	jal	2fc <close>
  return r;
 1b6:	64a2                	ld	s1,8(sp)
}
 1b8:	854a                	mv	a0,s2
 1ba:	60e2                	ld	ra,24(sp)
 1bc:	6442                	ld	s0,16(sp)
 1be:	6902                	ld	s2,0(sp)
 1c0:	6105                	addi	sp,sp,32
 1c2:	8082                	ret
    return -1;
 1c4:	597d                	li	s2,-1
 1c6:	bfcd                	j	1b8 <stat+0x2a>

00000000000001c8 <atoi>:

int
atoi(const char *s)
{
 1c8:	1141                	addi	sp,sp,-16
 1ca:	e422                	sd	s0,8(sp)
 1cc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ce:	00054683          	lbu	a3,0(a0)
 1d2:	fd06879b          	addiw	a5,a3,-48
 1d6:	0ff7f793          	zext.b	a5,a5
 1da:	4625                	li	a2,9
 1dc:	02f66863          	bltu	a2,a5,20c <atoi+0x44>
 1e0:	872a                	mv	a4,a0
  n = 0;
 1e2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e4:	0705                	addi	a4,a4,1
 1e6:	0025179b          	slliw	a5,a0,0x2
 1ea:	9fa9                	addw	a5,a5,a0
 1ec:	0017979b          	slliw	a5,a5,0x1
 1f0:	9fb5                	addw	a5,a5,a3
 1f2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f6:	00074683          	lbu	a3,0(a4)
 1fa:	fd06879b          	addiw	a5,a3,-48
 1fe:	0ff7f793          	zext.b	a5,a5
 202:	fef671e3          	bgeu	a2,a5,1e4 <atoi+0x1c>
  return n;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  n = 0;
 20c:	4501                	li	a0,0
 20e:	bfe5                	j	206 <atoi+0x3e>

0000000000000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 216:	02b57463          	bgeu	a0,a1,23e <memmove+0x2e>
    while(n-- > 0)
 21a:	00c05f63          	blez	a2,238 <memmove+0x28>
 21e:	1602                	slli	a2,a2,0x20
 220:	9201                	srli	a2,a2,0x20
 222:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 226:	872a                	mv	a4,a0
      *dst++ = *src++;
 228:	0585                	addi	a1,a1,1
 22a:	0705                	addi	a4,a4,1
 22c:	fff5c683          	lbu	a3,-1(a1)
 230:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 234:	fef71ae3          	bne	a4,a5,228 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret
    dst += n;
 23e:	00c50733          	add	a4,a0,a2
    src += n;
 242:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 244:	fec05ae3          	blez	a2,238 <memmove+0x28>
 248:	fff6079b          	addiw	a5,a2,-1
 24c:	1782                	slli	a5,a5,0x20
 24e:	9381                	srli	a5,a5,0x20
 250:	fff7c793          	not	a5,a5
 254:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 256:	15fd                	addi	a1,a1,-1
 258:	177d                	addi	a4,a4,-1
 25a:	0005c683          	lbu	a3,0(a1)
 25e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 262:	fee79ae3          	bne	a5,a4,256 <memmove+0x46>
 266:	bfc9                	j	238 <memmove+0x28>

0000000000000268 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 26e:	ca05                	beqz	a2,29e <memcmp+0x36>
 270:	fff6069b          	addiw	a3,a2,-1
 274:	1682                	slli	a3,a3,0x20
 276:	9281                	srli	a3,a3,0x20
 278:	0685                	addi	a3,a3,1
 27a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 27c:	00054783          	lbu	a5,0(a0)
 280:	0005c703          	lbu	a4,0(a1)
 284:	00e79863          	bne	a5,a4,294 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 288:	0505                	addi	a0,a0,1
    p2++;
 28a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28c:	fed518e3          	bne	a0,a3,27c <memcmp+0x14>
  }
  return 0;
 290:	4501                	li	a0,0
 292:	a019                	j	298 <memcmp+0x30>
      return *p1 - *p2;
 294:	40e7853b          	subw	a0,a5,a4
}
 298:	6422                	ld	s0,8(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret
  return 0;
 29e:	4501                	li	a0,0
 2a0:	bfe5                	j	298 <memcmp+0x30>

00000000000002a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2aa:	f67ff0ef          	jal	210 <memmove>
}
 2ae:	60a2                	ld	ra,8(sp)
 2b0:	6402                	ld	s0,0(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 2bc:	040007b7          	lui	a5,0x4000
 2c0:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 2c2:	07b2                	slli	a5,a5,0xc
}
 2c4:	4388                	lw	a0,0(a5)
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret

00000000000002cc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2cc:	4885                	li	a7,1
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2d4:	4889                	li	a7,2
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <wait>:
.global wait
wait:
 li a7, SYS_wait
 2dc:	488d                	li	a7,3
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2e4:	4891                	li	a7,4
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <read>:
.global read
read:
 li a7, SYS_read
 2ec:	4895                	li	a7,5
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <write>:
.global write
write:
 li a7, SYS_write
 2f4:	48c1                	li	a7,16
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <close>:
.global close
close:
 li a7, SYS_close
 2fc:	48d5                	li	a7,21
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <kill>:
.global kill
kill:
 li a7, SYS_kill
 304:	4899                	li	a7,6
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <exec>:
.global exec
exec:
 li a7, SYS_exec
 30c:	489d                	li	a7,7
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <open>:
.global open
open:
 li a7, SYS_open
 314:	48bd                	li	a7,15
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 31c:	48c5                	li	a7,17
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 324:	48c9                	li	a7,18
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 32c:	48a1                	li	a7,8
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <link>:
.global link
link:
 li a7, SYS_link
 334:	48cd                	li	a7,19
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 33c:	48d1                	li	a7,20
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 344:	48a5                	li	a7,9
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <dup>:
.global dup
dup:
 li a7, SYS_dup
 34c:	48a9                	li	a7,10
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 354:	48ad                	li	a7,11
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 35c:	48b1                	li	a7,12
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 364:	48b5                	li	a7,13
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 36c:	48b9                	li	a7,14
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <bind>:
.global bind
bind:
 li a7, SYS_bind
 374:	48f5                	li	a7,29
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 37c:	48f9                	li	a7,30
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <send>:
.global send
send:
 li a7, SYS_send
 384:	48fd                	li	a7,31
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <recv>:
.global recv
recv:
 li a7, SYS_recv
 38c:	02000893          	li	a7,32
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 396:	02100893          	li	a7,33
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 3a0:	02200893          	li	a7,34
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3aa:	1101                	addi	sp,sp,-32
 3ac:	ec06                	sd	ra,24(sp)
 3ae:	e822                	sd	s0,16(sp)
 3b0:	1000                	addi	s0,sp,32
 3b2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3b6:	4605                	li	a2,1
 3b8:	fef40593          	addi	a1,s0,-17
 3bc:	f39ff0ef          	jal	2f4 <write>
}
 3c0:	60e2                	ld	ra,24(sp)
 3c2:	6442                	ld	s0,16(sp)
 3c4:	6105                	addi	sp,sp,32
 3c6:	8082                	ret

00000000000003c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c8:	7139                	addi	sp,sp,-64
 3ca:	fc06                	sd	ra,56(sp)
 3cc:	f822                	sd	s0,48(sp)
 3ce:	f426                	sd	s1,40(sp)
 3d0:	0080                	addi	s0,sp,64
 3d2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3d4:	c299                	beqz	a3,3da <printint+0x12>
 3d6:	0805c963          	bltz	a1,468 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3da:	2581                	sext.w	a1,a1
  neg = 0;
 3dc:	4881                	li	a7,0
 3de:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3e2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3e4:	2601                	sext.w	a2,a2
 3e6:	00000517          	auipc	a0,0x0
 3ea:	50a50513          	addi	a0,a0,1290 # 8f0 <digits>
 3ee:	883a                	mv	a6,a4
 3f0:	2705                	addiw	a4,a4,1
 3f2:	02c5f7bb          	remuw	a5,a1,a2
 3f6:	1782                	slli	a5,a5,0x20
 3f8:	9381                	srli	a5,a5,0x20
 3fa:	97aa                	add	a5,a5,a0
 3fc:	0007c783          	lbu	a5,0(a5)
 400:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 404:	0005879b          	sext.w	a5,a1
 408:	02c5d5bb          	divuw	a1,a1,a2
 40c:	0685                	addi	a3,a3,1
 40e:	fec7f0e3          	bgeu	a5,a2,3ee <printint+0x26>
  if(neg)
 412:	00088c63          	beqz	a7,42a <printint+0x62>
    buf[i++] = '-';
 416:	fd070793          	addi	a5,a4,-48
 41a:	00878733          	add	a4,a5,s0
 41e:	02d00793          	li	a5,45
 422:	fef70823          	sb	a5,-16(a4)
 426:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 42a:	02e05a63          	blez	a4,45e <printint+0x96>
 42e:	f04a                	sd	s2,32(sp)
 430:	ec4e                	sd	s3,24(sp)
 432:	fc040793          	addi	a5,s0,-64
 436:	00e78933          	add	s2,a5,a4
 43a:	fff78993          	addi	s3,a5,-1
 43e:	99ba                	add	s3,s3,a4
 440:	377d                	addiw	a4,a4,-1
 442:	1702                	slli	a4,a4,0x20
 444:	9301                	srli	a4,a4,0x20
 446:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 44a:	fff94583          	lbu	a1,-1(s2)
 44e:	8526                	mv	a0,s1
 450:	f5bff0ef          	jal	3aa <putc>
  while(--i >= 0)
 454:	197d                	addi	s2,s2,-1
 456:	ff391ae3          	bne	s2,s3,44a <printint+0x82>
 45a:	7902                	ld	s2,32(sp)
 45c:	69e2                	ld	s3,24(sp)
}
 45e:	70e2                	ld	ra,56(sp)
 460:	7442                	ld	s0,48(sp)
 462:	74a2                	ld	s1,40(sp)
 464:	6121                	addi	sp,sp,64
 466:	8082                	ret
    x = -xx;
 468:	40b005bb          	negw	a1,a1
    neg = 1;
 46c:	4885                	li	a7,1
    x = -xx;
 46e:	bf85                	j	3de <printint+0x16>

0000000000000470 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 470:	711d                	addi	sp,sp,-96
 472:	ec86                	sd	ra,88(sp)
 474:	e8a2                	sd	s0,80(sp)
 476:	e0ca                	sd	s2,64(sp)
 478:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 47a:	0005c903          	lbu	s2,0(a1)
 47e:	26090863          	beqz	s2,6ee <vprintf+0x27e>
 482:	e4a6                	sd	s1,72(sp)
 484:	fc4e                	sd	s3,56(sp)
 486:	f852                	sd	s4,48(sp)
 488:	f456                	sd	s5,40(sp)
 48a:	f05a                	sd	s6,32(sp)
 48c:	ec5e                	sd	s7,24(sp)
 48e:	e862                	sd	s8,16(sp)
 490:	e466                	sd	s9,8(sp)
 492:	8b2a                	mv	s6,a0
 494:	8a2e                	mv	s4,a1
 496:	8bb2                	mv	s7,a2
  state = 0;
 498:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 49a:	4481                	li	s1,0
 49c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 49e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4a2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4a6:	06c00c93          	li	s9,108
 4aa:	a005                	j	4ca <vprintf+0x5a>
        putc(fd, c0);
 4ac:	85ca                	mv	a1,s2
 4ae:	855a                	mv	a0,s6
 4b0:	efbff0ef          	jal	3aa <putc>
 4b4:	a019                	j	4ba <vprintf+0x4a>
    } else if(state == '%'){
 4b6:	03598263          	beq	s3,s5,4da <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 4ba:	2485                	addiw	s1,s1,1
 4bc:	8726                	mv	a4,s1
 4be:	009a07b3          	add	a5,s4,s1
 4c2:	0007c903          	lbu	s2,0(a5)
 4c6:	20090c63          	beqz	s2,6de <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 4ca:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4ce:	fe0994e3          	bnez	s3,4b6 <vprintf+0x46>
      if(c0 == '%'){
 4d2:	fd579de3          	bne	a5,s5,4ac <vprintf+0x3c>
        state = '%';
 4d6:	89be                	mv	s3,a5
 4d8:	b7cd                	j	4ba <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4da:	00ea06b3          	add	a3,s4,a4
 4de:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4e2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4e4:	c681                	beqz	a3,4ec <vprintf+0x7c>
 4e6:	9752                	add	a4,a4,s4
 4e8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4ec:	03878f63          	beq	a5,s8,52a <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 4f0:	05978963          	beq	a5,s9,542 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4f4:	07500713          	li	a4,117
 4f8:	0ee78363          	beq	a5,a4,5de <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4fc:	07800713          	li	a4,120
 500:	12e78563          	beq	a5,a4,62a <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 504:	07000713          	li	a4,112
 508:	14e78a63          	beq	a5,a4,65c <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 50c:	07300713          	li	a4,115
 510:	18e78a63          	beq	a5,a4,6a4 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 514:	02500713          	li	a4,37
 518:	04e79563          	bne	a5,a4,562 <vprintf+0xf2>
        putc(fd, '%');
 51c:	02500593          	li	a1,37
 520:	855a                	mv	a0,s6
 522:	e89ff0ef          	jal	3aa <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 526:	4981                	li	s3,0
 528:	bf49                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 52a:	008b8913          	addi	s2,s7,8
 52e:	4685                	li	a3,1
 530:	4629                	li	a2,10
 532:	000ba583          	lw	a1,0(s7)
 536:	855a                	mv	a0,s6
 538:	e91ff0ef          	jal	3c8 <printint>
 53c:	8bca                	mv	s7,s2
      state = 0;
 53e:	4981                	li	s3,0
 540:	bfad                	j	4ba <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 542:	06400793          	li	a5,100
 546:	02f68963          	beq	a3,a5,578 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 54a:	06c00793          	li	a5,108
 54e:	04f68263          	beq	a3,a5,592 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 552:	07500793          	li	a5,117
 556:	0af68063          	beq	a3,a5,5f6 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 55a:	07800793          	li	a5,120
 55e:	0ef68263          	beq	a3,a5,642 <vprintf+0x1d2>
        putc(fd, '%');
 562:	02500593          	li	a1,37
 566:	855a                	mv	a0,s6
 568:	e43ff0ef          	jal	3aa <putc>
        putc(fd, c0);
 56c:	85ca                	mv	a1,s2
 56e:	855a                	mv	a0,s6
 570:	e3bff0ef          	jal	3aa <putc>
      state = 0;
 574:	4981                	li	s3,0
 576:	b791                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 578:	008b8913          	addi	s2,s7,8
 57c:	4685                	li	a3,1
 57e:	4629                	li	a2,10
 580:	000ba583          	lw	a1,0(s7)
 584:	855a                	mv	a0,s6
 586:	e43ff0ef          	jal	3c8 <printint>
        i += 1;
 58a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 58c:	8bca                	mv	s7,s2
      state = 0;
 58e:	4981                	li	s3,0
        i += 1;
 590:	b72d                	j	4ba <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 592:	06400793          	li	a5,100
 596:	02f60763          	beq	a2,a5,5c4 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 59a:	07500793          	li	a5,117
 59e:	06f60963          	beq	a2,a5,610 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5a2:	07800793          	li	a5,120
 5a6:	faf61ee3          	bne	a2,a5,562 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5aa:	008b8913          	addi	s2,s7,8
 5ae:	4681                	li	a3,0
 5b0:	4641                	li	a2,16
 5b2:	000ba583          	lw	a1,0(s7)
 5b6:	855a                	mv	a0,s6
 5b8:	e11ff0ef          	jal	3c8 <printint>
        i += 2;
 5bc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5be:	8bca                	mv	s7,s2
      state = 0;
 5c0:	4981                	li	s3,0
        i += 2;
 5c2:	bde5                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c4:	008b8913          	addi	s2,s7,8
 5c8:	4685                	li	a3,1
 5ca:	4629                	li	a2,10
 5cc:	000ba583          	lw	a1,0(s7)
 5d0:	855a                	mv	a0,s6
 5d2:	df7ff0ef          	jal	3c8 <printint>
        i += 2;
 5d6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d8:	8bca                	mv	s7,s2
      state = 0;
 5da:	4981                	li	s3,0
        i += 2;
 5dc:	bdf9                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 5de:	008b8913          	addi	s2,s7,8
 5e2:	4681                	li	a3,0
 5e4:	4629                	li	a2,10
 5e6:	000ba583          	lw	a1,0(s7)
 5ea:	855a                	mv	a0,s6
 5ec:	dddff0ef          	jal	3c8 <printint>
 5f0:	8bca                	mv	s7,s2
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	b5d9                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f6:	008b8913          	addi	s2,s7,8
 5fa:	4681                	li	a3,0
 5fc:	4629                	li	a2,10
 5fe:	000ba583          	lw	a1,0(s7)
 602:	855a                	mv	a0,s6
 604:	dc5ff0ef          	jal	3c8 <printint>
        i += 1;
 608:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 60a:	8bca                	mv	s7,s2
      state = 0;
 60c:	4981                	li	s3,0
        i += 1;
 60e:	b575                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 610:	008b8913          	addi	s2,s7,8
 614:	4681                	li	a3,0
 616:	4629                	li	a2,10
 618:	000ba583          	lw	a1,0(s7)
 61c:	855a                	mv	a0,s6
 61e:	dabff0ef          	jal	3c8 <printint>
        i += 2;
 622:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 624:	8bca                	mv	s7,s2
      state = 0;
 626:	4981                	li	s3,0
        i += 2;
 628:	bd49                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 62a:	008b8913          	addi	s2,s7,8
 62e:	4681                	li	a3,0
 630:	4641                	li	a2,16
 632:	000ba583          	lw	a1,0(s7)
 636:	855a                	mv	a0,s6
 638:	d91ff0ef          	jal	3c8 <printint>
 63c:	8bca                	mv	s7,s2
      state = 0;
 63e:	4981                	li	s3,0
 640:	bdad                	j	4ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 642:	008b8913          	addi	s2,s7,8
 646:	4681                	li	a3,0
 648:	4641                	li	a2,16
 64a:	000ba583          	lw	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	d79ff0ef          	jal	3c8 <printint>
        i += 1;
 654:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 656:	8bca                	mv	s7,s2
      state = 0;
 658:	4981                	li	s3,0
        i += 1;
 65a:	b585                	j	4ba <vprintf+0x4a>
 65c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 65e:	008b8d13          	addi	s10,s7,8
 662:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 666:	03000593          	li	a1,48
 66a:	855a                	mv	a0,s6
 66c:	d3fff0ef          	jal	3aa <putc>
  putc(fd, 'x');
 670:	07800593          	li	a1,120
 674:	855a                	mv	a0,s6
 676:	d35ff0ef          	jal	3aa <putc>
 67a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67c:	00000b97          	auipc	s7,0x0
 680:	274b8b93          	addi	s7,s7,628 # 8f0 <digits>
 684:	03c9d793          	srli	a5,s3,0x3c
 688:	97de                	add	a5,a5,s7
 68a:	0007c583          	lbu	a1,0(a5)
 68e:	855a                	mv	a0,s6
 690:	d1bff0ef          	jal	3aa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 694:	0992                	slli	s3,s3,0x4
 696:	397d                	addiw	s2,s2,-1
 698:	fe0916e3          	bnez	s2,684 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 69c:	8bea                	mv	s7,s10
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	6d02                	ld	s10,0(sp)
 6a2:	bd21                	j	4ba <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6a4:	008b8993          	addi	s3,s7,8
 6a8:	000bb903          	ld	s2,0(s7)
 6ac:	00090f63          	beqz	s2,6ca <vprintf+0x25a>
        for(; *s; s++)
 6b0:	00094583          	lbu	a1,0(s2)
 6b4:	c195                	beqz	a1,6d8 <vprintf+0x268>
          putc(fd, *s);
 6b6:	855a                	mv	a0,s6
 6b8:	cf3ff0ef          	jal	3aa <putc>
        for(; *s; s++)
 6bc:	0905                	addi	s2,s2,1
 6be:	00094583          	lbu	a1,0(s2)
 6c2:	f9f5                	bnez	a1,6b6 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 6c4:	8bce                	mv	s7,s3
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	bbcd                	j	4ba <vprintf+0x4a>
          s = "(null)";
 6ca:	00000917          	auipc	s2,0x0
 6ce:	21e90913          	addi	s2,s2,542 # 8e8 <malloc+0x112>
        for(; *s; s++)
 6d2:	02800593          	li	a1,40
 6d6:	b7c5                	j	6b6 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 6d8:	8bce                	mv	s7,s3
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	bbf9                	j	4ba <vprintf+0x4a>
 6de:	64a6                	ld	s1,72(sp)
 6e0:	79e2                	ld	s3,56(sp)
 6e2:	7a42                	ld	s4,48(sp)
 6e4:	7aa2                	ld	s5,40(sp)
 6e6:	7b02                	ld	s6,32(sp)
 6e8:	6be2                	ld	s7,24(sp)
 6ea:	6c42                	ld	s8,16(sp)
 6ec:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6ee:	60e6                	ld	ra,88(sp)
 6f0:	6446                	ld	s0,80(sp)
 6f2:	6906                	ld	s2,64(sp)
 6f4:	6125                	addi	sp,sp,96
 6f6:	8082                	ret

00000000000006f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6f8:	715d                	addi	sp,sp,-80
 6fa:	ec06                	sd	ra,24(sp)
 6fc:	e822                	sd	s0,16(sp)
 6fe:	1000                	addi	s0,sp,32
 700:	e010                	sd	a2,0(s0)
 702:	e414                	sd	a3,8(s0)
 704:	e818                	sd	a4,16(s0)
 706:	ec1c                	sd	a5,24(s0)
 708:	03043023          	sd	a6,32(s0)
 70c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 710:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 714:	8622                	mv	a2,s0
 716:	d5bff0ef          	jal	470 <vprintf>
}
 71a:	60e2                	ld	ra,24(sp)
 71c:	6442                	ld	s0,16(sp)
 71e:	6161                	addi	sp,sp,80
 720:	8082                	ret

0000000000000722 <printf>:

void
printf(const char *fmt, ...)
{
 722:	711d                	addi	sp,sp,-96
 724:	ec06                	sd	ra,24(sp)
 726:	e822                	sd	s0,16(sp)
 728:	1000                	addi	s0,sp,32
 72a:	e40c                	sd	a1,8(s0)
 72c:	e810                	sd	a2,16(s0)
 72e:	ec14                	sd	a3,24(s0)
 730:	f018                	sd	a4,32(s0)
 732:	f41c                	sd	a5,40(s0)
 734:	03043823          	sd	a6,48(s0)
 738:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 73c:	00840613          	addi	a2,s0,8
 740:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 744:	85aa                	mv	a1,a0
 746:	4505                	li	a0,1
 748:	d29ff0ef          	jal	470 <vprintf>
}
 74c:	60e2                	ld	ra,24(sp)
 74e:	6442                	ld	s0,16(sp)
 750:	6125                	addi	sp,sp,96
 752:	8082                	ret

0000000000000754 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 754:	1141                	addi	sp,sp,-16
 756:	e422                	sd	s0,8(sp)
 758:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 75a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75e:	00001797          	auipc	a5,0x1
 762:	8a27b783          	ld	a5,-1886(a5) # 1000 <freep>
 766:	a02d                	j	790 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 768:	4618                	lw	a4,8(a2)
 76a:	9f2d                	addw	a4,a4,a1
 76c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 770:	6398                	ld	a4,0(a5)
 772:	6310                	ld	a2,0(a4)
 774:	a83d                	j	7b2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 776:	ff852703          	lw	a4,-8(a0)
 77a:	9f31                	addw	a4,a4,a2
 77c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 77e:	ff053683          	ld	a3,-16(a0)
 782:	a091                	j	7c6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 784:	6398                	ld	a4,0(a5)
 786:	00e7e463          	bltu	a5,a4,78e <free+0x3a>
 78a:	00e6ea63          	bltu	a3,a4,79e <free+0x4a>
{
 78e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 790:	fed7fae3          	bgeu	a5,a3,784 <free+0x30>
 794:	6398                	ld	a4,0(a5)
 796:	00e6e463          	bltu	a3,a4,79e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79a:	fee7eae3          	bltu	a5,a4,78e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 79e:	ff852583          	lw	a1,-8(a0)
 7a2:	6390                	ld	a2,0(a5)
 7a4:	02059813          	slli	a6,a1,0x20
 7a8:	01c85713          	srli	a4,a6,0x1c
 7ac:	9736                	add	a4,a4,a3
 7ae:	fae60de3          	beq	a2,a4,768 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7b2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7b6:	4790                	lw	a2,8(a5)
 7b8:	02061593          	slli	a1,a2,0x20
 7bc:	01c5d713          	srli	a4,a1,0x1c
 7c0:	973e                	add	a4,a4,a5
 7c2:	fae68ae3          	beq	a3,a4,776 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7c6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c8:	00001717          	auipc	a4,0x1
 7cc:	82f73c23          	sd	a5,-1992(a4) # 1000 <freep>
}
 7d0:	6422                	ld	s0,8(sp)
 7d2:	0141                	addi	sp,sp,16
 7d4:	8082                	ret

00000000000007d6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d6:	7139                	addi	sp,sp,-64
 7d8:	fc06                	sd	ra,56(sp)
 7da:	f822                	sd	s0,48(sp)
 7dc:	f426                	sd	s1,40(sp)
 7de:	ec4e                	sd	s3,24(sp)
 7e0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	02051493          	slli	s1,a0,0x20
 7e6:	9081                	srli	s1,s1,0x20
 7e8:	04bd                	addi	s1,s1,15
 7ea:	8091                	srli	s1,s1,0x4
 7ec:	0014899b          	addiw	s3,s1,1
 7f0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7f2:	00001517          	auipc	a0,0x1
 7f6:	80e53503          	ld	a0,-2034(a0) # 1000 <freep>
 7fa:	c915                	beqz	a0,82e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fe:	4798                	lw	a4,8(a5)
 800:	08977a63          	bgeu	a4,s1,894 <malloc+0xbe>
 804:	f04a                	sd	s2,32(sp)
 806:	e852                	sd	s4,16(sp)
 808:	e456                	sd	s5,8(sp)
 80a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 80c:	8a4e                	mv	s4,s3
 80e:	0009871b          	sext.w	a4,s3
 812:	6685                	lui	a3,0x1
 814:	00d77363          	bgeu	a4,a3,81a <malloc+0x44>
 818:	6a05                	lui	s4,0x1
 81a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 81e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 822:	00000917          	auipc	s2,0x0
 826:	7de90913          	addi	s2,s2,2014 # 1000 <freep>
  if(p == (char*)-1)
 82a:	5afd                	li	s5,-1
 82c:	a081                	j	86c <malloc+0x96>
 82e:	f04a                	sd	s2,32(sp)
 830:	e852                	sd	s4,16(sp)
 832:	e456                	sd	s5,8(sp)
 834:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 836:	00000797          	auipc	a5,0x0
 83a:	7da78793          	addi	a5,a5,2010 # 1010 <base>
 83e:	00000717          	auipc	a4,0x0
 842:	7cf73123          	sd	a5,1986(a4) # 1000 <freep>
 846:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 848:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 84c:	b7c1                	j	80c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 84e:	6398                	ld	a4,0(a5)
 850:	e118                	sd	a4,0(a0)
 852:	a8a9                	j	8ac <malloc+0xd6>
  hp->s.size = nu;
 854:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 858:	0541                	addi	a0,a0,16
 85a:	efbff0ef          	jal	754 <free>
  return freep;
 85e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 862:	c12d                	beqz	a0,8c4 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 864:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 866:	4798                	lw	a4,8(a5)
 868:	02977263          	bgeu	a4,s1,88c <malloc+0xb6>
    if(p == freep)
 86c:	00093703          	ld	a4,0(s2)
 870:	853e                	mv	a0,a5
 872:	fef719e3          	bne	a4,a5,864 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 876:	8552                	mv	a0,s4
 878:	ae5ff0ef          	jal	35c <sbrk>
  if(p == (char*)-1)
 87c:	fd551ce3          	bne	a0,s5,854 <malloc+0x7e>
        return 0;
 880:	4501                	li	a0,0
 882:	7902                	ld	s2,32(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	a03d                	j	8b8 <malloc+0xe2>
 88c:	7902                	ld	s2,32(sp)
 88e:	6a42                	ld	s4,16(sp)
 890:	6aa2                	ld	s5,8(sp)
 892:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 894:	fae48de3          	beq	s1,a4,84e <malloc+0x78>
        p->s.size -= nunits;
 898:	4137073b          	subw	a4,a4,s3
 89c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 89e:	02071693          	slli	a3,a4,0x20
 8a2:	01c6d713          	srli	a4,a3,0x1c
 8a6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8a8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ac:	00000717          	auipc	a4,0x0
 8b0:	74a73a23          	sd	a0,1876(a4) # 1000 <freep>
      return (void*)(p + 1);
 8b4:	01078513          	addi	a0,a5,16
  }
}
 8b8:	70e2                	ld	ra,56(sp)
 8ba:	7442                	ld	s0,48(sp)
 8bc:	74a2                	ld	s1,40(sp)
 8be:	69e2                	ld	s3,24(sp)
 8c0:	6121                	addi	sp,sp,64
 8c2:	8082                	ret
 8c4:	7902                	ld	s2,32(sp)
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
 8cc:	b7f5                	j	8b8 <malloc+0xe2>
