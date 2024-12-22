
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	00f50d63          	beq	a0,a5,24 <main+0x24>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	8c058593          	addi	a1,a1,-1856 # 8d0 <malloc+0x100>
  18:	4509                	li	a0,2
  1a:	6d8000ef          	jal	6f2 <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	2ae000ef          	jal	2ce <exit>
  24:	e426                	sd	s1,8(sp)
  26:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  28:	698c                	ld	a1,16(a1)
  2a:	6488                	ld	a0,8(s1)
  2c:	302000ef          	jal	32e <link>
  30:	00054563          	bltz	a0,3a <main+0x3a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  34:	4501                	li	a0,0
  36:	298000ef          	jal	2ce <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  3a:	6894                	ld	a3,16(s1)
  3c:	6490                	ld	a2,8(s1)
  3e:	00001597          	auipc	a1,0x1
  42:	8aa58593          	addi	a1,a1,-1878 # 8e8 <malloc+0x118>
  46:	4509                	li	a0,2
  48:	6aa000ef          	jal	6f2 <fprintf>
  4c:	b7e5                	j	34 <main+0x34>

000000000000004e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  4e:	1141                	addi	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	addi	s0,sp,16
  extern int main();
  main();
  56:	fabff0ef          	jal	0 <main>
  exit(0);
  5a:	4501                	li	a0,0
  5c:	272000ef          	jal	2ce <exit>

0000000000000060 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	87aa                	mv	a5,a0
  68:	0585                	addi	a1,a1,1
  6a:	0785                	addi	a5,a5,1
  6c:	fff5c703          	lbu	a4,-1(a1)
  70:	fee78fa3          	sb	a4,-1(a5)
  74:	fb75                	bnez	a4,68 <strcpy+0x8>
    ;
  return os;
}
  76:	6422                	ld	s0,8(sp)
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  82:	00054783          	lbu	a5,0(a0)
  86:	cb91                	beqz	a5,9a <strcmp+0x1e>
  88:	0005c703          	lbu	a4,0(a1)
  8c:	00f71763          	bne	a4,a5,9a <strcmp+0x1e>
    p++, q++;
  90:	0505                	addi	a0,a0,1
  92:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  94:	00054783          	lbu	a5,0(a0)
  98:	fbe5                	bnez	a5,88 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  9a:	0005c503          	lbu	a0,0(a1)
}
  9e:	40a7853b          	subw	a0,a5,a0
  a2:	6422                	ld	s0,8(sp)
  a4:	0141                	addi	sp,sp,16
  a6:	8082                	ret

00000000000000a8 <strlen>:

uint
strlen(const char *s)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cf91                	beqz	a5,ce <strlen+0x26>
  b4:	0505                	addi	a0,a0,1
  b6:	87aa                	mv	a5,a0
  b8:	86be                	mv	a3,a5
  ba:	0785                	addi	a5,a5,1
  bc:	fff7c703          	lbu	a4,-1(a5)
  c0:	ff65                	bnez	a4,b8 <strlen+0x10>
  c2:	40a6853b          	subw	a0,a3,a0
  c6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  c8:	6422                	ld	s0,8(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret
  for(n = 0; s[n]; n++)
  ce:	4501                	li	a0,0
  d0:	bfe5                	j	c8 <strlen+0x20>

00000000000000d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d8:	ca19                	beqz	a2,ee <memset+0x1c>
  da:	87aa                	mv	a5,a0
  dc:	1602                	slli	a2,a2,0x20
  de:	9201                	srli	a2,a2,0x20
  e0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e8:	0785                	addi	a5,a5,1
  ea:	fee79de3          	bne	a5,a4,e4 <memset+0x12>
  }
  return dst;
}
  ee:	6422                	ld	s0,8(sp)
  f0:	0141                	addi	sp,sp,16
  f2:	8082                	ret

00000000000000f4 <strchr>:

char*
strchr(const char *s, char c)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	addi	s0,sp,16
  for(; *s; s++)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cb99                	beqz	a5,114 <strchr+0x20>
    if(*s == c)
 100:	00f58763          	beq	a1,a5,10e <strchr+0x1a>
  for(; *s; s++)
 104:	0505                	addi	a0,a0,1
 106:	00054783          	lbu	a5,0(a0)
 10a:	fbfd                	bnez	a5,100 <strchr+0xc>
      return (char*)s;
  return 0;
 10c:	4501                	li	a0,0
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret
  return 0;
 114:	4501                	li	a0,0
 116:	bfe5                	j	10e <strchr+0x1a>

0000000000000118 <gets>:

