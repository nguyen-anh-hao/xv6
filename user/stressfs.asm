
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	97a78793          	addi	a5,a5,-1670 # 990 <malloc+0x136>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	93450513          	addi	a0,a0,-1740 # 960 <malloc+0x106>
  34:	772000ef          	jal	7a6 <printf>
  memset(data, 'a', sizeof(data));
  38:	20000613          	li	a2,512
  3c:	06100593          	li	a1,97
  40:	dd040513          	addi	a0,s0,-560
  44:	118000ef          	jal	15c <memset>

  for(i = 0; i < 4; i++)
  48:	4481                	li	s1,0
  4a:	4911                	li	s2,4
    if(fork() > 0)
  4c:	304000ef          	jal	350 <fork>
  50:	00a04563          	bgtz	a0,5a <main+0x5a>
  for(i = 0; i < 4; i++)
  54:	2485                	addiw	s1,s1,1
  56:	ff249be3          	bne	s1,s2,4c <main+0x4c>
      break;

  printf("write %d\n", i);
  5a:	85a6                	mv	a1,s1
  5c:	00001517          	auipc	a0,0x1
  60:	91c50513          	addi	a0,a0,-1764 # 978 <malloc+0x11e>
  64:	742000ef          	jal	7a6 <printf>

  path[8] += i;
  68:	fd844783          	lbu	a5,-40(s0)
  6c:	9fa5                	addw	a5,a5,s1
  6e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  72:	20200593          	li	a1,514
  76:	fd040513          	addi	a0,s0,-48
  7a:	31e000ef          	jal	398 <open>
  7e:	892a                	mv	s2,a0
  80:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  82:	20000613          	li	a2,512
  86:	dd040593          	addi	a1,s0,-560
  8a:	854a                	mv	a0,s2
  8c:	2ec000ef          	jal	378 <write>
  for(i = 0; i < 20; i++)
  90:	34fd                	addiw	s1,s1,-1
  92:	f8e5                	bnez	s1,82 <main+0x82>
  close(fd);
  94:	854a                	mv	a0,s2
  96:	2ea000ef          	jal	380 <close>

  printf("read\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	8ee50513          	addi	a0,a0,-1810 # 988 <malloc+0x12e>
  a2:	704000ef          	jal	7a6 <printf>

  fd = open(path, O_RDONLY);
  a6:	4581                	li	a1,0
  a8:	fd040513          	addi	a0,s0,-48
  ac:	2ec000ef          	jal	398 <open>
  b0:	892a                	mv	s2,a0
  b2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  b4:	20000613          	li	a2,512
  b8:	dd040593          	addi	a1,s0,-560
  bc:	854a                	mv	a0,s2
  be:	2b2000ef          	jal	370 <read>
  for (i = 0; i < 20; i++)
  c2:	34fd                	addiw	s1,s1,-1
  c4:	f8e5                	bnez	s1,b4 <main+0xb4>
  close(fd);
  c6:	854a                	mv	a0,s2
  c8:	2b8000ef          	jal	380 <close>

  wait(0);
  cc:	4501                	li	a0,0
  ce:	292000ef          	jal	360 <wait>

  exit(0);
  d2:	4501                	li	a0,0
  d4:	284000ef          	jal	358 <exit>

00000000000000d8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  d8:	1141                	addi	sp,sp,-16
  da:	e406                	sd	ra,8(sp)
  dc:	e022                	sd	s0,0(sp)
  de:	0800                	addi	s0,sp,16
  extern int main();
  main();
  e0:	f21ff0ef          	jal	0 <main>
  exit(0);
  e4:	4501                	li	a0,0
  e6:	272000ef          	jal	358 <exit>

00000000000000ea <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  ea:	1141                	addi	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f0:	87aa                	mv	a5,a0
  f2:	0585                	addi	a1,a1,1
  f4:	0785                	addi	a5,a5,1
  f6:	fff5c703          	lbu	a4,-1(a1)
  fa:	fee78fa3          	sb	a4,-1(a5)
  fe:	fb75                	bnez	a4,f2 <strcpy+0x8>
    ;
  return os;
}
 100:	6422                	ld	s0,8(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 106:	1141                	addi	sp,sp,-16
 108:	e422                	sd	s0,8(sp)
 10a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 10c:	00054783          	lbu	a5,0(a0)
 110:	cb91                	beqz	a5,124 <strcmp+0x1e>
 112:	0005c703          	lbu	a4,0(a1)
 116:	00f71763          	bne	a4,a5,124 <strcmp+0x1e>
    p++, q++;
 11a:	0505                	addi	a0,a0,1
 11c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 11e:	00054783          	lbu	a5,0(a0)
 122:	fbe5                	bnez	a5,112 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 124:	0005c503          	lbu	a0,0(a1)
}
 128:	40a7853b          	subw	a0,a5,a0
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <strlen>:

uint
strlen(const char *s)
{
 132:	1141                	addi	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cf91                	beqz	a5,158 <strlen+0x26>
 13e:	0505                	addi	a0,a0,1
 140:	87aa                	mv	a5,a0
 142:	86be                	mv	a3,a5
 144:	0785                	addi	a5,a5,1
 146:	fff7c703          	lbu	a4,-1(a5)
 14a:	ff65                	bnez	a4,142 <strlen+0x10>
 14c:	40a6853b          	subw	a0,a3,a0
 150:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 152:	6422                	ld	s0,8(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret
  for(n = 0; s[n]; n++)
 158:	4501                	li	a0,0
 15a:	bfe5                	j	152 <strlen+0x20>

000000000000015c <memset>:

void*
memset(void *dst, int c, uint n)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 162:	ca19                	beqz	a2,178 <memset+0x1c>
 164:	87aa                	mv	a5,a0
 166:	1602                	slli	a2,a2,0x20
 168:	9201                	srli	a2,a2,0x20
 16a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 172:	0785                	addi	a5,a5,1
 174:	fee79de3          	bne	a5,a4,16e <memset+0x12>
  }
  return dst;
}
 178:	6422                	ld	s0,8(sp)
 17a:	0141                	addi	sp,sp,16
 17c:	8082                	ret

000000000000017e <strchr>:

char*
strchr(const char *s, char c)
{
 17e:	1141                	addi	sp,sp,-16
 180:	e422                	sd	s0,8(sp)
 182:	0800                	addi	s0,sp,16
  for(; *s; s++)
 184:	00054783          	lbu	a5,0(a0)
 188:	cb99                	beqz	a5,19e <strchr+0x20>
    if(*s == c)
 18a:	00f58763          	beq	a1,a5,198 <strchr+0x1a>
  for(; *s; s++)
 18e:	0505                	addi	a0,a0,1
 190:	00054783          	lbu	a5,0(a0)
 194:	fbfd                	bnez	a5,18a <strchr+0xc>
      return (char*)s;
  return 0;
 196:	4501                	li	a0,0
}
 198:	6422                	ld	s0,8(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret
  return 0;
 19e:	4501                	li	a0,0
 1a0:	bfe5                	j	198 <strchr+0x1a>

00000000000001a2 <gets>:

char*
gets(char *buf, int max)
{
 1a2:	711d                	addi	sp,sp,-96
 1a4:	ec86                	sd	ra,88(sp)
 1a6:	e8a2                	sd	s0,80(sp)
 1a8:	e4a6                	sd	s1,72(sp)
 1aa:	e0ca                	sd	s2,64(sp)
 1ac:	fc4e                	sd	s3,56(sp)
 1ae:	f852                	sd	s4,48(sp)
 1b0:	f456                	sd	s5,40(sp)
 1b2:	f05a                	sd	s6,32(sp)
 1b4:	ec5e                	sd	s7,24(sp)
 1b6:	1080                	addi	s0,sp,96
 1b8:	8baa                	mv	s7,a0
 1ba:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bc:	892a                	mv	s2,a0
 1be:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c0:	4aa9                	li	s5,10
 1c2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c4:	89a6                	mv	s3,s1
 1c6:	2485                	addiw	s1,s1,1
 1c8:	0344d663          	bge	s1,s4,1f4 <gets+0x52>
    cc = read(0, &c, 1);
 1cc:	4605                	li	a2,1
 1ce:	faf40593          	addi	a1,s0,-81
 1d2:	4501                	li	a0,0
 1d4:	19c000ef          	jal	370 <read>
    if(cc < 1)
 1d8:	00a05e63          	blez	a0,1f4 <gets+0x52>
    buf[i++] = c;
 1dc:	faf44783          	lbu	a5,-81(s0)
 1e0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e4:	01578763          	beq	a5,s5,1f2 <gets+0x50>
 1e8:	0905                	addi	s2,s2,1
 1ea:	fd679de3          	bne	a5,s6,1c4 <gets+0x22>
    buf[i++] = c;
 1ee:	89a6                	mv	s3,s1
 1f0:	a011                	j	1f4 <gets+0x52>
 1f2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f4:	99de                	add	s3,s3,s7
 1f6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1fa:	855e                	mv	a0,s7
 1fc:	60e6                	ld	ra,88(sp)
 1fe:	6446                	ld	s0,80(sp)
 200:	64a6                	ld	s1,72(sp)
 202:	6906                	ld	s2,64(sp)
 204:	79e2                	ld	s3,56(sp)
 206:	7a42                	ld	s4,48(sp)
 208:	7aa2                	ld	s5,40(sp)
 20a:	7b02                	ld	s6,32(sp)
 20c:	6be2                	ld	s7,24(sp)
 20e:	6125                	addi	sp,sp,96
 210:	8082                	ret

0000000000000212 <stat>:

int
stat(const char *n, struct stat *st)
{
 212:	1101                	addi	sp,sp,-32
 214:	ec06                	sd	ra,24(sp)
 216:	e822                	sd	s0,16(sp)
 218:	e04a                	sd	s2,0(sp)
 21a:	1000                	addi	s0,sp,32
 21c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21e:	4581                	li	a1,0
 220:	178000ef          	jal	398 <open>
  if(fd < 0)
 224:	02054263          	bltz	a0,248 <stat+0x36>
 228:	e426                	sd	s1,8(sp)
 22a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 22c:	85ca                	mv	a1,s2
 22e:	182000ef          	jal	3b0 <fstat>
 232:	892a                	mv	s2,a0
  close(fd);
 234:	8526                	mv	a0,s1
 236:	14a000ef          	jal	380 <close>
  return r;
 23a:	64a2                	ld	s1,8(sp)
}
 23c:	854a                	mv	a0,s2
 23e:	60e2                	ld	ra,24(sp)
 240:	6442                	ld	s0,16(sp)
 242:	6902                	ld	s2,0(sp)
 244:	6105                	addi	sp,sp,32
 246:	8082                	ret
    return -1;
 248:	597d                	li	s2,-1
 24a:	bfcd                	j	23c <stat+0x2a>

000000000000024c <atoi>:

int
atoi(const char *s)
{
 24c:	1141                	addi	sp,sp,-16
 24e:	e422                	sd	s0,8(sp)
 250:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 252:	00054683          	lbu	a3,0(a0)
 256:	fd06879b          	addiw	a5,a3,-48
 25a:	0ff7f793          	zext.b	a5,a5
 25e:	4625                	li	a2,9
 260:	02f66863          	bltu	a2,a5,290 <atoi+0x44>
 264:	872a                	mv	a4,a0
  n = 0;
 266:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 268:	0705                	addi	a4,a4,1
 26a:	0025179b          	slliw	a5,a0,0x2
 26e:	9fa9                	addw	a5,a5,a0
 270:	0017979b          	slliw	a5,a5,0x1
 274:	9fb5                	addw	a5,a5,a3
 276:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 27a:	00074683          	lbu	a3,0(a4)
 27e:	fd06879b          	addiw	a5,a3,-48
 282:	0ff7f793          	zext.b	a5,a5
 286:	fef671e3          	bgeu	a2,a5,268 <atoi+0x1c>
  return n;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret
  n = 0;
 290:	4501                	li	a0,0
 292:	bfe5                	j	28a <atoi+0x3e>

0000000000000294 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 29a:	02b57463          	bgeu	a0,a1,2c2 <memmove+0x2e>
    while(n-- > 0)
 29e:	00c05f63          	blez	a2,2bc <memmove+0x28>
 2a2:	1602                	slli	a2,a2,0x20
 2a4:	9201                	srli	a2,a2,0x20
 2a6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2aa:	872a                	mv	a4,a0
      *dst++ = *src++;
 2ac:	0585                	addi	a1,a1,1
 2ae:	0705                	addi	a4,a4,1
 2b0:	fff5c683          	lbu	a3,-1(a1)
 2b4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2b8:	fef71ae3          	bne	a4,a5,2ac <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
    dst += n;
 2c2:	00c50733          	add	a4,a0,a2
    src += n;
 2c6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2c8:	fec05ae3          	blez	a2,2bc <memmove+0x28>
 2cc:	fff6079b          	addiw	a5,a2,-1
 2d0:	1782                	slli	a5,a5,0x20
 2d2:	9381                	srli	a5,a5,0x20
 2d4:	fff7c793          	not	a5,a5
 2d8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2da:	15fd                	addi	a1,a1,-1
 2dc:	177d                	addi	a4,a4,-1
 2de:	0005c683          	lbu	a3,0(a1)
 2e2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2e6:	fee79ae3          	bne	a5,a4,2da <memmove+0x46>
 2ea:	bfc9                	j	2bc <memmove+0x28>

00000000000002ec <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f2:	ca05                	beqz	a2,322 <memcmp+0x36>
 2f4:	fff6069b          	addiw	a3,a2,-1
 2f8:	1682                	slli	a3,a3,0x20
 2fa:	9281                	srli	a3,a3,0x20
 2fc:	0685                	addi	a3,a3,1
 2fe:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 300:	00054783          	lbu	a5,0(a0)
 304:	0005c703          	lbu	a4,0(a1)
 308:	00e79863          	bne	a5,a4,318 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 30c:	0505                	addi	a0,a0,1
    p2++;
 30e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 310:	fed518e3          	bne	a0,a3,300 <memcmp+0x14>
  }
  return 0;
 314:	4501                	li	a0,0
 316:	a019                	j	31c <memcmp+0x30>
      return *p1 - *p2;
 318:	40e7853b          	subw	a0,a5,a4
}
 31c:	6422                	ld	s0,8(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret
  return 0;
 322:	4501                	li	a0,0
 324:	bfe5                	j	31c <memcmp+0x30>

0000000000000326 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 326:	1141                	addi	sp,sp,-16
 328:	e406                	sd	ra,8(sp)
 32a:	e022                	sd	s0,0(sp)
 32c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 32e:	f67ff0ef          	jal	294 <memmove>
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 340:	040007b7          	lui	a5,0x4000
 344:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffefed>
 346:	07b2                	slli	a5,a5,0xc
}
 348:	4388                	lw	a0,0(a5)
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 350:	4885                	li	a7,1
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <exit>:
.global exit
exit:
 li a7, SYS_exit
 358:	4889                	li	a7,2
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <wait>:
.global wait
wait:
 li a7, SYS_wait
 360:	488d                	li	a7,3
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 368:	4891                	li	a7,4
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <read>:
.global read
read:
 li a7, SYS_read
 370:	4895                	li	a7,5
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <write>:
.global write
write:
 li a7, SYS_write
 378:	48c1                	li	a7,16
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <close>:
.global close
close:
 li a7, SYS_close
 380:	48d5                	li	a7,21
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <kill>:
.global kill
kill:
 li a7, SYS_kill
 388:	4899                	li	a7,6
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <exec>:
.global exec
exec:
 li a7, SYS_exec
 390:	489d                	li	a7,7
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <open>:
.global open
open:
 li a7, SYS_open
 398:	48bd                	li	a7,15
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a0:	48c5                	li	a7,17
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a8:	48c9                	li	a7,18
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b0:	48a1                	li	a7,8
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <link>:
.global link
link:
 li a7, SYS_link
 3b8:	48cd                	li	a7,19
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c0:	48d1                	li	a7,20
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c8:	48a5                	li	a7,9
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d0:	48a9                	li	a7,10
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d8:	48ad                	li	a7,11
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e0:	48b1                	li	a7,12
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3e8:	48b5                	li	a7,13
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f0:	48b9                	li	a7,14
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <bind>:
.global bind
bind:
 li a7, SYS_bind
 3f8:	48f5                	li	a7,29
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 400:	48f9                	li	a7,30
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <send>:
.global send
send:
 li a7, SYS_send
 408:	48fd                	li	a7,31
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <recv>:
.global recv
recv:
 li a7, SYS_recv
 410:	02000893          	li	a7,32
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 41a:	02100893          	li	a7,33
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 424:	02200893          	li	a7,34
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 42e:	1101                	addi	sp,sp,-32
 430:	ec06                	sd	ra,24(sp)
 432:	e822                	sd	s0,16(sp)
 434:	1000                	addi	s0,sp,32
 436:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 43a:	4605                	li	a2,1
 43c:	fef40593          	addi	a1,s0,-17
 440:	f39ff0ef          	jal	378 <write>
}
 444:	60e2                	ld	ra,24(sp)
 446:	6442                	ld	s0,16(sp)
 448:	6105                	addi	sp,sp,32
 44a:	8082                	ret

