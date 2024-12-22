
user/_pgtbltest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <err>:

char *testname = "???";

void
err(char *why)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
  printf("pgtbltest: %s failed: %s, pid=%d\n", testname, why, getpid());
   e:	00002917          	auipc	s2,0x2
  12:	ff293903          	ld	s2,-14(s2) # 2000 <testname>
  16:	5b8000ef          	jal	5ce <getpid>
  1a:	86aa                	mv	a3,a0
  1c:	8626                	mv	a2,s1
  1e:	85ca                	mv	a1,s2
  20:	00001517          	auipc	a0,0x1
  24:	b3050513          	addi	a0,a0,-1232 # b50 <malloc+0x100>
  28:	175000ef          	jal	99c <printf>
  exit(1);
  2c:	4505                	li	a0,1
  2e:	520000ef          	jal	54e <exit>

0000000000000032 <print_pte>:
}

void
print_pte(uint64 va)
{
  32:	1101                	addi	sp,sp,-32
  34:	ec06                	sd	ra,24(sp)
  36:	e822                	sd	s0,16(sp)
  38:	e426                	sd	s1,8(sp)
  3a:	1000                	addi	s0,sp,32
  3c:	84aa                	mv	s1,a0
    pte_t pte = (pte_t) pgpte((void *) va);
  3e:	5d2000ef          	jal	610 <pgpte>
  42:	862a                	mv	a2,a0
    printf("va 0x%lx pte 0x%lx pa 0x%lx perm 0x%lx\n", va, pte, PTE2PA(pte), PTE_FLAGS(pte));
  44:	00a55693          	srli	a3,a0,0xa
  48:	3ff57713          	andi	a4,a0,1023
  4c:	06b2                	slli	a3,a3,0xc
  4e:	85a6                	mv	a1,s1
  50:	00001517          	auipc	a0,0x1
  54:	b2850513          	addi	a0,a0,-1240 # b78 <malloc+0x128>
  58:	145000ef          	jal	99c <printf>
}
  5c:	60e2                	ld	ra,24(sp)
  5e:	6442                	ld	s0,16(sp)
  60:	64a2                	ld	s1,8(sp)
  62:	6105                	addi	sp,sp,32
  64:	8082                	ret

0000000000000066 <print_pgtbl>:

void
print_pgtbl()
{
  66:	7179                	addi	sp,sp,-48
  68:	f406                	sd	ra,40(sp)
  6a:	f022                	sd	s0,32(sp)
  6c:	ec26                	sd	s1,24(sp)
  6e:	e84a                	sd	s2,16(sp)
  70:	e44e                	sd	s3,8(sp)
  72:	1800                	addi	s0,sp,48
  printf("print_pgtbl starting\n");
  74:	00001517          	auipc	a0,0x1
  78:	b2c50513          	addi	a0,a0,-1236 # ba0 <malloc+0x150>
  7c:	121000ef          	jal	99c <printf>
  80:	4481                	li	s1,0
  for (uint64 i = 0; i < 10; i++) {
  82:	6985                	lui	s3,0x1
  84:	6929                	lui	s2,0xa
    print_pte(i * PGSIZE);
  86:	8526                	mv	a0,s1
  88:	fabff0ef          	jal	32 <print_pte>
  for (uint64 i = 0; i < 10; i++) {
  8c:	94ce                	add	s1,s1,s3
  8e:	ff249ce3          	bne	s1,s2,86 <print_pgtbl+0x20>
  92:	020004b7          	lui	s1,0x2000
  96:	14ed                	addi	s1,s1,-5 # 1fffffb <base+0x1ffdfdb>
  98:	04b6                	slli	s1,s1,0xd
  }
  uint64 top = MAXVA/PGSIZE;
  for (uint64 i = top-10; i < top; i++) {
  9a:	6985                	lui	s3,0x1
  9c:	4905                	li	s2,1
  9e:	191a                	slli	s2,s2,0x26
    print_pte(i * PGSIZE);
  a0:	8526                	mv	a0,s1
  a2:	f91ff0ef          	jal	32 <print_pte>
  for (uint64 i = top-10; i < top; i++) {
  a6:	94ce                	add	s1,s1,s3
  a8:	ff249ce3          	bne	s1,s2,a0 <print_pgtbl+0x3a>
  }
  printf("print_pgtbl: OK\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	b0c50513          	addi	a0,a0,-1268 # bb8 <malloc+0x168>
  b4:	0e9000ef          	jal	99c <printf>
}
  b8:	70a2                	ld	ra,40(sp)
  ba:	7402                	ld	s0,32(sp)
  bc:	64e2                	ld	s1,24(sp)
  be:	6942                	ld	s2,16(sp)
  c0:	69a2                	ld	s3,8(sp)
  c2:	6145                	addi	sp,sp,48
  c4:	8082                	ret

00000000000000c6 <ugetpid_test>:

void
ugetpid_test()
{
  c6:	7179                	addi	sp,sp,-48
  c8:	f406                	sd	ra,40(sp)
  ca:	f022                	sd	s0,32(sp)
  cc:	ec26                	sd	s1,24(sp)
  ce:	1800                	addi	s0,sp,48
  int i;

  printf("ugetpid_test starting\n");
  d0:	00001517          	auipc	a0,0x1
  d4:	b0050513          	addi	a0,a0,-1280 # bd0 <malloc+0x180>
  d8:	0c5000ef          	jal	99c <printf>
  testname = "ugetpid_test";
  dc:	00001797          	auipc	a5,0x1
  e0:	b0c78793          	addi	a5,a5,-1268 # be8 <malloc+0x198>
  e4:	00002717          	auipc	a4,0x2
  e8:	f0f73e23          	sd	a5,-228(a4) # 2000 <testname>
  ec:	04000493          	li	s1,64

  for (i = 0; i < 64; i++) {
    int ret = fork();
  f0:	456000ef          	jal	546 <fork>
  f4:	fca42e23          	sw	a0,-36(s0)
    if (ret != 0) {
  f8:	c905                	beqz	a0,128 <ugetpid_test+0x62>
      wait(&ret);
  fa:	fdc40513          	addi	a0,s0,-36
  fe:	458000ef          	jal	556 <wait>
      if (ret != 0)
 102:	fdc42783          	lw	a5,-36(s0)
 106:	ef91                	bnez	a5,122 <ugetpid_test+0x5c>
  for (i = 0; i < 64; i++) {
 108:	34fd                	addiw	s1,s1,-1
 10a:	f0fd                	bnez	s1,f0 <ugetpid_test+0x2a>
    }
    if (getpid() != ugetpid())
      err("missmatched PID");
    exit(0);
  }
  printf("ugetpid_test: OK\n");
 10c:	00001517          	auipc	a0,0x1
 110:	afc50513          	addi	a0,a0,-1284 # c08 <malloc+0x1b8>
 114:	089000ef          	jal	99c <printf>
}
 118:	70a2                	ld	ra,40(sp)
 11a:	7402                	ld	s0,32(sp)
 11c:	64e2                	ld	s1,24(sp)
 11e:	6145                	addi	sp,sp,48
 120:	8082                	ret
        exit(1);
 122:	4505                	li	a0,1
 124:	42a000ef          	jal	54e <exit>
    if (getpid() != ugetpid())
 128:	4a6000ef          	jal	5ce <getpid>
 12c:	84aa                	mv	s1,a0
 12e:	402000ef          	jal	530 <ugetpid>
 132:	00a48863          	beq	s1,a0,142 <ugetpid_test+0x7c>
      err("missmatched PID");
 136:	00001517          	auipc	a0,0x1
 13a:	ac250513          	addi	a0,a0,-1342 # bf8 <malloc+0x1a8>
 13e:	ec3ff0ef          	jal	0 <err>
    exit(0);
 142:	4501                	li	a0,0
 144:	40a000ef          	jal	54e <exit>

0000000000000148 <print_kpgtbl>:

void
print_kpgtbl()
{
 148:	1141                	addi	sp,sp,-16
 14a:	e406                	sd	ra,8(sp)
 14c:	e022                	sd	s0,0(sp)
 14e:	0800                	addi	s0,sp,16
  printf("print_kpgtbl starting\n");
 150:	00001517          	auipc	a0,0x1
 154:	ad050513          	addi	a0,a0,-1328 # c20 <malloc+0x1d0>
 158:	045000ef          	jal	99c <printf>
  kpgtbl();
 15c:	4be000ef          	jal	61a <kpgtbl>
  printf("print_kpgtbl: OK\n");
 160:	00001517          	auipc	a0,0x1
 164:	ad850513          	addi	a0,a0,-1320 # c38 <malloc+0x1e8>
 168:	035000ef          	jal	99c <printf>
}
 16c:	60a2                	ld	ra,8(sp)
 16e:	6402                	ld	s0,0(sp)
 170:	0141                	addi	sp,sp,16
 172:	8082                	ret

0000000000000174 <supercheck>:


void
supercheck(uint64 s)
{
 174:	7139                	addi	sp,sp,-64
 176:	fc06                	sd	ra,56(sp)
 178:	f822                	sd	s0,48(sp)
 17a:	ec4e                	sd	s3,24(sp)
 17c:	e05a                	sd	s6,0(sp)
 17e:	0080                	addi	s0,sp,64
 180:	8b2a                	mv	s6,a0
  pte_t last_pte = 0;

  for (uint64 p = s;  p < s + 512 * PGSIZE; p += PGSIZE) {
 182:	002009b7          	lui	s3,0x200
 186:	99aa                	add	s3,s3,a0
 188:	ffe007b7          	lui	a5,0xffe00
 18c:	06f57163          	bgeu	a0,a5,1ee <supercheck+0x7a>
 190:	f426                	sd	s1,40(sp)
 192:	f04a                	sd	s2,32(sp)
 194:	e852                	sd	s4,16(sp)
 196:	e456                	sd	s5,8(sp)
 198:	84aa                	mv	s1,a0
  pte_t last_pte = 0;
 19a:	4501                	li	a0,0
    if(pte == 0)
      err("no pte");
    if ((uint64) last_pte != 0 && pte != last_pte) {
        err("pte different");
    }
    if((pte & PTE_V) == 0 || (pte & PTE_R) == 0 || (pte & PTE_W) == 0){
 19c:	4a9d                	li	s5,7
  for (uint64 p = s;  p < s + 512 * PGSIZE; p += PGSIZE) {
 19e:	6a05                	lui	s4,0x1
 1a0:	a831                	j	1bc <supercheck+0x48>
      err("no pte");
 1a2:	00001517          	auipc	a0,0x1
 1a6:	aae50513          	addi	a0,a0,-1362 # c50 <malloc+0x200>
 1aa:	e57ff0ef          	jal	0 <err>
    if((pte & PTE_V) == 0 || (pte & PTE_R) == 0 || (pte & PTE_W) == 0){
 1ae:	00757793          	andi	a5,a0,7
 1b2:	03579463          	bne	a5,s5,1da <supercheck+0x66>
  for (uint64 p = s;  p < s + 512 * PGSIZE; p += PGSIZE) {
 1b6:	94d2                	add	s1,s1,s4
 1b8:	0334f763          	bgeu	s1,s3,1e6 <supercheck+0x72>
    pte_t pte = (pte_t) pgpte((void *) p);
 1bc:	892a                	mv	s2,a0
 1be:	8526                	mv	a0,s1
 1c0:	450000ef          	jal	610 <pgpte>
    if(pte == 0)
 1c4:	dd79                	beqz	a0,1a2 <supercheck+0x2e>
    if ((uint64) last_pte != 0 && pte != last_pte) {
 1c6:	fe0904e3          	beqz	s2,1ae <supercheck+0x3a>
 1ca:	ff2502e3          	beq	a0,s2,1ae <supercheck+0x3a>
        err("pte different");
 1ce:	00001517          	auipc	a0,0x1
 1d2:	a8a50513          	addi	a0,a0,-1398 # c58 <malloc+0x208>
 1d6:	e2bff0ef          	jal	0 <err>
      err("pte wrong");
 1da:	00001517          	auipc	a0,0x1
 1de:	a8e50513          	addi	a0,a0,-1394 # c68 <malloc+0x218>
 1e2:	e1fff0ef          	jal	0 <err>
 1e6:	74a2                	ld	s1,40(sp)
 1e8:	7902                	ld	s2,32(sp)
 1ea:	6a42                	ld	s4,16(sp)
 1ec:	6aa2                	ld	s5,8(sp)
    }
    last_pte = pte;
  }

  for(int i = 0; i < 512; i += PGSIZE){
    *(int*)(s+i) = i;
 1ee:	000b2023          	sw	zero,0(s6)

  for(int i = 0; i < 512; i += PGSIZE){
    if(*(int*)(s+i) != i)
      err("wrong value");
  }
}
 1f2:	70e2                	ld	ra,56(sp)
 1f4:	7442                	ld	s0,48(sp)
 1f6:	69e2                	ld	s3,24(sp)
 1f8:	6b02                	ld	s6,0(sp)
 1fa:	6121                	addi	sp,sp,64
 1fc:	8082                	ret

00000000000001fe <superpg_test>:

void
superpg_test()
{
 1fe:	7179                	addi	sp,sp,-48
 200:	f406                	sd	ra,40(sp)
 202:	f022                	sd	s0,32(sp)
 204:	ec26                	sd	s1,24(sp)
 206:	1800                	addi	s0,sp,48
  int pid;
  
  printf("superpg_test starting\n");
 208:	00001517          	auipc	a0,0x1
 20c:	a7050513          	addi	a0,a0,-1424 # c78 <malloc+0x228>
 210:	78c000ef          	jal	99c <printf>
  testname = "superpg_test";
 214:	00001797          	auipc	a5,0x1
 218:	a7c78793          	addi	a5,a5,-1412 # c90 <malloc+0x240>
 21c:	00002717          	auipc	a4,0x2
 220:	def73223          	sd	a5,-540(a4) # 2000 <testname>
  
  char *end = sbrk(N);
 224:	00800537          	lui	a0,0x800
 228:	3ae000ef          	jal	5d6 <sbrk>
  if (end == 0 || end == (char*)0xffffffffffffffff)
 22c:	fff50713          	addi	a4,a0,-1 # 7fffff <base+0x7fdfdf>
 230:	57f5                	li	a5,-3
 232:	04e7e463          	bltu	a5,a4,27a <superpg_test+0x7c>
    err("sbrk failed");
  
  uint64 s = SUPERPGROUNDUP((uint64) end);
 236:	002007b7          	lui	a5,0x200
 23a:	17fd                	addi	a5,a5,-1 # 1fffff <base+0x1fdfdf>
 23c:	953e                	add	a0,a0,a5
 23e:	ffe007b7          	lui	a5,0xffe00
 242:	00f574b3          	and	s1,a0,a5
  supercheck(s);
 246:	8526                	mv	a0,s1
 248:	f2dff0ef          	jal	174 <supercheck>
  if((pid = fork()) < 0) {
 24c:	2fa000ef          	jal	546 <fork>
 250:	02054b63          	bltz	a0,286 <superpg_test+0x88>
    err("fork");
  } else if(pid == 0) {
 254:	cd1d                	beqz	a0,292 <superpg_test+0x94>
    supercheck(s);
    exit(0);
  } else {
    int status;
    wait(&status);
 256:	fdc40513          	addi	a0,s0,-36
 25a:	2fc000ef          	jal	556 <wait>
    if (status != 0) {
 25e:	fdc42783          	lw	a5,-36(s0)
 262:	ef95                	bnez	a5,29e <superpg_test+0xa0>
      exit(0);
    }
  }
  printf("superpg_test: OK\n");  
 264:	00001517          	auipc	a0,0x1
 268:	a5450513          	addi	a0,a0,-1452 # cb8 <malloc+0x268>
 26c:	730000ef          	jal	99c <printf>
}
 270:	70a2                	ld	ra,40(sp)
 272:	7402                	ld	s0,32(sp)
 274:	64e2                	ld	s1,24(sp)
 276:	6145                	addi	sp,sp,48
 278:	8082                	ret
    err("sbrk failed");
 27a:	00001517          	auipc	a0,0x1
 27e:	a2650513          	addi	a0,a0,-1498 # ca0 <malloc+0x250>
 282:	d7fff0ef          	jal	0 <err>
    err("fork");
 286:	00001517          	auipc	a0,0x1
 28a:	a2a50513          	addi	a0,a0,-1494 # cb0 <malloc+0x260>
 28e:	d73ff0ef          	jal	0 <err>
    supercheck(s);
 292:	8526                	mv	a0,s1
 294:	ee1ff0ef          	jal	174 <supercheck>
    exit(0);
 298:	4501                	li	a0,0
 29a:	2b4000ef          	jal	54e <exit>
      exit(0);
 29e:	4501                	li	a0,0
 2a0:	2ae000ef          	jal	54e <exit>

00000000000002a4 <main>:
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e406                	sd	ra,8(sp)
 2a8:	e022                	sd	s0,0(sp)
 2aa:	0800                	addi	s0,sp,16
  print_pgtbl();
 2ac:	dbbff0ef          	jal	66 <print_pgtbl>
  ugetpid_test();
 2b0:	e17ff0ef          	jal	c6 <ugetpid_test>
  print_kpgtbl();
 2b4:	e95ff0ef          	jal	148 <print_kpgtbl>
  superpg_test();
 2b8:	f47ff0ef          	jal	1fe <superpg_test>
  printf("pgtbltest: all tests succeeded\n");
 2bc:	00001517          	auipc	a0,0x1
 2c0:	a1450513          	addi	a0,a0,-1516 # cd0 <malloc+0x280>
 2c4:	6d8000ef          	jal	99c <printf>
  exit(0);
 2c8:	4501                	li	a0,0
 2ca:	284000ef          	jal	54e <exit>

00000000000002ce <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2d6:	fcfff0ef          	jal	2a4 <main>
  exit(0);
 2da:	4501                	li	a0,0
 2dc:	272000ef          	jal	54e <exit>

00000000000002e0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e6:	87aa                	mv	a5,a0
 2e8:	0585                	addi	a1,a1,1
 2ea:	0785                	addi	a5,a5,1 # ffffffffffe00001 <base+0xffffffffffdfdfe1>
 2ec:	fff5c703          	lbu	a4,-1(a1)
 2f0:	fee78fa3          	sb	a4,-1(a5)
 2f4:	fb75                	bnez	a4,2e8 <strcpy+0x8>
    ;
  return os;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret

00000000000002fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 302:	00054783          	lbu	a5,0(a0)
 306:	cb91                	beqz	a5,31a <strcmp+0x1e>
 308:	0005c703          	lbu	a4,0(a1)
 30c:	00f71763          	bne	a4,a5,31a <strcmp+0x1e>
    p++, q++;
 310:	0505                	addi	a0,a0,1
 312:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 314:	00054783          	lbu	a5,0(a0)
 318:	fbe5                	bnez	a5,308 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 31a:	0005c503          	lbu	a0,0(a1)
}
 31e:	40a7853b          	subw	a0,a5,a0
 322:	6422                	ld	s0,8(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret

0000000000000328 <strlen>:

uint
strlen(const char *s)
{
 328:	1141                	addi	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 32e:	00054783          	lbu	a5,0(a0)
 332:	cf91                	beqz	a5,34e <strlen+0x26>
 334:	0505                	addi	a0,a0,1
 336:	87aa                	mv	a5,a0
 338:	86be                	mv	a3,a5
 33a:	0785                	addi	a5,a5,1
 33c:	fff7c703          	lbu	a4,-1(a5)
 340:	ff65                	bnez	a4,338 <strlen+0x10>
 342:	40a6853b          	subw	a0,a3,a0
 346:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 348:	6422                	ld	s0,8(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret
  for(n = 0; s[n]; n++)
 34e:	4501                	li	a0,0
 350:	bfe5                	j	348 <strlen+0x20>

0000000000000352 <memset>:

void*
memset(void *dst, int c, uint n)
{
 352:	1141                	addi	sp,sp,-16
 354:	e422                	sd	s0,8(sp)
 356:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 358:	ca19                	beqz	a2,36e <memset+0x1c>
 35a:	87aa                	mv	a5,a0
 35c:	1602                	slli	a2,a2,0x20
 35e:	9201                	srli	a2,a2,0x20
 360:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 364:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 368:	0785                	addi	a5,a5,1
 36a:	fee79de3          	bne	a5,a4,364 <memset+0x12>
  }
  return dst;
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret

0000000000000374 <strchr>:

char*
strchr(const char *s, char c)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
  for(; *s; s++)
 37a:	00054783          	lbu	a5,0(a0)
 37e:	cb99                	beqz	a5,394 <strchr+0x20>
    if(*s == c)
 380:	00f58763          	beq	a1,a5,38e <strchr+0x1a>
  for(; *s; s++)
 384:	0505                	addi	a0,a0,1
 386:	00054783          	lbu	a5,0(a0)
 38a:	fbfd                	bnez	a5,380 <strchr+0xc>
      return (char*)s;
  return 0;
 38c:	4501                	li	a0,0
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	addi	sp,sp,16
 392:	8082                	ret
  return 0;
 394:	4501                	li	a0,0
 396:	bfe5                	j	38e <strchr+0x1a>

0000000000000398 <gets>:

char*
gets(char *buf, int max)
{
 398:	711d                	addi	sp,sp,-96
 39a:	ec86                	sd	ra,88(sp)
 39c:	e8a2                	sd	s0,80(sp)
 39e:	e4a6                	sd	s1,72(sp)
 3a0:	e0ca                	sd	s2,64(sp)
 3a2:	fc4e                	sd	s3,56(sp)
 3a4:	f852                	sd	s4,48(sp)
 3a6:	f456                	sd	s5,40(sp)
 3a8:	f05a                	sd	s6,32(sp)
 3aa:	ec5e                	sd	s7,24(sp)
 3ac:	1080                	addi	s0,sp,96
 3ae:	8baa                	mv	s7,a0
 3b0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b2:	892a                	mv	s2,a0
 3b4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3b6:	4aa9                	li	s5,10
 3b8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3ba:	89a6                	mv	s3,s1
 3bc:	2485                	addiw	s1,s1,1
 3be:	0344d663          	bge	s1,s4,3ea <gets+0x52>
    cc = read(0, &c, 1);
 3c2:	4605                	li	a2,1
 3c4:	faf40593          	addi	a1,s0,-81
 3c8:	4501                	li	a0,0
 3ca:	19c000ef          	jal	566 <read>
    if(cc < 1)
 3ce:	00a05e63          	blez	a0,3ea <gets+0x52>
    buf[i++] = c;
 3d2:	faf44783          	lbu	a5,-81(s0)
 3d6:	00f90023          	sb	a5,0(s2) # a000 <base+0x7fe0>
    if(c == '\n' || c == '\r')
 3da:	01578763          	beq	a5,s5,3e8 <gets+0x50>
 3de:	0905                	addi	s2,s2,1
 3e0:	fd679de3          	bne	a5,s6,3ba <gets+0x22>
    buf[i++] = c;
 3e4:	89a6                	mv	s3,s1
 3e6:	a011                	j	3ea <gets+0x52>
 3e8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3ea:	99de                	add	s3,s3,s7
 3ec:	00098023          	sb	zero,0(s3) # 200000 <base+0x1fdfe0>
  return buf;
}
 3f0:	855e                	mv	a0,s7
 3f2:	60e6                	ld	ra,88(sp)
 3f4:	6446                	ld	s0,80(sp)
 3f6:	64a6                	ld	s1,72(sp)
 3f8:	6906                	ld	s2,64(sp)
 3fa:	79e2                	ld	s3,56(sp)
 3fc:	7a42                	ld	s4,48(sp)
 3fe:	7aa2                	ld	s5,40(sp)
 400:	7b02                	ld	s6,32(sp)
 402:	6be2                	ld	s7,24(sp)
 404:	6125                	addi	sp,sp,96
 406:	8082                	ret

0000000000000408 <stat>:

int
stat(const char *n, struct stat *st)
{
 408:	1101                	addi	sp,sp,-32
 40a:	ec06                	sd	ra,24(sp)
 40c:	e822                	sd	s0,16(sp)
 40e:	e04a                	sd	s2,0(sp)
 410:	1000                	addi	s0,sp,32
 412:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 414:	4581                	li	a1,0
 416:	178000ef          	jal	58e <open>
  if(fd < 0)
 41a:	02054263          	bltz	a0,43e <stat+0x36>
 41e:	e426                	sd	s1,8(sp)
 420:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 422:	85ca                	mv	a1,s2
 424:	182000ef          	jal	5a6 <fstat>
 428:	892a                	mv	s2,a0
  close(fd);
 42a:	8526                	mv	a0,s1
 42c:	14a000ef          	jal	576 <close>
  return r;
 430:	64a2                	ld	s1,8(sp)
}
 432:	854a                	mv	a0,s2
 434:	60e2                	ld	ra,24(sp)
 436:	6442                	ld	s0,16(sp)
 438:	6902                	ld	s2,0(sp)
 43a:	6105                	addi	sp,sp,32
 43c:	8082                	ret
    return -1;
 43e:	597d                	li	s2,-1
 440:	bfcd                	j	432 <stat+0x2a>

0000000000000442 <atoi>:

int
atoi(const char *s)
{
 442:	1141                	addi	sp,sp,-16
 444:	e422                	sd	s0,8(sp)
 446:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 448:	00054683          	lbu	a3,0(a0)
 44c:	fd06879b          	addiw	a5,a3,-48
 450:	0ff7f793          	zext.b	a5,a5
 454:	4625                	li	a2,9
 456:	02f66863          	bltu	a2,a5,486 <atoi+0x44>
 45a:	872a                	mv	a4,a0
  n = 0;
 45c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 45e:	0705                	addi	a4,a4,1
 460:	0025179b          	slliw	a5,a0,0x2
 464:	9fa9                	addw	a5,a5,a0
 466:	0017979b          	slliw	a5,a5,0x1
 46a:	9fb5                	addw	a5,a5,a3
 46c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 470:	00074683          	lbu	a3,0(a4)
 474:	fd06879b          	addiw	a5,a3,-48
 478:	0ff7f793          	zext.b	a5,a5
 47c:	fef671e3          	bgeu	a2,a5,45e <atoi+0x1c>
  return n;
}
 480:	6422                	ld	s0,8(sp)
 482:	0141                	addi	sp,sp,16
 484:	8082                	ret
  n = 0;
 486:	4501                	li	a0,0
 488:	bfe5                	j	480 <atoi+0x3e>

000000000000048a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 48a:	1141                	addi	sp,sp,-16
 48c:	e422                	sd	s0,8(sp)
 48e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 490:	02b57463          	bgeu	a0,a1,4b8 <memmove+0x2e>
    while(n-- > 0)
 494:	00c05f63          	blez	a2,4b2 <memmove+0x28>
 498:	1602                	slli	a2,a2,0x20
 49a:	9201                	srli	a2,a2,0x20
 49c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4a0:	872a                	mv	a4,a0
      *dst++ = *src++;
 4a2:	0585                	addi	a1,a1,1
 4a4:	0705                	addi	a4,a4,1
 4a6:	fff5c683          	lbu	a3,-1(a1)
 4aa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4ae:	fef71ae3          	bne	a4,a5,4a2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4b2:	6422                	ld	s0,8(sp)
 4b4:	0141                	addi	sp,sp,16
 4b6:	8082                	ret
    dst += n;
 4b8:	00c50733          	add	a4,a0,a2
    src += n;
 4bc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4be:	fec05ae3          	blez	a2,4b2 <memmove+0x28>
 4c2:	fff6079b          	addiw	a5,a2,-1
 4c6:	1782                	slli	a5,a5,0x20
 4c8:	9381                	srli	a5,a5,0x20
 4ca:	fff7c793          	not	a5,a5
 4ce:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4d0:	15fd                	addi	a1,a1,-1
 4d2:	177d                	addi	a4,a4,-1
 4d4:	0005c683          	lbu	a3,0(a1)
 4d8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4dc:	fee79ae3          	bne	a5,a4,4d0 <memmove+0x46>
 4e0:	bfc9                	j	4b2 <memmove+0x28>

00000000000004e2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e422                	sd	s0,8(sp)
 4e6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4e8:	ca05                	beqz	a2,518 <memcmp+0x36>
 4ea:	fff6069b          	addiw	a3,a2,-1
 4ee:	1682                	slli	a3,a3,0x20
 4f0:	9281                	srli	a3,a3,0x20
 4f2:	0685                	addi	a3,a3,1
 4f4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4f6:	00054783          	lbu	a5,0(a0)
 4fa:	0005c703          	lbu	a4,0(a1)
 4fe:	00e79863          	bne	a5,a4,50e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 502:	0505                	addi	a0,a0,1
    p2++;
 504:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 506:	fed518e3          	bne	a0,a3,4f6 <memcmp+0x14>
  }
  return 0;
 50a:	4501                	li	a0,0
 50c:	a019                	j	512 <memcmp+0x30>
      return *p1 - *p2;
 50e:	40e7853b          	subw	a0,a5,a4
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret
  return 0;
 518:	4501                	li	a0,0
 51a:	bfe5                	j	512 <memcmp+0x30>

000000000000051c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e406                	sd	ra,8(sp)
 520:	e022                	sd	s0,0(sp)
 522:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 524:	f67ff0ef          	jal	48a <memmove>
}
 528:	60a2                	ld	ra,8(sp)
 52a:	6402                	ld	s0,0(sp)
 52c:	0141                	addi	sp,sp,16
 52e:	8082                	ret

0000000000000530 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 530:	1141                	addi	sp,sp,-16
 532:	e422                	sd	s0,8(sp)
 534:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 536:	040007b7          	lui	a5,0x4000
 53a:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffdfdd>
 53c:	07b2                	slli	a5,a5,0xc
}
 53e:	4388                	lw	a0,0(a5)
 540:	6422                	ld	s0,8(sp)
 542:	0141                	addi	sp,sp,16
 544:	8082                	ret

0000000000000546 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 546:	4885                	li	a7,1
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <exit>:
.global exit
exit:
 li a7, SYS_exit
 54e:	4889                	li	a7,2
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <wait>:
.global wait
wait:
 li a7, SYS_wait
 556:	488d                	li	a7,3
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 55e:	4891                	li	a7,4
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <read>:
.global read
read:
 li a7, SYS_read
 566:	4895                	li	a7,5
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <write>:
.global write
write:
 li a7, SYS_write
 56e:	48c1                	li	a7,16
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <close>:
.global close
close:
 li a7, SYS_close
 576:	48d5                	li	a7,21
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <kill>:
.global kill
kill:
 li a7, SYS_kill
 57e:	4899                	li	a7,6
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <exec>:
.global exec
exec:
 li a7, SYS_exec
 586:	489d                	li	a7,7
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <open>:
.global open
open:
 li a7, SYS_open
 58e:	48bd                	li	a7,15
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 596:	48c5                	li	a7,17
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 59e:	48c9                	li	a7,18
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a6:	48a1                	li	a7,8
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <link>:
.global link
link:
 li a7, SYS_link
 5ae:	48cd                	li	a7,19
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b6:	48d1                	li	a7,20
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5be:	48a5                	li	a7,9
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c6:	48a9                	li	a7,10
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ce:	48ad                	li	a7,11
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d6:	48b1                	li	a7,12
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5de:	48b5                	li	a7,13
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e6:	48b9                	li	a7,14
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <bind>:
.global bind
bind:
 li a7, SYS_bind
 5ee:	48f5                	li	a7,29
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
 5f6:	48f9                	li	a7,30
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <send>:
.global send
send:
 li a7, SYS_send
 5fe:	48fd                	li	a7,31
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <recv>:
.global recv
recv:
 li a7, SYS_recv
 606:	02000893          	li	a7,32
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
 610:	02100893          	li	a7,33
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
 61a:	02200893          	li	a7,34
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 624:	1101                	addi	sp,sp,-32
 626:	ec06                	sd	ra,24(sp)
 628:	e822                	sd	s0,16(sp)
 62a:	1000                	addi	s0,sp,32
 62c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 630:	4605                	li	a2,1
 632:	fef40593          	addi	a1,s0,-17
 636:	f39ff0ef          	jal	56e <write>
}
 63a:	60e2                	ld	ra,24(sp)
 63c:	6442                	ld	s0,16(sp)
 63e:	6105                	addi	sp,sp,32
 640:	8082                	ret

0000000000000642 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 642:	7139                	addi	sp,sp,-64
 644:	fc06                	sd	ra,56(sp)
 646:	f822                	sd	s0,48(sp)
 648:	f426                	sd	s1,40(sp)
 64a:	0080                	addi	s0,sp,64
 64c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64e:	c299                	beqz	a3,654 <printint+0x12>
 650:	0805c963          	bltz	a1,6e2 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 654:	2581                	sext.w	a1,a1
  neg = 0;
 656:	4881                	li	a7,0
 658:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 65c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 65e:	2601                	sext.w	a2,a2
 660:	00000517          	auipc	a0,0x0
 664:	6a050513          	addi	a0,a0,1696 # d00 <digits>
 668:	883a                	mv	a6,a4
 66a:	2705                	addiw	a4,a4,1
 66c:	02c5f7bb          	remuw	a5,a1,a2
 670:	1782                	slli	a5,a5,0x20
 672:	9381                	srli	a5,a5,0x20
 674:	97aa                	add	a5,a5,a0
 676:	0007c783          	lbu	a5,0(a5)
 67a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 67e:	0005879b          	sext.w	a5,a1
 682:	02c5d5bb          	divuw	a1,a1,a2
 686:	0685                	addi	a3,a3,1
 688:	fec7f0e3          	bgeu	a5,a2,668 <printint+0x26>
  if(neg)
 68c:	00088c63          	beqz	a7,6a4 <printint+0x62>
    buf[i++] = '-';
 690:	fd070793          	addi	a5,a4,-48
 694:	00878733          	add	a4,a5,s0
 698:	02d00793          	li	a5,45
 69c:	fef70823          	sb	a5,-16(a4)
 6a0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6a4:	02e05a63          	blez	a4,6d8 <printint+0x96>
 6a8:	f04a                	sd	s2,32(sp)
 6aa:	ec4e                	sd	s3,24(sp)
 6ac:	fc040793          	addi	a5,s0,-64
 6b0:	00e78933          	add	s2,a5,a4
 6b4:	fff78993          	addi	s3,a5,-1
 6b8:	99ba                	add	s3,s3,a4
 6ba:	377d                	addiw	a4,a4,-1
 6bc:	1702                	slli	a4,a4,0x20
 6be:	9301                	srli	a4,a4,0x20
 6c0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6c4:	fff94583          	lbu	a1,-1(s2)
 6c8:	8526                	mv	a0,s1
 6ca:	f5bff0ef          	jal	624 <putc>
  while(--i >= 0)
 6ce:	197d                	addi	s2,s2,-1
 6d0:	ff391ae3          	bne	s2,s3,6c4 <printint+0x82>
 6d4:	7902                	ld	s2,32(sp)
 6d6:	69e2                	ld	s3,24(sp)
}
 6d8:	70e2                	ld	ra,56(sp)
 6da:	7442                	ld	s0,48(sp)
 6dc:	74a2                	ld	s1,40(sp)
 6de:	6121                	addi	sp,sp,64
 6e0:	8082                	ret
    x = -xx;
 6e2:	40b005bb          	negw	a1,a1
    neg = 1;
 6e6:	4885                	li	a7,1
    x = -xx;
 6e8:	bf85                	j	658 <printint+0x16>

00000000000006ea <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ea:	711d                	addi	sp,sp,-96
 6ec:	ec86                	sd	ra,88(sp)
 6ee:	e8a2                	sd	s0,80(sp)
 6f0:	e0ca                	sd	s2,64(sp)
 6f2:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6f4:	0005c903          	lbu	s2,0(a1)
 6f8:	26090863          	beqz	s2,968 <vprintf+0x27e>
 6fc:	e4a6                	sd	s1,72(sp)
 6fe:	fc4e                	sd	s3,56(sp)
 700:	f852                	sd	s4,48(sp)
 702:	f456                	sd	s5,40(sp)
 704:	f05a                	sd	s6,32(sp)
 706:	ec5e                	sd	s7,24(sp)
 708:	e862                	sd	s8,16(sp)
 70a:	e466                	sd	s9,8(sp)
 70c:	8b2a                	mv	s6,a0
 70e:	8a2e                	mv	s4,a1
 710:	8bb2                	mv	s7,a2
  state = 0;
 712:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 714:	4481                	li	s1,0
 716:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 718:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 71c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 720:	06c00c93          	li	s9,108
 724:	a005                	j	744 <vprintf+0x5a>
        putc(fd, c0);
 726:	85ca                	mv	a1,s2
 728:	855a                	mv	a0,s6
 72a:	efbff0ef          	jal	624 <putc>
 72e:	a019                	j	734 <vprintf+0x4a>
    } else if(state == '%'){
 730:	03598263          	beq	s3,s5,754 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 734:	2485                	addiw	s1,s1,1
 736:	8726                	mv	a4,s1
 738:	009a07b3          	add	a5,s4,s1
 73c:	0007c903          	lbu	s2,0(a5)
 740:	20090c63          	beqz	s2,958 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 744:	0009079b          	sext.w	a5,s2
    if(state == 0){
 748:	fe0994e3          	bnez	s3,730 <vprintf+0x46>
      if(c0 == '%'){
 74c:	fd579de3          	bne	a5,s5,726 <vprintf+0x3c>
        state = '%';
 750:	89be                	mv	s3,a5
 752:	b7cd                	j	734 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 754:	00ea06b3          	add	a3,s4,a4
 758:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 75c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 75e:	c681                	beqz	a3,766 <vprintf+0x7c>
 760:	9752                	add	a4,a4,s4
 762:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 766:	03878f63          	beq	a5,s8,7a4 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 76a:	05978963          	beq	a5,s9,7bc <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 76e:	07500713          	li	a4,117
 772:	0ee78363          	beq	a5,a4,858 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 776:	07800713          	li	a4,120
 77a:	12e78563          	beq	a5,a4,8a4 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 77e:	07000713          	li	a4,112
 782:	14e78a63          	beq	a5,a4,8d6 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 786:	07300713          	li	a4,115
 78a:	18e78a63          	beq	a5,a4,91e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 78e:	02500713          	li	a4,37
 792:	04e79563          	bne	a5,a4,7dc <vprintf+0xf2>
        putc(fd, '%');
 796:	02500593          	li	a1,37
 79a:	855a                	mv	a0,s6
 79c:	e89ff0ef          	jal	624 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	bf49                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7a4:	008b8913          	addi	s2,s7,8
 7a8:	4685                	li	a3,1
 7aa:	4629                	li	a2,10
 7ac:	000ba583          	lw	a1,0(s7)
 7b0:	855a                	mv	a0,s6
 7b2:	e91ff0ef          	jal	642 <printint>
 7b6:	8bca                	mv	s7,s2
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	bfad                	j	734 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7bc:	06400793          	li	a5,100
 7c0:	02f68963          	beq	a3,a5,7f2 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7c4:	06c00793          	li	a5,108
 7c8:	04f68263          	beq	a3,a5,80c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 7cc:	07500793          	li	a5,117
 7d0:	0af68063          	beq	a3,a5,870 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 7d4:	07800793          	li	a5,120
 7d8:	0ef68263          	beq	a3,a5,8bc <vprintf+0x1d2>
        putc(fd, '%');
 7dc:	02500593          	li	a1,37
 7e0:	855a                	mv	a0,s6
 7e2:	e43ff0ef          	jal	624 <putc>
        putc(fd, c0);
 7e6:	85ca                	mv	a1,s2
 7e8:	855a                	mv	a0,s6
 7ea:	e3bff0ef          	jal	624 <putc>
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b791                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7f2:	008b8913          	addi	s2,s7,8
 7f6:	4685                	li	a3,1
 7f8:	4629                	li	a2,10
 7fa:	000ba583          	lw	a1,0(s7)
 7fe:	855a                	mv	a0,s6
 800:	e43ff0ef          	jal	642 <printint>
        i += 1;
 804:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 806:	8bca                	mv	s7,s2
      state = 0;
 808:	4981                	li	s3,0
        i += 1;
 80a:	b72d                	j	734 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 80c:	06400793          	li	a5,100
 810:	02f60763          	beq	a2,a5,83e <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 814:	07500793          	li	a5,117
 818:	06f60963          	beq	a2,a5,88a <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 81c:	07800793          	li	a5,120
 820:	faf61ee3          	bne	a2,a5,7dc <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 824:	008b8913          	addi	s2,s7,8
 828:	4681                	li	a3,0
 82a:	4641                	li	a2,16
 82c:	000ba583          	lw	a1,0(s7)
 830:	855a                	mv	a0,s6
 832:	e11ff0ef          	jal	642 <printint>
        i += 2;
 836:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 838:	8bca                	mv	s7,s2
      state = 0;
 83a:	4981                	li	s3,0
        i += 2;
 83c:	bde5                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 83e:	008b8913          	addi	s2,s7,8
 842:	4685                	li	a3,1
 844:	4629                	li	a2,10
 846:	000ba583          	lw	a1,0(s7)
 84a:	855a                	mv	a0,s6
 84c:	df7ff0ef          	jal	642 <printint>
        i += 2;
 850:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 852:	8bca                	mv	s7,s2
      state = 0;
 854:	4981                	li	s3,0
        i += 2;
 856:	bdf9                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 858:	008b8913          	addi	s2,s7,8
 85c:	4681                	li	a3,0
 85e:	4629                	li	a2,10
 860:	000ba583          	lw	a1,0(s7)
 864:	855a                	mv	a0,s6
 866:	dddff0ef          	jal	642 <printint>
 86a:	8bca                	mv	s7,s2
      state = 0;
 86c:	4981                	li	s3,0
 86e:	b5d9                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 870:	008b8913          	addi	s2,s7,8
 874:	4681                	li	a3,0
 876:	4629                	li	a2,10
 878:	000ba583          	lw	a1,0(s7)
 87c:	855a                	mv	a0,s6
 87e:	dc5ff0ef          	jal	642 <printint>
        i += 1;
 882:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 884:	8bca                	mv	s7,s2
      state = 0;
 886:	4981                	li	s3,0
        i += 1;
 888:	b575                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 88a:	008b8913          	addi	s2,s7,8
 88e:	4681                	li	a3,0
 890:	4629                	li	a2,10
 892:	000ba583          	lw	a1,0(s7)
 896:	855a                	mv	a0,s6
 898:	dabff0ef          	jal	642 <printint>
        i += 2;
 89c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 89e:	8bca                	mv	s7,s2
      state = 0;
 8a0:	4981                	li	s3,0
        i += 2;
 8a2:	bd49                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 8a4:	008b8913          	addi	s2,s7,8
 8a8:	4681                	li	a3,0
 8aa:	4641                	li	a2,16
 8ac:	000ba583          	lw	a1,0(s7)
 8b0:	855a                	mv	a0,s6
 8b2:	d91ff0ef          	jal	642 <printint>
 8b6:	8bca                	mv	s7,s2
      state = 0;
 8b8:	4981                	li	s3,0
 8ba:	bdad                	j	734 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8bc:	008b8913          	addi	s2,s7,8
 8c0:	4681                	li	a3,0
 8c2:	4641                	li	a2,16
 8c4:	000ba583          	lw	a1,0(s7)
 8c8:	855a                	mv	a0,s6
 8ca:	d79ff0ef          	jal	642 <printint>
        i += 1;
 8ce:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8d0:	8bca                	mv	s7,s2
      state = 0;
 8d2:	4981                	li	s3,0
        i += 1;
 8d4:	b585                	j	734 <vprintf+0x4a>
 8d6:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8d8:	008b8d13          	addi	s10,s7,8
 8dc:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8e0:	03000593          	li	a1,48
 8e4:	855a                	mv	a0,s6
 8e6:	d3fff0ef          	jal	624 <putc>
  putc(fd, 'x');
 8ea:	07800593          	li	a1,120
 8ee:	855a                	mv	a0,s6
 8f0:	d35ff0ef          	jal	624 <putc>
 8f4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8f6:	00000b97          	auipc	s7,0x0
 8fa:	40ab8b93          	addi	s7,s7,1034 # d00 <digits>
 8fe:	03c9d793          	srli	a5,s3,0x3c
 902:	97de                	add	a5,a5,s7
 904:	0007c583          	lbu	a1,0(a5)
 908:	855a                	mv	a0,s6
 90a:	d1bff0ef          	jal	624 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 90e:	0992                	slli	s3,s3,0x4
 910:	397d                	addiw	s2,s2,-1
 912:	fe0916e3          	bnez	s2,8fe <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 916:	8bea                	mv	s7,s10
      state = 0;
 918:	4981                	li	s3,0
 91a:	6d02                	ld	s10,0(sp)
 91c:	bd21                	j	734 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 91e:	008b8993          	addi	s3,s7,8
 922:	000bb903          	ld	s2,0(s7)
 926:	00090f63          	beqz	s2,944 <vprintf+0x25a>
        for(; *s; s++)
 92a:	00094583          	lbu	a1,0(s2)
 92e:	c195                	beqz	a1,952 <vprintf+0x268>
          putc(fd, *s);
 930:	855a                	mv	a0,s6
 932:	cf3ff0ef          	jal	624 <putc>
        for(; *s; s++)
 936:	0905                	addi	s2,s2,1
 938:	00094583          	lbu	a1,0(s2)
 93c:	f9f5                	bnez	a1,930 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 93e:	8bce                	mv	s7,s3
      state = 0;
 940:	4981                	li	s3,0
 942:	bbcd                	j	734 <vprintf+0x4a>
          s = "(null)";
 944:	00000917          	auipc	s2,0x0
 948:	3b490913          	addi	s2,s2,948 # cf8 <malloc+0x2a8>
        for(; *s; s++)
 94c:	02800593          	li	a1,40
 950:	b7c5                	j	930 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 952:	8bce                	mv	s7,s3
      state = 0;
 954:	4981                	li	s3,0
 956:	bbf9                	j	734 <vprintf+0x4a>
 958:	64a6                	ld	s1,72(sp)
 95a:	79e2                	ld	s3,56(sp)
 95c:	7a42                	ld	s4,48(sp)
 95e:	7aa2                	ld	s5,40(sp)
 960:	7b02                	ld	s6,32(sp)
 962:	6be2                	ld	s7,24(sp)
 964:	6c42                	ld	s8,16(sp)
 966:	6ca2                	ld	s9,8(sp)
    }
  }
}
 968:	60e6                	ld	ra,88(sp)
 96a:	6446                	ld	s0,80(sp)
 96c:	6906                	ld	s2,64(sp)
 96e:	6125                	addi	sp,sp,96
 970:	8082                	ret

0000000000000972 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 972:	715d                	addi	sp,sp,-80
 974:	ec06                	sd	ra,24(sp)
 976:	e822                	sd	s0,16(sp)
 978:	1000                	addi	s0,sp,32
 97a:	e010                	sd	a2,0(s0)
 97c:	e414                	sd	a3,8(s0)
 97e:	e818                	sd	a4,16(s0)
 980:	ec1c                	sd	a5,24(s0)
 982:	03043023          	sd	a6,32(s0)
 986:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 98a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 98e:	8622                	mv	a2,s0
 990:	d5bff0ef          	jal	6ea <vprintf>
}
 994:	60e2                	ld	ra,24(sp)
 996:	6442                	ld	s0,16(sp)
 998:	6161                	addi	sp,sp,80
 99a:	8082                	ret

000000000000099c <printf>:

void
printf(const char *fmt, ...)
{
 99c:	711d                	addi	sp,sp,-96
 99e:	ec06                	sd	ra,24(sp)
 9a0:	e822                	sd	s0,16(sp)
 9a2:	1000                	addi	s0,sp,32
 9a4:	e40c                	sd	a1,8(s0)
 9a6:	e810                	sd	a2,16(s0)
 9a8:	ec14                	sd	a3,24(s0)
 9aa:	f018                	sd	a4,32(s0)
 9ac:	f41c                	sd	a5,40(s0)
 9ae:	03043823          	sd	a6,48(s0)
 9b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9b6:	00840613          	addi	a2,s0,8
 9ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9be:	85aa                	mv	a1,a0
 9c0:	4505                	li	a0,1
 9c2:	d29ff0ef          	jal	6ea <vprintf>
}
 9c6:	60e2                	ld	ra,24(sp)
 9c8:	6442                	ld	s0,16(sp)
 9ca:	6125                	addi	sp,sp,96
 9cc:	8082                	ret

00000000000009ce <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9ce:	1141                	addi	sp,sp,-16
 9d0:	e422                	sd	s0,8(sp)
 9d2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9d4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d8:	00001797          	auipc	a5,0x1
 9dc:	6387b783          	ld	a5,1592(a5) # 2010 <freep>
 9e0:	a02d                	j	a0a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e2:	4618                	lw	a4,8(a2)
 9e4:	9f2d                	addw	a4,a4,a1
 9e6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9ea:	6398                	ld	a4,0(a5)
 9ec:	6310                	ld	a2,0(a4)
 9ee:	a83d                	j	a2c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9f0:	ff852703          	lw	a4,-8(a0)
 9f4:	9f31                	addw	a4,a4,a2
 9f6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9f8:	ff053683          	ld	a3,-16(a0)
 9fc:	a091                	j	a40 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9fe:	6398                	ld	a4,0(a5)
 a00:	00e7e463          	bltu	a5,a4,a08 <free+0x3a>
 a04:	00e6ea63          	bltu	a3,a4,a18 <free+0x4a>
{
 a08:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a0a:	fed7fae3          	bgeu	a5,a3,9fe <free+0x30>
 a0e:	6398                	ld	a4,0(a5)
 a10:	00e6e463          	bltu	a3,a4,a18 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a14:	fee7eae3          	bltu	a5,a4,a08 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a18:	ff852583          	lw	a1,-8(a0)
 a1c:	6390                	ld	a2,0(a5)
 a1e:	02059813          	slli	a6,a1,0x20
 a22:	01c85713          	srli	a4,a6,0x1c
 a26:	9736                	add	a4,a4,a3
 a28:	fae60de3          	beq	a2,a4,9e2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a2c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a30:	4790                	lw	a2,8(a5)
 a32:	02061593          	slli	a1,a2,0x20
 a36:	01c5d713          	srli	a4,a1,0x1c
 a3a:	973e                	add	a4,a4,a5
 a3c:	fae68ae3          	beq	a3,a4,9f0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a40:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a42:	00001717          	auipc	a4,0x1
 a46:	5cf73723          	sd	a5,1486(a4) # 2010 <freep>
}
 a4a:	6422                	ld	s0,8(sp)
 a4c:	0141                	addi	sp,sp,16
 a4e:	8082                	ret

0000000000000a50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a50:	7139                	addi	sp,sp,-64
 a52:	fc06                	sd	ra,56(sp)
 a54:	f822                	sd	s0,48(sp)
 a56:	f426                	sd	s1,40(sp)
 a58:	ec4e                	sd	s3,24(sp)
 a5a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5c:	02051493          	slli	s1,a0,0x20
 a60:	9081                	srli	s1,s1,0x20
 a62:	04bd                	addi	s1,s1,15
 a64:	8091                	srli	s1,s1,0x4
 a66:	0014899b          	addiw	s3,s1,1
 a6a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a6c:	00001517          	auipc	a0,0x1
 a70:	5a453503          	ld	a0,1444(a0) # 2010 <freep>
 a74:	c915                	beqz	a0,aa8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a76:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a78:	4798                	lw	a4,8(a5)
 a7a:	08977a63          	bgeu	a4,s1,b0e <malloc+0xbe>
 a7e:	f04a                	sd	s2,32(sp)
 a80:	e852                	sd	s4,16(sp)
 a82:	e456                	sd	s5,8(sp)
 a84:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a86:	8a4e                	mv	s4,s3
 a88:	0009871b          	sext.w	a4,s3
 a8c:	6685                	lui	a3,0x1
 a8e:	00d77363          	bgeu	a4,a3,a94 <malloc+0x44>
 a92:	6a05                	lui	s4,0x1
 a94:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a98:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a9c:	00001917          	auipc	s2,0x1
 aa0:	57490913          	addi	s2,s2,1396 # 2010 <freep>
  if(p == (char*)-1)
 aa4:	5afd                	li	s5,-1
 aa6:	a081                	j	ae6 <malloc+0x96>
 aa8:	f04a                	sd	s2,32(sp)
 aaa:	e852                	sd	s4,16(sp)
 aac:	e456                	sd	s5,8(sp)
 aae:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ab0:	00001797          	auipc	a5,0x1
 ab4:	57078793          	addi	a5,a5,1392 # 2020 <base>
 ab8:	00001717          	auipc	a4,0x1
 abc:	54f73c23          	sd	a5,1368(a4) # 2010 <freep>
 ac0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ac2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ac6:	b7c1                	j	a86 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ac8:	6398                	ld	a4,0(a5)
 aca:	e118                	sd	a4,0(a0)
 acc:	a8a9                	j	b26 <malloc+0xd6>
  hp->s.size = nu;
 ace:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ad2:	0541                	addi	a0,a0,16
 ad4:	efbff0ef          	jal	9ce <free>
  return freep;
 ad8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 adc:	c12d                	beqz	a0,b3e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ade:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae0:	4798                	lw	a4,8(a5)
 ae2:	02977263          	bgeu	a4,s1,b06 <malloc+0xb6>
    if(p == freep)
 ae6:	00093703          	ld	a4,0(s2)
 aea:	853e                	mv	a0,a5
 aec:	fef719e3          	bne	a4,a5,ade <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 af0:	8552                	mv	a0,s4
 af2:	ae5ff0ef          	jal	5d6 <sbrk>
  if(p == (char*)-1)
 af6:	fd551ce3          	bne	a0,s5,ace <malloc+0x7e>
        return 0;
 afa:	4501                	li	a0,0
 afc:	7902                	ld	s2,32(sp)
 afe:	6a42                	ld	s4,16(sp)
 b00:	6aa2                	ld	s5,8(sp)
 b02:	6b02                	ld	s6,0(sp)
 b04:	a03d                	j	b32 <malloc+0xe2>
 b06:	7902                	ld	s2,32(sp)
 b08:	6a42                	ld	s4,16(sp)
 b0a:	6aa2                	ld	s5,8(sp)
 b0c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b0e:	fae48de3          	beq	s1,a4,ac8 <malloc+0x78>
        p->s.size -= nunits;
 b12:	4137073b          	subw	a4,a4,s3
 b16:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b18:	02071693          	slli	a3,a4,0x20
 b1c:	01c6d713          	srli	a4,a3,0x1c
 b20:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b22:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b26:	00001717          	auipc	a4,0x1
 b2a:	4ea73523          	sd	a0,1258(a4) # 2010 <freep>
      return (void*)(p + 1);
 b2e:	01078513          	addi	a0,a5,16
  }
}
 b32:	70e2                	ld	ra,56(sp)
 b34:	7442                	ld	s0,48(sp)
 b36:	74a2                	ld	s1,40(sp)
 b38:	69e2                	ld	s3,24(sp)
 b3a:	6121                	addi	sp,sp,64
 b3c:	8082                	ret
 b3e:	7902                	ld	s2,32(sp)
 b40:	6a42                	ld	s4,16(sp)
 b42:	6aa2                	ld	s5,8(sp)
 b44:	6b02                	ld	s6,0(sp)
 b46:	b7f5                	j	b32 <malloc+0xe2>