char*
gets(char *buf, int max)
{
 118:	711d                	addi	sp,sp,-96
 11a:	ec86                	sd	ra,88(sp)
 11c:	e8a2                	sd	s0,80(sp)
 11e:	e4a6                	sd	s1,72(sp)
 120:	e0ca                	sd	s2,64(sp)
 122:	fc4e                	sd	s3,56(sp)
 124:	f852                	sd	s4,48(sp)
 126:	f456                	sd	s5,40(sp)
 128:	f05a                	sd	s6,32(sp)
 12a:	ec5e                	sd	s7,24(sp)
 12c:	1080                	addi	s0,sp,96
 12e:	8baa                	mv	s7,a0
 130:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 132:	892a                	mv	s2,a0
 134:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 136:	4aa9                	li	s5,10
 138:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 13a:	89a6                	mv	s3,s1
 13c:	2485                	addiw	s1,s1,1
 13e:	0344d663          	bge	s1,s4,16a <gets+0x52>
    cc = read(0, &c, 1);
 142:	4605                	li	a2,1
 144:	faf40593          	addi	a1,s0,-81
 148:	4501                	li	a0,0
 14a:	19c000ef          	jal	2e6 <read>
    if(cc < 1)
 14e:	00a05e63          	blez	a0,16a <gets+0x52>
    buf[i++] = c;
 152:	faf44783          	lbu	a5,-81(s0)
 156:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 15a:	01578763          	beq	a5,s5,168 <gets+0x50>
 15e:	0905                	addi	s2,s2,1
 160:	fd679de3          	bne	a5,s6,13a <gets+0x22>
    buf[i++] = c;
 164:	89a6                	mv	s3,s1
 166:	a011                	j	16a <gets+0x52>
 168:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 16a:	99de                	add	s3,s3,s7
 16c:	00098023          	sb	zero,0(s3)
  return buf;
}
 170:	855e                	mv	a0,s7
 172:	60e6                	ld	ra,88(sp)
 174:	6446                	ld	s0,80(sp)
 176:	64a6                	ld	s1,72(sp)
 178:	6906                	ld	s2,64(sp)
 17a:	79e2                	ld	s3,56(sp)
 17c:	7a42                	ld	s4,48(sp)
 17e:	7aa2                	ld	s5,40(sp)
 180:	7b02                	ld	s6,32(sp)
 182:	6be2                	ld	s7,24(sp)
 184:	6125                	addi	sp,sp,96
 186:	8082                	ret

0000000000000188 <stat>:

int
stat(const char *n, struct stat *st)
{
 188:	1101                	addi	sp,sp,-32
 18a:	ec06                	sd	ra,24(sp)
 18c:	e822                	sd	s0,16(sp)
 18e:	e04a                	sd	s2,0(sp)
 190:	1000                	addi	s0,sp,32
 192:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 194:	4581                	li	a1,0
 196:	178000ef          	jal	30e <open>
  if(fd < 0)
 19a:	02054263          	bltz	a0,1be <stat+0x36>
 19e:	e426                	sd	s1,8(sp)
 1a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a2:	85ca                	mv	a1,s2
 1a4:	182000ef          	jal	326 <fstat>
 1a8:	892a                	mv	s2,a0
  close(fd);
 1aa:	8526                	mv	a0,s1
 1ac:	14a000ef          	jal	2f6 <close>
  return r;
 1b0:	64a2                	ld	s1,8(sp)
}
 1b2:	854a                	mv	a0,s2
 1b4:	60e2                	ld	ra,24(sp)
 1b6:	6442                	ld	s0,16(sp)
 1b8:	6902                	ld	s2,0(sp)
 1ba:	6105                	addi	sp,sp,32
 1bc:	8082                	ret
    return -1;
 1be:	597d                	li	s2,-1
 1c0:	bfcd                	j	1b2 <stat+0x2a>

00000000000001c2 <atoi>:

int
atoi(const char *s)
{
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c8:	00054683          	lbu	a3,0(a0)
 1cc:	fd06879b          	addiw	a5,a3,-48
 1d0:	0ff7f793          	zext.b	a5,a5
 1d4:	4625                	li	a2,9
 1d6:	02f66863          	bltu	a2,a5,206 <atoi+0x44>
 1da:	872a                	mv	a4,a0
  n = 0;
 1dc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1de:	0705                	addi	a4,a4,1
 1e0:	0025179b          	slliw	a5,a0,0x2
 1e4:	9fa9                	addw	a5,a5,a0
 1e6:	0017979b          	slliw	a5,a5,0x1
 1ea:	9fb5                	addw	a5,a5,a3
 1ec:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f0:	00074683          	lbu	a3,0(a4)
 1f4:	fd06879b          	addiw	a5,a3,-48
 1f8:	0ff7f793          	zext.b	a5,a5
 1fc:	fef671e3          	bgeu	a2,a5,1de <atoi+0x1c>
  return n;
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret
  n = 0;
 206:	4501                	li	a0,0
 208:	bfe5                	j	200 <atoi+0x3e>

000000000000020a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 210:	02b57463          	bgeu	a0,a1,238 <memmove+0x2e>
    while(n-- > 0)
 214:	00c05f63          	blez	a2,232 <memmove+0x28>
 218:	1602                	slli	a2,a2,0x20
 21a:	9201                	srli	a2,a2,0x20
 21c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 220:	872a                	mv	a4,a0
      *dst++ = *src++;
 222:	0585                	addi	a1,a1,1
 224:	0705                	addi	a4,a4,1
 226:	fff5c683          	lbu	a3,-1(a1)
 22a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 22e:	fef71ae3          	bne	a4,a5,222 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
    dst += n;
 238:	00c50733          	add	a4,a0,a2
    src += n;
 23c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 23e:	fec05ae3          	blez	a2,232 <memmove+0x28>
 242:	fff6079b          	addiw	a5,a2,-1
 246:	1782                	slli	a5,a5,0x20
 248:	9381                	srli	a5,a5,0x20
 24a:	fff7c793          	not	a5,a5
 24e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 250:	15fd                	addi	a1,a1,-1
 252:	177d                	addi	a4,a4,-1
 254:	0005c683          	lbu	a3,0(a1)
 258:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 25c:	fee79ae3          	bne	a5,a4,250 <memmove+0x46>
 260:	bfc9                	j	232 <memmove+0x28>

0000000000000262 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 268:	ca05                	beqz	a2,298 <memcmp+0x36>
 26a:	fff6069b          	addiw	a3,a2,-1
 26e:	1682                	slli	a3,a3,0x20
 270:	9281                	srli	a3,a3,0x20
 272:	0685                	addi	a3,a3,1
 274:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 276:	00054783          	lbu	a5,0(a0)
 27a:	0005c703          	lbu	a4,0(a1)
 27e:	00e79863          	bne	a5,a4,28e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 282:	0505                	addi	a0,a0,1
    p2++;
 284:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 286:	fed518e3          	bne	a0,a3,276 <memcmp+0x14>
  }
  return 0;
 28a:	4501                	li	a0,0
 28c:	a019                	j	292 <memcmp+0x30>
      return *p1 - *p2;
 28e:	40e7853b          	subw	a0,a5,a4
}
 292:	6422                	ld	s0,8(sp)
 294:	0141                	addi	sp,sp,16
 296:	8082                	ret
  return 0;
 298:	4501                	li	a0,0
 29a:	bfe5                	j	292 <memcmp+0x30>

000000000000029c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a4:	f67ff0ef          	jal	20a <memmove>
}
 2a8:	60a2                	ld	ra,8(sp)
 2aa:	6402                	ld	s0,0(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 2b0:	1141                	addi	sp,sp,-16
 2b2:	e422                	sd	s0,8(sp)
 2b4:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 2b6:	040007b7          	lui	a5,0x4000
 2ba:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 2bc:	07b2                	slli	a5,a5,0xc
}
 2be:	4388                	lw	a0,0(a5)
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2c6:	4885                	li	a7,1
 ecall
 2c8:	00000073          	ecall
 ret
 2cc:	8082                	ret

00000000000002ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ce:	4889                	li	a7,2
 ecall
 2d0:	00000073          	ecall
 ret
 2d4:	8082                	ret

00000000000002d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2d6:	488d                	li	a7,3
 ecall
 2d8:	00000073          	ecall
 ret
 2dc:	8082                	ret

00000000000002de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2de:	4891                	li	a7,4
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <read>:
.global read
read:
 li a7, SYS_read
 2e6:	4895                	li	a7,5
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <write>:
.global write
write:
 li a7, SYS_write
 2ee:	48c1                	li	a7,16
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <close>:
.global close
close:
 li a7, SYS_close
 2f6:	48d5                	li	a7,21
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 2fe:	4899                	li	a7,6
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <exec>:
.global exec
exec:
 li a7, SYS_exec
 306:	489d                	li	a7,7
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <open>:
.global open
open:
 li a7, SYS_open
 30e:	48bd                	li	a7,15
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 316:	48c5                	li	a7,17
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 31e:	48c9                	li	a7,18
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 326:	48a1                	li	a7,8
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <link>:
.global link
link:
 li a7, SYS_link
 32e:	48cd                	li	a7,19
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 336:	48d1                	li	a7,20
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 33e:	48a5                	li	a7,9
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <dup>:
.global dup
dup:
 li a7, SYS_dup
 346:	48a9                	li	a7,10
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 34e:	48ad                	li	a7,11
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 356:	48b1                	li	a7,12
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 35e:	48b5                	li	a7,13
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 366:	48b9                	li	a7,14
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <bind>:
.global bind
bind:
 li a7, SYS_bind
 36e:	48f5                	li	a7,29
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 376:	48f9                	li	a7,30
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <send>:
.global send
send:
 li a7, SYS_send
 37e:	48fd                	li	a7,31
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <recv>:
.global recv
recv:
 li a7, SYS_recv
 386:	02000893          	li	a7,32
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 390:	02100893          	li	a7,33
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 39a:	02200893          	li	a7,34
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3a4:	1101                	addi	sp,sp,-32
 3a6:	ec06                	sd	ra,24(sp)
 3a8:	e822                	sd	s0,16(sp)
 3aa:	1000                	addi	s0,sp,32
 3ac:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3b0:	4605                	li	a2,1
 3b2:	fef40593          	addi	a1,s0,-17
 3b6:	f39ff0ef          	jal	2ee <write>
}
 3ba:	60e2                	ld	ra,24(sp)
 3bc:	6442                	ld	s0,16(sp)
 3be:	6105                	addi	sp,sp,32
 3c0:	8082                	ret