000000000000044c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 44c:	7139                	addi	sp,sp,-64
 44e:	fc06                	sd	ra,56(sp)
 450:	f822                	sd	s0,48(sp)
 452:	f426                	sd	s1,40(sp)
 454:	0080                	addi	s0,sp,64
 456:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 458:	c299                	beqz	a3,45e <printint+0x12>
 45a:	0805c963          	bltz	a1,4ec <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 45e:	2581                	sext.w	a1,a1
  neg = 0;
 460:	4881                	li	a7,0
 462:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 466:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 468:	2601                	sext.w	a2,a2
 46a:	00000517          	auipc	a0,0x0
 46e:	53e50513          	addi	a0,a0,1342 # 9a8 <digits>
 472:	883a                	mv	a6,a4
 474:	2705                	addiw	a4,a4,1
 476:	02c5f7bb          	remuw	a5,a1,a2
 47a:	1782                	slli	a5,a5,0x20
 47c:	9381                	srli	a5,a5,0x20
 47e:	97aa                	add	a5,a5,a0
 480:	0007c783          	lbu	a5,0(a5)
 484:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 488:	0005879b          	sext.w	a5,a1
 48c:	02c5d5bb          	divuw	a1,a1,a2
 490:	0685                	addi	a3,a3,1
 492:	fec7f0e3          	bgeu	a5,a2,472 <printint+0x26>
  if(neg)
 496:	00088c63          	beqz	a7,4ae <printint+0x62>
    buf[i++] = '-';
 49a:	fd070793          	addi	a5,a4,-48
 49e:	00878733          	add	a4,a5,s0
 4a2:	02d00793          	li	a5,45
 4a6:	fef70823          	sb	a5,-16(a4)
 4aa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4ae:	02e05a63          	blez	a4,4e2 <printint+0x96>
 4b2:	f04a                	sd	s2,32(sp)
 4b4:	ec4e                	sd	s3,24(sp)
 4b6:	fc040793          	addi	a5,s0,-64
 4ba:	00e78933          	add	s2,a5,a4
 4be:	fff78993          	addi	s3,a5,-1
 4c2:	99ba                	add	s3,s3,a4
 4c4:	377d                	addiw	a4,a4,-1
 4c6:	1702                	slli	a4,a4,0x20
 4c8:	9301                	srli	a4,a4,0x20
 4ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4ce:	fff94583          	lbu	a1,-1(s2)
 4d2:	8526                	mv	a0,s1
 4d4:	f5bff0ef          	jal	42e <putc>
  while(--i >= 0)
 4d8:	197d                	addi	s2,s2,-1
 4da:	ff391ae3          	bne	s2,s3,4ce <printint+0x82>
 4de:	7902                	ld	s2,32(sp)
 4e0:	69e2                	ld	s3,24(sp)
}
 4e2:	70e2                	ld	ra,56(sp)
 4e4:	7442                	ld	s0,48(sp)
 4e6:	74a2                	ld	s1,40(sp)
 4e8:	6121                	addi	sp,sp,64
 4ea:	8082                	ret
    x = -xx;
 4ec:	40b005bb          	negw	a1,a1
    neg = 1;
 4f0:	4885                	li	a7,1
    x = -xx;
 4f2:	bf85                	j	462 <printint+0x16>