00000000000003c2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c2:	7139                	addi	sp,sp,-64
 3c4:	fc06                	sd	ra,56(sp)
 3c6:	f822                	sd	s0,48(sp)
 3c8:	f426                	sd	s1,40(sp)
 3ca:	0080                	addi	s0,sp,64
 3cc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ce:	c299                	beqz	a3,3d4 <printint+0x12>
 3d0:	0805c963          	bltz	a1,462 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3d4:	2581                	sext.w	a1,a1
  neg = 0;
 3d6:	4881                	li	a7,0
 3d8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3dc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3de:	2601                	sext.w	a2,a2
 3e0:	00000517          	auipc	a0,0x0
 3e4:	52850513          	addi	a0,a0,1320 # 908 <digits>
 3e8:	883a                	mv	a6,a4
 3ea:	2705                	addiw	a4,a4,1
 3ec:	02c5f7bb          	remuw	a5,a1,a2
 3f0:	1782                	slli	a5,a5,0x20
 3f2:	9381                	srli	a5,a5,0x20
 3f4:	97aa                	add	a5,a5,a0
 3f6:	0007c783          	lbu	a5,0(a5)
 3fa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3fe:	0005879b          	sext.w	a5,a1
 402:	02c5d5bb          	divuw	a1,a1,a2
 406:	0685                	addi	a3,a3,1
 408:	fec7f0e3          	bgeu	a5,a2,3e8 <printint+0x26>
  if(neg)
 40c:	00088c63          	beqz	a7,424 <printint+0x62>
    buf[i++] = '-';
 410:	fd070793          	addi	a5,a4,-48
 414:	00878733          	add	a4,a5,s0
 418:	02d00793          	li	a5,45
 41c:	fef70823          	sb	a5,-16(a4)
 420:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 424:	02e05a63          	blez	a4,458 <printint+0x96>
 428:	f04a                	sd	s2,32(sp)
 42a:	ec4e                	sd	s3,24(sp)
 42c:	fc040793          	addi	a5,s0,-64
 430:	00e78933          	add	s2,a5,a4
 434:	fff78993          	addi	s3,a5,-1
 438:	99ba                	add	s3,s3,a4
 43a:	377d                	addiw	a4,a4,-1
 43c:	1702                	slli	a4,a4,0x20
 43e:	9301                	srli	a4,a4,0x20
 440:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 444:	fff94583          	lbu	a1,-1(s2)
 448:	8526                	mv	a0,s1
 44a:	f5bff0ef          	jal	3a4 <putc>
  while(--i >= 0)
 44e:	197d                	addi	s2,s2,-1
 450:	ff391ae3          	bne	s2,s3,444 <printint+0x82>
 454:	7902                	ld	s2,32(sp)
 456:	69e2                	ld	s3,24(sp)
}
 458:	70e2                	ld	ra,56(sp)
 45a:	7442                	ld	s0,48(sp)
 45c:	74a2                	ld	s1,40(sp)
 45e:	6121                	addi	sp,sp,64
 460:	8082                	ret
    x = -xx;
 462:	40b005bb          	negw	a1,a1
    neg = 1;
 466:	4885                	li	a7,1
    x = -xx;
 468:	bf85                	j	3d8 <printint+0x16>