00000000000004f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4f4:	711d                	addi	sp,sp,-96
 4f6:	ec86                	sd	ra,88(sp)
 4f8:	e8a2                	sd	s0,80(sp)
 4fa:	e0ca                	sd	s2,64(sp)
 4fc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4fe:	0005c903          	lbu	s2,0(a1)
 502:	26090863          	beqz	s2,772 <vprintf+0x27e>
 506:	e4a6                	sd	s1,72(sp)
 508:	fc4e                	sd	s3,56(sp)
 50a:	f852                	sd	s4,48(sp)
 50c:	f456                	sd	s5,40(sp)
 50e:	f05a                	sd	s6,32(sp)
 510:	ec5e                	sd	s7,24(sp)
 512:	e862                	sd	s8,16(sp)
 514:	e466                	sd	s9,8(sp)
 516:	8b2a                	mv	s6,a0
 518:	8a2e                	mv	s4,a1
 51a:	8bb2                	mv	s7,a2
  state = 0;
 51c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 51e:	4481                	li	s1,0
 520:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 522:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 526:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 52a:	06c00c93          	li	s9,108
 52e:	a005                	j	54e <vprintf+0x5a>
        putc(fd, c0);
 530:	85ca                	mv	a1,s2
 532:	855a                	mv	a0,s6
 534:	efbff0ef          	jal	42e <putc>
 538:	a019                	j	53e <vprintf+0x4a>
    } else if(state == '%'){
 53a:	03598263          	beq	s3,s5,55e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 53e:	2485                	addiw	s1,s1,1
 540:	8726                	mv	a4,s1
 542:	009a07b3          	add	a5,s4,s1
 546:	0007c903          	lbu	s2,0(a5)
 54a:	20090c63          	beqz	s2,762 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 54e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 552:	fe0994e3          	bnez	s3,53a <vprintf+0x46>
      if(c0 == '%'){
 556:	fd579de3          	bne	a5,s5,530 <vprintf+0x3c>
        state = '%';
 55a:	89be                	mv	s3,a5
 55c:	b7cd                	j	53e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 55e:	00ea06b3          	add	a3,s4,a4
 562:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 566:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 568:	c681                	beqz	a3,570 <vprintf+0x7c>
 56a:	9752                	add	a4,a4,s4
 56c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 570:	03878f63          	beq	a5,s8,5ae <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 574:	05978963          	beq	a5,s9,5c6 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 578:	07500713          	li	a4,117
 57c:	0ee78363          	beq	a5,a4,662 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 580:	07800713          	li	a4,120
 584:	12e78563          	beq	a5,a4,6ae <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 588:	07000713          	li	a4,112
 58c:	14e78a63          	beq	a5,a4,6e0 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 590:	07300713          	li	a4,115
 594:	18e78a63          	beq	a5,a4,728 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 598:	02500713          	li	a4,37
 59c:	04e79563          	bne	a5,a4,5e6 <vprintf+0xf2>
        putc(fd, '%');
 5a0:	02500593          	li	a1,37
 5a4:	855a                	mv	a0,s6
 5a6:	e89ff0ef          	jal	42e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	bf49                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5ae:	008b8913          	addi	s2,s7,8
 5b2:	4685                	li	a3,1
 5b4:	4629                	li	a2,10
 5b6:	000ba583          	lw	a1,0(s7)
 5ba:	855a                	mv	a0,s6
 5bc:	e91ff0ef          	jal	44c <printint>
 5c0:	8bca                	mv	s7,s2
      state = 0;
 5c2:	4981                	li	s3,0
 5c4:	bfad                	j	53e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5c6:	06400793          	li	a5,100
 5ca:	02f68963          	beq	a3,a5,5fc <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5ce:	06c00793          	li	a5,108
 5d2:	04f68263          	beq	a3,a5,616 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 5d6:	07500793          	li	a5,117
 5da:	0af68063          	beq	a3,a5,67a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 5de:	07800793          	li	a5,120
 5e2:	0ef68263          	beq	a3,a5,6c6 <vprintf+0x1d2>
        putc(fd, '%');
 5e6:	02500593          	li	a1,37
 5ea:	855a                	mv	a0,s6
 5ec:	e43ff0ef          	jal	42e <putc>
        putc(fd, c0);
 5f0:	85ca                	mv	a1,s2
 5f2:	855a                	mv	a0,s6
 5f4:	e3bff0ef          	jal	42e <putc>
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	b791                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5fc:	008b8913          	addi	s2,s7,8
 600:	4685                	li	a3,1
 602:	4629                	li	a2,10
 604:	000ba583          	lw	a1,0(s7)
 608:	855a                	mv	a0,s6
 60a:	e43ff0ef          	jal	44c <printint>
        i += 1;
 60e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 610:	8bca                	mv	s7,s2
      state = 0;
 612:	4981                	li	s3,0
        i += 1;
 614:	b72d                	j	53e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 616:	06400793          	li	a5,100
 61a:	02f60763          	beq	a2,a5,648 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 61e:	07500793          	li	a5,117
 622:	06f60963          	beq	a2,a5,694 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 626:	07800793          	li	a5,120
 62a:	faf61ee3          	bne	a2,a5,5e6 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 62e:	008b8913          	addi	s2,s7,8
 632:	4681                	li	a3,0
 634:	4641                	li	a2,16
 636:	000ba583          	lw	a1,0(s7)
 63a:	855a                	mv	a0,s6
 63c:	e11ff0ef          	jal	44c <printint>
        i += 2;
 640:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 642:	8bca                	mv	s7,s2
      state = 0;
 644:	4981                	li	s3,0
        i += 2;
 646:	bde5                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 648:	008b8913          	addi	s2,s7,8
 64c:	4685                	li	a3,1
 64e:	4629                	li	a2,10
 650:	000ba583          	lw	a1,0(s7)
 654:	855a                	mv	a0,s6
 656:	df7ff0ef          	jal	44c <printint>
        i += 2;
 65a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 65c:	8bca                	mv	s7,s2
      state = 0;
 65e:	4981                	li	s3,0
        i += 2;
 660:	bdf9                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 662:	008b8913          	addi	s2,s7,8
 666:	4681                	li	a3,0
 668:	4629                	li	a2,10
 66a:	000ba583          	lw	a1,0(s7)
 66e:	855a                	mv	a0,s6
 670:	dddff0ef          	jal	44c <printint>
 674:	8bca                	mv	s7,s2
      state = 0;
 676:	4981                	li	s3,0
 678:	b5d9                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 67a:	008b8913          	addi	s2,s7,8
 67e:	4681                	li	a3,0
 680:	4629                	li	a2,10
 682:	000ba583          	lw	a1,0(s7)
 686:	855a                	mv	a0,s6
 688:	dc5ff0ef          	jal	44c <printint>
        i += 1;
 68c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 68e:	8bca                	mv	s7,s2
      state = 0;
 690:	4981                	li	s3,0
        i += 1;
 692:	b575                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 694:	008b8913          	addi	s2,s7,8
 698:	4681                	li	a3,0
 69a:	4629                	li	a2,10
 69c:	000ba583          	lw	a1,0(s7)
 6a0:	855a                	mv	a0,s6
 6a2:	dabff0ef          	jal	44c <printint>
        i += 2;
 6a6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a8:	8bca                	mv	s7,s2
      state = 0;
 6aa:	4981                	li	s3,0
        i += 2;
 6ac:	bd49                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6ae:	008b8913          	addi	s2,s7,8
 6b2:	4681                	li	a3,0
 6b4:	4641                	li	a2,16
 6b6:	000ba583          	lw	a1,0(s7)
 6ba:	855a                	mv	a0,s6
 6bc:	d91ff0ef          	jal	44c <printint>
 6c0:	8bca                	mv	s7,s2
      state = 0;
 6c2:	4981                	li	s3,0
 6c4:	bdad                	j	53e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c6:	008b8913          	addi	s2,s7,8
 6ca:	4681                	li	a3,0
 6cc:	4641                	li	a2,16
 6ce:	000ba583          	lw	a1,0(s7)
 6d2:	855a                	mv	a0,s6
 6d4:	d79ff0ef          	jal	44c <printint>
        i += 1;
 6d8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6da:	8bca                	mv	s7,s2
      state = 0;
 6dc:	4981                	li	s3,0
        i += 1;
 6de:	b585                	j	53e <vprintf+0x4a>
 6e0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6e2:	008b8d13          	addi	s10,s7,8
 6e6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6ea:	03000593          	li	a1,48
 6ee:	855a                	mv	a0,s6
 6f0:	d3fff0ef          	jal	42e <putc>
  putc(fd, 'x');
 6f4:	07800593          	li	a1,120
 6f8:	855a                	mv	a0,s6
 6fa:	d35ff0ef          	jal	42e <putc>
 6fe:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 700:	00000b97          	auipc	s7,0x0
 704:	2a8b8b93          	addi	s7,s7,680 # 9a8 <digits>
 708:	03c9d793          	srli	a5,s3,0x3c
 70c:	97de                	add	a5,a5,s7
 70e:	0007c583          	lbu	a1,0(a5)
 712:	855a                	mv	a0,s6
 714:	d1bff0ef          	jal	42e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 718:	0992                	slli	s3,s3,0x4
 71a:	397d                	addiw	s2,s2,-1
 71c:	fe0916e3          	bnez	s2,708 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 720:	8bea                	mv	s7,s10
      state = 0;
 722:	4981                	li	s3,0
 724:	6d02                	ld	s10,0(sp)
 726:	bd21                	j	53e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 728:	008b8993          	addi	s3,s7,8
 72c:	000bb903          	ld	s2,0(s7)
 730:	00090f63          	beqz	s2,74e <vprintf+0x25a>
        for(; *s; s++)
 734:	00094583          	lbu	a1,0(s2)
 738:	c195                	beqz	a1,75c <vprintf+0x268>
          putc(fd, *s);
 73a:	855a                	mv	a0,s6
 73c:	cf3ff0ef          	jal	42e <putc>
        for(; *s; s++)
 740:	0905                	addi	s2,s2,1
 742:	00094583          	lbu	a1,0(s2)
 746:	f9f5                	bnez	a1,73a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 748:	8bce                	mv	s7,s3
      state = 0;
 74a:	4981                	li	s3,0
 74c:	bbcd                	j	53e <vprintf+0x4a>
          s = "(null)";
 74e:	00000917          	auipc	s2,0x0
 752:	25290913          	addi	s2,s2,594 # 9a0 <malloc+0x146>
        for(; *s; s++)
 756:	02800593          	li	a1,40
 75a:	b7c5                	j	73a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 75c:	8bce                	mv	s7,s3
      state = 0;
 75e:	4981                	li	s3,0
 760:	bbf9                	j	53e <vprintf+0x4a>
 762:	64a6                	ld	s1,72(sp)
 764:	79e2                	ld	s3,56(sp)
 766:	7a42                	ld	s4,48(sp)
 768:	7aa2                	ld	s5,40(sp)
 76a:	7b02                	ld	s6,32(sp)
 76c:	6be2                	ld	s7,24(sp)
 76e:	6c42                	ld	s8,16(sp)
 770:	6ca2                	ld	s9,8(sp)
    }
  }
}
 772:	60e6                	ld	ra,88(sp)
 774:	6446                	ld	s0,80(sp)
 776:	6906                	ld	s2,64(sp)
 778:	6125                	addi	sp,sp,96
 77a:	8082                	ret

000000000000077c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 77c:	715d                	addi	sp,sp,-80
 77e:	ec06                	sd	ra,24(sp)
 780:	e822                	sd	s0,16(sp)
 782:	1000                	addi	s0,sp,32
 784:	e010                	sd	a2,0(s0)
 786:	e414                	sd	a3,8(s0)
 788:	e818                	sd	a4,16(s0)
 78a:	ec1c                	sd	a5,24(s0)
 78c:	03043023          	sd	a6,32(s0)
 790:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 794:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 798:	8622                	mv	a2,s0
 79a:	d5bff0ef          	jal	4f4 <vprintf>
}
 79e:	60e2                	ld	ra,24(sp)
 7a0:	6442                	ld	s0,16(sp)
 7a2:	6161                	addi	sp,sp,80
 7a4:	8082                	ret

00000000000007a6 <printf>:

void
printf(const char *fmt, ...)
{
 7a6:	711d                	addi	sp,sp,-96
 7a8:	ec06                	sd	ra,24(sp)
 7aa:	e822                	sd	s0,16(sp)
 7ac:	1000                	addi	s0,sp,32
 7ae:	e40c                	sd	a1,8(s0)
 7b0:	e810                	sd	a2,16(s0)
 7b2:	ec14                	sd	a3,24(s0)
 7b4:	f018                	sd	a4,32(s0)
 7b6:	f41c                	sd	a5,40(s0)
 7b8:	03043823          	sd	a6,48(s0)
 7bc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7c0:	00840613          	addi	a2,s0,8
 7c4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7c8:	85aa                	mv	a1,a0
 7ca:	4505                	li	a0,1
 7cc:	d29ff0ef          	jal	4f4 <vprintf>
}
 7d0:	60e2                	ld	ra,24(sp)
 7d2:	6442                	ld	s0,16(sp)
 7d4:	6125                	addi	sp,sp,96
 7d6:	8082                	ret