000000000000046a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 46a:	711d                	addi	sp,sp,-96
 46c:	ec86                	sd	ra,88(sp)
 46e:	e8a2                	sd	s0,80(sp)
 470:	e0ca                	sd	s2,64(sp)
 472:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 474:	0005c903          	lbu	s2,0(a1)
 478:	26090863          	beqz	s2,6e8 <vprintf+0x27e>
 47c:	e4a6                	sd	s1,72(sp)
 47e:	fc4e                	sd	s3,56(sp)
 480:	f852                	sd	s4,48(sp)
 482:	f456                	sd	s5,40(sp)
 484:	f05a                	sd	s6,32(sp)
 486:	ec5e                	sd	s7,24(sp)
 488:	e862                	sd	s8,16(sp)
 48a:	e466                	sd	s9,8(sp)
 48c:	8b2a                	mv	s6,a0
 48e:	8a2e                	mv	s4,a1
 490:	8bb2                	mv	s7,a2
  state = 0;
 492:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 494:	4481                	li	s1,0
 496:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 498:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 49c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4a0:	06c00c93          	li	s9,108
 4a4:	a005                	j	4c4 <vprintf+0x5a>
        putc(fd, c0);
 4a6:	85ca                	mv	a1,s2
 4a8:	855a                	mv	a0,s6
 4aa:	efbff0ef          	jal	3a4 <putc>
 4ae:	a019                	j	4b4 <vprintf+0x4a>
    } else if(state == '%'){
 4b0:	03598263          	beq	s3,s5,4d4 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 4b4:	2485                	addiw	s1,s1,1
 4b6:	8726                	mv	a4,s1
 4b8:	009a07b3          	add	a5,s4,s1
 4bc:	0007c903          	lbu	s2,0(a5)
 4c0:	20090c63          	beqz	s2,6d8 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 4c4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4c8:	fe0994e3          	bnez	s3,4b0 <vprintf+0x46>
      if(c0 == '%'){
 4cc:	fd579de3          	bne	a5,s5,4a6 <vprintf+0x3c>
        state = '%';
 4d0:	89be                	mv	s3,a5
 4d2:	b7cd                	j	4b4 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4d4:	00ea06b3          	add	a3,s4,a4
 4d8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4dc:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4de:	c681                	beqz	a3,4e6 <vprintf+0x7c>
 4e0:	9752                	add	a4,a4,s4
 4e2:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4e6:	03878f63          	beq	a5,s8,524 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 4ea:	05978963          	beq	a5,s9,53c <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4ee:	07500713          	li	a4,117
 4f2:	0ee78363          	beq	a5,a4,5d8 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4f6:	07800713          	li	a4,120
 4fa:	12e78563          	beq	a5,a4,624 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4fe:	07000713          	li	a4,112
 502:	14e78a63          	beq	a5,a4,656 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 506:	07300713          	li	a4,115
 50a:	18e78a63          	beq	a5,a4,69e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 50e:	02500713          	li	a4,37
 512:	04e79563          	bne	a5,a4,55c <vprintf+0xf2>
        putc(fd, '%');
 516:	02500593          	li	a1,37
 51a:	855a                	mv	a0,s6
 51c:	e89ff0ef          	jal	3a4 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 520:	4981                	li	s3,0
 522:	bf49                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 524:	008b8913          	addi	s2,s7,8
 528:	4685                	li	a3,1
 52a:	4629                	li	a2,10
 52c:	000ba583          	lw	a1,0(s7)
 530:	855a                	mv	a0,s6
 532:	e91ff0ef          	jal	3c2 <printint>
 536:	8bca                	mv	s7,s2
      state = 0;
 538:	4981                	li	s3,0
 53a:	bfad                	j	4b4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 53c:	06400793          	li	a5,100
 540:	02f68963          	beq	a3,a5,572 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 544:	06c00793          	li	a5,108
 548:	04f68263          	beq	a3,a5,58c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 54c:	07500793          	li	a5,117
 550:	0af68063          	beq	a3,a5,5f0 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 554:	07800793          	li	a5,120
 558:	0ef68263          	beq	a3,a5,63c <vprintf+0x1d2>
        putc(fd, '%');
 55c:	02500593          	li	a1,37
 560:	855a                	mv	a0,s6
 562:	e43ff0ef          	jal	3a4 <putc>
        putc(fd, c0);
 566:	85ca                	mv	a1,s2
 568:	855a                	mv	a0,s6
 56a:	e3bff0ef          	jal	3a4 <putc>
      state = 0;
 56e:	4981                	li	s3,0
 570:	b791                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 572:	008b8913          	addi	s2,s7,8
 576:	4685                	li	a3,1
 578:	4629                	li	a2,10
 57a:	000ba583          	lw	a1,0(s7)
 57e:	855a                	mv	a0,s6
 580:	e43ff0ef          	jal	3c2 <printint>
        i += 1;
 584:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 586:	8bca                	mv	s7,s2
      state = 0;
 588:	4981                	li	s3,0
        i += 1;
 58a:	b72d                	j	4b4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 58c:	06400793          	li	a5,100
 590:	02f60763          	beq	a2,a5,5be <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 594:	07500793          	li	a5,117
 598:	06f60963          	beq	a2,a5,60a <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 59c:	07800793          	li	a5,120
 5a0:	faf61ee3          	bne	a2,a5,55c <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5a4:	008b8913          	addi	s2,s7,8
 5a8:	4681                	li	a3,0
 5aa:	4641                	li	a2,16
 5ac:	000ba583          	lw	a1,0(s7)
 5b0:	855a                	mv	a0,s6
 5b2:	e11ff0ef          	jal	3c2 <printint>
        i += 2;
 5b6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5b8:	8bca                	mv	s7,s2
      state = 0;
 5ba:	4981                	li	s3,0
        i += 2;
 5bc:	bde5                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5be:	008b8913          	addi	s2,s7,8
 5c2:	4685                	li	a3,1
 5c4:	4629                	li	a2,10
 5c6:	000ba583          	lw	a1,0(s7)
 5ca:	855a                	mv	a0,s6
 5cc:	df7ff0ef          	jal	3c2 <printint>
        i += 2;
 5d0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d2:	8bca                	mv	s7,s2
      state = 0;
 5d4:	4981                	li	s3,0
        i += 2;
 5d6:	bdf9                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 5d8:	008b8913          	addi	s2,s7,8
 5dc:	4681                	li	a3,0
 5de:	4629                	li	a2,10
 5e0:	000ba583          	lw	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	dddff0ef          	jal	3c2 <printint>
 5ea:	8bca                	mv	s7,s2
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	b5d9                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f0:	008b8913          	addi	s2,s7,8
 5f4:	4681                	li	a3,0
 5f6:	4629                	li	a2,10
 5f8:	000ba583          	lw	a1,0(s7)
 5fc:	855a                	mv	a0,s6
 5fe:	dc5ff0ef          	jal	3c2 <printint>
        i += 1;
 602:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 604:	8bca                	mv	s7,s2
      state = 0;
 606:	4981                	li	s3,0
        i += 1;
 608:	b575                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60a:	008b8913          	addi	s2,s7,8
 60e:	4681                	li	a3,0
 610:	4629                	li	a2,10
 612:	000ba583          	lw	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	dabff0ef          	jal	3c2 <printint>
        i += 2;
 61c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 61e:	8bca                	mv	s7,s2
      state = 0;
 620:	4981                	li	s3,0
        i += 2;
 622:	bd49                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 624:	008b8913          	addi	s2,s7,8
 628:	4681                	li	a3,0
 62a:	4641                	li	a2,16
 62c:	000ba583          	lw	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	d91ff0ef          	jal	3c2 <printint>
 636:	8bca                	mv	s7,s2
      state = 0;
 638:	4981                	li	s3,0
 63a:	bdad                	j	4b4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 63c:	008b8913          	addi	s2,s7,8
 640:	4681                	li	a3,0
 642:	4641                	li	a2,16
 644:	000ba583          	lw	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	d79ff0ef          	jal	3c2 <printint>
        i += 1;
 64e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 650:	8bca                	mv	s7,s2
      state = 0;
 652:	4981                	li	s3,0
        i += 1;
 654:	b585                	j	4b4 <vprintf+0x4a>
 656:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 658:	008b8d13          	addi	s10,s7,8
 65c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 660:	03000593          	li	a1,48
 664:	855a                	mv	a0,s6
 666:	d3fff0ef          	jal	3a4 <putc>
  putc(fd, 'x');
 66a:	07800593          	li	a1,120
 66e:	855a                	mv	a0,s6
 670:	d35ff0ef          	jal	3a4 <putc>
 674:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 676:	00000b97          	auipc	s7,0x0
 67a:	292b8b93          	addi	s7,s7,658 # 908 <digits>
 67e:	03c9d793          	srli	a5,s3,0x3c
 682:	97de                	add	a5,a5,s7
 684:	0007c583          	lbu	a1,0(a5)
 688:	855a                	mv	a0,s6
 68a:	d1bff0ef          	jal	3a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 68e:	0992                	slli	s3,s3,0x4
 690:	397d                	addiw	s2,s2,-1
 692:	fe0916e3          	bnez	s2,67e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 696:	8bea                	mv	s7,s10
      state = 0;
 698:	4981                	li	s3,0
 69a:	6d02                	ld	s10,0(sp)
 69c:	bd21                	j	4b4 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 69e:	008b8993          	addi	s3,s7,8
 6a2:	000bb903          	ld	s2,0(s7)
 6a6:	00090f63          	beqz	s2,6c4 <vprintf+0x25a>
        for(; *s; s++)
 6aa:	00094583          	lbu	a1,0(s2)
 6ae:	c195                	beqz	a1,6d2 <vprintf+0x268>
          putc(fd, *s);
 6b0:	855a                	mv	a0,s6
 6b2:	cf3ff0ef          	jal	3a4 <putc>
        for(; *s; s++)
 6b6:	0905                	addi	s2,s2,1
 6b8:	00094583          	lbu	a1,0(s2)
 6bc:	f9f5                	bnez	a1,6b0 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 6be:	8bce                	mv	s7,s3
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	bbcd                	j	4b4 <vprintf+0x4a>
          s = "(null)";
 6c4:	00000917          	auipc	s2,0x0
 6c8:	23c90913          	addi	s2,s2,572 # 900 <malloc+0x130>
        for(; *s; s++)
 6cc:	02800593          	li	a1,40
 6d0:	b7c5                	j	6b0 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 6d2:	8bce                	mv	s7,s3
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	bbf9                	j	4b4 <vprintf+0x4a>
 6d8:	64a6                	ld	s1,72(sp)
 6da:	79e2                	ld	s3,56(sp)
 6dc:	7a42                	ld	s4,48(sp)
 6de:	7aa2                	ld	s5,40(sp)
 6e0:	7b02                	ld	s6,32(sp)
 6e2:	6be2                	ld	s7,24(sp)
 6e4:	6c42                	ld	s8,16(sp)
 6e6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6e8:	60e6                	ld	ra,88(sp)
 6ea:	6446                	ld	s0,80(sp)
 6ec:	6906                	ld	s2,64(sp)
 6ee:	6125                	addi	sp,sp,96
 6f0:	8082                	ret

00000000000006f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6f2:	715d                	addi	sp,sp,-80
 6f4:	ec06                	sd	ra,24(sp)
 6f6:	e822                	sd	s0,16(sp)
 6f8:	1000                	addi	s0,sp,32
 6fa:	e010                	sd	a2,0(s0)
 6fc:	e414                	sd	a3,8(s0)
 6fe:	e818                	sd	a4,16(s0)
 700:	ec1c                	sd	a5,24(s0)
 702:	03043023          	sd	a6,32(s0)
 706:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 70a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 70e:	8622                	mv	a2,s0
 710:	d5bff0ef          	jal	46a <vprintf>
}
 714:	60e2                	ld	ra,24(sp)
 716:	6442                	ld	s0,16(sp)
 718:	6161                	addi	sp,sp,80
 71a:	8082                	ret

000000000000071c <printf>:

void
printf(const char *fmt, ...)
{
 71c:	711d                	addi	sp,sp,-96
 71e:	ec06                	sd	ra,24(sp)
 720:	e822                	sd	s0,16(sp)
 722:	1000                	addi	s0,sp,32
 724:	e40c                	sd	a1,8(s0)
 726:	e810                	sd	a2,16(s0)
 728:	ec14                	sd	a3,24(s0)
 72a:	f018                	sd	a4,32(s0)
 72c:	f41c                	sd	a5,40(s0)
 72e:	03043823          	sd	a6,48(s0)
 732:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 736:	00840613          	addi	a2,s0,8
 73a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 73e:	85aa                	mv	a1,a0
 740:	4505                	li	a0,1
 742:	d29ff0ef          	jal	46a <vprintf>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6125                	addi	sp,sp,96
 74c:	8082                	ret

000000000000074e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 74e:	1141                	addi	sp,sp,-16
 750:	e422                	sd	s0,8(sp)
 752:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 754:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 758:	00001797          	auipc	a5,0x1
 75c:	8a87b783          	ld	a5,-1880(a5) # 1000 <freep>
 760:	a02d                	j	78a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 762:	4618                	lw	a4,8(a2)
 764:	9f2d                	addw	a4,a4,a1
 766:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 76a:	6398                	ld	a4,0(a5)
 76c:	6310                	ld	a2,0(a4)
 76e:	a83d                	j	7ac <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 770:	ff852703          	lw	a4,-8(a0)
 774:	9f31                	addw	a4,a4,a2
 776:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 778:	ff053683          	ld	a3,-16(a0)
 77c:	a091                	j	7c0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77e:	6398                	ld	a4,0(a5)
 780:	00e7e463          	bltu	a5,a4,788 <free+0x3a>
 784:	00e6ea63          	bltu	a3,a4,798 <free+0x4a>
{
 788:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78a:	fed7fae3          	bgeu	a5,a3,77e <free+0x30>
 78e:	6398                	ld	a4,0(a5)
 790:	00e6e463          	bltu	a3,a4,798 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	fee7eae3          	bltu	a5,a4,788 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 798:	ff852583          	lw	a1,-8(a0)
 79c:	6390                	ld	a2,0(a5)
 79e:	02059813          	slli	a6,a1,0x20
 7a2:	01c85713          	srli	a4,a6,0x1c
 7a6:	9736                	add	a4,a4,a3
 7a8:	fae60de3          	beq	a2,a4,762 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7ac:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7b0:	4790                	lw	a2,8(a5)
 7b2:	02061593          	slli	a1,a2,0x20
 7b6:	01c5d713          	srli	a4,a1,0x1c
 7ba:	973e                	add	a4,a4,a5
 7bc:	fae68ae3          	beq	a3,a4,770 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7c0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c2:	00001717          	auipc	a4,0x1
 7c6:	82f73f23          	sd	a5,-1986(a4) # 1000 <freep>
}
 7ca:	6422                	ld	s0,8(sp)
 7cc:	0141                	addi	sp,sp,16
 7ce:	8082                	ret

00000000000007d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d0:	7139                	addi	sp,sp,-64
 7d2:	fc06                	sd	ra,56(sp)
 7d4:	f822                	sd	s0,48(sp)
 7d6:	f426                	sd	s1,40(sp)
 7d8:	ec4e                	sd	s3,24(sp)
 7da:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7dc:	02051493          	slli	s1,a0,0x20
 7e0:	9081                	srli	s1,s1,0x20
 7e2:	04bd                	addi	s1,s1,15
 7e4:	8091                	srli	s1,s1,0x4
 7e6:	0014899b          	addiw	s3,s1,1
 7ea:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7ec:	00001517          	auipc	a0,0x1
 7f0:	81453503          	ld	a0,-2028(a0) # 1000 <freep>
 7f4:	c915                	beqz	a0,828 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7f8:	4798                	lw	a4,8(a5)
 7fa:	08977a63          	bgeu	a4,s1,88e <malloc+0xbe>
 7fe:	f04a                	sd	s2,32(sp)
 800:	e852                	sd	s4,16(sp)
 802:	e456                	sd	s5,8(sp)
 804:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 806:	8a4e                	mv	s4,s3
 808:	0009871b          	sext.w	a4,s3
 80c:	6685                	lui	a3,0x1
 80e:	00d77363          	bgeu	a4,a3,814 <malloc+0x44>
 812:	6a05                	lui	s4,0x1
 814:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 818:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 81c:	00000917          	auipc	s2,0x0
 820:	7e490913          	addi	s2,s2,2020 # 1000 <freep>
  if(p == (char*)-1)
 824:	5afd                	li	s5,-1
 826:	a081                	j	866 <malloc+0x96>
 828:	f04a                	sd	s2,32(sp)
 82a:	e852                	sd	s4,16(sp)
 82c:	e456                	sd	s5,8(sp)
 82e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 830:	00000797          	auipc	a5,0x0
 834:	7e078793          	addi	a5,a5,2016 # 1010 <base>
 838:	00000717          	auipc	a4,0x0
 83c:	7cf73423          	sd	a5,1992(a4) # 1000 <freep>
 840:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 842:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 846:	b7c1                	j	806 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 848:	6398                	ld	a4,0(a5)
 84a:	e118                	sd	a4,0(a0)
 84c:	a8a9                	j	8a6 <malloc+0xd6>
  hp->s.size = nu;
 84e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 852:	0541                	addi	a0,a0,16
 854:	efbff0ef          	jal	74e <free>
  return freep;
 858:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 85c:	c12d                	beqz	a0,8be <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 860:	4798                	lw	a4,8(a5)
 862:	02977263          	bgeu	a4,s1,886 <malloc+0xb6>
    if(p == freep)
 866:	00093703          	ld	a4,0(s2)
 86a:	853e                	mv	a0,a5
 86c:	fef719e3          	bne	a4,a5,85e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 870:	8552                	mv	a0,s4
 872:	ae5ff0ef          	jal	356 <sbrk>
  if(p == (char*)-1)
 876:	fd551ce3          	bne	a0,s5,84e <malloc+0x7e>
        return 0;
 87a:	4501                	li	a0,0
 87c:	7902                	ld	s2,32(sp)
 87e:	6a42                	ld	s4,16(sp)
 880:	6aa2                	ld	s5,8(sp)
 882:	6b02                	ld	s6,0(sp)
 884:	a03d                	j	8b2 <malloc+0xe2>
 886:	7902                	ld	s2,32(sp)
 888:	6a42                	ld	s4,16(sp)
 88a:	6aa2                	ld	s5,8(sp)
 88c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 88e:	fae48de3          	beq	s1,a4,848 <malloc+0x78>
        p->s.size -= nunits;
 892:	4137073b          	subw	a4,a4,s3
 896:	c798                	sw	a4,8(a5)
        p += p->s.size;
 898:	02071693          	slli	a3,a4,0x20
 89c:	01c6d713          	srli	a4,a3,0x1c
 8a0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8a2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8a6:	00000717          	auipc	a4,0x0
 8aa:	74a73d23          	sd	a0,1882(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ae:	01078513          	addi	a0,a5,16
  }
}
 8b2:	70e2                	ld	ra,56(sp)
 8b4:	7442                	ld	s0,48(sp)
 8b6:	74a2                	ld	s1,40(sp)
 8b8:	69e2                	ld	s3,24(sp)
 8ba:	6121                	addi	sp,sp,64
 8bc:	8082                	ret
 8be:	7902                	ld	s2,32(sp)
 8c0:	6a42                	ld	s4,16(sp)
 8c2:	6aa2                	ld	s5,8(sp)
 8c4:	6b02                	ld	s6,0(sp)
 8c6:	b7f5                	j	8b2 <malloc+0xe2>