00000000000007d8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d8:	1141                	addi	sp,sp,-16
 7da:	e422                	sd	s0,8(sp)
 7dc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7de:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e2:	00001797          	auipc	a5,0x1
 7e6:	81e7b783          	ld	a5,-2018(a5) # 1000 <freep>
 7ea:	a02d                	j	814 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7ec:	4618                	lw	a4,8(a2)
 7ee:	9f2d                	addw	a4,a4,a1
 7f0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f4:	6398                	ld	a4,0(a5)
 7f6:	6310                	ld	a2,0(a4)
 7f8:	a83d                	j	836 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7fa:	ff852703          	lw	a4,-8(a0)
 7fe:	9f31                	addw	a4,a4,a2
 800:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 802:	ff053683          	ld	a3,-16(a0)
 806:	a091                	j	84a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 808:	6398                	ld	a4,0(a5)
 80a:	00e7e463          	bltu	a5,a4,812 <free+0x3a>
 80e:	00e6ea63          	bltu	a3,a4,822 <free+0x4a>
{
 812:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 814:	fed7fae3          	bgeu	a5,a3,808 <free+0x30>
 818:	6398                	ld	a4,0(a5)
 81a:	00e6e463          	bltu	a3,a4,822 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81e:	fee7eae3          	bltu	a5,a4,812 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 822:	ff852583          	lw	a1,-8(a0)
 826:	6390                	ld	a2,0(a5)
 828:	02059813          	slli	a6,a1,0x20
 82c:	01c85713          	srli	a4,a6,0x1c
 830:	9736                	add	a4,a4,a3
 832:	fae60de3          	beq	a2,a4,7ec <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 836:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 83a:	4790                	lw	a2,8(a5)
 83c:	02061593          	slli	a1,a2,0x20
 840:	01c5d713          	srli	a4,a1,0x1c
 844:	973e                	add	a4,a4,a5
 846:	fae68ae3          	beq	a3,a4,7fa <free+0x22>
    p->s.ptr = bp->s.ptr;
 84a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 84c:	00000717          	auipc	a4,0x0
 850:	7af73a23          	sd	a5,1972(a4) # 1000 <freep>
}
 854:	6422                	ld	s0,8(sp)
 856:	0141                	addi	sp,sp,16
 858:	8082                	ret

000000000000085a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 85a:	7139                	addi	sp,sp,-64
 85c:	fc06                	sd	ra,56(sp)
 85e:	f822                	sd	s0,48(sp)
 860:	f426                	sd	s1,40(sp)
 862:	ec4e                	sd	s3,24(sp)
 864:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 866:	02051493          	slli	s1,a0,0x20
 86a:	9081                	srli	s1,s1,0x20
 86c:	04bd                	addi	s1,s1,15
 86e:	8091                	srli	s1,s1,0x4
 870:	0014899b          	addiw	s3,s1,1
 874:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 876:	00000517          	auipc	a0,0x0
 87a:	78a53503          	ld	a0,1930(a0) # 1000 <freep>
 87e:	c915                	beqz	a0,8b2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 880:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 882:	4798                	lw	a4,8(a5)
 884:	08977a63          	bgeu	a4,s1,918 <malloc+0xbe>
 888:	f04a                	sd	s2,32(sp)
 88a:	e852                	sd	s4,16(sp)
 88c:	e456                	sd	s5,8(sp)
 88e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 890:	8a4e                	mv	s4,s3
 892:	0009871b          	sext.w	a4,s3
 896:	6685                	lui	a3,0x1
 898:	00d77363          	bgeu	a4,a3,89e <malloc+0x44>
 89c:	6a05                	lui	s4,0x1
 89e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8a2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a6:	00000917          	auipc	s2,0x0
 8aa:	75a90913          	addi	s2,s2,1882 # 1000 <freep>
  if(p == (char*)-1)
 8ae:	5afd                	li	s5,-1
 8b0:	a081                	j	8f0 <malloc+0x96>
 8b2:	f04a                	sd	s2,32(sp)
 8b4:	e852                	sd	s4,16(sp)
 8b6:	e456                	sd	s5,8(sp)
 8b8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ba:	00000797          	auipc	a5,0x0
 8be:	75678793          	addi	a5,a5,1878 # 1010 <base>
 8c2:	00000717          	auipc	a4,0x0
 8c6:	72f73f23          	sd	a5,1854(a4) # 1000 <freep>
 8ca:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8cc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8d0:	b7c1                	j	890 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8d2:	6398                	ld	a4,0(a5)
 8d4:	e118                	sd	a4,0(a0)
 8d6:	a8a9                	j	930 <malloc+0xd6>
  hp->s.size = nu;
 8d8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8dc:	0541                	addi	a0,a0,16
 8de:	efbff0ef          	jal	7d8 <free>
  return freep;
 8e2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8e6:	c12d                	beqz	a0,948 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ea:	4798                	lw	a4,8(a5)
 8ec:	02977263          	bgeu	a4,s1,910 <malloc+0xb6>
    if(p == freep)
 8f0:	00093703          	ld	a4,0(s2)
 8f4:	853e                	mv	a0,a5
 8f6:	fef719e3          	bne	a4,a5,8e8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 8fa:	8552                	mv	a0,s4
 8fc:	ae5ff0ef          	jal	3e0 <sbrk>
  if(p == (char*)-1)
 900:	fd551ce3          	bne	a0,s5,8d8 <malloc+0x7e>
        return 0;
 904:	4501                	li	a0,0
 906:	7902                	ld	s2,32(sp)
 908:	6a42                	ld	s4,16(sp)
 90a:	6aa2                	ld	s5,8(sp)
 90c:	6b02                	ld	s6,0(sp)
 90e:	a03d                	j	93c <malloc+0xe2>
 910:	7902                	ld	s2,32(sp)
 912:	6a42                	ld	s4,16(sp)
 914:	6aa2                	ld	s5,8(sp)
 916:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 918:	fae48de3          	beq	s1,a4,8d2 <malloc+0x78>
        p->s.size -= nunits;
 91c:	4137073b          	subw	a4,a4,s3
 920:	c798                	sw	a4,8(a5)
        p += p->s.size;
 922:	02071693          	slli	a3,a4,0x20
 926:	01c6d713          	srli	a4,a3,0x1c
 92a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 92c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 930:	00000717          	auipc	a4,0x0
 934:	6ca73823          	sd	a0,1744(a4) # 1000 <freep>
      return (void*)(p + 1);
 938:	01078513          	addi	a0,a5,16
  }
}
 93c:	70e2                	ld	ra,56(sp)
 93e:	7442                	ld	s0,48(sp)
 940:	74a2                	ld	s1,40(sp)
 942:	69e2                	ld	s3,24(sp)
 944:	6121                	addi	sp,sp,64
 946:	8082                	ret
 948:	7902                	ld	s2,32(sp)
 94a:	6a42                	ld	s4,16(sp)
 94c:	6aa2                	ld	s5,8(sp)
 94e:	6b02                	ld	s6,0(sp)
 950:	b7f5                	j	93c <malloc+0xe2>
