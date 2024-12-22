
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	addi	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
       e:	00007797          	auipc	a5,0x7
      12:	41a78793          	addi	a5,a5,1050 # 7428 <malloc+0x2490>
      16:	638c                	ld	a1,0(a5)
      18:	6790                	ld	a2,8(a5)
      1a:	6b94                	ld	a3,16(a5)
      1c:	6f98                	ld	a4,24(a5)
      1e:	739c                	ld	a5,32(a5)
      20:	fab43423          	sd	a1,-88(s0)
      24:	fac43823          	sd	a2,-80(s0)
      28:	fad43c23          	sd	a3,-72(s0)
      2c:	fce43023          	sd	a4,-64(s0)
      30:	fcf43423          	sd	a5,-56(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      34:	fa840493          	addi	s1,s0,-88
      38:	fd040993          	addi	s3,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      3c:	0004b903          	ld	s2,0(s1)
      40:	20100593          	li	a1,513
      44:	854a                	mv	a0,s2
      46:	291040ef          	jal	4ad6 <open>
    if(fd >= 0){
      4a:	00055c63          	bgez	a0,62 <copyinstr1+0x62>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      4e:	04a1                	addi	s1,s1,8
      50:	ff3496e3          	bne	s1,s3,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      exit(1);
    }
  }
}
      54:	60e6                	ld	ra,88(sp)
      56:	6446                	ld	s0,80(sp)
      58:	64a6                	ld	s1,72(sp)
      5a:	6906                	ld	s2,64(sp)
      5c:	79e2                	ld	s3,56(sp)
      5e:	6125                	addi	sp,sp,96
      60:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      62:	862a                	mv	a2,a0
      64:	85ca                	mv	a1,s2
      66:	00005517          	auipc	a0,0x5
      6a:	02a50513          	addi	a0,a0,42 # 5090 <malloc+0xf8>
      6e:	677040ef          	jal	4ee4 <printf>
      exit(1);
      72:	4505                	li	a0,1
      74:	223040ef          	jal	4a96 <exit>

0000000000000078 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      78:	0000a797          	auipc	a5,0xa
      7c:	4f078793          	addi	a5,a5,1264 # a568 <uninit>
      80:	0000d697          	auipc	a3,0xd
      84:	bf868693          	addi	a3,a3,-1032 # cc78 <buf>
    if(uninit[i] != '\0'){
      88:	0007c703          	lbu	a4,0(a5)
      8c:	e709                	bnez	a4,96 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      8e:	0785                	addi	a5,a5,1
      90:	fed79ce3          	bne	a5,a3,88 <bsstest+0x10>
      94:	8082                	ret
{
      96:	1141                	addi	sp,sp,-16
      98:	e406                	sd	ra,8(sp)
      9a:	e022                	sd	s0,0(sp)
      9c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      9e:	85aa                	mv	a1,a0
      a0:	00005517          	auipc	a0,0x5
      a4:	01050513          	addi	a0,a0,16 # 50b0 <malloc+0x118>
      a8:	63d040ef          	jal	4ee4 <printf>
      exit(1);
      ac:	4505                	li	a0,1
      ae:	1e9040ef          	jal	4a96 <exit>

00000000000000b2 <opentest>:
{
      b2:	1101                	addi	sp,sp,-32
      b4:	ec06                	sd	ra,24(sp)
      b6:	e822                	sd	s0,16(sp)
      b8:	e426                	sd	s1,8(sp)
      ba:	1000                	addi	s0,sp,32
      bc:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      be:	4581                	li	a1,0
      c0:	00005517          	auipc	a0,0x5
      c4:	00850513          	addi	a0,a0,8 # 50c8 <malloc+0x130>
      c8:	20f040ef          	jal	4ad6 <open>
  if(fd < 0){
      cc:	02054263          	bltz	a0,f0 <opentest+0x3e>
  close(fd);
      d0:	1ef040ef          	jal	4abe <close>
  fd = open("doesnotexist", 0);
      d4:	4581                	li	a1,0
      d6:	00005517          	auipc	a0,0x5
      da:	01250513          	addi	a0,a0,18 # 50e8 <malloc+0x150>
      de:	1f9040ef          	jal	4ad6 <open>
  if(fd >= 0){
      e2:	02055163          	bgez	a0,104 <opentest+0x52>
}
      e6:	60e2                	ld	ra,24(sp)
      e8:	6442                	ld	s0,16(sp)
      ea:	64a2                	ld	s1,8(sp)
      ec:	6105                	addi	sp,sp,32
      ee:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f0:	85a6                	mv	a1,s1
      f2:	00005517          	auipc	a0,0x5
      f6:	fde50513          	addi	a0,a0,-34 # 50d0 <malloc+0x138>
      fa:	5eb040ef          	jal	4ee4 <printf>
    exit(1);
      fe:	4505                	li	a0,1
     100:	197040ef          	jal	4a96 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     104:	85a6                	mv	a1,s1
     106:	00005517          	auipc	a0,0x5
     10a:	ff250513          	addi	a0,a0,-14 # 50f8 <malloc+0x160>
     10e:	5d7040ef          	jal	4ee4 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	183040ef          	jal	4a96 <exit>

0000000000000118 <truncate2>:
{
     118:	7179                	addi	sp,sp,-48
     11a:	f406                	sd	ra,40(sp)
     11c:	f022                	sd	s0,32(sp)
     11e:	ec26                	sd	s1,24(sp)
     120:	e84a                	sd	s2,16(sp)
     122:	e44e                	sd	s3,8(sp)
     124:	1800                	addi	s0,sp,48
     126:	89aa                	mv	s3,a0
  unlink("truncfile");
     128:	00005517          	auipc	a0,0x5
     12c:	ff850513          	addi	a0,a0,-8 # 5120 <malloc+0x188>
     130:	1b7040ef          	jal	4ae6 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     134:	60100593          	li	a1,1537
     138:	00005517          	auipc	a0,0x5
     13c:	fe850513          	addi	a0,a0,-24 # 5120 <malloc+0x188>
     140:	197040ef          	jal	4ad6 <open>
     144:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     146:	4611                	li	a2,4
     148:	00005597          	auipc	a1,0x5
     14c:	fe858593          	addi	a1,a1,-24 # 5130 <malloc+0x198>
     150:	167040ef          	jal	4ab6 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     154:	40100593          	li	a1,1025
     158:	00005517          	auipc	a0,0x5
     15c:	fc850513          	addi	a0,a0,-56 # 5120 <malloc+0x188>
     160:	177040ef          	jal	4ad6 <open>
     164:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     166:	4605                	li	a2,1
     168:	00005597          	auipc	a1,0x5
     16c:	fd058593          	addi	a1,a1,-48 # 5138 <malloc+0x1a0>
     170:	8526                	mv	a0,s1
     172:	145040ef          	jal	4ab6 <write>
  if(n != -1){
     176:	57fd                	li	a5,-1
     178:	02f51563          	bne	a0,a5,1a2 <truncate2+0x8a>
  unlink("truncfile");
     17c:	00005517          	auipc	a0,0x5
     180:	fa450513          	addi	a0,a0,-92 # 5120 <malloc+0x188>
     184:	163040ef          	jal	4ae6 <unlink>
  close(fd1);
     188:	8526                	mv	a0,s1
     18a:	135040ef          	jal	4abe <close>
  close(fd2);
     18e:	854a                	mv	a0,s2
     190:	12f040ef          	jal	4abe <close>
}
     194:	70a2                	ld	ra,40(sp)
     196:	7402                	ld	s0,32(sp)
     198:	64e2                	ld	s1,24(sp)
     19a:	6942                	ld	s2,16(sp)
     19c:	69a2                	ld	s3,8(sp)
     19e:	6145                	addi	sp,sp,48
     1a0:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a2:	862a                	mv	a2,a0
     1a4:	85ce                	mv	a1,s3
     1a6:	00005517          	auipc	a0,0x5
     1aa:	f9a50513          	addi	a0,a0,-102 # 5140 <malloc+0x1a8>
     1ae:	537040ef          	jal	4ee4 <printf>
    exit(1);
     1b2:	4505                	li	a0,1
     1b4:	0e3040ef          	jal	4a96 <exit>

00000000000001b8 <createtest>:
{
     1b8:	7179                	addi	sp,sp,-48
     1ba:	f406                	sd	ra,40(sp)
     1bc:	f022                	sd	s0,32(sp)
     1be:	ec26                	sd	s1,24(sp)
     1c0:	e84a                	sd	s2,16(sp)
     1c2:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1c4:	06100793          	li	a5,97
     1c8:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1cc:	fc040d23          	sb	zero,-38(s0)
     1d0:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     1d4:	06400913          	li	s2,100
    name[1] = '0' + i;
     1d8:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     1dc:	20200593          	li	a1,514
     1e0:	fd840513          	addi	a0,s0,-40
     1e4:	0f3040ef          	jal	4ad6 <open>
    close(fd);
     1e8:	0d7040ef          	jal	4abe <close>
  for(i = 0; i < N; i++){
     1ec:	2485                	addiw	s1,s1,1
     1ee:	0ff4f493          	zext.b	s1,s1
     1f2:	ff2493e3          	bne	s1,s2,1d8 <createtest+0x20>
  name[0] = 'a';
     1f6:	06100793          	li	a5,97
     1fa:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1fe:	fc040d23          	sb	zero,-38(s0)
     202:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     206:	06400913          	li	s2,100
    name[1] = '0' + i;
     20a:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     20e:	fd840513          	addi	a0,s0,-40
     212:	0d5040ef          	jal	4ae6 <unlink>
  for(i = 0; i < N; i++){
     216:	2485                	addiw	s1,s1,1
     218:	0ff4f493          	zext.b	s1,s1
     21c:	ff2497e3          	bne	s1,s2,20a <createtest+0x52>
}
     220:	70a2                	ld	ra,40(sp)
     222:	7402                	ld	s0,32(sp)
     224:	64e2                	ld	s1,24(sp)
     226:	6942                	ld	s2,16(sp)
     228:	6145                	addi	sp,sp,48
     22a:	8082                	ret

000000000000022c <bigwrite>:
{
     22c:	715d                	addi	sp,sp,-80
     22e:	e486                	sd	ra,72(sp)
     230:	e0a2                	sd	s0,64(sp)
     232:	fc26                	sd	s1,56(sp)
     234:	f84a                	sd	s2,48(sp)
     236:	f44e                	sd	s3,40(sp)
     238:	f052                	sd	s4,32(sp)
     23a:	ec56                	sd	s5,24(sp)
     23c:	e85a                	sd	s6,16(sp)
     23e:	e45e                	sd	s7,8(sp)
     240:	0880                	addi	s0,sp,80
     242:	8baa                	mv	s7,a0
  unlink("bigwrite");
     244:	00005517          	auipc	a0,0x5
     248:	f2450513          	addi	a0,a0,-220 # 5168 <malloc+0x1d0>
     24c:	09b040ef          	jal	4ae6 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     250:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     254:	00005a97          	auipc	s5,0x5
     258:	f14a8a93          	addi	s5,s5,-236 # 5168 <malloc+0x1d0>
      int cc = write(fd, buf, sz);
     25c:	0000da17          	auipc	s4,0xd
     260:	a1ca0a13          	addi	s4,s4,-1508 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     264:	6b0d                	lui	s6,0x3
     266:	1c9b0b13          	addi	s6,s6,457 # 31c9 <subdir+0x5ed>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26a:	20200593          	li	a1,514
     26e:	8556                	mv	a0,s5
     270:	067040ef          	jal	4ad6 <open>
     274:	892a                	mv	s2,a0
    if(fd < 0){
     276:	04054563          	bltz	a0,2c0 <bigwrite+0x94>
      int cc = write(fd, buf, sz);
     27a:	8626                	mv	a2,s1
     27c:	85d2                	mv	a1,s4
     27e:	039040ef          	jal	4ab6 <write>
     282:	89aa                	mv	s3,a0
      if(cc != sz){
     284:	04a49863          	bne	s1,a0,2d4 <bigwrite+0xa8>
      int cc = write(fd, buf, sz);
     288:	8626                	mv	a2,s1
     28a:	85d2                	mv	a1,s4
     28c:	854a                	mv	a0,s2
     28e:	029040ef          	jal	4ab6 <write>
      if(cc != sz){
     292:	04951263          	bne	a0,s1,2d6 <bigwrite+0xaa>
    close(fd);
     296:	854a                	mv	a0,s2
     298:	027040ef          	jal	4abe <close>
    unlink("bigwrite");
     29c:	8556                	mv	a0,s5
     29e:	049040ef          	jal	4ae6 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a2:	1d74849b          	addiw	s1,s1,471
     2a6:	fd6492e3          	bne	s1,s6,26a <bigwrite+0x3e>
}
     2aa:	60a6                	ld	ra,72(sp)
     2ac:	6406                	ld	s0,64(sp)
     2ae:	74e2                	ld	s1,56(sp)
     2b0:	7942                	ld	s2,48(sp)
     2b2:	79a2                	ld	s3,40(sp)
     2b4:	7a02                	ld	s4,32(sp)
     2b6:	6ae2                	ld	s5,24(sp)
     2b8:	6b42                	ld	s6,16(sp)
     2ba:	6ba2                	ld	s7,8(sp)
     2bc:	6161                	addi	sp,sp,80
     2be:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2c0:	85de                	mv	a1,s7
     2c2:	00005517          	auipc	a0,0x5
     2c6:	eb650513          	addi	a0,a0,-330 # 5178 <malloc+0x1e0>
     2ca:	41b040ef          	jal	4ee4 <printf>
      exit(1);
     2ce:	4505                	li	a0,1
     2d0:	7c6040ef          	jal	4a96 <exit>
      if(cc != sz){
     2d4:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2d6:	86aa                	mv	a3,a0
     2d8:	864e                	mv	a2,s3
     2da:	85de                	mv	a1,s7
     2dc:	00005517          	auipc	a0,0x5
     2e0:	ebc50513          	addi	a0,a0,-324 # 5198 <malloc+0x200>
     2e4:	401040ef          	jal	4ee4 <printf>
        exit(1);
     2e8:	4505                	li	a0,1
     2ea:	7ac040ef          	jal	4a96 <exit>

00000000000002ee <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     2ee:	7179                	addi	sp,sp,-48
     2f0:	f406                	sd	ra,40(sp)
     2f2:	f022                	sd	s0,32(sp)
     2f4:	ec26                	sd	s1,24(sp)
     2f6:	e84a                	sd	s2,16(sp)
     2f8:	e44e                	sd	s3,8(sp)
     2fa:	e052                	sd	s4,0(sp)
     2fc:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     2fe:	00005517          	auipc	a0,0x5
     302:	eb250513          	addi	a0,a0,-334 # 51b0 <malloc+0x218>
     306:	7e0040ef          	jal	4ae6 <unlink>
     30a:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     30e:	00005997          	auipc	s3,0x5
     312:	ea298993          	addi	s3,s3,-350 # 51b0 <malloc+0x218>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     316:	5a7d                	li	s4,-1
     318:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     31c:	20100593          	li	a1,513
     320:	854e                	mv	a0,s3
     322:	7b4040ef          	jal	4ad6 <open>
     326:	84aa                	mv	s1,a0
    if(fd < 0){
     328:	04054d63          	bltz	a0,382 <badwrite+0x94>
    write(fd, (char*)0xffffffffffL, 1);
     32c:	4605                	li	a2,1
     32e:	85d2                	mv	a1,s4
     330:	786040ef          	jal	4ab6 <write>
    close(fd);
     334:	8526                	mv	a0,s1
     336:	788040ef          	jal	4abe <close>
    unlink("junk");
     33a:	854e                	mv	a0,s3
     33c:	7aa040ef          	jal	4ae6 <unlink>
  for(int i = 0; i < assumed_free; i++){
     340:	397d                	addiw	s2,s2,-1
     342:	fc091de3          	bnez	s2,31c <badwrite+0x2e>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     346:	20100593          	li	a1,513
     34a:	00005517          	auipc	a0,0x5
     34e:	e6650513          	addi	a0,a0,-410 # 51b0 <malloc+0x218>
     352:	784040ef          	jal	4ad6 <open>
     356:	84aa                	mv	s1,a0
  if(fd < 0){
     358:	02054e63          	bltz	a0,394 <badwrite+0xa6>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     35c:	4605                	li	a2,1
     35e:	00005597          	auipc	a1,0x5
     362:	dda58593          	addi	a1,a1,-550 # 5138 <malloc+0x1a0>
     366:	750040ef          	jal	4ab6 <write>
     36a:	4785                	li	a5,1
     36c:	02f50d63          	beq	a0,a5,3a6 <badwrite+0xb8>
    printf("write failed\n");
     370:	00005517          	auipc	a0,0x5
     374:	e6050513          	addi	a0,a0,-416 # 51d0 <malloc+0x238>
     378:	36d040ef          	jal	4ee4 <printf>
    exit(1);
     37c:	4505                	li	a0,1
     37e:	718040ef          	jal	4a96 <exit>
      printf("open junk failed\n");
     382:	00005517          	auipc	a0,0x5
     386:	e3650513          	addi	a0,a0,-458 # 51b8 <malloc+0x220>
     38a:	35b040ef          	jal	4ee4 <printf>
      exit(1);
     38e:	4505                	li	a0,1
     390:	706040ef          	jal	4a96 <exit>
    printf("open junk failed\n");
     394:	00005517          	auipc	a0,0x5
     398:	e2450513          	addi	a0,a0,-476 # 51b8 <malloc+0x220>
     39c:	349040ef          	jal	4ee4 <printf>
    exit(1);
     3a0:	4505                	li	a0,1
     3a2:	6f4040ef          	jal	4a96 <exit>
  }
  close(fd);
     3a6:	8526                	mv	a0,s1
     3a8:	716040ef          	jal	4abe <close>
  unlink("junk");
     3ac:	00005517          	auipc	a0,0x5
     3b0:	e0450513          	addi	a0,a0,-508 # 51b0 <malloc+0x218>
     3b4:	732040ef          	jal	4ae6 <unlink>

  exit(0);
     3b8:	4501                	li	a0,0
     3ba:	6dc040ef          	jal	4a96 <exit>

00000000000003be <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3be:	715d                	addi	sp,sp,-80
     3c0:	e486                	sd	ra,72(sp)
     3c2:	e0a2                	sd	s0,64(sp)
     3c4:	fc26                	sd	s1,56(sp)
     3c6:	f84a                	sd	s2,48(sp)
     3c8:	f44e                	sd	s3,40(sp)
     3ca:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     3cc:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3ce:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     3d2:	40000993          	li	s3,1024
    name[0] = 'z';
     3d6:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     3da:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     3de:	41f4d71b          	sraiw	a4,s1,0x1f
     3e2:	01b7571b          	srliw	a4,a4,0x1b
     3e6:	009707bb          	addw	a5,a4,s1
     3ea:	4057d69b          	sraiw	a3,a5,0x5
     3ee:	0306869b          	addiw	a3,a3,48
     3f2:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     3f6:	8bfd                	andi	a5,a5,31
     3f8:	9f99                	subw	a5,a5,a4
     3fa:	0307879b          	addiw	a5,a5,48
     3fe:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     402:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     406:	fb040513          	addi	a0,s0,-80
     40a:	6dc040ef          	jal	4ae6 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     40e:	60200593          	li	a1,1538
     412:	fb040513          	addi	a0,s0,-80
     416:	6c0040ef          	jal	4ad6 <open>
    if(fd < 0){
     41a:	00054763          	bltz	a0,428 <outofinodes+0x6a>
      // failure is eventually expected.
      break;
    }
    close(fd);
     41e:	6a0040ef          	jal	4abe <close>
  for(int i = 0; i < nzz; i++){
     422:	2485                	addiw	s1,s1,1
     424:	fb3499e3          	bne	s1,s3,3d6 <outofinodes+0x18>
     428:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     42a:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     42e:	40000993          	li	s3,1024
    name[0] = 'z';
     432:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     436:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     43a:	41f4d71b          	sraiw	a4,s1,0x1f
     43e:	01b7571b          	srliw	a4,a4,0x1b
     442:	009707bb          	addw	a5,a4,s1
     446:	4057d69b          	sraiw	a3,a5,0x5
     44a:	0306869b          	addiw	a3,a3,48
     44e:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     452:	8bfd                	andi	a5,a5,31
     454:	9f99                	subw	a5,a5,a4
     456:	0307879b          	addiw	a5,a5,48
     45a:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     45e:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     462:	fb040513          	addi	a0,s0,-80
     466:	680040ef          	jal	4ae6 <unlink>
  for(int i = 0; i < nzz; i++){
     46a:	2485                	addiw	s1,s1,1
     46c:	fd3493e3          	bne	s1,s3,432 <outofinodes+0x74>
  }
}
     470:	60a6                	ld	ra,72(sp)
     472:	6406                	ld	s0,64(sp)
     474:	74e2                	ld	s1,56(sp)
     476:	7942                	ld	s2,48(sp)
     478:	79a2                	ld	s3,40(sp)
     47a:	6161                	addi	sp,sp,80
     47c:	8082                	ret

000000000000047e <copyin>:
{
     47e:	7159                	addi	sp,sp,-112
     480:	f486                	sd	ra,104(sp)
     482:	f0a2                	sd	s0,96(sp)
     484:	eca6                	sd	s1,88(sp)
     486:	e8ca                	sd	s2,80(sp)
     488:	e4ce                	sd	s3,72(sp)
     48a:	e0d2                	sd	s4,64(sp)
     48c:	fc56                	sd	s5,56(sp)
     48e:	1880                	addi	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     490:	00007797          	auipc	a5,0x7
     494:	f9878793          	addi	a5,a5,-104 # 7428 <malloc+0x2490>
     498:	638c                	ld	a1,0(a5)
     49a:	6790                	ld	a2,8(a5)
     49c:	6b94                	ld	a3,16(a5)
     49e:	6f98                	ld	a4,24(a5)
     4a0:	739c                	ld	a5,32(a5)
     4a2:	f8b43c23          	sd	a1,-104(s0)
     4a6:	fac43023          	sd	a2,-96(s0)
     4aa:	fad43423          	sd	a3,-88(s0)
     4ae:	fae43823          	sd	a4,-80(s0)
     4b2:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     4b6:	f9840913          	addi	s2,s0,-104
     4ba:	fc040a93          	addi	s5,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4be:	00005a17          	auipc	s4,0x5
     4c2:	d22a0a13          	addi	s4,s4,-734 # 51e0 <malloc+0x248>
    uint64 addr = addrs[ai];
     4c6:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4ca:	20100593          	li	a1,513
     4ce:	8552                	mv	a0,s4
     4d0:	606040ef          	jal	4ad6 <open>
     4d4:	84aa                	mv	s1,a0
    if(fd < 0){
     4d6:	06054763          	bltz	a0,544 <copyin+0xc6>
    int n = write(fd, (void*)addr, 8192);
     4da:	6609                	lui	a2,0x2
     4dc:	85ce                	mv	a1,s3
     4de:	5d8040ef          	jal	4ab6 <write>
    if(n >= 0){
     4e2:	06055a63          	bgez	a0,556 <copyin+0xd8>
    close(fd);
     4e6:	8526                	mv	a0,s1
     4e8:	5d6040ef          	jal	4abe <close>
    unlink("copyin1");
     4ec:	8552                	mv	a0,s4
     4ee:	5f8040ef          	jal	4ae6 <unlink>
    n = write(1, (char*)addr, 8192);
     4f2:	6609                	lui	a2,0x2
     4f4:	85ce                	mv	a1,s3
     4f6:	4505                	li	a0,1
     4f8:	5be040ef          	jal	4ab6 <write>
    if(n > 0){
     4fc:	06a04863          	bgtz	a0,56c <copyin+0xee>
    if(pipe(fds) < 0){
     500:	f9040513          	addi	a0,s0,-112
     504:	5a2040ef          	jal	4aa6 <pipe>
     508:	06054d63          	bltz	a0,582 <copyin+0x104>
    n = write(fds[1], (char*)addr, 8192);
     50c:	6609                	lui	a2,0x2
     50e:	85ce                	mv	a1,s3
     510:	f9442503          	lw	a0,-108(s0)
     514:	5a2040ef          	jal	4ab6 <write>
    if(n > 0){
     518:	06a04e63          	bgtz	a0,594 <copyin+0x116>
    close(fds[0]);
     51c:	f9042503          	lw	a0,-112(s0)
     520:	59e040ef          	jal	4abe <close>
    close(fds[1]);
     524:	f9442503          	lw	a0,-108(s0)
     528:	596040ef          	jal	4abe <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     52c:	0921                	addi	s2,s2,8
     52e:	f9591ce3          	bne	s2,s5,4c6 <copyin+0x48>
}
     532:	70a6                	ld	ra,104(sp)
     534:	7406                	ld	s0,96(sp)
     536:	64e6                	ld	s1,88(sp)
     538:	6946                	ld	s2,80(sp)
     53a:	69a6                	ld	s3,72(sp)
     53c:	6a06                	ld	s4,64(sp)
     53e:	7ae2                	ld	s5,56(sp)
     540:	6165                	addi	sp,sp,112
     542:	8082                	ret
      printf("open(copyin1) failed\n");
     544:	00005517          	auipc	a0,0x5
     548:	ca450513          	addi	a0,a0,-860 # 51e8 <malloc+0x250>
     54c:	199040ef          	jal	4ee4 <printf>
      exit(1);
     550:	4505                	li	a0,1
     552:	544040ef          	jal	4a96 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void*)addr, n);
     556:	862a                	mv	a2,a0
     558:	85ce                	mv	a1,s3
     55a:	00005517          	auipc	a0,0x5
     55e:	ca650513          	addi	a0,a0,-858 # 5200 <malloc+0x268>
     562:	183040ef          	jal	4ee4 <printf>
      exit(1);
     566:	4505                	li	a0,1
     568:	52e040ef          	jal	4a96 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     56c:	862a                	mv	a2,a0
     56e:	85ce                	mv	a1,s3
     570:	00005517          	auipc	a0,0x5
     574:	cc050513          	addi	a0,a0,-832 # 5230 <malloc+0x298>
     578:	16d040ef          	jal	4ee4 <printf>
      exit(1);
     57c:	4505                	li	a0,1
     57e:	518040ef          	jal	4a96 <exit>
      printf("pipe() failed\n");
     582:	00005517          	auipc	a0,0x5
     586:	cde50513          	addi	a0,a0,-802 # 5260 <malloc+0x2c8>
     58a:	15b040ef          	jal	4ee4 <printf>
      exit(1);
     58e:	4505                	li	a0,1
     590:	506040ef          	jal	4a96 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     594:	862a                	mv	a2,a0
     596:	85ce                	mv	a1,s3
     598:	00005517          	auipc	a0,0x5
     59c:	cd850513          	addi	a0,a0,-808 # 5270 <malloc+0x2d8>
     5a0:	145040ef          	jal	4ee4 <printf>
      exit(1);
     5a4:	4505                	li	a0,1
     5a6:	4f0040ef          	jal	4a96 <exit>

00000000000005aa <copyout>:
{
     5aa:	7119                	addi	sp,sp,-128
     5ac:	fc86                	sd	ra,120(sp)
     5ae:	f8a2                	sd	s0,112(sp)
     5b0:	f4a6                	sd	s1,104(sp)
     5b2:	f0ca                	sd	s2,96(sp)
     5b4:	ecce                	sd	s3,88(sp)
     5b6:	e8d2                	sd	s4,80(sp)
     5b8:	e4d6                	sd	s5,72(sp)
     5ba:	e0da                	sd	s6,64(sp)
     5bc:	0100                	addi	s0,sp,128
  uint64 addrs[] = { 0LL, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     5be:	00007797          	auipc	a5,0x7
     5c2:	e6a78793          	addi	a5,a5,-406 # 7428 <malloc+0x2490>
     5c6:	7788                	ld	a0,40(a5)
     5c8:	7b8c                	ld	a1,48(a5)
     5ca:	7f90                	ld	a2,56(a5)
     5cc:	63b4                	ld	a3,64(a5)
     5ce:	67b8                	ld	a4,72(a5)
     5d0:	6bbc                	ld	a5,80(a5)
     5d2:	f8a43823          	sd	a0,-112(s0)
     5d6:	f8b43c23          	sd	a1,-104(s0)
     5da:	fac43023          	sd	a2,-96(s0)
     5de:	fad43423          	sd	a3,-88(s0)
     5e2:	fae43823          	sd	a4,-80(s0)
     5e6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     5ea:	f9040913          	addi	s2,s0,-112
     5ee:	fc040b13          	addi	s6,s0,-64
    int fd = open("README", 0);
     5f2:	00005a17          	auipc	s4,0x5
     5f6:	caea0a13          	addi	s4,s4,-850 # 52a0 <malloc+0x308>
    n = write(fds[1], "x", 1);
     5fa:	00005a97          	auipc	s5,0x5
     5fe:	b3ea8a93          	addi	s5,s5,-1218 # 5138 <malloc+0x1a0>
    uint64 addr = addrs[ai];
     602:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     606:	4581                	li	a1,0
     608:	8552                	mv	a0,s4
     60a:	4cc040ef          	jal	4ad6 <open>
     60e:	84aa                	mv	s1,a0
    if(fd < 0){
     610:	06054763          	bltz	a0,67e <copyout+0xd4>
    int n = read(fd, (void*)addr, 8192);
     614:	6609                	lui	a2,0x2
     616:	85ce                	mv	a1,s3
     618:	496040ef          	jal	4aae <read>
    if(n > 0){
     61c:	06a04a63          	bgtz	a0,690 <copyout+0xe6>
    close(fd);
     620:	8526                	mv	a0,s1
     622:	49c040ef          	jal	4abe <close>
    if(pipe(fds) < 0){
     626:	f8840513          	addi	a0,s0,-120
     62a:	47c040ef          	jal	4aa6 <pipe>
     62e:	06054c63          	bltz	a0,6a6 <copyout+0xfc>
    n = write(fds[1], "x", 1);
     632:	4605                	li	a2,1
     634:	85d6                	mv	a1,s5
     636:	f8c42503          	lw	a0,-116(s0)
     63a:	47c040ef          	jal	4ab6 <write>
    if(n != 1){
     63e:	4785                	li	a5,1
     640:	06f51c63          	bne	a0,a5,6b8 <copyout+0x10e>
    n = read(fds[0], (void*)addr, 8192);
     644:	6609                	lui	a2,0x2
     646:	85ce                	mv	a1,s3
     648:	f8842503          	lw	a0,-120(s0)
     64c:	462040ef          	jal	4aae <read>
    if(n > 0){
     650:	06a04d63          	bgtz	a0,6ca <copyout+0x120>
    close(fds[0]);
     654:	f8842503          	lw	a0,-120(s0)
     658:	466040ef          	jal	4abe <close>
    close(fds[1]);
     65c:	f8c42503          	lw	a0,-116(s0)
     660:	45e040ef          	jal	4abe <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     664:	0921                	addi	s2,s2,8
     666:	f9691ee3          	bne	s2,s6,602 <copyout+0x58>
}
     66a:	70e6                	ld	ra,120(sp)
     66c:	7446                	ld	s0,112(sp)
     66e:	74a6                	ld	s1,104(sp)
     670:	7906                	ld	s2,96(sp)
     672:	69e6                	ld	s3,88(sp)
     674:	6a46                	ld	s4,80(sp)
     676:	6aa6                	ld	s5,72(sp)
     678:	6b06                	ld	s6,64(sp)
     67a:	6109                	addi	sp,sp,128
     67c:	8082                	ret
      printf("open(README) failed\n");
     67e:	00005517          	auipc	a0,0x5
     682:	c2a50513          	addi	a0,a0,-982 # 52a8 <malloc+0x310>
     686:	05f040ef          	jal	4ee4 <printf>
      exit(1);
     68a:	4505                	li	a0,1
     68c:	40a040ef          	jal	4a96 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     690:	862a                	mv	a2,a0
     692:	85ce                	mv	a1,s3
     694:	00005517          	auipc	a0,0x5
     698:	c2c50513          	addi	a0,a0,-980 # 52c0 <malloc+0x328>
     69c:	049040ef          	jal	4ee4 <printf>
      exit(1);
     6a0:	4505                	li	a0,1
     6a2:	3f4040ef          	jal	4a96 <exit>
      printf("pipe() failed\n");
     6a6:	00005517          	auipc	a0,0x5
     6aa:	bba50513          	addi	a0,a0,-1094 # 5260 <malloc+0x2c8>
     6ae:	037040ef          	jal	4ee4 <printf>
      exit(1);
     6b2:	4505                	li	a0,1
     6b4:	3e2040ef          	jal	4a96 <exit>
      printf("pipe write failed\n");
     6b8:	00005517          	auipc	a0,0x5
     6bc:	c3850513          	addi	a0,a0,-968 # 52f0 <malloc+0x358>
     6c0:	025040ef          	jal	4ee4 <printf>
      exit(1);
     6c4:	4505                	li	a0,1
     6c6:	3d0040ef          	jal	4a96 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     6ca:	862a                	mv	a2,a0
     6cc:	85ce                	mv	a1,s3
     6ce:	00005517          	auipc	a0,0x5
     6d2:	c3a50513          	addi	a0,a0,-966 # 5308 <malloc+0x370>
     6d6:	00f040ef          	jal	4ee4 <printf>
      exit(1);
     6da:	4505                	li	a0,1
     6dc:	3ba040ef          	jal	4a96 <exit>

00000000000006e0 <truncate1>:
{
     6e0:	711d                	addi	sp,sp,-96
     6e2:	ec86                	sd	ra,88(sp)
     6e4:	e8a2                	sd	s0,80(sp)
     6e6:	e4a6                	sd	s1,72(sp)
     6e8:	e0ca                	sd	s2,64(sp)
     6ea:	fc4e                	sd	s3,56(sp)
     6ec:	f852                	sd	s4,48(sp)
     6ee:	f456                	sd	s5,40(sp)
     6f0:	1080                	addi	s0,sp,96
     6f2:	8aaa                	mv	s5,a0
  unlink("truncfile");
     6f4:	00005517          	auipc	a0,0x5
     6f8:	a2c50513          	addi	a0,a0,-1492 # 5120 <malloc+0x188>
     6fc:	3ea040ef          	jal	4ae6 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     700:	60100593          	li	a1,1537
     704:	00005517          	auipc	a0,0x5
     708:	a1c50513          	addi	a0,a0,-1508 # 5120 <malloc+0x188>
     70c:	3ca040ef          	jal	4ad6 <open>
     710:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     712:	4611                	li	a2,4
     714:	00005597          	auipc	a1,0x5
     718:	a1c58593          	addi	a1,a1,-1508 # 5130 <malloc+0x198>
     71c:	39a040ef          	jal	4ab6 <write>
  close(fd1);
     720:	8526                	mv	a0,s1
     722:	39c040ef          	jal	4abe <close>
  int fd2 = open("truncfile", O_RDONLY);
     726:	4581                	li	a1,0
     728:	00005517          	auipc	a0,0x5
     72c:	9f850513          	addi	a0,a0,-1544 # 5120 <malloc+0x188>
     730:	3a6040ef          	jal	4ad6 <open>
     734:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     736:	02000613          	li	a2,32
     73a:	fa040593          	addi	a1,s0,-96
     73e:	370040ef          	jal	4aae <read>
  if(n != 4){
     742:	4791                	li	a5,4
     744:	0af51863          	bne	a0,a5,7f4 <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     748:	40100593          	li	a1,1025
     74c:	00005517          	auipc	a0,0x5
     750:	9d450513          	addi	a0,a0,-1580 # 5120 <malloc+0x188>
     754:	382040ef          	jal	4ad6 <open>
     758:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     75a:	4581                	li	a1,0
     75c:	00005517          	auipc	a0,0x5
     760:	9c450513          	addi	a0,a0,-1596 # 5120 <malloc+0x188>
     764:	372040ef          	jal	4ad6 <open>
     768:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     76a:	02000613          	li	a2,32
     76e:	fa040593          	addi	a1,s0,-96
     772:	33c040ef          	jal	4aae <read>
     776:	8a2a                	mv	s4,a0
  if(n != 0){
     778:	e949                	bnez	a0,80a <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     77a:	02000613          	li	a2,32
     77e:	fa040593          	addi	a1,s0,-96
     782:	8526                	mv	a0,s1
     784:	32a040ef          	jal	4aae <read>
     788:	8a2a                	mv	s4,a0
  if(n != 0){
     78a:	e155                	bnez	a0,82e <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     78c:	4619                	li	a2,6
     78e:	00005597          	auipc	a1,0x5
     792:	c0a58593          	addi	a1,a1,-1014 # 5398 <malloc+0x400>
     796:	854e                	mv	a0,s3
     798:	31e040ef          	jal	4ab6 <write>
  n = read(fd3, buf, sizeof(buf));
     79c:	02000613          	li	a2,32
     7a0:	fa040593          	addi	a1,s0,-96
     7a4:	854a                	mv	a0,s2
     7a6:	308040ef          	jal	4aae <read>
  if(n != 6){
     7aa:	4799                	li	a5,6
     7ac:	0af51363          	bne	a0,a5,852 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     7b0:	02000613          	li	a2,32
     7b4:	fa040593          	addi	a1,s0,-96
     7b8:	8526                	mv	a0,s1
     7ba:	2f4040ef          	jal	4aae <read>
  if(n != 2){
     7be:	4789                	li	a5,2
     7c0:	0af51463          	bne	a0,a5,868 <truncate1+0x188>
  unlink("truncfile");
     7c4:	00005517          	auipc	a0,0x5
     7c8:	95c50513          	addi	a0,a0,-1700 # 5120 <malloc+0x188>
     7cc:	31a040ef          	jal	4ae6 <unlink>
  close(fd1);
     7d0:	854e                	mv	a0,s3
     7d2:	2ec040ef          	jal	4abe <close>
  close(fd2);
     7d6:	8526                	mv	a0,s1
     7d8:	2e6040ef          	jal	4abe <close>
  close(fd3);
     7dc:	854a                	mv	a0,s2
     7de:	2e0040ef          	jal	4abe <close>
}
     7e2:	60e6                	ld	ra,88(sp)
     7e4:	6446                	ld	s0,80(sp)
     7e6:	64a6                	ld	s1,72(sp)
     7e8:	6906                	ld	s2,64(sp)
     7ea:	79e2                	ld	s3,56(sp)
     7ec:	7a42                	ld	s4,48(sp)
     7ee:	7aa2                	ld	s5,40(sp)
     7f0:	6125                	addi	sp,sp,96
     7f2:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     7f4:	862a                	mv	a2,a0
     7f6:	85d6                	mv	a1,s5
     7f8:	00005517          	auipc	a0,0x5
     7fc:	b4050513          	addi	a0,a0,-1216 # 5338 <malloc+0x3a0>
     800:	6e4040ef          	jal	4ee4 <printf>
    exit(1);
     804:	4505                	li	a0,1
     806:	290040ef          	jal	4a96 <exit>
    printf("aaa fd3=%d\n", fd3);
     80a:	85ca                	mv	a1,s2
     80c:	00005517          	auipc	a0,0x5
     810:	b4c50513          	addi	a0,a0,-1204 # 5358 <malloc+0x3c0>
     814:	6d0040ef          	jal	4ee4 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     818:	8652                	mv	a2,s4
     81a:	85d6                	mv	a1,s5
     81c:	00005517          	auipc	a0,0x5
     820:	b4c50513          	addi	a0,a0,-1204 # 5368 <malloc+0x3d0>
     824:	6c0040ef          	jal	4ee4 <printf>
    exit(1);
     828:	4505                	li	a0,1
     82a:	26c040ef          	jal	4a96 <exit>
    printf("bbb fd2=%d\n", fd2);
     82e:	85a6                	mv	a1,s1
     830:	00005517          	auipc	a0,0x5
     834:	b5850513          	addi	a0,a0,-1192 # 5388 <malloc+0x3f0>
     838:	6ac040ef          	jal	4ee4 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     83c:	8652                	mv	a2,s4
     83e:	85d6                	mv	a1,s5
     840:	00005517          	auipc	a0,0x5
     844:	b2850513          	addi	a0,a0,-1240 # 5368 <malloc+0x3d0>
     848:	69c040ef          	jal	4ee4 <printf>
    exit(1);
     84c:	4505                	li	a0,1
     84e:	248040ef          	jal	4a96 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     852:	862a                	mv	a2,a0
     854:	85d6                	mv	a1,s5
     856:	00005517          	auipc	a0,0x5
     85a:	b4a50513          	addi	a0,a0,-1206 # 53a0 <malloc+0x408>
     85e:	686040ef          	jal	4ee4 <printf>
    exit(1);
     862:	4505                	li	a0,1
     864:	232040ef          	jal	4a96 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     868:	862a                	mv	a2,a0
     86a:	85d6                	mv	a1,s5
     86c:	00005517          	auipc	a0,0x5
     870:	b5450513          	addi	a0,a0,-1196 # 53c0 <malloc+0x428>
     874:	670040ef          	jal	4ee4 <printf>
    exit(1);
     878:	4505                	li	a0,1
     87a:	21c040ef          	jal	4a96 <exit>

000000000000087e <writetest>:
{
     87e:	7139                	addi	sp,sp,-64
     880:	fc06                	sd	ra,56(sp)
     882:	f822                	sd	s0,48(sp)
     884:	f426                	sd	s1,40(sp)
     886:	f04a                	sd	s2,32(sp)
     888:	ec4e                	sd	s3,24(sp)
     88a:	e852                	sd	s4,16(sp)
     88c:	e456                	sd	s5,8(sp)
     88e:	e05a                	sd	s6,0(sp)
     890:	0080                	addi	s0,sp,64
     892:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     894:	20200593          	li	a1,514
     898:	00005517          	auipc	a0,0x5
     89c:	b4850513          	addi	a0,a0,-1208 # 53e0 <malloc+0x448>
     8a0:	236040ef          	jal	4ad6 <open>
  if(fd < 0){
     8a4:	08054f63          	bltz	a0,942 <writetest+0xc4>
     8a8:	892a                	mv	s2,a0
     8aa:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     8ac:	00005997          	auipc	s3,0x5
     8b0:	b5c98993          	addi	s3,s3,-1188 # 5408 <malloc+0x470>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     8b4:	00005a97          	auipc	s5,0x5
     8b8:	b8ca8a93          	addi	s5,s5,-1140 # 5440 <malloc+0x4a8>
  for(i = 0; i < N; i++){
     8bc:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     8c0:	4629                	li	a2,10
     8c2:	85ce                	mv	a1,s3
     8c4:	854a                	mv	a0,s2
     8c6:	1f0040ef          	jal	4ab6 <write>
     8ca:	47a9                	li	a5,10
     8cc:	08f51563          	bne	a0,a5,956 <writetest+0xd8>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     8d0:	4629                	li	a2,10
     8d2:	85d6                	mv	a1,s5
     8d4:	854a                	mv	a0,s2
     8d6:	1e0040ef          	jal	4ab6 <write>
     8da:	47a9                	li	a5,10
     8dc:	08f51863          	bne	a0,a5,96c <writetest+0xee>
  for(i = 0; i < N; i++){
     8e0:	2485                	addiw	s1,s1,1
     8e2:	fd449fe3          	bne	s1,s4,8c0 <writetest+0x42>
  close(fd);
     8e6:	854a                	mv	a0,s2
     8e8:	1d6040ef          	jal	4abe <close>
  fd = open("small", O_RDONLY);
     8ec:	4581                	li	a1,0
     8ee:	00005517          	auipc	a0,0x5
     8f2:	af250513          	addi	a0,a0,-1294 # 53e0 <malloc+0x448>
     8f6:	1e0040ef          	jal	4ad6 <open>
     8fa:	84aa                	mv	s1,a0
  if(fd < 0){
     8fc:	08054363          	bltz	a0,982 <writetest+0x104>
  i = read(fd, buf, N*SZ*2);
     900:	7d000613          	li	a2,2000
     904:	0000c597          	auipc	a1,0xc
     908:	37458593          	addi	a1,a1,884 # cc78 <buf>
     90c:	1a2040ef          	jal	4aae <read>
  if(i != N*SZ*2){
     910:	7d000793          	li	a5,2000
     914:	08f51163          	bne	a0,a5,996 <writetest+0x118>
  close(fd);
     918:	8526                	mv	a0,s1
     91a:	1a4040ef          	jal	4abe <close>
  if(unlink("small") < 0){
     91e:	00005517          	auipc	a0,0x5
     922:	ac250513          	addi	a0,a0,-1342 # 53e0 <malloc+0x448>
     926:	1c0040ef          	jal	4ae6 <unlink>
     92a:	08054063          	bltz	a0,9aa <writetest+0x12c>
}
     92e:	70e2                	ld	ra,56(sp)
     930:	7442                	ld	s0,48(sp)
     932:	74a2                	ld	s1,40(sp)
     934:	7902                	ld	s2,32(sp)
     936:	69e2                	ld	s3,24(sp)
     938:	6a42                	ld	s4,16(sp)
     93a:	6aa2                	ld	s5,8(sp)
     93c:	6b02                	ld	s6,0(sp)
     93e:	6121                	addi	sp,sp,64
     940:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     942:	85da                	mv	a1,s6
     944:	00005517          	auipc	a0,0x5
     948:	aa450513          	addi	a0,a0,-1372 # 53e8 <malloc+0x450>
     94c:	598040ef          	jal	4ee4 <printf>
    exit(1);
     950:	4505                	li	a0,1
     952:	144040ef          	jal	4a96 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     956:	8626                	mv	a2,s1
     958:	85da                	mv	a1,s6
     95a:	00005517          	auipc	a0,0x5
     95e:	abe50513          	addi	a0,a0,-1346 # 5418 <malloc+0x480>
     962:	582040ef          	jal	4ee4 <printf>
      exit(1);
     966:	4505                	li	a0,1
     968:	12e040ef          	jal	4a96 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     96c:	8626                	mv	a2,s1
     96e:	85da                	mv	a1,s6
     970:	00005517          	auipc	a0,0x5
     974:	ae050513          	addi	a0,a0,-1312 # 5450 <malloc+0x4b8>
     978:	56c040ef          	jal	4ee4 <printf>
      exit(1);
     97c:	4505                	li	a0,1
     97e:	118040ef          	jal	4a96 <exit>
    printf("%s: error: open small failed!\n", s);
     982:	85da                	mv	a1,s6
     984:	00005517          	auipc	a0,0x5
     988:	af450513          	addi	a0,a0,-1292 # 5478 <malloc+0x4e0>
     98c:	558040ef          	jal	4ee4 <printf>
    exit(1);
     990:	4505                	li	a0,1
     992:	104040ef          	jal	4a96 <exit>
    printf("%s: read failed\n", s);
     996:	85da                	mv	a1,s6
     998:	00005517          	auipc	a0,0x5
     99c:	b0050513          	addi	a0,a0,-1280 # 5498 <malloc+0x500>
     9a0:	544040ef          	jal	4ee4 <printf>
    exit(1);
     9a4:	4505                	li	a0,1
     9a6:	0f0040ef          	jal	4a96 <exit>
    printf("%s: unlink small failed\n", s);
     9aa:	85da                	mv	a1,s6
     9ac:	00005517          	auipc	a0,0x5
     9b0:	b0450513          	addi	a0,a0,-1276 # 54b0 <malloc+0x518>
     9b4:	530040ef          	jal	4ee4 <printf>
    exit(1);
     9b8:	4505                	li	a0,1
     9ba:	0dc040ef          	jal	4a96 <exit>

00000000000009be <writebig>:
{
     9be:	7139                	addi	sp,sp,-64
     9c0:	fc06                	sd	ra,56(sp)
     9c2:	f822                	sd	s0,48(sp)
     9c4:	f426                	sd	s1,40(sp)
     9c6:	f04a                	sd	s2,32(sp)
     9c8:	ec4e                	sd	s3,24(sp)
     9ca:	e852                	sd	s4,16(sp)
     9cc:	e456                	sd	s5,8(sp)
     9ce:	0080                	addi	s0,sp,64
     9d0:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     9d2:	20200593          	li	a1,514
     9d6:	00005517          	auipc	a0,0x5
     9da:	afa50513          	addi	a0,a0,-1286 # 54d0 <malloc+0x538>
     9de:	0f8040ef          	jal	4ad6 <open>
     9e2:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     9e4:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     9e6:	0000c917          	auipc	s2,0xc
     9ea:	29290913          	addi	s2,s2,658 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     9ee:	10c00a13          	li	s4,268
  if(fd < 0){
     9f2:	06054463          	bltz	a0,a5a <writebig+0x9c>
    ((int*)buf)[0] = i;
     9f6:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     9fa:	40000613          	li	a2,1024
     9fe:	85ca                	mv	a1,s2
     a00:	854e                	mv	a0,s3
     a02:	0b4040ef          	jal	4ab6 <write>
     a06:	40000793          	li	a5,1024
     a0a:	06f51263          	bne	a0,a5,a6e <writebig+0xb0>
  for(i = 0; i < MAXFILE; i++){
     a0e:	2485                	addiw	s1,s1,1
     a10:	ff4493e3          	bne	s1,s4,9f6 <writebig+0x38>
  close(fd);
     a14:	854e                	mv	a0,s3
     a16:	0a8040ef          	jal	4abe <close>
  fd = open("big", O_RDONLY);
     a1a:	4581                	li	a1,0
     a1c:	00005517          	auipc	a0,0x5
     a20:	ab450513          	addi	a0,a0,-1356 # 54d0 <malloc+0x538>
     a24:	0b2040ef          	jal	4ad6 <open>
     a28:	89aa                	mv	s3,a0
  n = 0;
     a2a:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a2c:	0000c917          	auipc	s2,0xc
     a30:	24c90913          	addi	s2,s2,588 # cc78 <buf>
  if(fd < 0){
     a34:	04054863          	bltz	a0,a84 <writebig+0xc6>
    i = read(fd, buf, BSIZE);
     a38:	40000613          	li	a2,1024
     a3c:	85ca                	mv	a1,s2
     a3e:	854e                	mv	a0,s3
     a40:	06e040ef          	jal	4aae <read>
    if(i == 0){
     a44:	c931                	beqz	a0,a98 <writebig+0xda>
    } else if(i != BSIZE){
     a46:	40000793          	li	a5,1024
     a4a:	08f51a63          	bne	a0,a5,ade <writebig+0x120>
    if(((int*)buf)[0] != n){
     a4e:	00092683          	lw	a3,0(s2)
     a52:	0a969163          	bne	a3,s1,af4 <writebig+0x136>
    n++;
     a56:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a58:	b7c5                	j	a38 <writebig+0x7a>
    printf("%s: error: creat big failed!\n", s);
     a5a:	85d6                	mv	a1,s5
     a5c:	00005517          	auipc	a0,0x5
     a60:	a7c50513          	addi	a0,a0,-1412 # 54d8 <malloc+0x540>
     a64:	480040ef          	jal	4ee4 <printf>
    exit(1);
     a68:	4505                	li	a0,1
     a6a:	02c040ef          	jal	4a96 <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     a6e:	8626                	mv	a2,s1
     a70:	85d6                	mv	a1,s5
     a72:	00005517          	auipc	a0,0x5
     a76:	a8650513          	addi	a0,a0,-1402 # 54f8 <malloc+0x560>
     a7a:	46a040ef          	jal	4ee4 <printf>
      exit(1);
     a7e:	4505                	li	a0,1
     a80:	016040ef          	jal	4a96 <exit>
    printf("%s: error: open big failed!\n", s);
     a84:	85d6                	mv	a1,s5
     a86:	00005517          	auipc	a0,0x5
     a8a:	a9a50513          	addi	a0,a0,-1382 # 5520 <malloc+0x588>
     a8e:	456040ef          	jal	4ee4 <printf>
    exit(1);
     a92:	4505                	li	a0,1
     a94:	002040ef          	jal	4a96 <exit>
      if(n != MAXFILE){
     a98:	10c00793          	li	a5,268
     a9c:	02f49663          	bne	s1,a5,ac8 <writebig+0x10a>
  close(fd);
     aa0:	854e                	mv	a0,s3
     aa2:	01c040ef          	jal	4abe <close>
  if(unlink("big") < 0){
     aa6:	00005517          	auipc	a0,0x5
     aaa:	a2a50513          	addi	a0,a0,-1494 # 54d0 <malloc+0x538>
     aae:	038040ef          	jal	4ae6 <unlink>
     ab2:	04054c63          	bltz	a0,b0a <writebig+0x14c>
}
     ab6:	70e2                	ld	ra,56(sp)
     ab8:	7442                	ld	s0,48(sp)
     aba:	74a2                	ld	s1,40(sp)
     abc:	7902                	ld	s2,32(sp)
     abe:	69e2                	ld	s3,24(sp)
     ac0:	6a42                	ld	s4,16(sp)
     ac2:	6aa2                	ld	s5,8(sp)
     ac4:	6121                	addi	sp,sp,64
     ac6:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ac8:	8626                	mv	a2,s1
     aca:	85d6                	mv	a1,s5
     acc:	00005517          	auipc	a0,0x5
     ad0:	a7450513          	addi	a0,a0,-1420 # 5540 <malloc+0x5a8>
     ad4:	410040ef          	jal	4ee4 <printf>
        exit(1);
     ad8:	4505                	li	a0,1
     ada:	7bd030ef          	jal	4a96 <exit>
      printf("%s: read failed %d\n", s, i);
     ade:	862a                	mv	a2,a0
     ae0:	85d6                	mv	a1,s5
     ae2:	00005517          	auipc	a0,0x5
     ae6:	a8650513          	addi	a0,a0,-1402 # 5568 <malloc+0x5d0>
     aea:	3fa040ef          	jal	4ee4 <printf>
      exit(1);
     aee:	4505                	li	a0,1
     af0:	7a7030ef          	jal	4a96 <exit>
      printf("%s: read content of block %d is %d\n", s,
     af4:	8626                	mv	a2,s1
     af6:	85d6                	mv	a1,s5
     af8:	00005517          	auipc	a0,0x5
     afc:	a8850513          	addi	a0,a0,-1400 # 5580 <malloc+0x5e8>
     b00:	3e4040ef          	jal	4ee4 <printf>
      exit(1);
     b04:	4505                	li	a0,1
     b06:	791030ef          	jal	4a96 <exit>
    printf("%s: unlink big failed\n", s);
     b0a:	85d6                	mv	a1,s5
     b0c:	00005517          	auipc	a0,0x5
     b10:	a9c50513          	addi	a0,a0,-1380 # 55a8 <malloc+0x610>
     b14:	3d0040ef          	jal	4ee4 <printf>
    exit(1);
     b18:	4505                	li	a0,1
     b1a:	77d030ef          	jal	4a96 <exit>

0000000000000b1e <unlinkread>:
{
     b1e:	7179                	addi	sp,sp,-48
     b20:	f406                	sd	ra,40(sp)
     b22:	f022                	sd	s0,32(sp)
     b24:	ec26                	sd	s1,24(sp)
     b26:	e84a                	sd	s2,16(sp)
     b28:	e44e                	sd	s3,8(sp)
     b2a:	1800                	addi	s0,sp,48
     b2c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b2e:	20200593          	li	a1,514
     b32:	00005517          	auipc	a0,0x5
     b36:	a8e50513          	addi	a0,a0,-1394 # 55c0 <malloc+0x628>
     b3a:	79d030ef          	jal	4ad6 <open>
  if(fd < 0){
     b3e:	0a054f63          	bltz	a0,bfc <unlinkread+0xde>
     b42:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b44:	4615                	li	a2,5
     b46:	00005597          	auipc	a1,0x5
     b4a:	aaa58593          	addi	a1,a1,-1366 # 55f0 <malloc+0x658>
     b4e:	769030ef          	jal	4ab6 <write>
  close(fd);
     b52:	8526                	mv	a0,s1
     b54:	76b030ef          	jal	4abe <close>
  fd = open("unlinkread", O_RDWR);
     b58:	4589                	li	a1,2
     b5a:	00005517          	auipc	a0,0x5
     b5e:	a6650513          	addi	a0,a0,-1434 # 55c0 <malloc+0x628>
     b62:	775030ef          	jal	4ad6 <open>
     b66:	84aa                	mv	s1,a0
  if(fd < 0){
     b68:	0a054463          	bltz	a0,c10 <unlinkread+0xf2>
  if(unlink("unlinkread") != 0){
     b6c:	00005517          	auipc	a0,0x5
     b70:	a5450513          	addi	a0,a0,-1452 # 55c0 <malloc+0x628>
     b74:	773030ef          	jal	4ae6 <unlink>
     b78:	e555                	bnez	a0,c24 <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     b7a:	20200593          	li	a1,514
     b7e:	00005517          	auipc	a0,0x5
     b82:	a4250513          	addi	a0,a0,-1470 # 55c0 <malloc+0x628>
     b86:	751030ef          	jal	4ad6 <open>
     b8a:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     b8c:	460d                	li	a2,3
     b8e:	00005597          	auipc	a1,0x5
     b92:	aaa58593          	addi	a1,a1,-1366 # 5638 <malloc+0x6a0>
     b96:	721030ef          	jal	4ab6 <write>
  close(fd1);
     b9a:	854a                	mv	a0,s2
     b9c:	723030ef          	jal	4abe <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     ba0:	660d                	lui	a2,0x3
     ba2:	0000c597          	auipc	a1,0xc
     ba6:	0d658593          	addi	a1,a1,214 # cc78 <buf>
     baa:	8526                	mv	a0,s1
     bac:	703030ef          	jal	4aae <read>
     bb0:	4795                	li	a5,5
     bb2:	08f51363          	bne	a0,a5,c38 <unlinkread+0x11a>
  if(buf[0] != 'h'){
     bb6:	0000c717          	auipc	a4,0xc
     bba:	0c274703          	lbu	a4,194(a4) # cc78 <buf>
     bbe:	06800793          	li	a5,104
     bc2:	08f71563          	bne	a4,a5,c4c <unlinkread+0x12e>
  if(write(fd, buf, 10) != 10){
     bc6:	4629                	li	a2,10
     bc8:	0000c597          	auipc	a1,0xc
     bcc:	0b058593          	addi	a1,a1,176 # cc78 <buf>
     bd0:	8526                	mv	a0,s1
     bd2:	6e5030ef          	jal	4ab6 <write>
     bd6:	47a9                	li	a5,10
     bd8:	08f51463          	bne	a0,a5,c60 <unlinkread+0x142>
  close(fd);
     bdc:	8526                	mv	a0,s1
     bde:	6e1030ef          	jal	4abe <close>
  unlink("unlinkread");
     be2:	00005517          	auipc	a0,0x5
     be6:	9de50513          	addi	a0,a0,-1570 # 55c0 <malloc+0x628>
     bea:	6fd030ef          	jal	4ae6 <unlink>
}
     bee:	70a2                	ld	ra,40(sp)
     bf0:	7402                	ld	s0,32(sp)
     bf2:	64e2                	ld	s1,24(sp)
     bf4:	6942                	ld	s2,16(sp)
     bf6:	69a2                	ld	s3,8(sp)
     bf8:	6145                	addi	sp,sp,48
     bfa:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     bfc:	85ce                	mv	a1,s3
     bfe:	00005517          	auipc	a0,0x5
     c02:	9d250513          	addi	a0,a0,-1582 # 55d0 <malloc+0x638>
     c06:	2de040ef          	jal	4ee4 <printf>
    exit(1);
     c0a:	4505                	li	a0,1
     c0c:	68b030ef          	jal	4a96 <exit>
    printf("%s: open unlinkread failed\n", s);
     c10:	85ce                	mv	a1,s3
     c12:	00005517          	auipc	a0,0x5
     c16:	9e650513          	addi	a0,a0,-1562 # 55f8 <malloc+0x660>
     c1a:	2ca040ef          	jal	4ee4 <printf>
    exit(1);
     c1e:	4505                	li	a0,1
     c20:	677030ef          	jal	4a96 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c24:	85ce                	mv	a1,s3
     c26:	00005517          	auipc	a0,0x5
     c2a:	9f250513          	addi	a0,a0,-1550 # 5618 <malloc+0x680>
     c2e:	2b6040ef          	jal	4ee4 <printf>
    exit(1);
     c32:	4505                	li	a0,1
     c34:	663030ef          	jal	4a96 <exit>
    printf("%s: unlinkread read failed", s);
     c38:	85ce                	mv	a1,s3
     c3a:	00005517          	auipc	a0,0x5
     c3e:	a0650513          	addi	a0,a0,-1530 # 5640 <malloc+0x6a8>
     c42:	2a2040ef          	jal	4ee4 <printf>
    exit(1);
     c46:	4505                	li	a0,1
     c48:	64f030ef          	jal	4a96 <exit>
    printf("%s: unlinkread wrong data\n", s);
     c4c:	85ce                	mv	a1,s3
     c4e:	00005517          	auipc	a0,0x5
     c52:	a1250513          	addi	a0,a0,-1518 # 5660 <malloc+0x6c8>
     c56:	28e040ef          	jal	4ee4 <printf>
    exit(1);
     c5a:	4505                	li	a0,1
     c5c:	63b030ef          	jal	4a96 <exit>
    printf("%s: unlinkread write failed\n", s);
     c60:	85ce                	mv	a1,s3
     c62:	00005517          	auipc	a0,0x5
     c66:	a1e50513          	addi	a0,a0,-1506 # 5680 <malloc+0x6e8>
     c6a:	27a040ef          	jal	4ee4 <printf>
    exit(1);
     c6e:	4505                	li	a0,1
     c70:	627030ef          	jal	4a96 <exit>

0000000000000c74 <linktest>:
{
     c74:	1101                	addi	sp,sp,-32
     c76:	ec06                	sd	ra,24(sp)
     c78:	e822                	sd	s0,16(sp)
     c7a:	e426                	sd	s1,8(sp)
     c7c:	e04a                	sd	s2,0(sp)
     c7e:	1000                	addi	s0,sp,32
     c80:	892a                	mv	s2,a0
  unlink("lf1");
     c82:	00005517          	auipc	a0,0x5
     c86:	a1e50513          	addi	a0,a0,-1506 # 56a0 <malloc+0x708>
     c8a:	65d030ef          	jal	4ae6 <unlink>
  unlink("lf2");
     c8e:	00005517          	auipc	a0,0x5
     c92:	a1a50513          	addi	a0,a0,-1510 # 56a8 <malloc+0x710>
     c96:	651030ef          	jal	4ae6 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     c9a:	20200593          	li	a1,514
     c9e:	00005517          	auipc	a0,0x5
     ca2:	a0250513          	addi	a0,a0,-1534 # 56a0 <malloc+0x708>
     ca6:	631030ef          	jal	4ad6 <open>
  if(fd < 0){
     caa:	0c054f63          	bltz	a0,d88 <linktest+0x114>
     cae:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     cb0:	4615                	li	a2,5
     cb2:	00005597          	auipc	a1,0x5
     cb6:	93e58593          	addi	a1,a1,-1730 # 55f0 <malloc+0x658>
     cba:	5fd030ef          	jal	4ab6 <write>
     cbe:	4795                	li	a5,5
     cc0:	0cf51e63          	bne	a0,a5,d9c <linktest+0x128>
  close(fd);
     cc4:	8526                	mv	a0,s1
     cc6:	5f9030ef          	jal	4abe <close>
  if(link("lf1", "lf2") < 0){
     cca:	00005597          	auipc	a1,0x5
     cce:	9de58593          	addi	a1,a1,-1570 # 56a8 <malloc+0x710>
     cd2:	00005517          	auipc	a0,0x5
     cd6:	9ce50513          	addi	a0,a0,-1586 # 56a0 <malloc+0x708>
     cda:	61d030ef          	jal	4af6 <link>
     cde:	0c054963          	bltz	a0,db0 <linktest+0x13c>
  unlink("lf1");
     ce2:	00005517          	auipc	a0,0x5
     ce6:	9be50513          	addi	a0,a0,-1602 # 56a0 <malloc+0x708>
     cea:	5fd030ef          	jal	4ae6 <unlink>
  if(open("lf1", 0) >= 0){
     cee:	4581                	li	a1,0
     cf0:	00005517          	auipc	a0,0x5
     cf4:	9b050513          	addi	a0,a0,-1616 # 56a0 <malloc+0x708>
     cf8:	5df030ef          	jal	4ad6 <open>
     cfc:	0c055463          	bgez	a0,dc4 <linktest+0x150>
  fd = open("lf2", 0);
     d00:	4581                	li	a1,0
     d02:	00005517          	auipc	a0,0x5
     d06:	9a650513          	addi	a0,a0,-1626 # 56a8 <malloc+0x710>
     d0a:	5cd030ef          	jal	4ad6 <open>
     d0e:	84aa                	mv	s1,a0
  if(fd < 0){
     d10:	0c054463          	bltz	a0,dd8 <linktest+0x164>
  if(read(fd, buf, sizeof(buf)) != SZ){
     d14:	660d                	lui	a2,0x3
     d16:	0000c597          	auipc	a1,0xc
     d1a:	f6258593          	addi	a1,a1,-158 # cc78 <buf>
     d1e:	591030ef          	jal	4aae <read>
     d22:	4795                	li	a5,5
     d24:	0cf51463          	bne	a0,a5,dec <linktest+0x178>
  close(fd);
     d28:	8526                	mv	a0,s1
     d2a:	595030ef          	jal	4abe <close>
  if(link("lf2", "lf2") >= 0){
     d2e:	00005597          	auipc	a1,0x5
     d32:	97a58593          	addi	a1,a1,-1670 # 56a8 <malloc+0x710>
     d36:	852e                	mv	a0,a1
     d38:	5bf030ef          	jal	4af6 <link>
     d3c:	0c055263          	bgez	a0,e00 <linktest+0x18c>
  unlink("lf2");
     d40:	00005517          	auipc	a0,0x5
     d44:	96850513          	addi	a0,a0,-1688 # 56a8 <malloc+0x710>
     d48:	59f030ef          	jal	4ae6 <unlink>
  if(link("lf2", "lf1") >= 0){
     d4c:	00005597          	auipc	a1,0x5
     d50:	95458593          	addi	a1,a1,-1708 # 56a0 <malloc+0x708>
     d54:	00005517          	auipc	a0,0x5
     d58:	95450513          	addi	a0,a0,-1708 # 56a8 <malloc+0x710>
     d5c:	59b030ef          	jal	4af6 <link>
     d60:	0a055a63          	bgez	a0,e14 <linktest+0x1a0>
  if(link(".", "lf1") >= 0){
     d64:	00005597          	auipc	a1,0x5
     d68:	93c58593          	addi	a1,a1,-1732 # 56a0 <malloc+0x708>
     d6c:	00005517          	auipc	a0,0x5
     d70:	a4450513          	addi	a0,a0,-1468 # 57b0 <malloc+0x818>
     d74:	583030ef          	jal	4af6 <link>
     d78:	0a055863          	bgez	a0,e28 <linktest+0x1b4>
}
     d7c:	60e2                	ld	ra,24(sp)
     d7e:	6442                	ld	s0,16(sp)
     d80:	64a2                	ld	s1,8(sp)
     d82:	6902                	ld	s2,0(sp)
     d84:	6105                	addi	sp,sp,32
     d86:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     d88:	85ca                	mv	a1,s2
     d8a:	00005517          	auipc	a0,0x5
     d8e:	92650513          	addi	a0,a0,-1754 # 56b0 <malloc+0x718>
     d92:	152040ef          	jal	4ee4 <printf>
    exit(1);
     d96:	4505                	li	a0,1
     d98:	4ff030ef          	jal	4a96 <exit>
    printf("%s: write lf1 failed\n", s);
     d9c:	85ca                	mv	a1,s2
     d9e:	00005517          	auipc	a0,0x5
     da2:	92a50513          	addi	a0,a0,-1750 # 56c8 <malloc+0x730>
     da6:	13e040ef          	jal	4ee4 <printf>
    exit(1);
     daa:	4505                	li	a0,1
     dac:	4eb030ef          	jal	4a96 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     db0:	85ca                	mv	a1,s2
     db2:	00005517          	auipc	a0,0x5
     db6:	92e50513          	addi	a0,a0,-1746 # 56e0 <malloc+0x748>
     dba:	12a040ef          	jal	4ee4 <printf>
    exit(1);
     dbe:	4505                	li	a0,1
     dc0:	4d7030ef          	jal	4a96 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     dc4:	85ca                	mv	a1,s2
     dc6:	00005517          	auipc	a0,0x5
     dca:	93a50513          	addi	a0,a0,-1734 # 5700 <malloc+0x768>
     dce:	116040ef          	jal	4ee4 <printf>
    exit(1);
     dd2:	4505                	li	a0,1
     dd4:	4c3030ef          	jal	4a96 <exit>
    printf("%s: open lf2 failed\n", s);
     dd8:	85ca                	mv	a1,s2
     dda:	00005517          	auipc	a0,0x5
     dde:	95650513          	addi	a0,a0,-1706 # 5730 <malloc+0x798>
     de2:	102040ef          	jal	4ee4 <printf>
    exit(1);
     de6:	4505                	li	a0,1
     de8:	4af030ef          	jal	4a96 <exit>
    printf("%s: read lf2 failed\n", s);
     dec:	85ca                	mv	a1,s2
     dee:	00005517          	auipc	a0,0x5
     df2:	95a50513          	addi	a0,a0,-1702 # 5748 <malloc+0x7b0>
     df6:	0ee040ef          	jal	4ee4 <printf>
    exit(1);
     dfa:	4505                	li	a0,1
     dfc:	49b030ef          	jal	4a96 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e00:	85ca                	mv	a1,s2
     e02:	00005517          	auipc	a0,0x5
     e06:	95e50513          	addi	a0,a0,-1698 # 5760 <malloc+0x7c8>
     e0a:	0da040ef          	jal	4ee4 <printf>
    exit(1);
     e0e:	4505                	li	a0,1
     e10:	487030ef          	jal	4a96 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e14:	85ca                	mv	a1,s2
     e16:	00005517          	auipc	a0,0x5
     e1a:	97250513          	addi	a0,a0,-1678 # 5788 <malloc+0x7f0>
     e1e:	0c6040ef          	jal	4ee4 <printf>
    exit(1);
     e22:	4505                	li	a0,1
     e24:	473030ef          	jal	4a96 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e28:	85ca                	mv	a1,s2
     e2a:	00005517          	auipc	a0,0x5
     e2e:	98e50513          	addi	a0,a0,-1650 # 57b8 <malloc+0x820>
     e32:	0b2040ef          	jal	4ee4 <printf>
    exit(1);
     e36:	4505                	li	a0,1
     e38:	45f030ef          	jal	4a96 <exit>

0000000000000e3c <validatetest>:
{
     e3c:	7139                	addi	sp,sp,-64
     e3e:	fc06                	sd	ra,56(sp)
     e40:	f822                	sd	s0,48(sp)
     e42:	f426                	sd	s1,40(sp)
     e44:	f04a                	sd	s2,32(sp)
     e46:	ec4e                	sd	s3,24(sp)
     e48:	e852                	sd	s4,16(sp)
     e4a:	e456                	sd	s5,8(sp)
     e4c:	e05a                	sd	s6,0(sp)
     e4e:	0080                	addi	s0,sp,64
     e50:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     e52:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
     e54:	00005997          	auipc	s3,0x5
     e58:	98498993          	addi	s3,s3,-1660 # 57d8 <malloc+0x840>
     e5c:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     e5e:	6a85                	lui	s5,0x1
     e60:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
     e64:	85a6                	mv	a1,s1
     e66:	854e                	mv	a0,s3
     e68:	48f030ef          	jal	4af6 <link>
     e6c:	01251f63          	bne	a0,s2,e8a <validatetest+0x4e>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     e70:	94d6                	add	s1,s1,s5
     e72:	ff4499e3          	bne	s1,s4,e64 <validatetest+0x28>
}
     e76:	70e2                	ld	ra,56(sp)
     e78:	7442                	ld	s0,48(sp)
     e7a:	74a2                	ld	s1,40(sp)
     e7c:	7902                	ld	s2,32(sp)
     e7e:	69e2                	ld	s3,24(sp)
     e80:	6a42                	ld	s4,16(sp)
     e82:	6aa2                	ld	s5,8(sp)
     e84:	6b02                	ld	s6,0(sp)
     e86:	6121                	addi	sp,sp,64
     e88:	8082                	ret
      printf("%s: link should not succeed\n", s);
     e8a:	85da                	mv	a1,s6
     e8c:	00005517          	auipc	a0,0x5
     e90:	95c50513          	addi	a0,a0,-1700 # 57e8 <malloc+0x850>
     e94:	050040ef          	jal	4ee4 <printf>
      exit(1);
     e98:	4505                	li	a0,1
     e9a:	3fd030ef          	jal	4a96 <exit>

0000000000000e9e <bigdir>:
{
     e9e:	715d                	addi	sp,sp,-80
     ea0:	e486                	sd	ra,72(sp)
     ea2:	e0a2                	sd	s0,64(sp)
     ea4:	fc26                	sd	s1,56(sp)
     ea6:	f84a                	sd	s2,48(sp)
     ea8:	f44e                	sd	s3,40(sp)
     eaa:	f052                	sd	s4,32(sp)
     eac:	ec56                	sd	s5,24(sp)
     eae:	e85a                	sd	s6,16(sp)
     eb0:	0880                	addi	s0,sp,80
     eb2:	89aa                	mv	s3,a0
  unlink("bd");
     eb4:	00005517          	auipc	a0,0x5
     eb8:	95450513          	addi	a0,a0,-1708 # 5808 <malloc+0x870>
     ebc:	42b030ef          	jal	4ae6 <unlink>
  fd = open("bd", O_CREATE);
     ec0:	20000593          	li	a1,512
     ec4:	00005517          	auipc	a0,0x5
     ec8:	94450513          	addi	a0,a0,-1724 # 5808 <malloc+0x870>
     ecc:	40b030ef          	jal	4ad6 <open>
  if(fd < 0){
     ed0:	0c054163          	bltz	a0,f92 <bigdir+0xf4>
  close(fd);
     ed4:	3eb030ef          	jal	4abe <close>
  for(i = 0; i < N; i++){
     ed8:	4901                	li	s2,0
    name[0] = 'x';
     eda:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     ede:	00005a17          	auipc	s4,0x5
     ee2:	92aa0a13          	addi	s4,s4,-1750 # 5808 <malloc+0x870>
  for(i = 0; i < N; i++){
     ee6:	1f400b13          	li	s6,500
    name[0] = 'x';
     eea:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     eee:	41f9571b          	sraiw	a4,s2,0x1f
     ef2:	01a7571b          	srliw	a4,a4,0x1a
     ef6:	012707bb          	addw	a5,a4,s2
     efa:	4067d69b          	sraiw	a3,a5,0x6
     efe:	0306869b          	addiw	a3,a3,48
     f02:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f06:	03f7f793          	andi	a5,a5,63
     f0a:	9f99                	subw	a5,a5,a4
     f0c:	0307879b          	addiw	a5,a5,48
     f10:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f14:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
     f18:	fb040593          	addi	a1,s0,-80
     f1c:	8552                	mv	a0,s4
     f1e:	3d9030ef          	jal	4af6 <link>
     f22:	84aa                	mv	s1,a0
     f24:	e149                	bnez	a0,fa6 <bigdir+0x108>
  for(i = 0; i < N; i++){
     f26:	2905                	addiw	s2,s2,1
     f28:	fd6911e3          	bne	s2,s6,eea <bigdir+0x4c>
  unlink("bd");
     f2c:	00005517          	auipc	a0,0x5
     f30:	8dc50513          	addi	a0,a0,-1828 # 5808 <malloc+0x870>
     f34:	3b3030ef          	jal	4ae6 <unlink>
    name[0] = 'x';
     f38:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
     f3c:	1f400a13          	li	s4,500
    name[0] = 'x';
     f40:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
     f44:	41f4d71b          	sraiw	a4,s1,0x1f
     f48:	01a7571b          	srliw	a4,a4,0x1a
     f4c:	009707bb          	addw	a5,a4,s1
     f50:	4067d69b          	sraiw	a3,a5,0x6
     f54:	0306869b          	addiw	a3,a3,48
     f58:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f5c:	03f7f793          	andi	a5,a5,63
     f60:	9f99                	subw	a5,a5,a4
     f62:	0307879b          	addiw	a5,a5,48
     f66:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f6a:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
     f6e:	fb040513          	addi	a0,s0,-80
     f72:	375030ef          	jal	4ae6 <unlink>
     f76:	e529                	bnez	a0,fc0 <bigdir+0x122>
  for(i = 0; i < N; i++){
     f78:	2485                	addiw	s1,s1,1
     f7a:	fd4493e3          	bne	s1,s4,f40 <bigdir+0xa2>
}
     f7e:	60a6                	ld	ra,72(sp)
     f80:	6406                	ld	s0,64(sp)
     f82:	74e2                	ld	s1,56(sp)
     f84:	7942                	ld	s2,48(sp)
     f86:	79a2                	ld	s3,40(sp)
     f88:	7a02                	ld	s4,32(sp)
     f8a:	6ae2                	ld	s5,24(sp)
     f8c:	6b42                	ld	s6,16(sp)
     f8e:	6161                	addi	sp,sp,80
     f90:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     f92:	85ce                	mv	a1,s3
     f94:	00005517          	auipc	a0,0x5
     f98:	87c50513          	addi	a0,a0,-1924 # 5810 <malloc+0x878>
     f9c:	749030ef          	jal	4ee4 <printf>
    exit(1);
     fa0:	4505                	li	a0,1
     fa2:	2f5030ef          	jal	4a96 <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
     fa6:	fb040693          	addi	a3,s0,-80
     faa:	864a                	mv	a2,s2
     fac:	85ce                	mv	a1,s3
     fae:	00005517          	auipc	a0,0x5
     fb2:	88250513          	addi	a0,a0,-1918 # 5830 <malloc+0x898>
     fb6:	72f030ef          	jal	4ee4 <printf>
      exit(1);
     fba:	4505                	li	a0,1
     fbc:	2db030ef          	jal	4a96 <exit>
      printf("%s: bigdir unlink failed", s);
     fc0:	85ce                	mv	a1,s3
     fc2:	00005517          	auipc	a0,0x5
     fc6:	89650513          	addi	a0,a0,-1898 # 5858 <malloc+0x8c0>
     fca:	71b030ef          	jal	4ee4 <printf>
      exit(1);
     fce:	4505                	li	a0,1
     fd0:	2c7030ef          	jal	4a96 <exit>

0000000000000fd4 <pgbug>:
{
     fd4:	7179                	addi	sp,sp,-48
     fd6:	f406                	sd	ra,40(sp)
     fd8:	f022                	sd	s0,32(sp)
     fda:	ec26                	sd	s1,24(sp)
     fdc:	1800                	addi	s0,sp,48
  argv[0] = 0;
     fde:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
     fe2:	00008497          	auipc	s1,0x8
     fe6:	01e48493          	addi	s1,s1,30 # 9000 <big>
     fea:	fd840593          	addi	a1,s0,-40
     fee:	6088                	ld	a0,0(s1)
     ff0:	2df030ef          	jal	4ace <exec>
  pipe(big);
     ff4:	6088                	ld	a0,0(s1)
     ff6:	2b1030ef          	jal	4aa6 <pipe>
  exit(0);
     ffa:	4501                	li	a0,0
     ffc:	29b030ef          	jal	4a96 <exit>

0000000000001000 <badarg>:
{
    1000:	7139                	addi	sp,sp,-64
    1002:	fc06                	sd	ra,56(sp)
    1004:	f822                	sd	s0,48(sp)
    1006:	f426                	sd	s1,40(sp)
    1008:	f04a                	sd	s2,32(sp)
    100a:	ec4e                	sd	s3,24(sp)
    100c:	0080                	addi	s0,sp,64
    100e:	64b1                	lui	s1,0xc
    1010:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    1014:	597d                	li	s2,-1
    1016:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    101a:	00004997          	auipc	s3,0x4
    101e:	0ae98993          	addi	s3,s3,174 # 50c8 <malloc+0x130>
    argv[0] = (char*)0xffffffff;
    1022:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1026:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    102a:	fc040593          	addi	a1,s0,-64
    102e:	854e                	mv	a0,s3
    1030:	29f030ef          	jal	4ace <exec>
  for(int i = 0; i < 50000; i++){
    1034:	34fd                	addiw	s1,s1,-1
    1036:	f4f5                	bnez	s1,1022 <badarg+0x22>
  exit(0);
    1038:	4501                	li	a0,0
    103a:	25d030ef          	jal	4a96 <exit>

000000000000103e <copyinstr2>:
{
    103e:	7155                	addi	sp,sp,-208
    1040:	e586                	sd	ra,200(sp)
    1042:	e1a2                	sd	s0,192(sp)
    1044:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    1046:	f6840793          	addi	a5,s0,-152
    104a:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    104e:	07800713          	li	a4,120
    1052:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    1056:	0785                	addi	a5,a5,1
    1058:	fed79de3          	bne	a5,a3,1052 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    105c:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    1060:	f6840513          	addi	a0,s0,-152
    1064:	283030ef          	jal	4ae6 <unlink>
  if(ret != -1){
    1068:	57fd                	li	a5,-1
    106a:	0cf51263          	bne	a0,a5,112e <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    106e:	20100593          	li	a1,513
    1072:	f6840513          	addi	a0,s0,-152
    1076:	261030ef          	jal	4ad6 <open>
  if(fd != -1){
    107a:	57fd                	li	a5,-1
    107c:	0cf51563          	bne	a0,a5,1146 <copyinstr2+0x108>
  ret = link(b, b);
    1080:	f6840593          	addi	a1,s0,-152
    1084:	852e                	mv	a0,a1
    1086:	271030ef          	jal	4af6 <link>
  if(ret != -1){
    108a:	57fd                	li	a5,-1
    108c:	0cf51963          	bne	a0,a5,115e <copyinstr2+0x120>
  char *args[] = { "xx", 0 };
    1090:	00006797          	auipc	a5,0x6
    1094:	91878793          	addi	a5,a5,-1768 # 69a8 <malloc+0x1a10>
    1098:	f4f43c23          	sd	a5,-168(s0)
    109c:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    10a0:	f5840593          	addi	a1,s0,-168
    10a4:	f6840513          	addi	a0,s0,-152
    10a8:	227030ef          	jal	4ace <exec>
  if(ret != -1){
    10ac:	57fd                	li	a5,-1
    10ae:	0cf51563          	bne	a0,a5,1178 <copyinstr2+0x13a>
  int pid = fork();
    10b2:	1dd030ef          	jal	4a8e <fork>
  if(pid < 0){
    10b6:	0c054d63          	bltz	a0,1190 <copyinstr2+0x152>
  if(pid == 0){
    10ba:	0e051863          	bnez	a0,11aa <copyinstr2+0x16c>
    10be:	00008797          	auipc	a5,0x8
    10c2:	4a278793          	addi	a5,a5,1186 # 9560 <big.0>
    10c6:	00009697          	auipc	a3,0x9
    10ca:	49a68693          	addi	a3,a3,1178 # a560 <big.0+0x1000>
      big[i] = 'x';
    10ce:	07800713          	li	a4,120
    10d2:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    10d6:	0785                	addi	a5,a5,1
    10d8:	fed79de3          	bne	a5,a3,10d2 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    10dc:	00009797          	auipc	a5,0x9
    10e0:	48078223          	sb	zero,1156(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    10e4:	00006797          	auipc	a5,0x6
    10e8:	34478793          	addi	a5,a5,836 # 7428 <malloc+0x2490>
    10ec:	6fb0                	ld	a2,88(a5)
    10ee:	73b4                	ld	a3,96(a5)
    10f0:	77b8                	ld	a4,104(a5)
    10f2:	7bbc                	ld	a5,112(a5)
    10f4:	f2c43823          	sd	a2,-208(s0)
    10f8:	f2d43c23          	sd	a3,-200(s0)
    10fc:	f4e43023          	sd	a4,-192(s0)
    1100:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1104:	f3040593          	addi	a1,s0,-208
    1108:	00004517          	auipc	a0,0x4
    110c:	fc050513          	addi	a0,a0,-64 # 50c8 <malloc+0x130>
    1110:	1bf030ef          	jal	4ace <exec>
    if(ret != -1){
    1114:	57fd                	li	a5,-1
    1116:	08f50663          	beq	a0,a5,11a2 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    111a:	55fd                	li	a1,-1
    111c:	00004517          	auipc	a0,0x4
    1120:	7e450513          	addi	a0,a0,2020 # 5900 <malloc+0x968>
    1124:	5c1030ef          	jal	4ee4 <printf>
      exit(1);
    1128:	4505                	li	a0,1
    112a:	16d030ef          	jal	4a96 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    112e:	862a                	mv	a2,a0
    1130:	f6840593          	addi	a1,s0,-152
    1134:	00004517          	auipc	a0,0x4
    1138:	74450513          	addi	a0,a0,1860 # 5878 <malloc+0x8e0>
    113c:	5a9030ef          	jal	4ee4 <printf>
    exit(1);
    1140:	4505                	li	a0,1
    1142:	155030ef          	jal	4a96 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1146:	862a                	mv	a2,a0
    1148:	f6840593          	addi	a1,s0,-152
    114c:	00004517          	auipc	a0,0x4
    1150:	74c50513          	addi	a0,a0,1868 # 5898 <malloc+0x900>
    1154:	591030ef          	jal	4ee4 <printf>
    exit(1);
    1158:	4505                	li	a0,1
    115a:	13d030ef          	jal	4a96 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    115e:	86aa                	mv	a3,a0
    1160:	f6840613          	addi	a2,s0,-152
    1164:	85b2                	mv	a1,a2
    1166:	00004517          	auipc	a0,0x4
    116a:	75250513          	addi	a0,a0,1874 # 58b8 <malloc+0x920>
    116e:	577030ef          	jal	4ee4 <printf>
    exit(1);
    1172:	4505                	li	a0,1
    1174:	123030ef          	jal	4a96 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1178:	567d                	li	a2,-1
    117a:	f6840593          	addi	a1,s0,-152
    117e:	00004517          	auipc	a0,0x4
    1182:	76250513          	addi	a0,a0,1890 # 58e0 <malloc+0x948>
    1186:	55f030ef          	jal	4ee4 <printf>
    exit(1);
    118a:	4505                	li	a0,1
    118c:	10b030ef          	jal	4a96 <exit>
    printf("fork failed\n");
    1190:	00006517          	auipc	a0,0x6
    1194:	d3850513          	addi	a0,a0,-712 # 6ec8 <malloc+0x1f30>
    1198:	54d030ef          	jal	4ee4 <printf>
    exit(1);
    119c:	4505                	li	a0,1
    119e:	0f9030ef          	jal	4a96 <exit>
    exit(747); // OK
    11a2:	2eb00513          	li	a0,747
    11a6:	0f1030ef          	jal	4a96 <exit>
  int st = 0;
    11aa:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    11ae:	f5440513          	addi	a0,s0,-172
    11b2:	0ed030ef          	jal	4a9e <wait>
  if(st != 747){
    11b6:	f5442703          	lw	a4,-172(s0)
    11ba:	2eb00793          	li	a5,747
    11be:	00f71663          	bne	a4,a5,11ca <copyinstr2+0x18c>
}
    11c2:	60ae                	ld	ra,200(sp)
    11c4:	640e                	ld	s0,192(sp)
    11c6:	6169                	addi	sp,sp,208
    11c8:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    11ca:	00004517          	auipc	a0,0x4
    11ce:	75e50513          	addi	a0,a0,1886 # 5928 <malloc+0x990>
    11d2:	513030ef          	jal	4ee4 <printf>
    exit(1);
    11d6:	4505                	li	a0,1
    11d8:	0bf030ef          	jal	4a96 <exit>

00000000000011dc <truncate3>:
{
    11dc:	7159                	addi	sp,sp,-112
    11de:	f486                	sd	ra,104(sp)
    11e0:	f0a2                	sd	s0,96(sp)
    11e2:	e8ca                	sd	s2,80(sp)
    11e4:	1880                	addi	s0,sp,112
    11e6:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    11e8:	60100593          	li	a1,1537
    11ec:	00004517          	auipc	a0,0x4
    11f0:	f3450513          	addi	a0,a0,-204 # 5120 <malloc+0x188>
    11f4:	0e3030ef          	jal	4ad6 <open>
    11f8:	0c7030ef          	jal	4abe <close>
  pid = fork();
    11fc:	093030ef          	jal	4a8e <fork>
  if(pid < 0){
    1200:	06054663          	bltz	a0,126c <truncate3+0x90>
  if(pid == 0){
    1204:	e55d                	bnez	a0,12b2 <truncate3+0xd6>
    1206:	eca6                	sd	s1,88(sp)
    1208:	e4ce                	sd	s3,72(sp)
    120a:	e0d2                	sd	s4,64(sp)
    120c:	fc56                	sd	s5,56(sp)
    120e:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    1212:	00004a17          	auipc	s4,0x4
    1216:	f0ea0a13          	addi	s4,s4,-242 # 5120 <malloc+0x188>
      int n = write(fd, "1234567890", 10);
    121a:	00004a97          	auipc	s5,0x4
    121e:	76ea8a93          	addi	s5,s5,1902 # 5988 <malloc+0x9f0>
      int fd = open("truncfile", O_WRONLY);
    1222:	4585                	li	a1,1
    1224:	8552                	mv	a0,s4
    1226:	0b1030ef          	jal	4ad6 <open>
    122a:	84aa                	mv	s1,a0
      if(fd < 0){
    122c:	04054e63          	bltz	a0,1288 <truncate3+0xac>
      int n = write(fd, "1234567890", 10);
    1230:	4629                	li	a2,10
    1232:	85d6                	mv	a1,s5
    1234:	083030ef          	jal	4ab6 <write>
      if(n != 10){
    1238:	47a9                	li	a5,10
    123a:	06f51163          	bne	a0,a5,129c <truncate3+0xc0>
      close(fd);
    123e:	8526                	mv	a0,s1
    1240:	07f030ef          	jal	4abe <close>
      fd = open("truncfile", O_RDONLY);
    1244:	4581                	li	a1,0
    1246:	8552                	mv	a0,s4
    1248:	08f030ef          	jal	4ad6 <open>
    124c:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    124e:	02000613          	li	a2,32
    1252:	f9840593          	addi	a1,s0,-104
    1256:	059030ef          	jal	4aae <read>
      close(fd);
    125a:	8526                	mv	a0,s1
    125c:	063030ef          	jal	4abe <close>
    for(int i = 0; i < 100; i++){
    1260:	39fd                	addiw	s3,s3,-1
    1262:	fc0990e3          	bnez	s3,1222 <truncate3+0x46>
    exit(0);
    1266:	4501                	li	a0,0
    1268:	02f030ef          	jal	4a96 <exit>
    126c:	eca6                	sd	s1,88(sp)
    126e:	e4ce                	sd	s3,72(sp)
    1270:	e0d2                	sd	s4,64(sp)
    1272:	fc56                	sd	s5,56(sp)
    printf("%s: fork failed\n", s);
    1274:	85ca                	mv	a1,s2
    1276:	00004517          	auipc	a0,0x4
    127a:	6e250513          	addi	a0,a0,1762 # 5958 <malloc+0x9c0>
    127e:	467030ef          	jal	4ee4 <printf>
    exit(1);
    1282:	4505                	li	a0,1
    1284:	013030ef          	jal	4a96 <exit>
        printf("%s: open failed\n", s);
    1288:	85ca                	mv	a1,s2
    128a:	00004517          	auipc	a0,0x4
    128e:	6e650513          	addi	a0,a0,1766 # 5970 <malloc+0x9d8>
    1292:	453030ef          	jal	4ee4 <printf>
        exit(1);
    1296:	4505                	li	a0,1
    1298:	7fe030ef          	jal	4a96 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    129c:	862a                	mv	a2,a0
    129e:	85ca                	mv	a1,s2
    12a0:	00004517          	auipc	a0,0x4
    12a4:	6f850513          	addi	a0,a0,1784 # 5998 <malloc+0xa00>
    12a8:	43d030ef          	jal	4ee4 <printf>
        exit(1);
    12ac:	4505                	li	a0,1
    12ae:	7e8030ef          	jal	4a96 <exit>
    12b2:	eca6                	sd	s1,88(sp)
    12b4:	e4ce                	sd	s3,72(sp)
    12b6:	e0d2                	sd	s4,64(sp)
    12b8:	fc56                	sd	s5,56(sp)
    12ba:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    12be:	00004a17          	auipc	s4,0x4
    12c2:	e62a0a13          	addi	s4,s4,-414 # 5120 <malloc+0x188>
    int n = write(fd, "xxx", 3);
    12c6:	00004a97          	auipc	s5,0x4
    12ca:	6f2a8a93          	addi	s5,s5,1778 # 59b8 <malloc+0xa20>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    12ce:	60100593          	li	a1,1537
    12d2:	8552                	mv	a0,s4
    12d4:	003030ef          	jal	4ad6 <open>
    12d8:	84aa                	mv	s1,a0
    if(fd < 0){
    12da:	02054d63          	bltz	a0,1314 <truncate3+0x138>
    int n = write(fd, "xxx", 3);
    12de:	460d                	li	a2,3
    12e0:	85d6                	mv	a1,s5
    12e2:	7d4030ef          	jal	4ab6 <write>
    if(n != 3){
    12e6:	478d                	li	a5,3
    12e8:	04f51063          	bne	a0,a5,1328 <truncate3+0x14c>
    close(fd);
    12ec:	8526                	mv	a0,s1
    12ee:	7d0030ef          	jal	4abe <close>
  for(int i = 0; i < 150; i++){
    12f2:	39fd                	addiw	s3,s3,-1
    12f4:	fc099de3          	bnez	s3,12ce <truncate3+0xf2>
  wait(&xstatus);
    12f8:	fbc40513          	addi	a0,s0,-68
    12fc:	7a2030ef          	jal	4a9e <wait>
  unlink("truncfile");
    1300:	00004517          	auipc	a0,0x4
    1304:	e2050513          	addi	a0,a0,-480 # 5120 <malloc+0x188>
    1308:	7de030ef          	jal	4ae6 <unlink>
  exit(xstatus);
    130c:	fbc42503          	lw	a0,-68(s0)
    1310:	786030ef          	jal	4a96 <exit>
      printf("%s: open failed\n", s);
    1314:	85ca                	mv	a1,s2
    1316:	00004517          	auipc	a0,0x4
    131a:	65a50513          	addi	a0,a0,1626 # 5970 <malloc+0x9d8>
    131e:	3c7030ef          	jal	4ee4 <printf>
      exit(1);
    1322:	4505                	li	a0,1
    1324:	772030ef          	jal	4a96 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1328:	862a                	mv	a2,a0
    132a:	85ca                	mv	a1,s2
    132c:	00004517          	auipc	a0,0x4
    1330:	69450513          	addi	a0,a0,1684 # 59c0 <malloc+0xa28>
    1334:	3b1030ef          	jal	4ee4 <printf>
      exit(1);
    1338:	4505                	li	a0,1
    133a:	75c030ef          	jal	4a96 <exit>

000000000000133e <exectest>:
{
    133e:	715d                	addi	sp,sp,-80
    1340:	e486                	sd	ra,72(sp)
    1342:	e0a2                	sd	s0,64(sp)
    1344:	f84a                	sd	s2,48(sp)
    1346:	0880                	addi	s0,sp,80
    1348:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    134a:	00004797          	auipc	a5,0x4
    134e:	d7e78793          	addi	a5,a5,-642 # 50c8 <malloc+0x130>
    1352:	fcf43023          	sd	a5,-64(s0)
    1356:	00004797          	auipc	a5,0x4
    135a:	68a78793          	addi	a5,a5,1674 # 59e0 <malloc+0xa48>
    135e:	fcf43423          	sd	a5,-56(s0)
    1362:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1366:	00004517          	auipc	a0,0x4
    136a:	68250513          	addi	a0,a0,1666 # 59e8 <malloc+0xa50>
    136e:	778030ef          	jal	4ae6 <unlink>
  pid = fork();
    1372:	71c030ef          	jal	4a8e <fork>
  if(pid < 0) {
    1376:	02054f63          	bltz	a0,13b4 <exectest+0x76>
    137a:	fc26                	sd	s1,56(sp)
    137c:	84aa                	mv	s1,a0
  if(pid == 0) {
    137e:	e935                	bnez	a0,13f2 <exectest+0xb4>
    close(1);
    1380:	4505                	li	a0,1
    1382:	73c030ef          	jal	4abe <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1386:	20100593          	li	a1,513
    138a:	00004517          	auipc	a0,0x4
    138e:	65e50513          	addi	a0,a0,1630 # 59e8 <malloc+0xa50>
    1392:	744030ef          	jal	4ad6 <open>
    if(fd < 0) {
    1396:	02054a63          	bltz	a0,13ca <exectest+0x8c>
    if(fd != 1) {
    139a:	4785                	li	a5,1
    139c:	04f50163          	beq	a0,a5,13de <exectest+0xa0>
      printf("%s: wrong fd\n", s);
    13a0:	85ca                	mv	a1,s2
    13a2:	00004517          	auipc	a0,0x4
    13a6:	66650513          	addi	a0,a0,1638 # 5a08 <malloc+0xa70>
    13aa:	33b030ef          	jal	4ee4 <printf>
      exit(1);
    13ae:	4505                	li	a0,1
    13b0:	6e6030ef          	jal	4a96 <exit>
    13b4:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    13b6:	85ca                	mv	a1,s2
    13b8:	00004517          	auipc	a0,0x4
    13bc:	5a050513          	addi	a0,a0,1440 # 5958 <malloc+0x9c0>
    13c0:	325030ef          	jal	4ee4 <printf>
     exit(1);
    13c4:	4505                	li	a0,1
    13c6:	6d0030ef          	jal	4a96 <exit>
      printf("%s: create failed\n", s);
    13ca:	85ca                	mv	a1,s2
    13cc:	00004517          	auipc	a0,0x4
    13d0:	62450513          	addi	a0,a0,1572 # 59f0 <malloc+0xa58>
    13d4:	311030ef          	jal	4ee4 <printf>
      exit(1);
    13d8:	4505                	li	a0,1
    13da:	6bc030ef          	jal	4a96 <exit>
    if(exec("echo", echoargv) < 0){
    13de:	fc040593          	addi	a1,s0,-64
    13e2:	00004517          	auipc	a0,0x4
    13e6:	ce650513          	addi	a0,a0,-794 # 50c8 <malloc+0x130>
    13ea:	6e4030ef          	jal	4ace <exec>
    13ee:	00054d63          	bltz	a0,1408 <exectest+0xca>
  if (wait(&xstatus) != pid) {
    13f2:	fdc40513          	addi	a0,s0,-36
    13f6:	6a8030ef          	jal	4a9e <wait>
    13fa:	02951163          	bne	a0,s1,141c <exectest+0xde>
  if(xstatus != 0)
    13fe:	fdc42503          	lw	a0,-36(s0)
    1402:	c50d                	beqz	a0,142c <exectest+0xee>
    exit(xstatus);
    1404:	692030ef          	jal	4a96 <exit>
      printf("%s: exec echo failed\n", s);
    1408:	85ca                	mv	a1,s2
    140a:	00004517          	auipc	a0,0x4
    140e:	60e50513          	addi	a0,a0,1550 # 5a18 <malloc+0xa80>
    1412:	2d3030ef          	jal	4ee4 <printf>
      exit(1);
    1416:	4505                	li	a0,1
    1418:	67e030ef          	jal	4a96 <exit>
    printf("%s: wait failed!\n", s);
    141c:	85ca                	mv	a1,s2
    141e:	00004517          	auipc	a0,0x4
    1422:	61250513          	addi	a0,a0,1554 # 5a30 <malloc+0xa98>
    1426:	2bf030ef          	jal	4ee4 <printf>
    142a:	bfd1                	j	13fe <exectest+0xc0>
  fd = open("echo-ok", O_RDONLY);
    142c:	4581                	li	a1,0
    142e:	00004517          	auipc	a0,0x4
    1432:	5ba50513          	addi	a0,a0,1466 # 59e8 <malloc+0xa50>
    1436:	6a0030ef          	jal	4ad6 <open>
  if(fd < 0) {
    143a:	02054463          	bltz	a0,1462 <exectest+0x124>
  if (read(fd, buf, 2) != 2) {
    143e:	4609                	li	a2,2
    1440:	fb840593          	addi	a1,s0,-72
    1444:	66a030ef          	jal	4aae <read>
    1448:	4789                	li	a5,2
    144a:	02f50663          	beq	a0,a5,1476 <exectest+0x138>
    printf("%s: read failed\n", s);
    144e:	85ca                	mv	a1,s2
    1450:	00004517          	auipc	a0,0x4
    1454:	04850513          	addi	a0,a0,72 # 5498 <malloc+0x500>
    1458:	28d030ef          	jal	4ee4 <printf>
    exit(1);
    145c:	4505                	li	a0,1
    145e:	638030ef          	jal	4a96 <exit>
    printf("%s: open failed\n", s);
    1462:	85ca                	mv	a1,s2
    1464:	00004517          	auipc	a0,0x4
    1468:	50c50513          	addi	a0,a0,1292 # 5970 <malloc+0x9d8>
    146c:	279030ef          	jal	4ee4 <printf>
    exit(1);
    1470:	4505                	li	a0,1
    1472:	624030ef          	jal	4a96 <exit>
  unlink("echo-ok");
    1476:	00004517          	auipc	a0,0x4
    147a:	57250513          	addi	a0,a0,1394 # 59e8 <malloc+0xa50>
    147e:	668030ef          	jal	4ae6 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1482:	fb844703          	lbu	a4,-72(s0)
    1486:	04f00793          	li	a5,79
    148a:	00f71863          	bne	a4,a5,149a <exectest+0x15c>
    148e:	fb944703          	lbu	a4,-71(s0)
    1492:	04b00793          	li	a5,75
    1496:	00f70c63          	beq	a4,a5,14ae <exectest+0x170>
    printf("%s: wrong output\n", s);
    149a:	85ca                	mv	a1,s2
    149c:	00004517          	auipc	a0,0x4
    14a0:	5ac50513          	addi	a0,a0,1452 # 5a48 <malloc+0xab0>
    14a4:	241030ef          	jal	4ee4 <printf>
    exit(1);
    14a8:	4505                	li	a0,1
    14aa:	5ec030ef          	jal	4a96 <exit>
    exit(0);
    14ae:	4501                	li	a0,0
    14b0:	5e6030ef          	jal	4a96 <exit>

00000000000014b4 <pipe1>:
{
    14b4:	711d                	addi	sp,sp,-96
    14b6:	ec86                	sd	ra,88(sp)
    14b8:	e8a2                	sd	s0,80(sp)
    14ba:	fc4e                	sd	s3,56(sp)
    14bc:	1080                	addi	s0,sp,96
    14be:	89aa                	mv	s3,a0
  if(pipe(fds) != 0){
    14c0:	fa840513          	addi	a0,s0,-88
    14c4:	5e2030ef          	jal	4aa6 <pipe>
    14c8:	e92d                	bnez	a0,153a <pipe1+0x86>
    14ca:	e4a6                	sd	s1,72(sp)
    14cc:	f852                	sd	s4,48(sp)
    14ce:	84aa                	mv	s1,a0
  pid = fork();
    14d0:	5be030ef          	jal	4a8e <fork>
    14d4:	8a2a                	mv	s4,a0
  if(pid == 0){
    14d6:	c151                	beqz	a0,155a <pipe1+0xa6>
  } else if(pid > 0){
    14d8:	14a05e63          	blez	a0,1634 <pipe1+0x180>
    14dc:	e0ca                	sd	s2,64(sp)
    14de:	f456                	sd	s5,40(sp)
    close(fds[1]);
    14e0:	fac42503          	lw	a0,-84(s0)
    14e4:	5da030ef          	jal	4abe <close>
    total = 0;
    14e8:	8a26                	mv	s4,s1
    cc = 1;
    14ea:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    14ec:	0000ba97          	auipc	s5,0xb
    14f0:	78ca8a93          	addi	s5,s5,1932 # cc78 <buf>
    14f4:	864a                	mv	a2,s2
    14f6:	85d6                	mv	a1,s5
    14f8:	fa842503          	lw	a0,-88(s0)
    14fc:	5b2030ef          	jal	4aae <read>
    1500:	0ea05a63          	blez	a0,15f4 <pipe1+0x140>
      for(i = 0; i < n; i++){
    1504:	0000b717          	auipc	a4,0xb
    1508:	77470713          	addi	a4,a4,1908 # cc78 <buf>
    150c:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1510:	00074683          	lbu	a3,0(a4)
    1514:	0ff4f793          	zext.b	a5,s1
    1518:	2485                	addiw	s1,s1,1
    151a:	0af69d63          	bne	a3,a5,15d4 <pipe1+0x120>
      for(i = 0; i < n; i++){
    151e:	0705                	addi	a4,a4,1
    1520:	fec498e3          	bne	s1,a2,1510 <pipe1+0x5c>
      total += n;
    1524:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    1528:	0019179b          	slliw	a5,s2,0x1
    152c:	0007891b          	sext.w	s2,a5
      if(cc > sizeof(buf))
    1530:	670d                	lui	a4,0x3
    1532:	fd2771e3          	bgeu	a4,s2,14f4 <pipe1+0x40>
        cc = sizeof(buf);
    1536:	690d                	lui	s2,0x3
    1538:	bf75                	j	14f4 <pipe1+0x40>
    153a:	e4a6                	sd	s1,72(sp)
    153c:	e0ca                	sd	s2,64(sp)
    153e:	f852                	sd	s4,48(sp)
    1540:	f456                	sd	s5,40(sp)
    1542:	f05a                	sd	s6,32(sp)
    1544:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    1546:	85ce                	mv	a1,s3
    1548:	00004517          	auipc	a0,0x4
    154c:	51850513          	addi	a0,a0,1304 # 5a60 <malloc+0xac8>
    1550:	195030ef          	jal	4ee4 <printf>
    exit(1);
    1554:	4505                	li	a0,1
    1556:	540030ef          	jal	4a96 <exit>
    155a:	e0ca                	sd	s2,64(sp)
    155c:	f456                	sd	s5,40(sp)
    155e:	f05a                	sd	s6,32(sp)
    1560:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    1562:	fa842503          	lw	a0,-88(s0)
    1566:	558030ef          	jal	4abe <close>
    for(n = 0; n < N; n++){
    156a:	0000bb17          	auipc	s6,0xb
    156e:	70eb0b13          	addi	s6,s6,1806 # cc78 <buf>
    1572:	416004bb          	negw	s1,s6
    1576:	0ff4f493          	zext.b	s1,s1
    157a:	409b0913          	addi	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    157e:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1580:	6a85                	lui	s5,0x1
    1582:	42da8a93          	addi	s5,s5,1069 # 142d <exectest+0xef>
{
    1586:	87da                	mv	a5,s6
        buf[i] = seq++;
    1588:	0097873b          	addw	a4,a5,s1
    158c:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1590:	0785                	addi	a5,a5,1
    1592:	ff279be3          	bne	a5,s2,1588 <pipe1+0xd4>
    1596:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    159a:	40900613          	li	a2,1033
    159e:	85de                	mv	a1,s7
    15a0:	fac42503          	lw	a0,-84(s0)
    15a4:	512030ef          	jal	4ab6 <write>
    15a8:	40900793          	li	a5,1033
    15ac:	00f51a63          	bne	a0,a5,15c0 <pipe1+0x10c>
    for(n = 0; n < N; n++){
    15b0:	24a5                	addiw	s1,s1,9
    15b2:	0ff4f493          	zext.b	s1,s1
    15b6:	fd5a18e3          	bne	s4,s5,1586 <pipe1+0xd2>
    exit(0);
    15ba:	4501                	li	a0,0
    15bc:	4da030ef          	jal	4a96 <exit>
        printf("%s: pipe1 oops 1\n", s);
    15c0:	85ce                	mv	a1,s3
    15c2:	00004517          	auipc	a0,0x4
    15c6:	4b650513          	addi	a0,a0,1206 # 5a78 <malloc+0xae0>
    15ca:	11b030ef          	jal	4ee4 <printf>
        exit(1);
    15ce:	4505                	li	a0,1
    15d0:	4c6030ef          	jal	4a96 <exit>
          printf("%s: pipe1 oops 2\n", s);
    15d4:	85ce                	mv	a1,s3
    15d6:	00004517          	auipc	a0,0x4
    15da:	4ba50513          	addi	a0,a0,1210 # 5a90 <malloc+0xaf8>
    15de:	107030ef          	jal	4ee4 <printf>
          return;
    15e2:	64a6                	ld	s1,72(sp)
    15e4:	6906                	ld	s2,64(sp)
    15e6:	7a42                	ld	s4,48(sp)
    15e8:	7aa2                	ld	s5,40(sp)
}
    15ea:	60e6                	ld	ra,88(sp)
    15ec:	6446                	ld	s0,80(sp)
    15ee:	79e2                	ld	s3,56(sp)
    15f0:	6125                	addi	sp,sp,96
    15f2:	8082                	ret
    if(total != N * SZ){
    15f4:	6785                	lui	a5,0x1
    15f6:	42d78793          	addi	a5,a5,1069 # 142d <exectest+0xef>
    15fa:	00fa0f63          	beq	s4,a5,1618 <pipe1+0x164>
    15fe:	f05a                	sd	s6,32(sp)
    1600:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    1602:	8652                	mv	a2,s4
    1604:	85ce                	mv	a1,s3
    1606:	00004517          	auipc	a0,0x4
    160a:	4a250513          	addi	a0,a0,1186 # 5aa8 <malloc+0xb10>
    160e:	0d7030ef          	jal	4ee4 <printf>
      exit(1);
    1612:	4505                	li	a0,1
    1614:	482030ef          	jal	4a96 <exit>
    1618:	f05a                	sd	s6,32(sp)
    161a:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    161c:	fa842503          	lw	a0,-88(s0)
    1620:	49e030ef          	jal	4abe <close>
    wait(&xstatus);
    1624:	fa440513          	addi	a0,s0,-92
    1628:	476030ef          	jal	4a9e <wait>
    exit(xstatus);
    162c:	fa442503          	lw	a0,-92(s0)
    1630:	466030ef          	jal	4a96 <exit>
    1634:	e0ca                	sd	s2,64(sp)
    1636:	f456                	sd	s5,40(sp)
    1638:	f05a                	sd	s6,32(sp)
    163a:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    163c:	85ce                	mv	a1,s3
    163e:	00004517          	auipc	a0,0x4
    1642:	48a50513          	addi	a0,a0,1162 # 5ac8 <malloc+0xb30>
    1646:	09f030ef          	jal	4ee4 <printf>
    exit(1);
    164a:	4505                	li	a0,1
    164c:	44a030ef          	jal	4a96 <exit>

0000000000001650 <exitwait>:
{
    1650:	7139                	addi	sp,sp,-64
    1652:	fc06                	sd	ra,56(sp)
    1654:	f822                	sd	s0,48(sp)
    1656:	f426                	sd	s1,40(sp)
    1658:	f04a                	sd	s2,32(sp)
    165a:	ec4e                	sd	s3,24(sp)
    165c:	e852                	sd	s4,16(sp)
    165e:	0080                	addi	s0,sp,64
    1660:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1662:	4901                	li	s2,0
    1664:	06400993          	li	s3,100
    pid = fork();
    1668:	426030ef          	jal	4a8e <fork>
    166c:	84aa                	mv	s1,a0
    if(pid < 0){
    166e:	02054863          	bltz	a0,169e <exitwait+0x4e>
    if(pid){
    1672:	c525                	beqz	a0,16da <exitwait+0x8a>
      if(wait(&xstate) != pid){
    1674:	fcc40513          	addi	a0,s0,-52
    1678:	426030ef          	jal	4a9e <wait>
    167c:	02951b63          	bne	a0,s1,16b2 <exitwait+0x62>
      if(i != xstate) {
    1680:	fcc42783          	lw	a5,-52(s0)
    1684:	05279163          	bne	a5,s2,16c6 <exitwait+0x76>
  for(i = 0; i < 100; i++){
    1688:	2905                	addiw	s2,s2,1 # 3001 <subdir+0x425>
    168a:	fd391fe3          	bne	s2,s3,1668 <exitwait+0x18>
}
    168e:	70e2                	ld	ra,56(sp)
    1690:	7442                	ld	s0,48(sp)
    1692:	74a2                	ld	s1,40(sp)
    1694:	7902                	ld	s2,32(sp)
    1696:	69e2                	ld	s3,24(sp)
    1698:	6a42                	ld	s4,16(sp)
    169a:	6121                	addi	sp,sp,64
    169c:	8082                	ret
      printf("%s: fork failed\n", s);
    169e:	85d2                	mv	a1,s4
    16a0:	00004517          	auipc	a0,0x4
    16a4:	2b850513          	addi	a0,a0,696 # 5958 <malloc+0x9c0>
    16a8:	03d030ef          	jal	4ee4 <printf>
      exit(1);
    16ac:	4505                	li	a0,1
    16ae:	3e8030ef          	jal	4a96 <exit>
        printf("%s: wait wrong pid\n", s);
    16b2:	85d2                	mv	a1,s4
    16b4:	00004517          	auipc	a0,0x4
    16b8:	42c50513          	addi	a0,a0,1068 # 5ae0 <malloc+0xb48>
    16bc:	029030ef          	jal	4ee4 <printf>
        exit(1);
    16c0:	4505                	li	a0,1
    16c2:	3d4030ef          	jal	4a96 <exit>
        printf("%s: wait wrong exit status\n", s);
    16c6:	85d2                	mv	a1,s4
    16c8:	00004517          	auipc	a0,0x4
    16cc:	43050513          	addi	a0,a0,1072 # 5af8 <malloc+0xb60>
    16d0:	015030ef          	jal	4ee4 <printf>
        exit(1);
    16d4:	4505                	li	a0,1
    16d6:	3c0030ef          	jal	4a96 <exit>
      exit(i);
    16da:	854a                	mv	a0,s2
    16dc:	3ba030ef          	jal	4a96 <exit>

00000000000016e0 <twochildren>:
{
    16e0:	1101                	addi	sp,sp,-32
    16e2:	ec06                	sd	ra,24(sp)
    16e4:	e822                	sd	s0,16(sp)
    16e6:	e426                	sd	s1,8(sp)
    16e8:	e04a                	sd	s2,0(sp)
    16ea:	1000                	addi	s0,sp,32
    16ec:	892a                	mv	s2,a0
    16ee:	3e800493          	li	s1,1000
    int pid1 = fork();
    16f2:	39c030ef          	jal	4a8e <fork>
    if(pid1 < 0){
    16f6:	02054663          	bltz	a0,1722 <twochildren+0x42>
    if(pid1 == 0){
    16fa:	cd15                	beqz	a0,1736 <twochildren+0x56>
      int pid2 = fork();
    16fc:	392030ef          	jal	4a8e <fork>
      if(pid2 < 0){
    1700:	02054d63          	bltz	a0,173a <twochildren+0x5a>
      if(pid2 == 0){
    1704:	c529                	beqz	a0,174e <twochildren+0x6e>
        wait(0);
    1706:	4501                	li	a0,0
    1708:	396030ef          	jal	4a9e <wait>
        wait(0);
    170c:	4501                	li	a0,0
    170e:	390030ef          	jal	4a9e <wait>
  for(int i = 0; i < 1000; i++){
    1712:	34fd                	addiw	s1,s1,-1
    1714:	fcf9                	bnez	s1,16f2 <twochildren+0x12>
}
    1716:	60e2                	ld	ra,24(sp)
    1718:	6442                	ld	s0,16(sp)
    171a:	64a2                	ld	s1,8(sp)
    171c:	6902                	ld	s2,0(sp)
    171e:	6105                	addi	sp,sp,32
    1720:	8082                	ret
      printf("%s: fork failed\n", s);
    1722:	85ca                	mv	a1,s2
    1724:	00004517          	auipc	a0,0x4
    1728:	23450513          	addi	a0,a0,564 # 5958 <malloc+0x9c0>
    172c:	7b8030ef          	jal	4ee4 <printf>
      exit(1);
    1730:	4505                	li	a0,1
    1732:	364030ef          	jal	4a96 <exit>
      exit(0);
    1736:	360030ef          	jal	4a96 <exit>
        printf("%s: fork failed\n", s);
    173a:	85ca                	mv	a1,s2
    173c:	00004517          	auipc	a0,0x4
    1740:	21c50513          	addi	a0,a0,540 # 5958 <malloc+0x9c0>
    1744:	7a0030ef          	jal	4ee4 <printf>
        exit(1);
    1748:	4505                	li	a0,1
    174a:	34c030ef          	jal	4a96 <exit>
        exit(0);
    174e:	348030ef          	jal	4a96 <exit>

0000000000001752 <forkfork>:
{
    1752:	7179                	addi	sp,sp,-48
    1754:	f406                	sd	ra,40(sp)
    1756:	f022                	sd	s0,32(sp)
    1758:	ec26                	sd	s1,24(sp)
    175a:	1800                	addi	s0,sp,48
    175c:	84aa                	mv	s1,a0
    int pid = fork();
    175e:	330030ef          	jal	4a8e <fork>
    if(pid < 0){
    1762:	02054b63          	bltz	a0,1798 <forkfork+0x46>
    if(pid == 0){
    1766:	c139                	beqz	a0,17ac <forkfork+0x5a>
    int pid = fork();
    1768:	326030ef          	jal	4a8e <fork>
    if(pid < 0){
    176c:	02054663          	bltz	a0,1798 <forkfork+0x46>
    if(pid == 0){
    1770:	cd15                	beqz	a0,17ac <forkfork+0x5a>
    wait(&xstatus);
    1772:	fdc40513          	addi	a0,s0,-36
    1776:	328030ef          	jal	4a9e <wait>
    if(xstatus != 0) {
    177a:	fdc42783          	lw	a5,-36(s0)
    177e:	ebb9                	bnez	a5,17d4 <forkfork+0x82>
    wait(&xstatus);
    1780:	fdc40513          	addi	a0,s0,-36
    1784:	31a030ef          	jal	4a9e <wait>
    if(xstatus != 0) {
    1788:	fdc42783          	lw	a5,-36(s0)
    178c:	e7a1                	bnez	a5,17d4 <forkfork+0x82>
}
    178e:	70a2                	ld	ra,40(sp)
    1790:	7402                	ld	s0,32(sp)
    1792:	64e2                	ld	s1,24(sp)
    1794:	6145                	addi	sp,sp,48
    1796:	8082                	ret
      printf("%s: fork failed", s);
    1798:	85a6                	mv	a1,s1
    179a:	00004517          	auipc	a0,0x4
    179e:	37e50513          	addi	a0,a0,894 # 5b18 <malloc+0xb80>
    17a2:	742030ef          	jal	4ee4 <printf>
      exit(1);
    17a6:	4505                	li	a0,1
    17a8:	2ee030ef          	jal	4a96 <exit>
{
    17ac:	0c800493          	li	s1,200
        int pid1 = fork();
    17b0:	2de030ef          	jal	4a8e <fork>
        if(pid1 < 0){
    17b4:	00054b63          	bltz	a0,17ca <forkfork+0x78>
        if(pid1 == 0){
    17b8:	cd01                	beqz	a0,17d0 <forkfork+0x7e>
        wait(0);
    17ba:	4501                	li	a0,0
    17bc:	2e2030ef          	jal	4a9e <wait>
      for(int j = 0; j < 200; j++){
    17c0:	34fd                	addiw	s1,s1,-1
    17c2:	f4fd                	bnez	s1,17b0 <forkfork+0x5e>
      exit(0);
    17c4:	4501                	li	a0,0
    17c6:	2d0030ef          	jal	4a96 <exit>
          exit(1);
    17ca:	4505                	li	a0,1
    17cc:	2ca030ef          	jal	4a96 <exit>
          exit(0);
    17d0:	2c6030ef          	jal	4a96 <exit>
      printf("%s: fork in child failed", s);
    17d4:	85a6                	mv	a1,s1
    17d6:	00004517          	auipc	a0,0x4
    17da:	35250513          	addi	a0,a0,850 # 5b28 <malloc+0xb90>
    17de:	706030ef          	jal	4ee4 <printf>
      exit(1);
    17e2:	4505                	li	a0,1
    17e4:	2b2030ef          	jal	4a96 <exit>

00000000000017e8 <reparent2>:
{
    17e8:	1101                	addi	sp,sp,-32
    17ea:	ec06                	sd	ra,24(sp)
    17ec:	e822                	sd	s0,16(sp)
    17ee:	e426                	sd	s1,8(sp)
    17f0:	1000                	addi	s0,sp,32
    17f2:	32000493          	li	s1,800
    int pid1 = fork();
    17f6:	298030ef          	jal	4a8e <fork>
    if(pid1 < 0){
    17fa:	00054b63          	bltz	a0,1810 <reparent2+0x28>
    if(pid1 == 0){
    17fe:	c115                	beqz	a0,1822 <reparent2+0x3a>
    wait(0);
    1800:	4501                	li	a0,0
    1802:	29c030ef          	jal	4a9e <wait>
  for(int i = 0; i < 800; i++){
    1806:	34fd                	addiw	s1,s1,-1
    1808:	f4fd                	bnez	s1,17f6 <reparent2+0xe>
  exit(0);
    180a:	4501                	li	a0,0
    180c:	28a030ef          	jal	4a96 <exit>
      printf("fork failed\n");
    1810:	00005517          	auipc	a0,0x5
    1814:	6b850513          	addi	a0,a0,1720 # 6ec8 <malloc+0x1f30>
    1818:	6cc030ef          	jal	4ee4 <printf>
      exit(1);
    181c:	4505                	li	a0,1
    181e:	278030ef          	jal	4a96 <exit>
      fork();
    1822:	26c030ef          	jal	4a8e <fork>
      fork();
    1826:	268030ef          	jal	4a8e <fork>
      exit(0);
    182a:	4501                	li	a0,0
    182c:	26a030ef          	jal	4a96 <exit>

0000000000001830 <createdelete>:
{
    1830:	7175                	addi	sp,sp,-144
    1832:	e506                	sd	ra,136(sp)
    1834:	e122                	sd	s0,128(sp)
    1836:	fca6                	sd	s1,120(sp)
    1838:	f8ca                	sd	s2,112(sp)
    183a:	f4ce                	sd	s3,104(sp)
    183c:	f0d2                	sd	s4,96(sp)
    183e:	ecd6                	sd	s5,88(sp)
    1840:	e8da                	sd	s6,80(sp)
    1842:	e4de                	sd	s7,72(sp)
    1844:	e0e2                	sd	s8,64(sp)
    1846:	fc66                	sd	s9,56(sp)
    1848:	0900                	addi	s0,sp,144
    184a:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    184c:	4901                	li	s2,0
    184e:	4991                	li	s3,4
    pid = fork();
    1850:	23e030ef          	jal	4a8e <fork>
    1854:	84aa                	mv	s1,a0
    if(pid < 0){
    1856:	02054d63          	bltz	a0,1890 <createdelete+0x60>
    if(pid == 0){
    185a:	c529                	beqz	a0,18a4 <createdelete+0x74>
  for(pi = 0; pi < NCHILD; pi++){
    185c:	2905                	addiw	s2,s2,1
    185e:	ff3919e3          	bne	s2,s3,1850 <createdelete+0x20>
    1862:	4491                	li	s1,4
    wait(&xstatus);
    1864:	f7c40513          	addi	a0,s0,-132
    1868:	236030ef          	jal	4a9e <wait>
    if(xstatus != 0)
    186c:	f7c42903          	lw	s2,-132(s0)
    1870:	0a091e63          	bnez	s2,192c <createdelete+0xfc>
  for(pi = 0; pi < NCHILD; pi++){
    1874:	34fd                	addiw	s1,s1,-1
    1876:	f4fd                	bnez	s1,1864 <createdelete+0x34>
  name[0] = name[1] = name[2] = 0;
    1878:	f8040123          	sb	zero,-126(s0)
    187c:	03000993          	li	s3,48
    1880:	5a7d                	li	s4,-1
    1882:	07000c13          	li	s8,112
      if((i == 0 || i >= N/2) && fd < 0){
    1886:	4b25                	li	s6,9
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1888:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
    188a:	07400a93          	li	s5,116
    188e:	aa39                	j	19ac <createdelete+0x17c>
      printf("%s: fork failed\n", s);
    1890:	85e6                	mv	a1,s9
    1892:	00004517          	auipc	a0,0x4
    1896:	0c650513          	addi	a0,a0,198 # 5958 <malloc+0x9c0>
    189a:	64a030ef          	jal	4ee4 <printf>
      exit(1);
    189e:	4505                	li	a0,1
    18a0:	1f6030ef          	jal	4a96 <exit>
      name[0] = 'p' + pi;
    18a4:	0709091b          	addiw	s2,s2,112
    18a8:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    18ac:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    18b0:	4951                	li	s2,20
    18b2:	a831                	j	18ce <createdelete+0x9e>
          printf("%s: create failed\n", s);
    18b4:	85e6                	mv	a1,s9
    18b6:	00004517          	auipc	a0,0x4
    18ba:	13a50513          	addi	a0,a0,314 # 59f0 <malloc+0xa58>
    18be:	626030ef          	jal	4ee4 <printf>
          exit(1);
    18c2:	4505                	li	a0,1
    18c4:	1d2030ef          	jal	4a96 <exit>
      for(i = 0; i < N; i++){
    18c8:	2485                	addiw	s1,s1,1
    18ca:	05248e63          	beq	s1,s2,1926 <createdelete+0xf6>
        name[1] = '0' + i;
    18ce:	0304879b          	addiw	a5,s1,48
    18d2:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    18d6:	20200593          	li	a1,514
    18da:	f8040513          	addi	a0,s0,-128
    18de:	1f8030ef          	jal	4ad6 <open>
        if(fd < 0){
    18e2:	fc0549e3          	bltz	a0,18b4 <createdelete+0x84>
        close(fd);
    18e6:	1d8030ef          	jal	4abe <close>
        if(i > 0 && (i % 2 ) == 0){
    18ea:	10905063          	blez	s1,19ea <createdelete+0x1ba>
    18ee:	0014f793          	andi	a5,s1,1
    18f2:	fbf9                	bnez	a5,18c8 <createdelete+0x98>
          name[1] = '0' + (i / 2);
    18f4:	01f4d79b          	srliw	a5,s1,0x1f
    18f8:	9fa5                	addw	a5,a5,s1
    18fa:	4017d79b          	sraiw	a5,a5,0x1
    18fe:	0307879b          	addiw	a5,a5,48
    1902:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1906:	f8040513          	addi	a0,s0,-128
    190a:	1dc030ef          	jal	4ae6 <unlink>
    190e:	fa055de3          	bgez	a0,18c8 <createdelete+0x98>
            printf("%s: unlink failed\n", s);
    1912:	85e6                	mv	a1,s9
    1914:	00004517          	auipc	a0,0x4
    1918:	23450513          	addi	a0,a0,564 # 5b48 <malloc+0xbb0>
    191c:	5c8030ef          	jal	4ee4 <printf>
            exit(1);
    1920:	4505                	li	a0,1
    1922:	174030ef          	jal	4a96 <exit>
      exit(0);
    1926:	4501                	li	a0,0
    1928:	16e030ef          	jal	4a96 <exit>
      exit(1);
    192c:	4505                	li	a0,1
    192e:	168030ef          	jal	4a96 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1932:	f8040613          	addi	a2,s0,-128
    1936:	85e6                	mv	a1,s9
    1938:	00004517          	auipc	a0,0x4
    193c:	22850513          	addi	a0,a0,552 # 5b60 <malloc+0xbc8>
    1940:	5a4030ef          	jal	4ee4 <printf>
        exit(1);
    1944:	4505                	li	a0,1
    1946:	150030ef          	jal	4a96 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    194a:	034bfb63          	bgeu	s7,s4,1980 <createdelete+0x150>
      if(fd >= 0)
    194e:	02055663          	bgez	a0,197a <createdelete+0x14a>
    for(pi = 0; pi < NCHILD; pi++){
    1952:	2485                	addiw	s1,s1,1
    1954:	0ff4f493          	zext.b	s1,s1
    1958:	05548263          	beq	s1,s5,199c <createdelete+0x16c>
      name[0] = 'p' + pi;
    195c:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1960:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1964:	4581                	li	a1,0
    1966:	f8040513          	addi	a0,s0,-128
    196a:	16c030ef          	jal	4ad6 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    196e:	00090463          	beqz	s2,1976 <createdelete+0x146>
    1972:	fd2b5ce3          	bge	s6,s2,194a <createdelete+0x11a>
    1976:	fa054ee3          	bltz	a0,1932 <createdelete+0x102>
        close(fd);
    197a:	144030ef          	jal	4abe <close>
    197e:	bfd1                	j	1952 <createdelete+0x122>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1980:	fc0549e3          	bltz	a0,1952 <createdelete+0x122>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1984:	f8040613          	addi	a2,s0,-128
    1988:	85e6                	mv	a1,s9
    198a:	00004517          	auipc	a0,0x4
    198e:	1fe50513          	addi	a0,a0,510 # 5b88 <malloc+0xbf0>
    1992:	552030ef          	jal	4ee4 <printf>
        exit(1);
    1996:	4505                	li	a0,1
    1998:	0fe030ef          	jal	4a96 <exit>
  for(i = 0; i < N; i++){
    199c:	2905                	addiw	s2,s2,1
    199e:	2a05                	addiw	s4,s4,1
    19a0:	2985                	addiw	s3,s3,1
    19a2:	0ff9f993          	zext.b	s3,s3
    19a6:	47d1                	li	a5,20
    19a8:	02f90863          	beq	s2,a5,19d8 <createdelete+0x1a8>
    for(pi = 0; pi < NCHILD; pi++){
    19ac:	84e2                	mv	s1,s8
    19ae:	b77d                	j	195c <createdelete+0x12c>
  for(i = 0; i < N; i++){
    19b0:	2905                	addiw	s2,s2,1
    19b2:	0ff97913          	zext.b	s2,s2
    19b6:	03490c63          	beq	s2,s4,19ee <createdelete+0x1be>
  name[0] = name[1] = name[2] = 0;
    19ba:	84d6                	mv	s1,s5
      name[0] = 'p' + pi;
    19bc:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    19c0:	f92400a3          	sb	s2,-127(s0)
      unlink(name);
    19c4:	f8040513          	addi	a0,s0,-128
    19c8:	11e030ef          	jal	4ae6 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    19cc:	2485                	addiw	s1,s1,1
    19ce:	0ff4f493          	zext.b	s1,s1
    19d2:	ff3495e3          	bne	s1,s3,19bc <createdelete+0x18c>
    19d6:	bfe9                	j	19b0 <createdelete+0x180>
    19d8:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    19dc:	07000a93          	li	s5,112
    for(pi = 0; pi < NCHILD; pi++){
    19e0:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    19e4:	04400a13          	li	s4,68
    19e8:	bfc9                	j	19ba <createdelete+0x18a>
      for(i = 0; i < N; i++){
    19ea:	2485                	addiw	s1,s1,1
    19ec:	b5cd                	j	18ce <createdelete+0x9e>
}
    19ee:	60aa                	ld	ra,136(sp)
    19f0:	640a                	ld	s0,128(sp)
    19f2:	74e6                	ld	s1,120(sp)
    19f4:	7946                	ld	s2,112(sp)
    19f6:	79a6                	ld	s3,104(sp)
    19f8:	7a06                	ld	s4,96(sp)
    19fa:	6ae6                	ld	s5,88(sp)
    19fc:	6b46                	ld	s6,80(sp)
    19fe:	6ba6                	ld	s7,72(sp)
    1a00:	6c06                	ld	s8,64(sp)
    1a02:	7ce2                	ld	s9,56(sp)
    1a04:	6149                	addi	sp,sp,144
    1a06:	8082                	ret

0000000000001a08 <linkunlink>:
{
    1a08:	711d                	addi	sp,sp,-96
    1a0a:	ec86                	sd	ra,88(sp)
    1a0c:	e8a2                	sd	s0,80(sp)
    1a0e:	e4a6                	sd	s1,72(sp)
    1a10:	e0ca                	sd	s2,64(sp)
    1a12:	fc4e                	sd	s3,56(sp)
    1a14:	f852                	sd	s4,48(sp)
    1a16:	f456                	sd	s5,40(sp)
    1a18:	f05a                	sd	s6,32(sp)
    1a1a:	ec5e                	sd	s7,24(sp)
    1a1c:	e862                	sd	s8,16(sp)
    1a1e:	e466                	sd	s9,8(sp)
    1a20:	1080                	addi	s0,sp,96
    1a22:	84aa                	mv	s1,a0
  unlink("x");
    1a24:	00003517          	auipc	a0,0x3
    1a28:	71450513          	addi	a0,a0,1812 # 5138 <malloc+0x1a0>
    1a2c:	0ba030ef          	jal	4ae6 <unlink>
  pid = fork();
    1a30:	05e030ef          	jal	4a8e <fork>
  if(pid < 0){
    1a34:	02054b63          	bltz	a0,1a6a <linkunlink+0x62>
    1a38:	8caa                	mv	s9,a0
  unsigned int x = (pid ? 1 : 97);
    1a3a:	06100913          	li	s2,97
    1a3e:	c111                	beqz	a0,1a42 <linkunlink+0x3a>
    1a40:	4905                	li	s2,1
    1a42:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1a46:	41c65a37          	lui	s4,0x41c65
    1a4a:	e6da0a1b          	addiw	s4,s4,-403 # 41c64e6d <base+0x41c551f5>
    1a4e:	698d                	lui	s3,0x3
    1a50:	0399899b          	addiw	s3,s3,57 # 3039 <subdir+0x45d>
    if((x % 3) == 0){
    1a54:	4a8d                	li	s5,3
    } else if((x % 3) == 1){
    1a56:	4b85                	li	s7,1
      unlink("x");
    1a58:	00003b17          	auipc	s6,0x3
    1a5c:	6e0b0b13          	addi	s6,s6,1760 # 5138 <malloc+0x1a0>
      link("cat", "x");
    1a60:	00004c17          	auipc	s8,0x4
    1a64:	150c0c13          	addi	s8,s8,336 # 5bb0 <malloc+0xc18>
    1a68:	a025                	j	1a90 <linkunlink+0x88>
    printf("%s: fork failed\n", s);
    1a6a:	85a6                	mv	a1,s1
    1a6c:	00004517          	auipc	a0,0x4
    1a70:	eec50513          	addi	a0,a0,-276 # 5958 <malloc+0x9c0>
    1a74:	470030ef          	jal	4ee4 <printf>
    exit(1);
    1a78:	4505                	li	a0,1
    1a7a:	01c030ef          	jal	4a96 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1a7e:	20200593          	li	a1,514
    1a82:	855a                	mv	a0,s6
    1a84:	052030ef          	jal	4ad6 <open>
    1a88:	036030ef          	jal	4abe <close>
  for(i = 0; i < 100; i++){
    1a8c:	34fd                	addiw	s1,s1,-1
    1a8e:	c495                	beqz	s1,1aba <linkunlink+0xb2>
    x = x * 1103515245 + 12345;
    1a90:	034907bb          	mulw	a5,s2,s4
    1a94:	013787bb          	addw	a5,a5,s3
    1a98:	0007891b          	sext.w	s2,a5
    if((x % 3) == 0){
    1a9c:	0357f7bb          	remuw	a5,a5,s5
    1aa0:	2781                	sext.w	a5,a5
    1aa2:	dff1                	beqz	a5,1a7e <linkunlink+0x76>
    } else if((x % 3) == 1){
    1aa4:	01778663          	beq	a5,s7,1ab0 <linkunlink+0xa8>
      unlink("x");
    1aa8:	855a                	mv	a0,s6
    1aaa:	03c030ef          	jal	4ae6 <unlink>
    1aae:	bff9                	j	1a8c <linkunlink+0x84>
      link("cat", "x");
    1ab0:	85da                	mv	a1,s6
    1ab2:	8562                	mv	a0,s8
    1ab4:	042030ef          	jal	4af6 <link>
    1ab8:	bfd1                	j	1a8c <linkunlink+0x84>
  if(pid)
    1aba:	020c8263          	beqz	s9,1ade <linkunlink+0xd6>
    wait(0);
    1abe:	4501                	li	a0,0
    1ac0:	7df020ef          	jal	4a9e <wait>
}
    1ac4:	60e6                	ld	ra,88(sp)
    1ac6:	6446                	ld	s0,80(sp)
    1ac8:	64a6                	ld	s1,72(sp)
    1aca:	6906                	ld	s2,64(sp)
    1acc:	79e2                	ld	s3,56(sp)
    1ace:	7a42                	ld	s4,48(sp)
    1ad0:	7aa2                	ld	s5,40(sp)
    1ad2:	7b02                	ld	s6,32(sp)
    1ad4:	6be2                	ld	s7,24(sp)
    1ad6:	6c42                	ld	s8,16(sp)
    1ad8:	6ca2                	ld	s9,8(sp)
    1ada:	6125                	addi	sp,sp,96
    1adc:	8082                	ret
    exit(0);
    1ade:	4501                	li	a0,0
    1ae0:	7b7020ef          	jal	4a96 <exit>

0000000000001ae4 <forktest>:
{
    1ae4:	7179                	addi	sp,sp,-48
    1ae6:	f406                	sd	ra,40(sp)
    1ae8:	f022                	sd	s0,32(sp)
    1aea:	ec26                	sd	s1,24(sp)
    1aec:	e84a                	sd	s2,16(sp)
    1aee:	e44e                	sd	s3,8(sp)
    1af0:	1800                	addi	s0,sp,48
    1af2:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1af4:	4481                	li	s1,0
    1af6:	3e800913          	li	s2,1000
    pid = fork();
    1afa:	795020ef          	jal	4a8e <fork>
    if(pid < 0)
    1afe:	06054063          	bltz	a0,1b5e <forktest+0x7a>
    if(pid == 0)
    1b02:	cd11                	beqz	a0,1b1e <forktest+0x3a>
  for(n=0; n<N; n++){
    1b04:	2485                	addiw	s1,s1,1
    1b06:	ff249ae3          	bne	s1,s2,1afa <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1b0a:	85ce                	mv	a1,s3
    1b0c:	00004517          	auipc	a0,0x4
    1b10:	0f450513          	addi	a0,a0,244 # 5c00 <malloc+0xc68>
    1b14:	3d0030ef          	jal	4ee4 <printf>
    exit(1);
    1b18:	4505                	li	a0,1
    1b1a:	77d020ef          	jal	4a96 <exit>
      exit(0);
    1b1e:	779020ef          	jal	4a96 <exit>
    printf("%s: no fork at all!\n", s);
    1b22:	85ce                	mv	a1,s3
    1b24:	00004517          	auipc	a0,0x4
    1b28:	09450513          	addi	a0,a0,148 # 5bb8 <malloc+0xc20>
    1b2c:	3b8030ef          	jal	4ee4 <printf>
    exit(1);
    1b30:	4505                	li	a0,1
    1b32:	765020ef          	jal	4a96 <exit>
      printf("%s: wait stopped early\n", s);
    1b36:	85ce                	mv	a1,s3
    1b38:	00004517          	auipc	a0,0x4
    1b3c:	09850513          	addi	a0,a0,152 # 5bd0 <malloc+0xc38>
    1b40:	3a4030ef          	jal	4ee4 <printf>
      exit(1);
    1b44:	4505                	li	a0,1
    1b46:	751020ef          	jal	4a96 <exit>
    printf("%s: wait got too many\n", s);
    1b4a:	85ce                	mv	a1,s3
    1b4c:	00004517          	auipc	a0,0x4
    1b50:	09c50513          	addi	a0,a0,156 # 5be8 <malloc+0xc50>
    1b54:	390030ef          	jal	4ee4 <printf>
    exit(1);
    1b58:	4505                	li	a0,1
    1b5a:	73d020ef          	jal	4a96 <exit>
  if (n == 0) {
    1b5e:	d0f1                	beqz	s1,1b22 <forktest+0x3e>
  for(; n > 0; n--){
    1b60:	00905963          	blez	s1,1b72 <forktest+0x8e>
    if(wait(0) < 0){
    1b64:	4501                	li	a0,0
    1b66:	739020ef          	jal	4a9e <wait>
    1b6a:	fc0546e3          	bltz	a0,1b36 <forktest+0x52>
  for(; n > 0; n--){
    1b6e:	34fd                	addiw	s1,s1,-1
    1b70:	f8f5                	bnez	s1,1b64 <forktest+0x80>
  if(wait(0) != -1){
    1b72:	4501                	li	a0,0
    1b74:	72b020ef          	jal	4a9e <wait>
    1b78:	57fd                	li	a5,-1
    1b7a:	fcf518e3          	bne	a0,a5,1b4a <forktest+0x66>
}
    1b7e:	70a2                	ld	ra,40(sp)
    1b80:	7402                	ld	s0,32(sp)
    1b82:	64e2                	ld	s1,24(sp)
    1b84:	6942                	ld	s2,16(sp)
    1b86:	69a2                	ld	s3,8(sp)
    1b88:	6145                	addi	sp,sp,48
    1b8a:	8082                	ret

0000000000001b8c <kernmem>:
{
    1b8c:	715d                	addi	sp,sp,-80
    1b8e:	e486                	sd	ra,72(sp)
    1b90:	e0a2                	sd	s0,64(sp)
    1b92:	fc26                	sd	s1,56(sp)
    1b94:	f84a                	sd	s2,48(sp)
    1b96:	f44e                	sd	s3,40(sp)
    1b98:	f052                	sd	s4,32(sp)
    1b9a:	ec56                	sd	s5,24(sp)
    1b9c:	0880                	addi	s0,sp,80
    1b9e:	8aaa                	mv	s5,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1ba0:	4485                	li	s1,1
    1ba2:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    1ba4:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1ba6:	69b1                	lui	s3,0xc
    1ba8:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    1bac:	1003d937          	lui	s2,0x1003d
    1bb0:	090e                	slli	s2,s2,0x3
    1bb2:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    1bb6:	6d9020ef          	jal	4a8e <fork>
    if(pid < 0){
    1bba:	02054763          	bltz	a0,1be8 <kernmem+0x5c>
    if(pid == 0){
    1bbe:	cd1d                	beqz	a0,1bfc <kernmem+0x70>
    wait(&xstatus);
    1bc0:	fbc40513          	addi	a0,s0,-68
    1bc4:	6db020ef          	jal	4a9e <wait>
    if(xstatus != -1)  // did kernel kill child?
    1bc8:	fbc42783          	lw	a5,-68(s0)
    1bcc:	05479563          	bne	a5,s4,1c16 <kernmem+0x8a>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1bd0:	94ce                	add	s1,s1,s3
    1bd2:	ff2492e3          	bne	s1,s2,1bb6 <kernmem+0x2a>
}
    1bd6:	60a6                	ld	ra,72(sp)
    1bd8:	6406                	ld	s0,64(sp)
    1bda:	74e2                	ld	s1,56(sp)
    1bdc:	7942                	ld	s2,48(sp)
    1bde:	79a2                	ld	s3,40(sp)
    1be0:	7a02                	ld	s4,32(sp)
    1be2:	6ae2                	ld	s5,24(sp)
    1be4:	6161                	addi	sp,sp,80
    1be6:	8082                	ret
      printf("%s: fork failed\n", s);
    1be8:	85d6                	mv	a1,s5
    1bea:	00004517          	auipc	a0,0x4
    1bee:	d6e50513          	addi	a0,a0,-658 # 5958 <malloc+0x9c0>
    1bf2:	2f2030ef          	jal	4ee4 <printf>
      exit(1);
    1bf6:	4505                	li	a0,1
    1bf8:	69f020ef          	jal	4a96 <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1bfc:	0004c683          	lbu	a3,0(s1)
    1c00:	8626                	mv	a2,s1
    1c02:	85d6                	mv	a1,s5
    1c04:	00004517          	auipc	a0,0x4
    1c08:	02450513          	addi	a0,a0,36 # 5c28 <malloc+0xc90>
    1c0c:	2d8030ef          	jal	4ee4 <printf>
      exit(1);
    1c10:	4505                	li	a0,1
    1c12:	685020ef          	jal	4a96 <exit>
      exit(1);
    1c16:	4505                	li	a0,1
    1c18:	67f020ef          	jal	4a96 <exit>

0000000000001c1c <MAXVAplus>:
{
    1c1c:	7179                	addi	sp,sp,-48
    1c1e:	f406                	sd	ra,40(sp)
    1c20:	f022                	sd	s0,32(sp)
    1c22:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    1c24:	4785                	li	a5,1
    1c26:	179a                	slli	a5,a5,0x26
    1c28:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    1c2c:	fd843783          	ld	a5,-40(s0)
    1c30:	cf85                	beqz	a5,1c68 <MAXVAplus+0x4c>
    1c32:	ec26                	sd	s1,24(sp)
    1c34:	e84a                	sd	s2,16(sp)
    1c36:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    1c38:	54fd                	li	s1,-1
    pid = fork();
    1c3a:	655020ef          	jal	4a8e <fork>
    if(pid < 0){
    1c3e:	02054963          	bltz	a0,1c70 <MAXVAplus+0x54>
    if(pid == 0){
    1c42:	c129                	beqz	a0,1c84 <MAXVAplus+0x68>
    wait(&xstatus);
    1c44:	fd440513          	addi	a0,s0,-44
    1c48:	657020ef          	jal	4a9e <wait>
    if(xstatus != -1)  // did kernel kill child?
    1c4c:	fd442783          	lw	a5,-44(s0)
    1c50:	04979c63          	bne	a5,s1,1ca8 <MAXVAplus+0x8c>
  for( ; a != 0; a <<= 1){
    1c54:	fd843783          	ld	a5,-40(s0)
    1c58:	0786                	slli	a5,a5,0x1
    1c5a:	fcf43c23          	sd	a5,-40(s0)
    1c5e:	fd843783          	ld	a5,-40(s0)
    1c62:	ffe1                	bnez	a5,1c3a <MAXVAplus+0x1e>
    1c64:	64e2                	ld	s1,24(sp)
    1c66:	6942                	ld	s2,16(sp)
}
    1c68:	70a2                	ld	ra,40(sp)
    1c6a:	7402                	ld	s0,32(sp)
    1c6c:	6145                	addi	sp,sp,48
    1c6e:	8082                	ret
      printf("%s: fork failed\n", s);
    1c70:	85ca                	mv	a1,s2
    1c72:	00004517          	auipc	a0,0x4
    1c76:	ce650513          	addi	a0,a0,-794 # 5958 <malloc+0x9c0>
    1c7a:	26a030ef          	jal	4ee4 <printf>
      exit(1);
    1c7e:	4505                	li	a0,1
    1c80:	617020ef          	jal	4a96 <exit>
      *(char*)a = 99;
    1c84:	fd843783          	ld	a5,-40(s0)
    1c88:	06300713          	li	a4,99
    1c8c:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void*)a);
    1c90:	fd843603          	ld	a2,-40(s0)
    1c94:	85ca                	mv	a1,s2
    1c96:	00004517          	auipc	a0,0x4
    1c9a:	fb250513          	addi	a0,a0,-78 # 5c48 <malloc+0xcb0>
    1c9e:	246030ef          	jal	4ee4 <printf>
      exit(1);
    1ca2:	4505                	li	a0,1
    1ca4:	5f3020ef          	jal	4a96 <exit>
      exit(1);
    1ca8:	4505                	li	a0,1
    1caa:	5ed020ef          	jal	4a96 <exit>

0000000000001cae <stacktest>:
{
    1cae:	7179                	addi	sp,sp,-48
    1cb0:	f406                	sd	ra,40(sp)
    1cb2:	f022                	sd	s0,32(sp)
    1cb4:	ec26                	sd	s1,24(sp)
    1cb6:	1800                	addi	s0,sp,48
    1cb8:	84aa                	mv	s1,a0
  pid = fork();
    1cba:	5d5020ef          	jal	4a8e <fork>
  if(pid == 0) {
    1cbe:	cd11                	beqz	a0,1cda <stacktest+0x2c>
  } else if(pid < 0){
    1cc0:	02054c63          	bltz	a0,1cf8 <stacktest+0x4a>
  wait(&xstatus);
    1cc4:	fdc40513          	addi	a0,s0,-36
    1cc8:	5d7020ef          	jal	4a9e <wait>
  if(xstatus == -1)  // kernel killed child?
    1ccc:	fdc42503          	lw	a0,-36(s0)
    1cd0:	57fd                	li	a5,-1
    1cd2:	02f50d63          	beq	a0,a5,1d0c <stacktest+0x5e>
    exit(xstatus);
    1cd6:	5c1020ef          	jal	4a96 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1cda:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1cdc:	77fd                	lui	a5,0xfffff
    1cde:	97ba                	add	a5,a5,a4
    1ce0:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    1ce4:	85a6                	mv	a1,s1
    1ce6:	00004517          	auipc	a0,0x4
    1cea:	f7a50513          	addi	a0,a0,-134 # 5c60 <malloc+0xcc8>
    1cee:	1f6030ef          	jal	4ee4 <printf>
    exit(1);
    1cf2:	4505                	li	a0,1
    1cf4:	5a3020ef          	jal	4a96 <exit>
    printf("%s: fork failed\n", s);
    1cf8:	85a6                	mv	a1,s1
    1cfa:	00004517          	auipc	a0,0x4
    1cfe:	c5e50513          	addi	a0,a0,-930 # 5958 <malloc+0x9c0>
    1d02:	1e2030ef          	jal	4ee4 <printf>
    exit(1);
    1d06:	4505                	li	a0,1
    1d08:	58f020ef          	jal	4a96 <exit>
    exit(0);
    1d0c:	4501                	li	a0,0
    1d0e:	589020ef          	jal	4a96 <exit>

0000000000001d12 <nowrite>:
{
    1d12:	7159                	addi	sp,sp,-112
    1d14:	f486                	sd	ra,104(sp)
    1d16:	f0a2                	sd	s0,96(sp)
    1d18:	eca6                	sd	s1,88(sp)
    1d1a:	e8ca                	sd	s2,80(sp)
    1d1c:	e4ce                	sd	s3,72(sp)
    1d1e:	1880                	addi	s0,sp,112
    1d20:	89aa                	mv	s3,a0
  uint64 addrs[] = { 0, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
    1d22:	00005797          	auipc	a5,0x5
    1d26:	70678793          	addi	a5,a5,1798 # 7428 <malloc+0x2490>
    1d2a:	7788                	ld	a0,40(a5)
    1d2c:	7b8c                	ld	a1,48(a5)
    1d2e:	7f90                	ld	a2,56(a5)
    1d30:	63b4                	ld	a3,64(a5)
    1d32:	67b8                	ld	a4,72(a5)
    1d34:	6bbc                	ld	a5,80(a5)
    1d36:	f8a43c23          	sd	a0,-104(s0)
    1d3a:	fab43023          	sd	a1,-96(s0)
    1d3e:	fac43423          	sd	a2,-88(s0)
    1d42:	fad43823          	sd	a3,-80(s0)
    1d46:	fae43c23          	sd	a4,-72(s0)
    1d4a:	fcf43023          	sd	a5,-64(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1d4e:	4481                	li	s1,0
    1d50:	4919                	li	s2,6
    pid = fork();
    1d52:	53d020ef          	jal	4a8e <fork>
    if(pid == 0) {
    1d56:	c105                	beqz	a0,1d76 <nowrite+0x64>
    } else if(pid < 0){
    1d58:	04054263          	bltz	a0,1d9c <nowrite+0x8a>
    wait(&xstatus);
    1d5c:	fcc40513          	addi	a0,s0,-52
    1d60:	53f020ef          	jal	4a9e <wait>
    if(xstatus == 0){
    1d64:	fcc42783          	lw	a5,-52(s0)
    1d68:	c7a1                	beqz	a5,1db0 <nowrite+0x9e>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1d6a:	2485                	addiw	s1,s1,1
    1d6c:	ff2493e3          	bne	s1,s2,1d52 <nowrite+0x40>
  exit(0);
    1d70:	4501                	li	a0,0
    1d72:	525020ef          	jal	4a96 <exit>
      volatile int *addr = (int *) addrs[ai];
    1d76:	048e                	slli	s1,s1,0x3
    1d78:	fd048793          	addi	a5,s1,-48
    1d7c:	008784b3          	add	s1,a5,s0
    1d80:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1d84:	47a9                	li	a5,10
    1d86:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1d88:	85ce                	mv	a1,s3
    1d8a:	00004517          	auipc	a0,0x4
    1d8e:	efe50513          	addi	a0,a0,-258 # 5c88 <malloc+0xcf0>
    1d92:	152030ef          	jal	4ee4 <printf>
      exit(0);
    1d96:	4501                	li	a0,0
    1d98:	4ff020ef          	jal	4a96 <exit>
      printf("%s: fork failed\n", s);
    1d9c:	85ce                	mv	a1,s3
    1d9e:	00004517          	auipc	a0,0x4
    1da2:	bba50513          	addi	a0,a0,-1094 # 5958 <malloc+0x9c0>
    1da6:	13e030ef          	jal	4ee4 <printf>
      exit(1);
    1daa:	4505                	li	a0,1
    1dac:	4eb020ef          	jal	4a96 <exit>
      exit(1);
    1db0:	4505                	li	a0,1
    1db2:	4e5020ef          	jal	4a96 <exit>

0000000000001db6 <manywrites>:
{
    1db6:	711d                	addi	sp,sp,-96
    1db8:	ec86                	sd	ra,88(sp)
    1dba:	e8a2                	sd	s0,80(sp)
    1dbc:	e4a6                	sd	s1,72(sp)
    1dbe:	e0ca                	sd	s2,64(sp)
    1dc0:	fc4e                	sd	s3,56(sp)
    1dc2:	f456                	sd	s5,40(sp)
    1dc4:	1080                	addi	s0,sp,96
    1dc6:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1dc8:	4981                	li	s3,0
    1dca:	4911                	li	s2,4
    int pid = fork();
    1dcc:	4c3020ef          	jal	4a8e <fork>
    1dd0:	84aa                	mv	s1,a0
    if(pid < 0){
    1dd2:	02054963          	bltz	a0,1e04 <manywrites+0x4e>
    if(pid == 0){
    1dd6:	c139                	beqz	a0,1e1c <manywrites+0x66>
  for(int ci = 0; ci < nchildren; ci++){
    1dd8:	2985                	addiw	s3,s3,1
    1dda:	ff2999e3          	bne	s3,s2,1dcc <manywrites+0x16>
    1dde:	f852                	sd	s4,48(sp)
    1de0:	f05a                	sd	s6,32(sp)
    1de2:	ec5e                	sd	s7,24(sp)
    1de4:	4491                	li	s1,4
    int st = 0;
    1de6:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1dea:	fa840513          	addi	a0,s0,-88
    1dee:	4b1020ef          	jal	4a9e <wait>
    if(st != 0)
    1df2:	fa842503          	lw	a0,-88(s0)
    1df6:	0c051863          	bnez	a0,1ec6 <manywrites+0x110>
  for(int ci = 0; ci < nchildren; ci++){
    1dfa:	34fd                	addiw	s1,s1,-1
    1dfc:	f4ed                	bnez	s1,1de6 <manywrites+0x30>
  exit(0);
    1dfe:	4501                	li	a0,0
    1e00:	497020ef          	jal	4a96 <exit>
    1e04:	f852                	sd	s4,48(sp)
    1e06:	f05a                	sd	s6,32(sp)
    1e08:	ec5e                	sd	s7,24(sp)
      printf("fork failed\n");
    1e0a:	00005517          	auipc	a0,0x5
    1e0e:	0be50513          	addi	a0,a0,190 # 6ec8 <malloc+0x1f30>
    1e12:	0d2030ef          	jal	4ee4 <printf>
      exit(1);
    1e16:	4505                	li	a0,1
    1e18:	47f020ef          	jal	4a96 <exit>
    1e1c:	f852                	sd	s4,48(sp)
    1e1e:	f05a                	sd	s6,32(sp)
    1e20:	ec5e                	sd	s7,24(sp)
      name[0] = 'b';
    1e22:	06200793          	li	a5,98
    1e26:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1e2a:	0619879b          	addiw	a5,s3,97
    1e2e:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1e32:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1e36:	fa840513          	addi	a0,s0,-88
    1e3a:	4ad020ef          	jal	4ae6 <unlink>
    1e3e:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    1e40:	0000bb17          	auipc	s6,0xb
    1e44:	e38b0b13          	addi	s6,s6,-456 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    1e48:	8a26                	mv	s4,s1
    1e4a:	0209c863          	bltz	s3,1e7a <manywrites+0xc4>
          int fd = open(name, O_CREATE | O_RDWR);
    1e4e:	20200593          	li	a1,514
    1e52:	fa840513          	addi	a0,s0,-88
    1e56:	481020ef          	jal	4ad6 <open>
    1e5a:	892a                	mv	s2,a0
          if(fd < 0){
    1e5c:	02054d63          	bltz	a0,1e96 <manywrites+0xe0>
          int cc = write(fd, buf, sz);
    1e60:	660d                	lui	a2,0x3
    1e62:	85da                	mv	a1,s6
    1e64:	453020ef          	jal	4ab6 <write>
          if(cc != sz){
    1e68:	678d                	lui	a5,0x3
    1e6a:	04f51263          	bne	a0,a5,1eae <manywrites+0xf8>
          close(fd);
    1e6e:	854a                	mv	a0,s2
    1e70:	44f020ef          	jal	4abe <close>
        for(int i = 0; i < ci+1; i++){
    1e74:	2a05                	addiw	s4,s4,1
    1e76:	fd49dce3          	bge	s3,s4,1e4e <manywrites+0x98>
        unlink(name);
    1e7a:	fa840513          	addi	a0,s0,-88
    1e7e:	469020ef          	jal	4ae6 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1e82:	3bfd                	addiw	s7,s7,-1
    1e84:	fc0b92e3          	bnez	s7,1e48 <manywrites+0x92>
      unlink(name);
    1e88:	fa840513          	addi	a0,s0,-88
    1e8c:	45b020ef          	jal	4ae6 <unlink>
      exit(0);
    1e90:	4501                	li	a0,0
    1e92:	405020ef          	jal	4a96 <exit>
            printf("%s: cannot create %s\n", s, name);
    1e96:	fa840613          	addi	a2,s0,-88
    1e9a:	85d6                	mv	a1,s5
    1e9c:	00004517          	auipc	a0,0x4
    1ea0:	e0c50513          	addi	a0,a0,-500 # 5ca8 <malloc+0xd10>
    1ea4:	040030ef          	jal	4ee4 <printf>
            exit(1);
    1ea8:	4505                	li	a0,1
    1eaa:	3ed020ef          	jal	4a96 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1eae:	86aa                	mv	a3,a0
    1eb0:	660d                	lui	a2,0x3
    1eb2:	85d6                	mv	a1,s5
    1eb4:	00003517          	auipc	a0,0x3
    1eb8:	2e450513          	addi	a0,a0,740 # 5198 <malloc+0x200>
    1ebc:	028030ef          	jal	4ee4 <printf>
            exit(1);
    1ec0:	4505                	li	a0,1
    1ec2:	3d5020ef          	jal	4a96 <exit>
      exit(st);
    1ec6:	3d1020ef          	jal	4a96 <exit>

0000000000001eca <copyinstr3>:
{
    1eca:	7179                	addi	sp,sp,-48
    1ecc:	f406                	sd	ra,40(sp)
    1ece:	f022                	sd	s0,32(sp)
    1ed0:	ec26                	sd	s1,24(sp)
    1ed2:	1800                	addi	s0,sp,48
  sbrk(8192);
    1ed4:	6509                	lui	a0,0x2
    1ed6:	449020ef          	jal	4b1e <sbrk>
  uint64 top = (uint64) sbrk(0);
    1eda:	4501                	li	a0,0
    1edc:	443020ef          	jal	4b1e <sbrk>
  if((top % PGSIZE) != 0){
    1ee0:	03451793          	slli	a5,a0,0x34
    1ee4:	e7bd                	bnez	a5,1f52 <copyinstr3+0x88>
  top = (uint64) sbrk(0);
    1ee6:	4501                	li	a0,0
    1ee8:	437020ef          	jal	4b1e <sbrk>
  if(top % PGSIZE){
    1eec:	03451793          	slli	a5,a0,0x34
    1ef0:	ebad                	bnez	a5,1f62 <copyinstr3+0x98>
  char *b = (char *) (top - 1);
    1ef2:	fff50493          	addi	s1,a0,-1 # 1fff <rwsbrk+0x31>
  *b = 'x';
    1ef6:	07800793          	li	a5,120
    1efa:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1efe:	8526                	mv	a0,s1
    1f00:	3e7020ef          	jal	4ae6 <unlink>
  if(ret != -1){
    1f04:	57fd                	li	a5,-1
    1f06:	06f51763          	bne	a0,a5,1f74 <copyinstr3+0xaa>
  int fd = open(b, O_CREATE | O_WRONLY);
    1f0a:	20100593          	li	a1,513
    1f0e:	8526                	mv	a0,s1
    1f10:	3c7020ef          	jal	4ad6 <open>
  if(fd != -1){
    1f14:	57fd                	li	a5,-1
    1f16:	06f51a63          	bne	a0,a5,1f8a <copyinstr3+0xc0>
  ret = link(b, b);
    1f1a:	85a6                	mv	a1,s1
    1f1c:	8526                	mv	a0,s1
    1f1e:	3d9020ef          	jal	4af6 <link>
  if(ret != -1){
    1f22:	57fd                	li	a5,-1
    1f24:	06f51e63          	bne	a0,a5,1fa0 <copyinstr3+0xd6>
  char *args[] = { "xx", 0 };
    1f28:	00005797          	auipc	a5,0x5
    1f2c:	a8078793          	addi	a5,a5,-1408 # 69a8 <malloc+0x1a10>
    1f30:	fcf43823          	sd	a5,-48(s0)
    1f34:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    1f38:	fd040593          	addi	a1,s0,-48
    1f3c:	8526                	mv	a0,s1
    1f3e:	391020ef          	jal	4ace <exec>
  if(ret != -1){
    1f42:	57fd                	li	a5,-1
    1f44:	06f51a63          	bne	a0,a5,1fb8 <copyinstr3+0xee>
}
    1f48:	70a2                	ld	ra,40(sp)
    1f4a:	7402                	ld	s0,32(sp)
    1f4c:	64e2                	ld	s1,24(sp)
    1f4e:	6145                	addi	sp,sp,48
    1f50:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    1f52:	0347d513          	srli	a0,a5,0x34
    1f56:	6785                	lui	a5,0x1
    1f58:	40a7853b          	subw	a0,a5,a0
    1f5c:	3c3020ef          	jal	4b1e <sbrk>
    1f60:	b759                	j	1ee6 <copyinstr3+0x1c>
    printf("oops\n");
    1f62:	00004517          	auipc	a0,0x4
    1f66:	d5e50513          	addi	a0,a0,-674 # 5cc0 <malloc+0xd28>
    1f6a:	77b020ef          	jal	4ee4 <printf>
    exit(1);
    1f6e:	4505                	li	a0,1
    1f70:	327020ef          	jal	4a96 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1f74:	862a                	mv	a2,a0
    1f76:	85a6                	mv	a1,s1
    1f78:	00004517          	auipc	a0,0x4
    1f7c:	90050513          	addi	a0,a0,-1792 # 5878 <malloc+0x8e0>
    1f80:	765020ef          	jal	4ee4 <printf>
    exit(1);
    1f84:	4505                	li	a0,1
    1f86:	311020ef          	jal	4a96 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1f8a:	862a                	mv	a2,a0
    1f8c:	85a6                	mv	a1,s1
    1f8e:	00004517          	auipc	a0,0x4
    1f92:	90a50513          	addi	a0,a0,-1782 # 5898 <malloc+0x900>
    1f96:	74f020ef          	jal	4ee4 <printf>
    exit(1);
    1f9a:	4505                	li	a0,1
    1f9c:	2fb020ef          	jal	4a96 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1fa0:	86aa                	mv	a3,a0
    1fa2:	8626                	mv	a2,s1
    1fa4:	85a6                	mv	a1,s1
    1fa6:	00004517          	auipc	a0,0x4
    1faa:	91250513          	addi	a0,a0,-1774 # 58b8 <malloc+0x920>
    1fae:	737020ef          	jal	4ee4 <printf>
    exit(1);
    1fb2:	4505                	li	a0,1
    1fb4:	2e3020ef          	jal	4a96 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1fb8:	567d                	li	a2,-1
    1fba:	85a6                	mv	a1,s1
    1fbc:	00004517          	auipc	a0,0x4
    1fc0:	92450513          	addi	a0,a0,-1756 # 58e0 <malloc+0x948>
    1fc4:	721020ef          	jal	4ee4 <printf>
    exit(1);
    1fc8:	4505                	li	a0,1
    1fca:	2cd020ef          	jal	4a96 <exit>

0000000000001fce <rwsbrk>:
{
    1fce:	1101                	addi	sp,sp,-32
    1fd0:	ec06                	sd	ra,24(sp)
    1fd2:	e822                	sd	s0,16(sp)
    1fd4:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    1fd6:	6509                	lui	a0,0x2
    1fd8:	347020ef          	jal	4b1e <sbrk>
  if(a == 0xffffffffffffffffLL) {
    1fdc:	57fd                	li	a5,-1
    1fde:	04f50a63          	beq	a0,a5,2032 <rwsbrk+0x64>
    1fe2:	e426                	sd	s1,8(sp)
    1fe4:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    1fe6:	7579                	lui	a0,0xffffe
    1fe8:	337020ef          	jal	4b1e <sbrk>
    1fec:	57fd                	li	a5,-1
    1fee:	04f50d63          	beq	a0,a5,2048 <rwsbrk+0x7a>
    1ff2:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    1ff4:	20100593          	li	a1,513
    1ff8:	00004517          	auipc	a0,0x4
    1ffc:	d0850513          	addi	a0,a0,-760 # 5d00 <malloc+0xd68>
    2000:	2d7020ef          	jal	4ad6 <open>
    2004:	892a                	mv	s2,a0
  if(fd < 0){
    2006:	04054b63          	bltz	a0,205c <rwsbrk+0x8e>
  n = write(fd, (void*)(a+4096), 1024);
    200a:	6785                	lui	a5,0x1
    200c:	94be                	add	s1,s1,a5
    200e:	40000613          	li	a2,1024
    2012:	85a6                	mv	a1,s1
    2014:	2a3020ef          	jal	4ab6 <write>
    2018:	862a                	mv	a2,a0
  if(n >= 0){
    201a:	04054a63          	bltz	a0,206e <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void*)a+4096, n);
    201e:	85a6                	mv	a1,s1
    2020:	00004517          	auipc	a0,0x4
    2024:	d0050513          	addi	a0,a0,-768 # 5d20 <malloc+0xd88>
    2028:	6bd020ef          	jal	4ee4 <printf>
    exit(1);
    202c:	4505                	li	a0,1
    202e:	269020ef          	jal	4a96 <exit>
    2032:	e426                	sd	s1,8(sp)
    2034:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    2036:	00004517          	auipc	a0,0x4
    203a:	c9250513          	addi	a0,a0,-878 # 5cc8 <malloc+0xd30>
    203e:	6a7020ef          	jal	4ee4 <printf>
    exit(1);
    2042:	4505                	li	a0,1
    2044:	253020ef          	jal	4a96 <exit>
    2048:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    204a:	00004517          	auipc	a0,0x4
    204e:	c9650513          	addi	a0,a0,-874 # 5ce0 <malloc+0xd48>
    2052:	693020ef          	jal	4ee4 <printf>
    exit(1);
    2056:	4505                	li	a0,1
    2058:	23f020ef          	jal	4a96 <exit>
    printf("open(rwsbrk) failed\n");
    205c:	00004517          	auipc	a0,0x4
    2060:	cac50513          	addi	a0,a0,-852 # 5d08 <malloc+0xd70>
    2064:	681020ef          	jal	4ee4 <printf>
    exit(1);
    2068:	4505                	li	a0,1
    206a:	22d020ef          	jal	4a96 <exit>
  close(fd);
    206e:	854a                	mv	a0,s2
    2070:	24f020ef          	jal	4abe <close>
  unlink("rwsbrk");
    2074:	00004517          	auipc	a0,0x4
    2078:	c8c50513          	addi	a0,a0,-884 # 5d00 <malloc+0xd68>
    207c:	26b020ef          	jal	4ae6 <unlink>
  fd = open("README", O_RDONLY);
    2080:	4581                	li	a1,0
    2082:	00003517          	auipc	a0,0x3
    2086:	21e50513          	addi	a0,a0,542 # 52a0 <malloc+0x308>
    208a:	24d020ef          	jal	4ad6 <open>
    208e:	892a                	mv	s2,a0
  if(fd < 0){
    2090:	02054363          	bltz	a0,20b6 <rwsbrk+0xe8>
  n = read(fd, (void*)(a+4096), 10);
    2094:	4629                	li	a2,10
    2096:	85a6                	mv	a1,s1
    2098:	217020ef          	jal	4aae <read>
    209c:	862a                	mv	a2,a0
  if(n >= 0){
    209e:	02054563          	bltz	a0,20c8 <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void*)a+4096, n);
    20a2:	85a6                	mv	a1,s1
    20a4:	00004517          	auipc	a0,0x4
    20a8:	cac50513          	addi	a0,a0,-852 # 5d50 <malloc+0xdb8>
    20ac:	639020ef          	jal	4ee4 <printf>
    exit(1);
    20b0:	4505                	li	a0,1
    20b2:	1e5020ef          	jal	4a96 <exit>
    printf("open(rwsbrk) failed\n");
    20b6:	00004517          	auipc	a0,0x4
    20ba:	c5250513          	addi	a0,a0,-942 # 5d08 <malloc+0xd70>
    20be:	627020ef          	jal	4ee4 <printf>
    exit(1);
    20c2:	4505                	li	a0,1
    20c4:	1d3020ef          	jal	4a96 <exit>
  close(fd);
    20c8:	854a                	mv	a0,s2
    20ca:	1f5020ef          	jal	4abe <close>
  exit(0);
    20ce:	4501                	li	a0,0
    20d0:	1c7020ef          	jal	4a96 <exit>

00000000000020d4 <sbrkbasic>:
{
    20d4:	7139                	addi	sp,sp,-64
    20d6:	fc06                	sd	ra,56(sp)
    20d8:	f822                	sd	s0,48(sp)
    20da:	ec4e                	sd	s3,24(sp)
    20dc:	0080                	addi	s0,sp,64
    20de:	89aa                	mv	s3,a0
  pid = fork();
    20e0:	1af020ef          	jal	4a8e <fork>
  if(pid < 0){
    20e4:	02054b63          	bltz	a0,211a <sbrkbasic+0x46>
  if(pid == 0){
    20e8:	e939                	bnez	a0,213e <sbrkbasic+0x6a>
    a = sbrk(TOOMUCH);
    20ea:	40000537          	lui	a0,0x40000
    20ee:	231020ef          	jal	4b1e <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    20f2:	57fd                	li	a5,-1
    20f4:	02f50f63          	beq	a0,a5,2132 <sbrkbasic+0x5e>
    20f8:	f426                	sd	s1,40(sp)
    20fa:	f04a                	sd	s2,32(sp)
    20fc:	e852                	sd	s4,16(sp)
    for(b = a; b < a+TOOMUCH; b += 4096){
    20fe:	400007b7          	lui	a5,0x40000
    2102:	97aa                	add	a5,a5,a0
      *b = 99;
    2104:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    2108:	6705                	lui	a4,0x1
      *b = 99;
    210a:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    210e:	953a                	add	a0,a0,a4
    2110:	fef51de3          	bne	a0,a5,210a <sbrkbasic+0x36>
    exit(1);
    2114:	4505                	li	a0,1
    2116:	181020ef          	jal	4a96 <exit>
    211a:	f426                	sd	s1,40(sp)
    211c:	f04a                	sd	s2,32(sp)
    211e:	e852                	sd	s4,16(sp)
    printf("fork failed in sbrkbasic\n");
    2120:	00004517          	auipc	a0,0x4
    2124:	c5850513          	addi	a0,a0,-936 # 5d78 <malloc+0xde0>
    2128:	5bd020ef          	jal	4ee4 <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	169020ef          	jal	4a96 <exit>
    2132:	f426                	sd	s1,40(sp)
    2134:	f04a                	sd	s2,32(sp)
    2136:	e852                	sd	s4,16(sp)
      exit(0);
    2138:	4501                	li	a0,0
    213a:	15d020ef          	jal	4a96 <exit>
  wait(&xstatus);
    213e:	fcc40513          	addi	a0,s0,-52
    2142:	15d020ef          	jal	4a9e <wait>
  if(xstatus == 1){
    2146:	fcc42703          	lw	a4,-52(s0)
    214a:	4785                	li	a5,1
    214c:	00f70e63          	beq	a4,a5,2168 <sbrkbasic+0x94>
    2150:	f426                	sd	s1,40(sp)
    2152:	f04a                	sd	s2,32(sp)
    2154:	e852                	sd	s4,16(sp)
  a = sbrk(0);
    2156:	4501                	li	a0,0
    2158:	1c7020ef          	jal	4b1e <sbrk>
    215c:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    215e:	4901                	li	s2,0
    2160:	6a05                	lui	s4,0x1
    2162:	388a0a13          	addi	s4,s4,904 # 1388 <exectest+0x4a>
    2166:	a839                	j	2184 <sbrkbasic+0xb0>
    2168:	f426                	sd	s1,40(sp)
    216a:	f04a                	sd	s2,32(sp)
    216c:	e852                	sd	s4,16(sp)
    printf("%s: too much memory allocated!\n", s);
    216e:	85ce                	mv	a1,s3
    2170:	00004517          	auipc	a0,0x4
    2174:	c2850513          	addi	a0,a0,-984 # 5d98 <malloc+0xe00>
    2178:	56d020ef          	jal	4ee4 <printf>
    exit(1);
    217c:	4505                	li	a0,1
    217e:	119020ef          	jal	4a96 <exit>
    2182:	84be                	mv	s1,a5
    b = sbrk(1);
    2184:	4505                	li	a0,1
    2186:	199020ef          	jal	4b1e <sbrk>
    if(b != a){
    218a:	04951263          	bne	a0,s1,21ce <sbrkbasic+0xfa>
    *b = 1;
    218e:	4785                	li	a5,1
    2190:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2194:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    2198:	2905                	addiw	s2,s2,1
    219a:	ff4914e3          	bne	s2,s4,2182 <sbrkbasic+0xae>
  pid = fork();
    219e:	0f1020ef          	jal	4a8e <fork>
    21a2:	892a                	mv	s2,a0
  if(pid < 0){
    21a4:	04054263          	bltz	a0,21e8 <sbrkbasic+0x114>
  c = sbrk(1);
    21a8:	4505                	li	a0,1
    21aa:	175020ef          	jal	4b1e <sbrk>
  c = sbrk(1);
    21ae:	4505                	li	a0,1
    21b0:	16f020ef          	jal	4b1e <sbrk>
  if(c != a + 1){
    21b4:	0489                	addi	s1,s1,2
    21b6:	04a48363          	beq	s1,a0,21fc <sbrkbasic+0x128>
    printf("%s: sbrk test failed post-fork\n", s);
    21ba:	85ce                	mv	a1,s3
    21bc:	00004517          	auipc	a0,0x4
    21c0:	c3c50513          	addi	a0,a0,-964 # 5df8 <malloc+0xe60>
    21c4:	521020ef          	jal	4ee4 <printf>
    exit(1);
    21c8:	4505                	li	a0,1
    21ca:	0cd020ef          	jal	4a96 <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    21ce:	872a                	mv	a4,a0
    21d0:	86a6                	mv	a3,s1
    21d2:	864a                	mv	a2,s2
    21d4:	85ce                	mv	a1,s3
    21d6:	00004517          	auipc	a0,0x4
    21da:	be250513          	addi	a0,a0,-1054 # 5db8 <malloc+0xe20>
    21de:	507020ef          	jal	4ee4 <printf>
      exit(1);
    21e2:	4505                	li	a0,1
    21e4:	0b3020ef          	jal	4a96 <exit>
    printf("%s: sbrk test fork failed\n", s);
    21e8:	85ce                	mv	a1,s3
    21ea:	00004517          	auipc	a0,0x4
    21ee:	bee50513          	addi	a0,a0,-1042 # 5dd8 <malloc+0xe40>
    21f2:	4f3020ef          	jal	4ee4 <printf>
    exit(1);
    21f6:	4505                	li	a0,1
    21f8:	09f020ef          	jal	4a96 <exit>
  if(pid == 0)
    21fc:	00091563          	bnez	s2,2206 <sbrkbasic+0x132>
    exit(0);
    2200:	4501                	li	a0,0
    2202:	095020ef          	jal	4a96 <exit>
  wait(&xstatus);
    2206:	fcc40513          	addi	a0,s0,-52
    220a:	095020ef          	jal	4a9e <wait>
  exit(xstatus);
    220e:	fcc42503          	lw	a0,-52(s0)
    2212:	085020ef          	jal	4a96 <exit>

0000000000002216 <sbrkmuch>:
{
    2216:	7179                	addi	sp,sp,-48
    2218:	f406                	sd	ra,40(sp)
    221a:	f022                	sd	s0,32(sp)
    221c:	ec26                	sd	s1,24(sp)
    221e:	e84a                	sd	s2,16(sp)
    2220:	e44e                	sd	s3,8(sp)
    2222:	e052                	sd	s4,0(sp)
    2224:	1800                	addi	s0,sp,48
    2226:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2228:	4501                	li	a0,0
    222a:	0f5020ef          	jal	4b1e <sbrk>
    222e:	892a                	mv	s2,a0
  a = sbrk(0);
    2230:	4501                	li	a0,0
    2232:	0ed020ef          	jal	4b1e <sbrk>
    2236:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2238:	06400537          	lui	a0,0x6400
    223c:	9d05                	subw	a0,a0,s1
    223e:	0e1020ef          	jal	4b1e <sbrk>
  if (p != a) {
    2242:	0aa49463          	bne	s1,a0,22ea <sbrkmuch+0xd4>
  char *eee = sbrk(0);
    2246:	4501                	li	a0,0
    2248:	0d7020ef          	jal	4b1e <sbrk>
    224c:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    224e:	00a4f963          	bgeu	s1,a0,2260 <sbrkmuch+0x4a>
    *pp = 1;
    2252:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2254:	6705                	lui	a4,0x1
    *pp = 1;
    2256:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    225a:	94ba                	add	s1,s1,a4
    225c:	fef4ede3          	bltu	s1,a5,2256 <sbrkmuch+0x40>
  *lastaddr = 99;
    2260:	064007b7          	lui	a5,0x6400
    2264:	06300713          	li	a4,99
    2268:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    226c:	4501                	li	a0,0
    226e:	0b1020ef          	jal	4b1e <sbrk>
    2272:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2274:	757d                	lui	a0,0xfffff
    2276:	0a9020ef          	jal	4b1e <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    227a:	57fd                	li	a5,-1
    227c:	08f50163          	beq	a0,a5,22fe <sbrkmuch+0xe8>
  c = sbrk(0);
    2280:	4501                	li	a0,0
    2282:	09d020ef          	jal	4b1e <sbrk>
  if(c != a - PGSIZE){
    2286:	77fd                	lui	a5,0xfffff
    2288:	97a6                	add	a5,a5,s1
    228a:	08f51463          	bne	a0,a5,2312 <sbrkmuch+0xfc>
  a = sbrk(0);
    228e:	4501                	li	a0,0
    2290:	08f020ef          	jal	4b1e <sbrk>
    2294:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2296:	6505                	lui	a0,0x1
    2298:	087020ef          	jal	4b1e <sbrk>
    229c:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    229e:	08a49663          	bne	s1,a0,232a <sbrkmuch+0x114>
    22a2:	4501                	li	a0,0
    22a4:	07b020ef          	jal	4b1e <sbrk>
    22a8:	6785                	lui	a5,0x1
    22aa:	97a6                	add	a5,a5,s1
    22ac:	06f51f63          	bne	a0,a5,232a <sbrkmuch+0x114>
  if(*lastaddr == 99){
    22b0:	064007b7          	lui	a5,0x6400
    22b4:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    22b8:	06300793          	li	a5,99
    22bc:	08f70363          	beq	a4,a5,2342 <sbrkmuch+0x12c>
  a = sbrk(0);
    22c0:	4501                	li	a0,0
    22c2:	05d020ef          	jal	4b1e <sbrk>
    22c6:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    22c8:	4501                	li	a0,0
    22ca:	055020ef          	jal	4b1e <sbrk>
    22ce:	40a9053b          	subw	a0,s2,a0
    22d2:	04d020ef          	jal	4b1e <sbrk>
  if(c != a){
    22d6:	08a49063          	bne	s1,a0,2356 <sbrkmuch+0x140>
}
    22da:	70a2                	ld	ra,40(sp)
    22dc:	7402                	ld	s0,32(sp)
    22de:	64e2                	ld	s1,24(sp)
    22e0:	6942                	ld	s2,16(sp)
    22e2:	69a2                	ld	s3,8(sp)
    22e4:	6a02                	ld	s4,0(sp)
    22e6:	6145                	addi	sp,sp,48
    22e8:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    22ea:	85ce                	mv	a1,s3
    22ec:	00004517          	auipc	a0,0x4
    22f0:	b2c50513          	addi	a0,a0,-1236 # 5e18 <malloc+0xe80>
    22f4:	3f1020ef          	jal	4ee4 <printf>
    exit(1);
    22f8:	4505                	li	a0,1
    22fa:	79c020ef          	jal	4a96 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    22fe:	85ce                	mv	a1,s3
    2300:	00004517          	auipc	a0,0x4
    2304:	b6050513          	addi	a0,a0,-1184 # 5e60 <malloc+0xec8>
    2308:	3dd020ef          	jal	4ee4 <printf>
    exit(1);
    230c:	4505                	li	a0,1
    230e:	788020ef          	jal	4a96 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a, c);
    2312:	86aa                	mv	a3,a0
    2314:	8626                	mv	a2,s1
    2316:	85ce                	mv	a1,s3
    2318:	00004517          	auipc	a0,0x4
    231c:	b6850513          	addi	a0,a0,-1176 # 5e80 <malloc+0xee8>
    2320:	3c5020ef          	jal	4ee4 <printf>
    exit(1);
    2324:	4505                	li	a0,1
    2326:	770020ef          	jal	4a96 <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    232a:	86d2                	mv	a3,s4
    232c:	8626                	mv	a2,s1
    232e:	85ce                	mv	a1,s3
    2330:	00004517          	auipc	a0,0x4
    2334:	b9050513          	addi	a0,a0,-1136 # 5ec0 <malloc+0xf28>
    2338:	3ad020ef          	jal	4ee4 <printf>
    exit(1);
    233c:	4505                	li	a0,1
    233e:	758020ef          	jal	4a96 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2342:	85ce                	mv	a1,s3
    2344:	00004517          	auipc	a0,0x4
    2348:	bac50513          	addi	a0,a0,-1108 # 5ef0 <malloc+0xf58>
    234c:	399020ef          	jal	4ee4 <printf>
    exit(1);
    2350:	4505                	li	a0,1
    2352:	744020ef          	jal	4a96 <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    2356:	86aa                	mv	a3,a0
    2358:	8626                	mv	a2,s1
    235a:	85ce                	mv	a1,s3
    235c:	00004517          	auipc	a0,0x4
    2360:	bcc50513          	addi	a0,a0,-1076 # 5f28 <malloc+0xf90>
    2364:	381020ef          	jal	4ee4 <printf>
    exit(1);
    2368:	4505                	li	a0,1
    236a:	72c020ef          	jal	4a96 <exit>

000000000000236e <sbrkarg>:
{
    236e:	7179                	addi	sp,sp,-48
    2370:	f406                	sd	ra,40(sp)
    2372:	f022                	sd	s0,32(sp)
    2374:	ec26                	sd	s1,24(sp)
    2376:	e84a                	sd	s2,16(sp)
    2378:	e44e                	sd	s3,8(sp)
    237a:	1800                	addi	s0,sp,48
    237c:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    237e:	6505                	lui	a0,0x1
    2380:	79e020ef          	jal	4b1e <sbrk>
    2384:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2386:	20100593          	li	a1,513
    238a:	00004517          	auipc	a0,0x4
    238e:	bc650513          	addi	a0,a0,-1082 # 5f50 <malloc+0xfb8>
    2392:	744020ef          	jal	4ad6 <open>
    2396:	84aa                	mv	s1,a0
  unlink("sbrk");
    2398:	00004517          	auipc	a0,0x4
    239c:	bb850513          	addi	a0,a0,-1096 # 5f50 <malloc+0xfb8>
    23a0:	746020ef          	jal	4ae6 <unlink>
  if(fd < 0)  {
    23a4:	0204c963          	bltz	s1,23d6 <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    23a8:	6605                	lui	a2,0x1
    23aa:	85ca                	mv	a1,s2
    23ac:	8526                	mv	a0,s1
    23ae:	708020ef          	jal	4ab6 <write>
    23b2:	02054c63          	bltz	a0,23ea <sbrkarg+0x7c>
  close(fd);
    23b6:	8526                	mv	a0,s1
    23b8:	706020ef          	jal	4abe <close>
  a = sbrk(PGSIZE);
    23bc:	6505                	lui	a0,0x1
    23be:	760020ef          	jal	4b1e <sbrk>
  if(pipe((int *) a) != 0){
    23c2:	6e4020ef          	jal	4aa6 <pipe>
    23c6:	ed05                	bnez	a0,23fe <sbrkarg+0x90>
}
    23c8:	70a2                	ld	ra,40(sp)
    23ca:	7402                	ld	s0,32(sp)
    23cc:	64e2                	ld	s1,24(sp)
    23ce:	6942                	ld	s2,16(sp)
    23d0:	69a2                	ld	s3,8(sp)
    23d2:	6145                	addi	sp,sp,48
    23d4:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    23d6:	85ce                	mv	a1,s3
    23d8:	00004517          	auipc	a0,0x4
    23dc:	b8050513          	addi	a0,a0,-1152 # 5f58 <malloc+0xfc0>
    23e0:	305020ef          	jal	4ee4 <printf>
    exit(1);
    23e4:	4505                	li	a0,1
    23e6:	6b0020ef          	jal	4a96 <exit>
    printf("%s: write sbrk failed\n", s);
    23ea:	85ce                	mv	a1,s3
    23ec:	00004517          	auipc	a0,0x4
    23f0:	b8450513          	addi	a0,a0,-1148 # 5f70 <malloc+0xfd8>
    23f4:	2f1020ef          	jal	4ee4 <printf>
    exit(1);
    23f8:	4505                	li	a0,1
    23fa:	69c020ef          	jal	4a96 <exit>
    printf("%s: pipe() failed\n", s);
    23fe:	85ce                	mv	a1,s3
    2400:	00003517          	auipc	a0,0x3
    2404:	66050513          	addi	a0,a0,1632 # 5a60 <malloc+0xac8>
    2408:	2dd020ef          	jal	4ee4 <printf>
    exit(1);
    240c:	4505                	li	a0,1
    240e:	688020ef          	jal	4a96 <exit>

0000000000002412 <argptest>:
{
    2412:	1101                	addi	sp,sp,-32
    2414:	ec06                	sd	ra,24(sp)
    2416:	e822                	sd	s0,16(sp)
    2418:	e426                	sd	s1,8(sp)
    241a:	e04a                	sd	s2,0(sp)
    241c:	1000                	addi	s0,sp,32
    241e:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2420:	4581                	li	a1,0
    2422:	00004517          	auipc	a0,0x4
    2426:	b6650513          	addi	a0,a0,-1178 # 5f88 <malloc+0xff0>
    242a:	6ac020ef          	jal	4ad6 <open>
  if (fd < 0) {
    242e:	02054563          	bltz	a0,2458 <argptest+0x46>
    2432:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2434:	4501                	li	a0,0
    2436:	6e8020ef          	jal	4b1e <sbrk>
    243a:	567d                	li	a2,-1
    243c:	fff50593          	addi	a1,a0,-1
    2440:	8526                	mv	a0,s1
    2442:	66c020ef          	jal	4aae <read>
  close(fd);
    2446:	8526                	mv	a0,s1
    2448:	676020ef          	jal	4abe <close>
}
    244c:	60e2                	ld	ra,24(sp)
    244e:	6442                	ld	s0,16(sp)
    2450:	64a2                	ld	s1,8(sp)
    2452:	6902                	ld	s2,0(sp)
    2454:	6105                	addi	sp,sp,32
    2456:	8082                	ret
    printf("%s: open failed\n", s);
    2458:	85ca                	mv	a1,s2
    245a:	00003517          	auipc	a0,0x3
    245e:	51650513          	addi	a0,a0,1302 # 5970 <malloc+0x9d8>
    2462:	283020ef          	jal	4ee4 <printf>
    exit(1);
    2466:	4505                	li	a0,1
    2468:	62e020ef          	jal	4a96 <exit>

000000000000246c <sbrkbugs>:
{
    246c:	1141                	addi	sp,sp,-16
    246e:	e406                	sd	ra,8(sp)
    2470:	e022                	sd	s0,0(sp)
    2472:	0800                	addi	s0,sp,16
  int pid = fork();
    2474:	61a020ef          	jal	4a8e <fork>
  if(pid < 0){
    2478:	00054c63          	bltz	a0,2490 <sbrkbugs+0x24>
  if(pid == 0){
    247c:	e11d                	bnez	a0,24a2 <sbrkbugs+0x36>
    int sz = (uint64) sbrk(0);
    247e:	6a0020ef          	jal	4b1e <sbrk>
    sbrk(-sz);
    2482:	40a0053b          	negw	a0,a0
    2486:	698020ef          	jal	4b1e <sbrk>
    exit(0);
    248a:	4501                	li	a0,0
    248c:	60a020ef          	jal	4a96 <exit>
    printf("fork failed\n");
    2490:	00005517          	auipc	a0,0x5
    2494:	a3850513          	addi	a0,a0,-1480 # 6ec8 <malloc+0x1f30>
    2498:	24d020ef          	jal	4ee4 <printf>
    exit(1);
    249c:	4505                	li	a0,1
    249e:	5f8020ef          	jal	4a96 <exit>
  wait(0);
    24a2:	4501                	li	a0,0
    24a4:	5fa020ef          	jal	4a9e <wait>
  pid = fork();
    24a8:	5e6020ef          	jal	4a8e <fork>
  if(pid < 0){
    24ac:	00054f63          	bltz	a0,24ca <sbrkbugs+0x5e>
  if(pid == 0){
    24b0:	e515                	bnez	a0,24dc <sbrkbugs+0x70>
    int sz = (uint64) sbrk(0);
    24b2:	66c020ef          	jal	4b1e <sbrk>
    sbrk(-(sz - 3500));
    24b6:	6785                	lui	a5,0x1
    24b8:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0x138>
    24bc:	40a7853b          	subw	a0,a5,a0
    24c0:	65e020ef          	jal	4b1e <sbrk>
    exit(0);
    24c4:	4501                	li	a0,0
    24c6:	5d0020ef          	jal	4a96 <exit>
    printf("fork failed\n");
    24ca:	00005517          	auipc	a0,0x5
    24ce:	9fe50513          	addi	a0,a0,-1538 # 6ec8 <malloc+0x1f30>
    24d2:	213020ef          	jal	4ee4 <printf>
    exit(1);
    24d6:	4505                	li	a0,1
    24d8:	5be020ef          	jal	4a96 <exit>
  wait(0);
    24dc:	4501                	li	a0,0
    24de:	5c0020ef          	jal	4a9e <wait>
  pid = fork();
    24e2:	5ac020ef          	jal	4a8e <fork>
  if(pid < 0){
    24e6:	02054263          	bltz	a0,250a <sbrkbugs+0x9e>
  if(pid == 0){
    24ea:	e90d                	bnez	a0,251c <sbrkbugs+0xb0>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    24ec:	632020ef          	jal	4b1e <sbrk>
    24f0:	67ad                	lui	a5,0xb
    24f2:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x298>
    24f6:	40a7853b          	subw	a0,a5,a0
    24fa:	624020ef          	jal	4b1e <sbrk>
    sbrk(-10);
    24fe:	5559                	li	a0,-10
    2500:	61e020ef          	jal	4b1e <sbrk>
    exit(0);
    2504:	4501                	li	a0,0
    2506:	590020ef          	jal	4a96 <exit>
    printf("fork failed\n");
    250a:	00005517          	auipc	a0,0x5
    250e:	9be50513          	addi	a0,a0,-1602 # 6ec8 <malloc+0x1f30>
    2512:	1d3020ef          	jal	4ee4 <printf>
    exit(1);
    2516:	4505                	li	a0,1
    2518:	57e020ef          	jal	4a96 <exit>
  wait(0);
    251c:	4501                	li	a0,0
    251e:	580020ef          	jal	4a9e <wait>
  exit(0);
    2522:	4501                	li	a0,0
    2524:	572020ef          	jal	4a96 <exit>

0000000000002528 <sbrklast>:
{
    2528:	7179                	addi	sp,sp,-48
    252a:	f406                	sd	ra,40(sp)
    252c:	f022                	sd	s0,32(sp)
    252e:	ec26                	sd	s1,24(sp)
    2530:	e84a                	sd	s2,16(sp)
    2532:	e44e                	sd	s3,8(sp)
    2534:	e052                	sd	s4,0(sp)
    2536:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2538:	4501                	li	a0,0
    253a:	5e4020ef          	jal	4b1e <sbrk>
  if((top % 4096) != 0)
    253e:	03451793          	slli	a5,a0,0x34
    2542:	ebad                	bnez	a5,25b4 <sbrklast+0x8c>
  sbrk(4096);
    2544:	6505                	lui	a0,0x1
    2546:	5d8020ef          	jal	4b1e <sbrk>
  sbrk(10);
    254a:	4529                	li	a0,10
    254c:	5d2020ef          	jal	4b1e <sbrk>
  sbrk(-20);
    2550:	5531                	li	a0,-20
    2552:	5cc020ef          	jal	4b1e <sbrk>
  top = (uint64) sbrk(0);
    2556:	4501                	li	a0,0
    2558:	5c6020ef          	jal	4b1e <sbrk>
    255c:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    255e:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0x122>
  p[0] = 'x';
    2562:	07800a13          	li	s4,120
    2566:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    256a:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    256e:	20200593          	li	a1,514
    2572:	854a                	mv	a0,s2
    2574:	562020ef          	jal	4ad6 <open>
    2578:	89aa                	mv	s3,a0
  write(fd, p, 1);
    257a:	4605                	li	a2,1
    257c:	85ca                	mv	a1,s2
    257e:	538020ef          	jal	4ab6 <write>
  close(fd);
    2582:	854e                	mv	a0,s3
    2584:	53a020ef          	jal	4abe <close>
  fd = open(p, O_RDWR);
    2588:	4589                	li	a1,2
    258a:	854a                	mv	a0,s2
    258c:	54a020ef          	jal	4ad6 <open>
  p[0] = '\0';
    2590:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2594:	4605                	li	a2,1
    2596:	85ca                	mv	a1,s2
    2598:	516020ef          	jal	4aae <read>
  if(p[0] != 'x')
    259c:	fc04c783          	lbu	a5,-64(s1)
    25a0:	03479263          	bne	a5,s4,25c4 <sbrklast+0x9c>
}
    25a4:	70a2                	ld	ra,40(sp)
    25a6:	7402                	ld	s0,32(sp)
    25a8:	64e2                	ld	s1,24(sp)
    25aa:	6942                	ld	s2,16(sp)
    25ac:	69a2                	ld	s3,8(sp)
    25ae:	6a02                	ld	s4,0(sp)
    25b0:	6145                	addi	sp,sp,48
    25b2:	8082                	ret
    sbrk(4096 - (top % 4096));
    25b4:	0347d513          	srli	a0,a5,0x34
    25b8:	6785                	lui	a5,0x1
    25ba:	40a7853b          	subw	a0,a5,a0
    25be:	560020ef          	jal	4b1e <sbrk>
    25c2:	b749                	j	2544 <sbrklast+0x1c>
    exit(1);
    25c4:	4505                	li	a0,1
    25c6:	4d0020ef          	jal	4a96 <exit>

00000000000025ca <sbrk8000>:
{
    25ca:	1141                	addi	sp,sp,-16
    25cc:	e406                	sd	ra,8(sp)
    25ce:	e022                	sd	s0,0(sp)
    25d0:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    25d2:	80000537          	lui	a0,0x80000
    25d6:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    25d8:	546020ef          	jal	4b1e <sbrk>
  volatile char *top = sbrk(0);
    25dc:	4501                	li	a0,0
    25de:	540020ef          	jal	4b1e <sbrk>
  *(top-1) = *(top-1) + 1;
    25e2:	fff54783          	lbu	a5,-1(a0)
    25e6:	2785                	addiw	a5,a5,1 # 1001 <badarg+0x1>
    25e8:	0ff7f793          	zext.b	a5,a5
    25ec:	fef50fa3          	sb	a5,-1(a0)
}
    25f0:	60a2                	ld	ra,8(sp)
    25f2:	6402                	ld	s0,0(sp)
    25f4:	0141                	addi	sp,sp,16
    25f6:	8082                	ret

00000000000025f8 <execout>:
{
    25f8:	715d                	addi	sp,sp,-80
    25fa:	e486                	sd	ra,72(sp)
    25fc:	e0a2                	sd	s0,64(sp)
    25fe:	fc26                	sd	s1,56(sp)
    2600:	f84a                	sd	s2,48(sp)
    2602:	f44e                	sd	s3,40(sp)
    2604:	f052                	sd	s4,32(sp)
    2606:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2608:	4901                	li	s2,0
    260a:	49bd                	li	s3,15
    int pid = fork();
    260c:	482020ef          	jal	4a8e <fork>
    2610:	84aa                	mv	s1,a0
    if(pid < 0){
    2612:	00054c63          	bltz	a0,262a <execout+0x32>
    } else if(pid == 0){
    2616:	c11d                	beqz	a0,263c <execout+0x44>
      wait((int*)0);
    2618:	4501                	li	a0,0
    261a:	484020ef          	jal	4a9e <wait>
  for(int avail = 0; avail < 15; avail++){
    261e:	2905                	addiw	s2,s2,1
    2620:	ff3916e3          	bne	s2,s3,260c <execout+0x14>
  exit(0);
    2624:	4501                	li	a0,0
    2626:	470020ef          	jal	4a96 <exit>
      printf("fork failed\n");
    262a:	00005517          	auipc	a0,0x5
    262e:	89e50513          	addi	a0,a0,-1890 # 6ec8 <malloc+0x1f30>
    2632:	0b3020ef          	jal	4ee4 <printf>
      exit(1);
    2636:	4505                	li	a0,1
    2638:	45e020ef          	jal	4a96 <exit>
        if(a == 0xffffffffffffffffLL)
    263c:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    263e:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2640:	6505                	lui	a0,0x1
    2642:	4dc020ef          	jal	4b1e <sbrk>
        if(a == 0xffffffffffffffffLL)
    2646:	01350763          	beq	a0,s3,2654 <execout+0x5c>
        *(char*)(a + 4096 - 1) = 1;
    264a:	6785                	lui	a5,0x1
    264c:	97aa                	add	a5,a5,a0
    264e:	ff478fa3          	sb	s4,-1(a5) # fff <pgbug+0x2b>
      while(1){
    2652:	b7fd                	j	2640 <execout+0x48>
      for(int i = 0; i < avail; i++)
    2654:	01205863          	blez	s2,2664 <execout+0x6c>
        sbrk(-4096);
    2658:	757d                	lui	a0,0xfffff
    265a:	4c4020ef          	jal	4b1e <sbrk>
      for(int i = 0; i < avail; i++)
    265e:	2485                	addiw	s1,s1,1
    2660:	ff249ce3          	bne	s1,s2,2658 <execout+0x60>
      close(1);
    2664:	4505                	li	a0,1
    2666:	458020ef          	jal	4abe <close>
      char *args[] = { "echo", "x", 0 };
    266a:	00003517          	auipc	a0,0x3
    266e:	a5e50513          	addi	a0,a0,-1442 # 50c8 <malloc+0x130>
    2672:	faa43c23          	sd	a0,-72(s0)
    2676:	00003797          	auipc	a5,0x3
    267a:	ac278793          	addi	a5,a5,-1342 # 5138 <malloc+0x1a0>
    267e:	fcf43023          	sd	a5,-64(s0)
    2682:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2686:	fb840593          	addi	a1,s0,-72
    268a:	444020ef          	jal	4ace <exec>
      exit(0);
    268e:	4501                	li	a0,0
    2690:	406020ef          	jal	4a96 <exit>

0000000000002694 <fourteen>:
{
    2694:	1101                	addi	sp,sp,-32
    2696:	ec06                	sd	ra,24(sp)
    2698:	e822                	sd	s0,16(sp)
    269a:	e426                	sd	s1,8(sp)
    269c:	1000                	addi	s0,sp,32
    269e:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    26a0:	00004517          	auipc	a0,0x4
    26a4:	ac050513          	addi	a0,a0,-1344 # 6160 <malloc+0x11c8>
    26a8:	456020ef          	jal	4afe <mkdir>
    26ac:	e555                	bnez	a0,2758 <fourteen+0xc4>
  if(mkdir("12345678901234/123456789012345") != 0){
    26ae:	00004517          	auipc	a0,0x4
    26b2:	90a50513          	addi	a0,a0,-1782 # 5fb8 <malloc+0x1020>
    26b6:	448020ef          	jal	4afe <mkdir>
    26ba:	e94d                	bnez	a0,276c <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26bc:	20000593          	li	a1,512
    26c0:	00004517          	auipc	a0,0x4
    26c4:	95050513          	addi	a0,a0,-1712 # 6010 <malloc+0x1078>
    26c8:	40e020ef          	jal	4ad6 <open>
  if(fd < 0){
    26cc:	0a054a63          	bltz	a0,2780 <fourteen+0xec>
  close(fd);
    26d0:	3ee020ef          	jal	4abe <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    26d4:	4581                	li	a1,0
    26d6:	00004517          	auipc	a0,0x4
    26da:	9b250513          	addi	a0,a0,-1614 # 6088 <malloc+0x10f0>
    26de:	3f8020ef          	jal	4ad6 <open>
  if(fd < 0){
    26e2:	0a054963          	bltz	a0,2794 <fourteen+0x100>
  close(fd);
    26e6:	3d8020ef          	jal	4abe <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    26ea:	00004517          	auipc	a0,0x4
    26ee:	a0e50513          	addi	a0,a0,-1522 # 60f8 <malloc+0x1160>
    26f2:	40c020ef          	jal	4afe <mkdir>
    26f6:	c94d                	beqz	a0,27a8 <fourteen+0x114>
  if(mkdir("123456789012345/12345678901234") == 0){
    26f8:	00004517          	auipc	a0,0x4
    26fc:	a5850513          	addi	a0,a0,-1448 # 6150 <malloc+0x11b8>
    2700:	3fe020ef          	jal	4afe <mkdir>
    2704:	cd45                	beqz	a0,27bc <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    2706:	00004517          	auipc	a0,0x4
    270a:	a4a50513          	addi	a0,a0,-1462 # 6150 <malloc+0x11b8>
    270e:	3d8020ef          	jal	4ae6 <unlink>
  unlink("12345678901234/12345678901234");
    2712:	00004517          	auipc	a0,0x4
    2716:	9e650513          	addi	a0,a0,-1562 # 60f8 <malloc+0x1160>
    271a:	3cc020ef          	jal	4ae6 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    271e:	00004517          	auipc	a0,0x4
    2722:	96a50513          	addi	a0,a0,-1686 # 6088 <malloc+0x10f0>
    2726:	3c0020ef          	jal	4ae6 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    272a:	00004517          	auipc	a0,0x4
    272e:	8e650513          	addi	a0,a0,-1818 # 6010 <malloc+0x1078>
    2732:	3b4020ef          	jal	4ae6 <unlink>
  unlink("12345678901234/123456789012345");
    2736:	00004517          	auipc	a0,0x4
    273a:	88250513          	addi	a0,a0,-1918 # 5fb8 <malloc+0x1020>
    273e:	3a8020ef          	jal	4ae6 <unlink>
  unlink("12345678901234");
    2742:	00004517          	auipc	a0,0x4
    2746:	a1e50513          	addi	a0,a0,-1506 # 6160 <malloc+0x11c8>
    274a:	39c020ef          	jal	4ae6 <unlink>
}
    274e:	60e2                	ld	ra,24(sp)
    2750:	6442                	ld	s0,16(sp)
    2752:	64a2                	ld	s1,8(sp)
    2754:	6105                	addi	sp,sp,32
    2756:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2758:	85a6                	mv	a1,s1
    275a:	00004517          	auipc	a0,0x4
    275e:	83650513          	addi	a0,a0,-1994 # 5f90 <malloc+0xff8>
    2762:	782020ef          	jal	4ee4 <printf>
    exit(1);
    2766:	4505                	li	a0,1
    2768:	32e020ef          	jal	4a96 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    276c:	85a6                	mv	a1,s1
    276e:	00004517          	auipc	a0,0x4
    2772:	86a50513          	addi	a0,a0,-1942 # 5fd8 <malloc+0x1040>
    2776:	76e020ef          	jal	4ee4 <printf>
    exit(1);
    277a:	4505                	li	a0,1
    277c:	31a020ef          	jal	4a96 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2780:	85a6                	mv	a1,s1
    2782:	00004517          	auipc	a0,0x4
    2786:	8be50513          	addi	a0,a0,-1858 # 6040 <malloc+0x10a8>
    278a:	75a020ef          	jal	4ee4 <printf>
    exit(1);
    278e:	4505                	li	a0,1
    2790:	306020ef          	jal	4a96 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2794:	85a6                	mv	a1,s1
    2796:	00004517          	auipc	a0,0x4
    279a:	92250513          	addi	a0,a0,-1758 # 60b8 <malloc+0x1120>
    279e:	746020ef          	jal	4ee4 <printf>
    exit(1);
    27a2:	4505                	li	a0,1
    27a4:	2f2020ef          	jal	4a96 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    27a8:	85a6                	mv	a1,s1
    27aa:	00004517          	auipc	a0,0x4
    27ae:	96e50513          	addi	a0,a0,-1682 # 6118 <malloc+0x1180>
    27b2:	732020ef          	jal	4ee4 <printf>
    exit(1);
    27b6:	4505                	li	a0,1
    27b8:	2de020ef          	jal	4a96 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    27bc:	85a6                	mv	a1,s1
    27be:	00004517          	auipc	a0,0x4
    27c2:	9b250513          	addi	a0,a0,-1614 # 6170 <malloc+0x11d8>
    27c6:	71e020ef          	jal	4ee4 <printf>
    exit(1);
    27ca:	4505                	li	a0,1
    27cc:	2ca020ef          	jal	4a96 <exit>

00000000000027d0 <diskfull>:
{
    27d0:	b8010113          	addi	sp,sp,-1152
    27d4:	46113c23          	sd	ra,1144(sp)
    27d8:	46813823          	sd	s0,1136(sp)
    27dc:	46913423          	sd	s1,1128(sp)
    27e0:	47213023          	sd	s2,1120(sp)
    27e4:	45313c23          	sd	s3,1112(sp)
    27e8:	45413823          	sd	s4,1104(sp)
    27ec:	45513423          	sd	s5,1096(sp)
    27f0:	45613023          	sd	s6,1088(sp)
    27f4:	43713c23          	sd	s7,1080(sp)
    27f8:	43813823          	sd	s8,1072(sp)
    27fc:	43913423          	sd	s9,1064(sp)
    2800:	48010413          	addi	s0,sp,1152
    2804:	8caa                	mv	s9,a0
  unlink("diskfulldir");
    2806:	00004517          	auipc	a0,0x4
    280a:	9a250513          	addi	a0,a0,-1630 # 61a8 <malloc+0x1210>
    280e:	2d8020ef          	jal	4ae6 <unlink>
    2812:	03000993          	li	s3,48
    name[0] = 'b';
    2816:	06200b13          	li	s6,98
    name[1] = 'i';
    281a:	06900a93          	li	s5,105
    name[2] = 'g';
    281e:	06700a13          	li	s4,103
    2822:	10c00b93          	li	s7,268
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    2826:	07f00c13          	li	s8,127
    282a:	aab9                	j	2988 <diskfull+0x1b8>
      printf("%s: could not create file %s\n", s, name);
    282c:	b8040613          	addi	a2,s0,-1152
    2830:	85e6                	mv	a1,s9
    2832:	00004517          	auipc	a0,0x4
    2836:	98650513          	addi	a0,a0,-1658 # 61b8 <malloc+0x1220>
    283a:	6aa020ef          	jal	4ee4 <printf>
      break;
    283e:	a039                	j	284c <diskfull+0x7c>
        close(fd);
    2840:	854a                	mv	a0,s2
    2842:	27c020ef          	jal	4abe <close>
    close(fd);
    2846:	854a                	mv	a0,s2
    2848:	276020ef          	jal	4abe <close>
  for(int i = 0; i < nzz; i++){
    284c:	4481                	li	s1,0
    name[0] = 'z';
    284e:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    2852:	08000993          	li	s3,128
    name[0] = 'z';
    2856:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    285a:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    285e:	41f4d71b          	sraiw	a4,s1,0x1f
    2862:	01b7571b          	srliw	a4,a4,0x1b
    2866:	009707bb          	addw	a5,a4,s1
    286a:	4057d69b          	sraiw	a3,a5,0x5
    286e:	0306869b          	addiw	a3,a3,48
    2872:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    2876:	8bfd                	andi	a5,a5,31
    2878:	9f99                	subw	a5,a5,a4
    287a:	0307879b          	addiw	a5,a5,48
    287e:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    2882:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    2886:	ba040513          	addi	a0,s0,-1120
    288a:	25c020ef          	jal	4ae6 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    288e:	60200593          	li	a1,1538
    2892:	ba040513          	addi	a0,s0,-1120
    2896:	240020ef          	jal	4ad6 <open>
    if(fd < 0)
    289a:	00054763          	bltz	a0,28a8 <diskfull+0xd8>
    close(fd);
    289e:	220020ef          	jal	4abe <close>
  for(int i = 0; i < nzz; i++){
    28a2:	2485                	addiw	s1,s1,1
    28a4:	fb3499e3          	bne	s1,s3,2856 <diskfull+0x86>
  if(mkdir("diskfulldir") == 0)
    28a8:	00004517          	auipc	a0,0x4
    28ac:	90050513          	addi	a0,a0,-1792 # 61a8 <malloc+0x1210>
    28b0:	24e020ef          	jal	4afe <mkdir>
    28b4:	12050063          	beqz	a0,29d4 <diskfull+0x204>
  unlink("diskfulldir");
    28b8:	00004517          	auipc	a0,0x4
    28bc:	8f050513          	addi	a0,a0,-1808 # 61a8 <malloc+0x1210>
    28c0:	226020ef          	jal	4ae6 <unlink>
  for(int i = 0; i < nzz; i++){
    28c4:	4481                	li	s1,0
    name[0] = 'z';
    28c6:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    28ca:	08000993          	li	s3,128
    name[0] = 'z';
    28ce:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    28d2:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    28d6:	41f4d71b          	sraiw	a4,s1,0x1f
    28da:	01b7571b          	srliw	a4,a4,0x1b
    28de:	009707bb          	addw	a5,a4,s1
    28e2:	4057d69b          	sraiw	a3,a5,0x5
    28e6:	0306869b          	addiw	a3,a3,48
    28ea:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    28ee:	8bfd                	andi	a5,a5,31
    28f0:	9f99                	subw	a5,a5,a4
    28f2:	0307879b          	addiw	a5,a5,48
    28f6:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    28fa:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    28fe:	ba040513          	addi	a0,s0,-1120
    2902:	1e4020ef          	jal	4ae6 <unlink>
  for(int i = 0; i < nzz; i++){
    2906:	2485                	addiw	s1,s1,1
    2908:	fd3493e3          	bne	s1,s3,28ce <diskfull+0xfe>
    290c:	03000493          	li	s1,48
    name[0] = 'b';
    2910:	06200a93          	li	s5,98
    name[1] = 'i';
    2914:	06900a13          	li	s4,105
    name[2] = 'g';
    2918:	06700993          	li	s3,103
  for(int i = 0; '0' + i < 0177; i++){
    291c:	07f00913          	li	s2,127
    name[0] = 'b';
    2920:	bb540023          	sb	s5,-1120(s0)
    name[1] = 'i';
    2924:	bb4400a3          	sb	s4,-1119(s0)
    name[2] = 'g';
    2928:	bb340123          	sb	s3,-1118(s0)
    name[3] = '0' + i;
    292c:	ba9401a3          	sb	s1,-1117(s0)
    name[4] = '\0';
    2930:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    2934:	ba040513          	addi	a0,s0,-1120
    2938:	1ae020ef          	jal	4ae6 <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    293c:	2485                	addiw	s1,s1,1
    293e:	0ff4f493          	zext.b	s1,s1
    2942:	fd249fe3          	bne	s1,s2,2920 <diskfull+0x150>
}
    2946:	47813083          	ld	ra,1144(sp)
    294a:	47013403          	ld	s0,1136(sp)
    294e:	46813483          	ld	s1,1128(sp)
    2952:	46013903          	ld	s2,1120(sp)
    2956:	45813983          	ld	s3,1112(sp)
    295a:	45013a03          	ld	s4,1104(sp)
    295e:	44813a83          	ld	s5,1096(sp)
    2962:	44013b03          	ld	s6,1088(sp)
    2966:	43813b83          	ld	s7,1080(sp)
    296a:	43013c03          	ld	s8,1072(sp)
    296e:	42813c83          	ld	s9,1064(sp)
    2972:	48010113          	addi	sp,sp,1152
    2976:	8082                	ret
    close(fd);
    2978:	854a                	mv	a0,s2
    297a:	144020ef          	jal	4abe <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    297e:	2985                	addiw	s3,s3,1
    2980:	0ff9f993          	zext.b	s3,s3
    2984:	ed8984e3          	beq	s3,s8,284c <diskfull+0x7c>
    name[0] = 'b';
    2988:	b9640023          	sb	s6,-1152(s0)
    name[1] = 'i';
    298c:	b95400a3          	sb	s5,-1151(s0)
    name[2] = 'g';
    2990:	b9440123          	sb	s4,-1150(s0)
    name[3] = '0' + fi;
    2994:	b93401a3          	sb	s3,-1149(s0)
    name[4] = '\0';
    2998:	b8040223          	sb	zero,-1148(s0)
    unlink(name);
    299c:	b8040513          	addi	a0,s0,-1152
    29a0:	146020ef          	jal	4ae6 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    29a4:	60200593          	li	a1,1538
    29a8:	b8040513          	addi	a0,s0,-1152
    29ac:	12a020ef          	jal	4ad6 <open>
    29b0:	892a                	mv	s2,a0
    if(fd < 0){
    29b2:	e6054de3          	bltz	a0,282c <diskfull+0x5c>
    29b6:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    29b8:	40000613          	li	a2,1024
    29bc:	ba040593          	addi	a1,s0,-1120
    29c0:	854a                	mv	a0,s2
    29c2:	0f4020ef          	jal	4ab6 <write>
    29c6:	40000793          	li	a5,1024
    29ca:	e6f51be3          	bne	a0,a5,2840 <diskfull+0x70>
    for(int i = 0; i < MAXFILE; i++){
    29ce:	34fd                	addiw	s1,s1,-1
    29d0:	f4e5                	bnez	s1,29b8 <diskfull+0x1e8>
    29d2:	b75d                	j	2978 <diskfull+0x1a8>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    29d4:	85e6                	mv	a1,s9
    29d6:	00004517          	auipc	a0,0x4
    29da:	80250513          	addi	a0,a0,-2046 # 61d8 <malloc+0x1240>
    29de:	506020ef          	jal	4ee4 <printf>
    29e2:	bdd9                	j	28b8 <diskfull+0xe8>

00000000000029e4 <iputtest>:
{
    29e4:	1101                	addi	sp,sp,-32
    29e6:	ec06                	sd	ra,24(sp)
    29e8:	e822                	sd	s0,16(sp)
    29ea:	e426                	sd	s1,8(sp)
    29ec:	1000                	addi	s0,sp,32
    29ee:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    29f0:	00004517          	auipc	a0,0x4
    29f4:	81850513          	addi	a0,a0,-2024 # 6208 <malloc+0x1270>
    29f8:	106020ef          	jal	4afe <mkdir>
    29fc:	02054f63          	bltz	a0,2a3a <iputtest+0x56>
  if(chdir("iputdir") < 0){
    2a00:	00004517          	auipc	a0,0x4
    2a04:	80850513          	addi	a0,a0,-2040 # 6208 <malloc+0x1270>
    2a08:	0fe020ef          	jal	4b06 <chdir>
    2a0c:	04054163          	bltz	a0,2a4e <iputtest+0x6a>
  if(unlink("../iputdir") < 0){
    2a10:	00004517          	auipc	a0,0x4
    2a14:	83850513          	addi	a0,a0,-1992 # 6248 <malloc+0x12b0>
    2a18:	0ce020ef          	jal	4ae6 <unlink>
    2a1c:	04054363          	bltz	a0,2a62 <iputtest+0x7e>
  if(chdir("/") < 0){
    2a20:	00004517          	auipc	a0,0x4
    2a24:	85850513          	addi	a0,a0,-1960 # 6278 <malloc+0x12e0>
    2a28:	0de020ef          	jal	4b06 <chdir>
    2a2c:	04054563          	bltz	a0,2a76 <iputtest+0x92>
}
    2a30:	60e2                	ld	ra,24(sp)
    2a32:	6442                	ld	s0,16(sp)
    2a34:	64a2                	ld	s1,8(sp)
    2a36:	6105                	addi	sp,sp,32
    2a38:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2a3a:	85a6                	mv	a1,s1
    2a3c:	00003517          	auipc	a0,0x3
    2a40:	7d450513          	addi	a0,a0,2004 # 6210 <malloc+0x1278>
    2a44:	4a0020ef          	jal	4ee4 <printf>
    exit(1);
    2a48:	4505                	li	a0,1
    2a4a:	04c020ef          	jal	4a96 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2a4e:	85a6                	mv	a1,s1
    2a50:	00003517          	auipc	a0,0x3
    2a54:	7d850513          	addi	a0,a0,2008 # 6228 <malloc+0x1290>
    2a58:	48c020ef          	jal	4ee4 <printf>
    exit(1);
    2a5c:	4505                	li	a0,1
    2a5e:	038020ef          	jal	4a96 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2a62:	85a6                	mv	a1,s1
    2a64:	00003517          	auipc	a0,0x3
    2a68:	7f450513          	addi	a0,a0,2036 # 6258 <malloc+0x12c0>
    2a6c:	478020ef          	jal	4ee4 <printf>
    exit(1);
    2a70:	4505                	li	a0,1
    2a72:	024020ef          	jal	4a96 <exit>
    printf("%s: chdir / failed\n", s);
    2a76:	85a6                	mv	a1,s1
    2a78:	00004517          	auipc	a0,0x4
    2a7c:	80850513          	addi	a0,a0,-2040 # 6280 <malloc+0x12e8>
    2a80:	464020ef          	jal	4ee4 <printf>
    exit(1);
    2a84:	4505                	li	a0,1
    2a86:	010020ef          	jal	4a96 <exit>

0000000000002a8a <exitiputtest>:
{
    2a8a:	7179                	addi	sp,sp,-48
    2a8c:	f406                	sd	ra,40(sp)
    2a8e:	f022                	sd	s0,32(sp)
    2a90:	ec26                	sd	s1,24(sp)
    2a92:	1800                	addi	s0,sp,48
    2a94:	84aa                	mv	s1,a0
  pid = fork();
    2a96:	7f9010ef          	jal	4a8e <fork>
  if(pid < 0){
    2a9a:	02054e63          	bltz	a0,2ad6 <exitiputtest+0x4c>
  if(pid == 0){
    2a9e:	e541                	bnez	a0,2b26 <exitiputtest+0x9c>
    if(mkdir("iputdir") < 0){
    2aa0:	00003517          	auipc	a0,0x3
    2aa4:	76850513          	addi	a0,a0,1896 # 6208 <malloc+0x1270>
    2aa8:	056020ef          	jal	4afe <mkdir>
    2aac:	02054f63          	bltz	a0,2aea <exitiputtest+0x60>
    if(chdir("iputdir") < 0){
    2ab0:	00003517          	auipc	a0,0x3
    2ab4:	75850513          	addi	a0,a0,1880 # 6208 <malloc+0x1270>
    2ab8:	04e020ef          	jal	4b06 <chdir>
    2abc:	04054163          	bltz	a0,2afe <exitiputtest+0x74>
    if(unlink("../iputdir") < 0){
    2ac0:	00003517          	auipc	a0,0x3
    2ac4:	78850513          	addi	a0,a0,1928 # 6248 <malloc+0x12b0>
    2ac8:	01e020ef          	jal	4ae6 <unlink>
    2acc:	04054363          	bltz	a0,2b12 <exitiputtest+0x88>
    exit(0);
    2ad0:	4501                	li	a0,0
    2ad2:	7c5010ef          	jal	4a96 <exit>
    printf("%s: fork failed\n", s);
    2ad6:	85a6                	mv	a1,s1
    2ad8:	00003517          	auipc	a0,0x3
    2adc:	e8050513          	addi	a0,a0,-384 # 5958 <malloc+0x9c0>
    2ae0:	404020ef          	jal	4ee4 <printf>
    exit(1);
    2ae4:	4505                	li	a0,1
    2ae6:	7b1010ef          	jal	4a96 <exit>
      printf("%s: mkdir failed\n", s);
    2aea:	85a6                	mv	a1,s1
    2aec:	00003517          	auipc	a0,0x3
    2af0:	72450513          	addi	a0,a0,1828 # 6210 <malloc+0x1278>
    2af4:	3f0020ef          	jal	4ee4 <printf>
      exit(1);
    2af8:	4505                	li	a0,1
    2afa:	79d010ef          	jal	4a96 <exit>
      printf("%s: child chdir failed\n", s);
    2afe:	85a6                	mv	a1,s1
    2b00:	00003517          	auipc	a0,0x3
    2b04:	79850513          	addi	a0,a0,1944 # 6298 <malloc+0x1300>
    2b08:	3dc020ef          	jal	4ee4 <printf>
      exit(1);
    2b0c:	4505                	li	a0,1
    2b0e:	789010ef          	jal	4a96 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2b12:	85a6                	mv	a1,s1
    2b14:	00003517          	auipc	a0,0x3
    2b18:	74450513          	addi	a0,a0,1860 # 6258 <malloc+0x12c0>
    2b1c:	3c8020ef          	jal	4ee4 <printf>
      exit(1);
    2b20:	4505                	li	a0,1
    2b22:	775010ef          	jal	4a96 <exit>
  wait(&xstatus);
    2b26:	fdc40513          	addi	a0,s0,-36
    2b2a:	775010ef          	jal	4a9e <wait>
  exit(xstatus);
    2b2e:	fdc42503          	lw	a0,-36(s0)
    2b32:	765010ef          	jal	4a96 <exit>

0000000000002b36 <dirtest>:
{
    2b36:	1101                	addi	sp,sp,-32
    2b38:	ec06                	sd	ra,24(sp)
    2b3a:	e822                	sd	s0,16(sp)
    2b3c:	e426                	sd	s1,8(sp)
    2b3e:	1000                	addi	s0,sp,32
    2b40:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    2b42:	00003517          	auipc	a0,0x3
    2b46:	76e50513          	addi	a0,a0,1902 # 62b0 <malloc+0x1318>
    2b4a:	7b5010ef          	jal	4afe <mkdir>
    2b4e:	02054f63          	bltz	a0,2b8c <dirtest+0x56>
  if(chdir("dir0") < 0){
    2b52:	00003517          	auipc	a0,0x3
    2b56:	75e50513          	addi	a0,a0,1886 # 62b0 <malloc+0x1318>
    2b5a:	7ad010ef          	jal	4b06 <chdir>
    2b5e:	04054163          	bltz	a0,2ba0 <dirtest+0x6a>
  if(chdir("..") < 0){
    2b62:	00003517          	auipc	a0,0x3
    2b66:	76e50513          	addi	a0,a0,1902 # 62d0 <malloc+0x1338>
    2b6a:	79d010ef          	jal	4b06 <chdir>
    2b6e:	04054363          	bltz	a0,2bb4 <dirtest+0x7e>
  if(unlink("dir0") < 0){
    2b72:	00003517          	auipc	a0,0x3
    2b76:	73e50513          	addi	a0,a0,1854 # 62b0 <malloc+0x1318>
    2b7a:	76d010ef          	jal	4ae6 <unlink>
    2b7e:	04054563          	bltz	a0,2bc8 <dirtest+0x92>
}
    2b82:	60e2                	ld	ra,24(sp)
    2b84:	6442                	ld	s0,16(sp)
    2b86:	64a2                	ld	s1,8(sp)
    2b88:	6105                	addi	sp,sp,32
    2b8a:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2b8c:	85a6                	mv	a1,s1
    2b8e:	00003517          	auipc	a0,0x3
    2b92:	68250513          	addi	a0,a0,1666 # 6210 <malloc+0x1278>
    2b96:	34e020ef          	jal	4ee4 <printf>
    exit(1);
    2b9a:	4505                	li	a0,1
    2b9c:	6fb010ef          	jal	4a96 <exit>
    printf("%s: chdir dir0 failed\n", s);
    2ba0:	85a6                	mv	a1,s1
    2ba2:	00003517          	auipc	a0,0x3
    2ba6:	71650513          	addi	a0,a0,1814 # 62b8 <malloc+0x1320>
    2baa:	33a020ef          	jal	4ee4 <printf>
    exit(1);
    2bae:	4505                	li	a0,1
    2bb0:	6e7010ef          	jal	4a96 <exit>
    printf("%s: chdir .. failed\n", s);
    2bb4:	85a6                	mv	a1,s1
    2bb6:	00003517          	auipc	a0,0x3
    2bba:	72250513          	addi	a0,a0,1826 # 62d8 <malloc+0x1340>
    2bbe:	326020ef          	jal	4ee4 <printf>
    exit(1);
    2bc2:	4505                	li	a0,1
    2bc4:	6d3010ef          	jal	4a96 <exit>
    printf("%s: unlink dir0 failed\n", s);
    2bc8:	85a6                	mv	a1,s1
    2bca:	00003517          	auipc	a0,0x3
    2bce:	72650513          	addi	a0,a0,1830 # 62f0 <malloc+0x1358>
    2bd2:	312020ef          	jal	4ee4 <printf>
    exit(1);
    2bd6:	4505                	li	a0,1
    2bd8:	6bf010ef          	jal	4a96 <exit>

0000000000002bdc <subdir>:
{
    2bdc:	1101                	addi	sp,sp,-32
    2bde:	ec06                	sd	ra,24(sp)
    2be0:	e822                	sd	s0,16(sp)
    2be2:	e426                	sd	s1,8(sp)
    2be4:	e04a                	sd	s2,0(sp)
    2be6:	1000                	addi	s0,sp,32
    2be8:	892a                	mv	s2,a0
  unlink("ff");
    2bea:	00004517          	auipc	a0,0x4
    2bee:	84e50513          	addi	a0,a0,-1970 # 6438 <malloc+0x14a0>
    2bf2:	6f5010ef          	jal	4ae6 <unlink>
  if(mkdir("dd") != 0){
    2bf6:	00003517          	auipc	a0,0x3
    2bfa:	71250513          	addi	a0,a0,1810 # 6308 <malloc+0x1370>
    2bfe:	701010ef          	jal	4afe <mkdir>
    2c02:	2e051263          	bnez	a0,2ee6 <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2c06:	20200593          	li	a1,514
    2c0a:	00003517          	auipc	a0,0x3
    2c0e:	71e50513          	addi	a0,a0,1822 # 6328 <malloc+0x1390>
    2c12:	6c5010ef          	jal	4ad6 <open>
    2c16:	84aa                	mv	s1,a0
  if(fd < 0){
    2c18:	2e054163          	bltz	a0,2efa <subdir+0x31e>
  write(fd, "ff", 2);
    2c1c:	4609                	li	a2,2
    2c1e:	00004597          	auipc	a1,0x4
    2c22:	81a58593          	addi	a1,a1,-2022 # 6438 <malloc+0x14a0>
    2c26:	691010ef          	jal	4ab6 <write>
  close(fd);
    2c2a:	8526                	mv	a0,s1
    2c2c:	693010ef          	jal	4abe <close>
  if(unlink("dd") >= 0){
    2c30:	00003517          	auipc	a0,0x3
    2c34:	6d850513          	addi	a0,a0,1752 # 6308 <malloc+0x1370>
    2c38:	6af010ef          	jal	4ae6 <unlink>
    2c3c:	2c055963          	bgez	a0,2f0e <subdir+0x332>
  if(mkdir("/dd/dd") != 0){
    2c40:	00003517          	auipc	a0,0x3
    2c44:	74050513          	addi	a0,a0,1856 # 6380 <malloc+0x13e8>
    2c48:	6b7010ef          	jal	4afe <mkdir>
    2c4c:	2c051b63          	bnez	a0,2f22 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2c50:	20200593          	li	a1,514
    2c54:	00003517          	auipc	a0,0x3
    2c58:	75450513          	addi	a0,a0,1876 # 63a8 <malloc+0x1410>
    2c5c:	67b010ef          	jal	4ad6 <open>
    2c60:	84aa                	mv	s1,a0
  if(fd < 0){
    2c62:	2c054a63          	bltz	a0,2f36 <subdir+0x35a>
  write(fd, "FF", 2);
    2c66:	4609                	li	a2,2
    2c68:	00003597          	auipc	a1,0x3
    2c6c:	77058593          	addi	a1,a1,1904 # 63d8 <malloc+0x1440>
    2c70:	647010ef          	jal	4ab6 <write>
  close(fd);
    2c74:	8526                	mv	a0,s1
    2c76:	649010ef          	jal	4abe <close>
  fd = open("dd/dd/../ff", 0);
    2c7a:	4581                	li	a1,0
    2c7c:	00003517          	auipc	a0,0x3
    2c80:	76450513          	addi	a0,a0,1892 # 63e0 <malloc+0x1448>
    2c84:	653010ef          	jal	4ad6 <open>
    2c88:	84aa                	mv	s1,a0
  if(fd < 0){
    2c8a:	2c054063          	bltz	a0,2f4a <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2c8e:	660d                	lui	a2,0x3
    2c90:	0000a597          	auipc	a1,0xa
    2c94:	fe858593          	addi	a1,a1,-24 # cc78 <buf>
    2c98:	617010ef          	jal	4aae <read>
  if(cc != 2 || buf[0] != 'f'){
    2c9c:	4789                	li	a5,2
    2c9e:	2cf51063          	bne	a0,a5,2f5e <subdir+0x382>
    2ca2:	0000a717          	auipc	a4,0xa
    2ca6:	fd674703          	lbu	a4,-42(a4) # cc78 <buf>
    2caa:	06600793          	li	a5,102
    2cae:	2af71863          	bne	a4,a5,2f5e <subdir+0x382>
  close(fd);
    2cb2:	8526                	mv	a0,s1
    2cb4:	60b010ef          	jal	4abe <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2cb8:	00003597          	auipc	a1,0x3
    2cbc:	77858593          	addi	a1,a1,1912 # 6430 <malloc+0x1498>
    2cc0:	00003517          	auipc	a0,0x3
    2cc4:	6e850513          	addi	a0,a0,1768 # 63a8 <malloc+0x1410>
    2cc8:	62f010ef          	jal	4af6 <link>
    2ccc:	2a051363          	bnez	a0,2f72 <subdir+0x396>
  if(unlink("dd/dd/ff") != 0){
    2cd0:	00003517          	auipc	a0,0x3
    2cd4:	6d850513          	addi	a0,a0,1752 # 63a8 <malloc+0x1410>
    2cd8:	60f010ef          	jal	4ae6 <unlink>
    2cdc:	2a051563          	bnez	a0,2f86 <subdir+0x3aa>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2ce0:	4581                	li	a1,0
    2ce2:	00003517          	auipc	a0,0x3
    2ce6:	6c650513          	addi	a0,a0,1734 # 63a8 <malloc+0x1410>
    2cea:	5ed010ef          	jal	4ad6 <open>
    2cee:	2a055663          	bgez	a0,2f9a <subdir+0x3be>
  if(chdir("dd") != 0){
    2cf2:	00003517          	auipc	a0,0x3
    2cf6:	61650513          	addi	a0,a0,1558 # 6308 <malloc+0x1370>
    2cfa:	60d010ef          	jal	4b06 <chdir>
    2cfe:	2a051863          	bnez	a0,2fae <subdir+0x3d2>
  if(chdir("dd/../../dd") != 0){
    2d02:	00003517          	auipc	a0,0x3
    2d06:	7c650513          	addi	a0,a0,1990 # 64c8 <malloc+0x1530>
    2d0a:	5fd010ef          	jal	4b06 <chdir>
    2d0e:	2a051a63          	bnez	a0,2fc2 <subdir+0x3e6>
  if(chdir("dd/../../../dd") != 0){
    2d12:	00003517          	auipc	a0,0x3
    2d16:	7e650513          	addi	a0,a0,2022 # 64f8 <malloc+0x1560>
    2d1a:	5ed010ef          	jal	4b06 <chdir>
    2d1e:	2a051c63          	bnez	a0,2fd6 <subdir+0x3fa>
  if(chdir("./..") != 0){
    2d22:	00004517          	auipc	a0,0x4
    2d26:	80e50513          	addi	a0,a0,-2034 # 6530 <malloc+0x1598>
    2d2a:	5dd010ef          	jal	4b06 <chdir>
    2d2e:	2a051e63          	bnez	a0,2fea <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2d32:	4581                	li	a1,0
    2d34:	00003517          	auipc	a0,0x3
    2d38:	6fc50513          	addi	a0,a0,1788 # 6430 <malloc+0x1498>
    2d3c:	59b010ef          	jal	4ad6 <open>
    2d40:	84aa                	mv	s1,a0
  if(fd < 0){
    2d42:	2a054e63          	bltz	a0,2ffe <subdir+0x422>
  if(read(fd, buf, sizeof(buf)) != 2){
    2d46:	660d                	lui	a2,0x3
    2d48:	0000a597          	auipc	a1,0xa
    2d4c:	f3058593          	addi	a1,a1,-208 # cc78 <buf>
    2d50:	55f010ef          	jal	4aae <read>
    2d54:	4789                	li	a5,2
    2d56:	2af51e63          	bne	a0,a5,3012 <subdir+0x436>
  close(fd);
    2d5a:	8526                	mv	a0,s1
    2d5c:	563010ef          	jal	4abe <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2d60:	4581                	li	a1,0
    2d62:	00003517          	auipc	a0,0x3
    2d66:	64650513          	addi	a0,a0,1606 # 63a8 <malloc+0x1410>
    2d6a:	56d010ef          	jal	4ad6 <open>
    2d6e:	2a055c63          	bgez	a0,3026 <subdir+0x44a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2d72:	20200593          	li	a1,514
    2d76:	00004517          	auipc	a0,0x4
    2d7a:	84a50513          	addi	a0,a0,-1974 # 65c0 <malloc+0x1628>
    2d7e:	559010ef          	jal	4ad6 <open>
    2d82:	2a055c63          	bgez	a0,303a <subdir+0x45e>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2d86:	20200593          	li	a1,514
    2d8a:	00004517          	auipc	a0,0x4
    2d8e:	86650513          	addi	a0,a0,-1946 # 65f0 <malloc+0x1658>
    2d92:	545010ef          	jal	4ad6 <open>
    2d96:	2a055c63          	bgez	a0,304e <subdir+0x472>
  if(open("dd", O_CREATE) >= 0){
    2d9a:	20000593          	li	a1,512
    2d9e:	00003517          	auipc	a0,0x3
    2da2:	56a50513          	addi	a0,a0,1386 # 6308 <malloc+0x1370>
    2da6:	531010ef          	jal	4ad6 <open>
    2daa:	2a055c63          	bgez	a0,3062 <subdir+0x486>
  if(open("dd", O_RDWR) >= 0){
    2dae:	4589                	li	a1,2
    2db0:	00003517          	auipc	a0,0x3
    2db4:	55850513          	addi	a0,a0,1368 # 6308 <malloc+0x1370>
    2db8:	51f010ef          	jal	4ad6 <open>
    2dbc:	2a055d63          	bgez	a0,3076 <subdir+0x49a>
  if(open("dd", O_WRONLY) >= 0){
    2dc0:	4585                	li	a1,1
    2dc2:	00003517          	auipc	a0,0x3
    2dc6:	54650513          	addi	a0,a0,1350 # 6308 <malloc+0x1370>
    2dca:	50d010ef          	jal	4ad6 <open>
    2dce:	2a055e63          	bgez	a0,308a <subdir+0x4ae>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2dd2:	00004597          	auipc	a1,0x4
    2dd6:	8ae58593          	addi	a1,a1,-1874 # 6680 <malloc+0x16e8>
    2dda:	00003517          	auipc	a0,0x3
    2dde:	7e650513          	addi	a0,a0,2022 # 65c0 <malloc+0x1628>
    2de2:	515010ef          	jal	4af6 <link>
    2de6:	2a050c63          	beqz	a0,309e <subdir+0x4c2>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2dea:	00004597          	auipc	a1,0x4
    2dee:	89658593          	addi	a1,a1,-1898 # 6680 <malloc+0x16e8>
    2df2:	00003517          	auipc	a0,0x3
    2df6:	7fe50513          	addi	a0,a0,2046 # 65f0 <malloc+0x1658>
    2dfa:	4fd010ef          	jal	4af6 <link>
    2dfe:	2a050a63          	beqz	a0,30b2 <subdir+0x4d6>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2e02:	00003597          	auipc	a1,0x3
    2e06:	62e58593          	addi	a1,a1,1582 # 6430 <malloc+0x1498>
    2e0a:	00003517          	auipc	a0,0x3
    2e0e:	51e50513          	addi	a0,a0,1310 # 6328 <malloc+0x1390>
    2e12:	4e5010ef          	jal	4af6 <link>
    2e16:	2a050863          	beqz	a0,30c6 <subdir+0x4ea>
  if(mkdir("dd/ff/ff") == 0){
    2e1a:	00003517          	auipc	a0,0x3
    2e1e:	7a650513          	addi	a0,a0,1958 # 65c0 <malloc+0x1628>
    2e22:	4dd010ef          	jal	4afe <mkdir>
    2e26:	2a050a63          	beqz	a0,30da <subdir+0x4fe>
  if(mkdir("dd/xx/ff") == 0){
    2e2a:	00003517          	auipc	a0,0x3
    2e2e:	7c650513          	addi	a0,a0,1990 # 65f0 <malloc+0x1658>
    2e32:	4cd010ef          	jal	4afe <mkdir>
    2e36:	2a050c63          	beqz	a0,30ee <subdir+0x512>
  if(mkdir("dd/dd/ffff") == 0){
    2e3a:	00003517          	auipc	a0,0x3
    2e3e:	5f650513          	addi	a0,a0,1526 # 6430 <malloc+0x1498>
    2e42:	4bd010ef          	jal	4afe <mkdir>
    2e46:	2a050e63          	beqz	a0,3102 <subdir+0x526>
  if(unlink("dd/xx/ff") == 0){
    2e4a:	00003517          	auipc	a0,0x3
    2e4e:	7a650513          	addi	a0,a0,1958 # 65f0 <malloc+0x1658>
    2e52:	495010ef          	jal	4ae6 <unlink>
    2e56:	2c050063          	beqz	a0,3116 <subdir+0x53a>
  if(unlink("dd/ff/ff") == 0){
    2e5a:	00003517          	auipc	a0,0x3
    2e5e:	76650513          	addi	a0,a0,1894 # 65c0 <malloc+0x1628>
    2e62:	485010ef          	jal	4ae6 <unlink>
    2e66:	2c050263          	beqz	a0,312a <subdir+0x54e>
  if(chdir("dd/ff") == 0){
    2e6a:	00003517          	auipc	a0,0x3
    2e6e:	4be50513          	addi	a0,a0,1214 # 6328 <malloc+0x1390>
    2e72:	495010ef          	jal	4b06 <chdir>
    2e76:	2c050463          	beqz	a0,313e <subdir+0x562>
  if(chdir("dd/xx") == 0){
    2e7a:	00004517          	auipc	a0,0x4
    2e7e:	95650513          	addi	a0,a0,-1706 # 67d0 <malloc+0x1838>
    2e82:	485010ef          	jal	4b06 <chdir>
    2e86:	2c050663          	beqz	a0,3152 <subdir+0x576>
  if(unlink("dd/dd/ffff") != 0){
    2e8a:	00003517          	auipc	a0,0x3
    2e8e:	5a650513          	addi	a0,a0,1446 # 6430 <malloc+0x1498>
    2e92:	455010ef          	jal	4ae6 <unlink>
    2e96:	2c051863          	bnez	a0,3166 <subdir+0x58a>
  if(unlink("dd/ff") != 0){
    2e9a:	00003517          	auipc	a0,0x3
    2e9e:	48e50513          	addi	a0,a0,1166 # 6328 <malloc+0x1390>
    2ea2:	445010ef          	jal	4ae6 <unlink>
    2ea6:	2c051a63          	bnez	a0,317a <subdir+0x59e>
  if(unlink("dd") == 0){
    2eaa:	00003517          	auipc	a0,0x3
    2eae:	45e50513          	addi	a0,a0,1118 # 6308 <malloc+0x1370>
    2eb2:	435010ef          	jal	4ae6 <unlink>
    2eb6:	2c050c63          	beqz	a0,318e <subdir+0x5b2>
  if(unlink("dd/dd") < 0){
    2eba:	00004517          	auipc	a0,0x4
    2ebe:	98650513          	addi	a0,a0,-1658 # 6840 <malloc+0x18a8>
    2ec2:	425010ef          	jal	4ae6 <unlink>
    2ec6:	2c054e63          	bltz	a0,31a2 <subdir+0x5c6>
  if(unlink("dd") < 0){
    2eca:	00003517          	auipc	a0,0x3
    2ece:	43e50513          	addi	a0,a0,1086 # 6308 <malloc+0x1370>
    2ed2:	415010ef          	jal	4ae6 <unlink>
    2ed6:	2e054063          	bltz	a0,31b6 <subdir+0x5da>
}
    2eda:	60e2                	ld	ra,24(sp)
    2edc:	6442                	ld	s0,16(sp)
    2ede:	64a2                	ld	s1,8(sp)
    2ee0:	6902                	ld	s2,0(sp)
    2ee2:	6105                	addi	sp,sp,32
    2ee4:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2ee6:	85ca                	mv	a1,s2
    2ee8:	00003517          	auipc	a0,0x3
    2eec:	42850513          	addi	a0,a0,1064 # 6310 <malloc+0x1378>
    2ef0:	7f5010ef          	jal	4ee4 <printf>
    exit(1);
    2ef4:	4505                	li	a0,1
    2ef6:	3a1010ef          	jal	4a96 <exit>
    printf("%s: create dd/ff failed\n", s);
    2efa:	85ca                	mv	a1,s2
    2efc:	00003517          	auipc	a0,0x3
    2f00:	43450513          	addi	a0,a0,1076 # 6330 <malloc+0x1398>
    2f04:	7e1010ef          	jal	4ee4 <printf>
    exit(1);
    2f08:	4505                	li	a0,1
    2f0a:	38d010ef          	jal	4a96 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2f0e:	85ca                	mv	a1,s2
    2f10:	00003517          	auipc	a0,0x3
    2f14:	44050513          	addi	a0,a0,1088 # 6350 <malloc+0x13b8>
    2f18:	7cd010ef          	jal	4ee4 <printf>
    exit(1);
    2f1c:	4505                	li	a0,1
    2f1e:	379010ef          	jal	4a96 <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    2f22:	85ca                	mv	a1,s2
    2f24:	00003517          	auipc	a0,0x3
    2f28:	46450513          	addi	a0,a0,1124 # 6388 <malloc+0x13f0>
    2f2c:	7b9010ef          	jal	4ee4 <printf>
    exit(1);
    2f30:	4505                	li	a0,1
    2f32:	365010ef          	jal	4a96 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2f36:	85ca                	mv	a1,s2
    2f38:	00003517          	auipc	a0,0x3
    2f3c:	48050513          	addi	a0,a0,1152 # 63b8 <malloc+0x1420>
    2f40:	7a5010ef          	jal	4ee4 <printf>
    exit(1);
    2f44:	4505                	li	a0,1
    2f46:	351010ef          	jal	4a96 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2f4a:	85ca                	mv	a1,s2
    2f4c:	00003517          	auipc	a0,0x3
    2f50:	4a450513          	addi	a0,a0,1188 # 63f0 <malloc+0x1458>
    2f54:	791010ef          	jal	4ee4 <printf>
    exit(1);
    2f58:	4505                	li	a0,1
    2f5a:	33d010ef          	jal	4a96 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2f5e:	85ca                	mv	a1,s2
    2f60:	00003517          	auipc	a0,0x3
    2f64:	4b050513          	addi	a0,a0,1200 # 6410 <malloc+0x1478>
    2f68:	77d010ef          	jal	4ee4 <printf>
    exit(1);
    2f6c:	4505                	li	a0,1
    2f6e:	329010ef          	jal	4a96 <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    2f72:	85ca                	mv	a1,s2
    2f74:	00003517          	auipc	a0,0x3
    2f78:	4cc50513          	addi	a0,a0,1228 # 6440 <malloc+0x14a8>
    2f7c:	769010ef          	jal	4ee4 <printf>
    exit(1);
    2f80:	4505                	li	a0,1
    2f82:	315010ef          	jal	4a96 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2f86:	85ca                	mv	a1,s2
    2f88:	00003517          	auipc	a0,0x3
    2f8c:	4e050513          	addi	a0,a0,1248 # 6468 <malloc+0x14d0>
    2f90:	755010ef          	jal	4ee4 <printf>
    exit(1);
    2f94:	4505                	li	a0,1
    2f96:	301010ef          	jal	4a96 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2f9a:	85ca                	mv	a1,s2
    2f9c:	00003517          	auipc	a0,0x3
    2fa0:	4ec50513          	addi	a0,a0,1260 # 6488 <malloc+0x14f0>
    2fa4:	741010ef          	jal	4ee4 <printf>
    exit(1);
    2fa8:	4505                	li	a0,1
    2faa:	2ed010ef          	jal	4a96 <exit>
    printf("%s: chdir dd failed\n", s);
    2fae:	85ca                	mv	a1,s2
    2fb0:	00003517          	auipc	a0,0x3
    2fb4:	50050513          	addi	a0,a0,1280 # 64b0 <malloc+0x1518>
    2fb8:	72d010ef          	jal	4ee4 <printf>
    exit(1);
    2fbc:	4505                	li	a0,1
    2fbe:	2d9010ef          	jal	4a96 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2fc2:	85ca                	mv	a1,s2
    2fc4:	00003517          	auipc	a0,0x3
    2fc8:	51450513          	addi	a0,a0,1300 # 64d8 <malloc+0x1540>
    2fcc:	719010ef          	jal	4ee4 <printf>
    exit(1);
    2fd0:	4505                	li	a0,1
    2fd2:	2c5010ef          	jal	4a96 <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    2fd6:	85ca                	mv	a1,s2
    2fd8:	00003517          	auipc	a0,0x3
    2fdc:	53050513          	addi	a0,a0,1328 # 6508 <malloc+0x1570>
    2fe0:	705010ef          	jal	4ee4 <printf>
    exit(1);
    2fe4:	4505                	li	a0,1
    2fe6:	2b1010ef          	jal	4a96 <exit>
    printf("%s: chdir ./.. failed\n", s);
    2fea:	85ca                	mv	a1,s2
    2fec:	00003517          	auipc	a0,0x3
    2ff0:	54c50513          	addi	a0,a0,1356 # 6538 <malloc+0x15a0>
    2ff4:	6f1010ef          	jal	4ee4 <printf>
    exit(1);
    2ff8:	4505                	li	a0,1
    2ffa:	29d010ef          	jal	4a96 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2ffe:	85ca                	mv	a1,s2
    3000:	00003517          	auipc	a0,0x3
    3004:	55050513          	addi	a0,a0,1360 # 6550 <malloc+0x15b8>
    3008:	6dd010ef          	jal	4ee4 <printf>
    exit(1);
    300c:	4505                	li	a0,1
    300e:	289010ef          	jal	4a96 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3012:	85ca                	mv	a1,s2
    3014:	00003517          	auipc	a0,0x3
    3018:	55c50513          	addi	a0,a0,1372 # 6570 <malloc+0x15d8>
    301c:	6c9010ef          	jal	4ee4 <printf>
    exit(1);
    3020:	4505                	li	a0,1
    3022:	275010ef          	jal	4a96 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3026:	85ca                	mv	a1,s2
    3028:	00003517          	auipc	a0,0x3
    302c:	56850513          	addi	a0,a0,1384 # 6590 <malloc+0x15f8>
    3030:	6b5010ef          	jal	4ee4 <printf>
    exit(1);
    3034:	4505                	li	a0,1
    3036:	261010ef          	jal	4a96 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    303a:	85ca                	mv	a1,s2
    303c:	00003517          	auipc	a0,0x3
    3040:	59450513          	addi	a0,a0,1428 # 65d0 <malloc+0x1638>
    3044:	6a1010ef          	jal	4ee4 <printf>
    exit(1);
    3048:	4505                	li	a0,1
    304a:	24d010ef          	jal	4a96 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    304e:	85ca                	mv	a1,s2
    3050:	00003517          	auipc	a0,0x3
    3054:	5b050513          	addi	a0,a0,1456 # 6600 <malloc+0x1668>
    3058:	68d010ef          	jal	4ee4 <printf>
    exit(1);
    305c:	4505                	li	a0,1
    305e:	239010ef          	jal	4a96 <exit>
    printf("%s: create dd succeeded!\n", s);
    3062:	85ca                	mv	a1,s2
    3064:	00003517          	auipc	a0,0x3
    3068:	5bc50513          	addi	a0,a0,1468 # 6620 <malloc+0x1688>
    306c:	679010ef          	jal	4ee4 <printf>
    exit(1);
    3070:	4505                	li	a0,1
    3072:	225010ef          	jal	4a96 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3076:	85ca                	mv	a1,s2
    3078:	00003517          	auipc	a0,0x3
    307c:	5c850513          	addi	a0,a0,1480 # 6640 <malloc+0x16a8>
    3080:	665010ef          	jal	4ee4 <printf>
    exit(1);
    3084:	4505                	li	a0,1
    3086:	211010ef          	jal	4a96 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    308a:	85ca                	mv	a1,s2
    308c:	00003517          	auipc	a0,0x3
    3090:	5d450513          	addi	a0,a0,1492 # 6660 <malloc+0x16c8>
    3094:	651010ef          	jal	4ee4 <printf>
    exit(1);
    3098:	4505                	li	a0,1
    309a:	1fd010ef          	jal	4a96 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    309e:	85ca                	mv	a1,s2
    30a0:	00003517          	auipc	a0,0x3
    30a4:	5f050513          	addi	a0,a0,1520 # 6690 <malloc+0x16f8>
    30a8:	63d010ef          	jal	4ee4 <printf>
    exit(1);
    30ac:	4505                	li	a0,1
    30ae:	1e9010ef          	jal	4a96 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    30b2:	85ca                	mv	a1,s2
    30b4:	00003517          	auipc	a0,0x3
    30b8:	60450513          	addi	a0,a0,1540 # 66b8 <malloc+0x1720>
    30bc:	629010ef          	jal	4ee4 <printf>
    exit(1);
    30c0:	4505                	li	a0,1
    30c2:	1d5010ef          	jal	4a96 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    30c6:	85ca                	mv	a1,s2
    30c8:	00003517          	auipc	a0,0x3
    30cc:	61850513          	addi	a0,a0,1560 # 66e0 <malloc+0x1748>
    30d0:	615010ef          	jal	4ee4 <printf>
    exit(1);
    30d4:	4505                	li	a0,1
    30d6:	1c1010ef          	jal	4a96 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    30da:	85ca                	mv	a1,s2
    30dc:	00003517          	auipc	a0,0x3
    30e0:	62c50513          	addi	a0,a0,1580 # 6708 <malloc+0x1770>
    30e4:	601010ef          	jal	4ee4 <printf>
    exit(1);
    30e8:	4505                	li	a0,1
    30ea:	1ad010ef          	jal	4a96 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    30ee:	85ca                	mv	a1,s2
    30f0:	00003517          	auipc	a0,0x3
    30f4:	63850513          	addi	a0,a0,1592 # 6728 <malloc+0x1790>
    30f8:	5ed010ef          	jal	4ee4 <printf>
    exit(1);
    30fc:	4505                	li	a0,1
    30fe:	199010ef          	jal	4a96 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3102:	85ca                	mv	a1,s2
    3104:	00003517          	auipc	a0,0x3
    3108:	64450513          	addi	a0,a0,1604 # 6748 <malloc+0x17b0>
    310c:	5d9010ef          	jal	4ee4 <printf>
    exit(1);
    3110:	4505                	li	a0,1
    3112:	185010ef          	jal	4a96 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3116:	85ca                	mv	a1,s2
    3118:	00003517          	auipc	a0,0x3
    311c:	65850513          	addi	a0,a0,1624 # 6770 <malloc+0x17d8>
    3120:	5c5010ef          	jal	4ee4 <printf>
    exit(1);
    3124:	4505                	li	a0,1
    3126:	171010ef          	jal	4a96 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    312a:	85ca                	mv	a1,s2
    312c:	00003517          	auipc	a0,0x3
    3130:	66450513          	addi	a0,a0,1636 # 6790 <malloc+0x17f8>
    3134:	5b1010ef          	jal	4ee4 <printf>
    exit(1);
    3138:	4505                	li	a0,1
    313a:	15d010ef          	jal	4a96 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    313e:	85ca                	mv	a1,s2
    3140:	00003517          	auipc	a0,0x3
    3144:	67050513          	addi	a0,a0,1648 # 67b0 <malloc+0x1818>
    3148:	59d010ef          	jal	4ee4 <printf>
    exit(1);
    314c:	4505                	li	a0,1
    314e:	149010ef          	jal	4a96 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3152:	85ca                	mv	a1,s2
    3154:	00003517          	auipc	a0,0x3
    3158:	68450513          	addi	a0,a0,1668 # 67d8 <malloc+0x1840>
    315c:	589010ef          	jal	4ee4 <printf>
    exit(1);
    3160:	4505                	li	a0,1
    3162:	135010ef          	jal	4a96 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3166:	85ca                	mv	a1,s2
    3168:	00003517          	auipc	a0,0x3
    316c:	30050513          	addi	a0,a0,768 # 6468 <malloc+0x14d0>
    3170:	575010ef          	jal	4ee4 <printf>
    exit(1);
    3174:	4505                	li	a0,1
    3176:	121010ef          	jal	4a96 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    317a:	85ca                	mv	a1,s2
    317c:	00003517          	auipc	a0,0x3
    3180:	67c50513          	addi	a0,a0,1660 # 67f8 <malloc+0x1860>
    3184:	561010ef          	jal	4ee4 <printf>
    exit(1);
    3188:	4505                	li	a0,1
    318a:	10d010ef          	jal	4a96 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    318e:	85ca                	mv	a1,s2
    3190:	00003517          	auipc	a0,0x3
    3194:	68850513          	addi	a0,a0,1672 # 6818 <malloc+0x1880>
    3198:	54d010ef          	jal	4ee4 <printf>
    exit(1);
    319c:	4505                	li	a0,1
    319e:	0f9010ef          	jal	4a96 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    31a2:	85ca                	mv	a1,s2
    31a4:	00003517          	auipc	a0,0x3
    31a8:	6a450513          	addi	a0,a0,1700 # 6848 <malloc+0x18b0>
    31ac:	539010ef          	jal	4ee4 <printf>
    exit(1);
    31b0:	4505                	li	a0,1
    31b2:	0e5010ef          	jal	4a96 <exit>
    printf("%s: unlink dd failed\n", s);
    31b6:	85ca                	mv	a1,s2
    31b8:	00003517          	auipc	a0,0x3
    31bc:	6b050513          	addi	a0,a0,1712 # 6868 <malloc+0x18d0>
    31c0:	525010ef          	jal	4ee4 <printf>
    exit(1);
    31c4:	4505                	li	a0,1
    31c6:	0d1010ef          	jal	4a96 <exit>

00000000000031ca <rmdot>:
{
    31ca:	1101                	addi	sp,sp,-32
    31cc:	ec06                	sd	ra,24(sp)
    31ce:	e822                	sd	s0,16(sp)
    31d0:	e426                	sd	s1,8(sp)
    31d2:	1000                	addi	s0,sp,32
    31d4:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    31d6:	00003517          	auipc	a0,0x3
    31da:	6aa50513          	addi	a0,a0,1706 # 6880 <malloc+0x18e8>
    31de:	121010ef          	jal	4afe <mkdir>
    31e2:	e53d                	bnez	a0,3250 <rmdot+0x86>
  if(chdir("dots") != 0){
    31e4:	00003517          	auipc	a0,0x3
    31e8:	69c50513          	addi	a0,a0,1692 # 6880 <malloc+0x18e8>
    31ec:	11b010ef          	jal	4b06 <chdir>
    31f0:	e935                	bnez	a0,3264 <rmdot+0x9a>
  if(unlink(".") == 0){
    31f2:	00002517          	auipc	a0,0x2
    31f6:	5be50513          	addi	a0,a0,1470 # 57b0 <malloc+0x818>
    31fa:	0ed010ef          	jal	4ae6 <unlink>
    31fe:	cd2d                	beqz	a0,3278 <rmdot+0xae>
  if(unlink("..") == 0){
    3200:	00003517          	auipc	a0,0x3
    3204:	0d050513          	addi	a0,a0,208 # 62d0 <malloc+0x1338>
    3208:	0df010ef          	jal	4ae6 <unlink>
    320c:	c141                	beqz	a0,328c <rmdot+0xc2>
  if(chdir("/") != 0){
    320e:	00003517          	auipc	a0,0x3
    3212:	06a50513          	addi	a0,a0,106 # 6278 <malloc+0x12e0>
    3216:	0f1010ef          	jal	4b06 <chdir>
    321a:	e159                	bnez	a0,32a0 <rmdot+0xd6>
  if(unlink("dots/.") == 0){
    321c:	00003517          	auipc	a0,0x3
    3220:	6cc50513          	addi	a0,a0,1740 # 68e8 <malloc+0x1950>
    3224:	0c3010ef          	jal	4ae6 <unlink>
    3228:	c551                	beqz	a0,32b4 <rmdot+0xea>
  if(unlink("dots/..") == 0){
    322a:	00003517          	auipc	a0,0x3
    322e:	6e650513          	addi	a0,a0,1766 # 6910 <malloc+0x1978>
    3232:	0b5010ef          	jal	4ae6 <unlink>
    3236:	c949                	beqz	a0,32c8 <rmdot+0xfe>
  if(unlink("dots") != 0){
    3238:	00003517          	auipc	a0,0x3
    323c:	64850513          	addi	a0,a0,1608 # 6880 <malloc+0x18e8>
    3240:	0a7010ef          	jal	4ae6 <unlink>
    3244:	ed41                	bnez	a0,32dc <rmdot+0x112>
}
    3246:	60e2                	ld	ra,24(sp)
    3248:	6442                	ld	s0,16(sp)
    324a:	64a2                	ld	s1,8(sp)
    324c:	6105                	addi	sp,sp,32
    324e:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3250:	85a6                	mv	a1,s1
    3252:	00003517          	auipc	a0,0x3
    3256:	63650513          	addi	a0,a0,1590 # 6888 <malloc+0x18f0>
    325a:	48b010ef          	jal	4ee4 <printf>
    exit(1);
    325e:	4505                	li	a0,1
    3260:	037010ef          	jal	4a96 <exit>
    printf("%s: chdir dots failed\n", s);
    3264:	85a6                	mv	a1,s1
    3266:	00003517          	auipc	a0,0x3
    326a:	63a50513          	addi	a0,a0,1594 # 68a0 <malloc+0x1908>
    326e:	477010ef          	jal	4ee4 <printf>
    exit(1);
    3272:	4505                	li	a0,1
    3274:	023010ef          	jal	4a96 <exit>
    printf("%s: rm . worked!\n", s);
    3278:	85a6                	mv	a1,s1
    327a:	00003517          	auipc	a0,0x3
    327e:	63e50513          	addi	a0,a0,1598 # 68b8 <malloc+0x1920>
    3282:	463010ef          	jal	4ee4 <printf>
    exit(1);
    3286:	4505                	li	a0,1
    3288:	00f010ef          	jal	4a96 <exit>
    printf("%s: rm .. worked!\n", s);
    328c:	85a6                	mv	a1,s1
    328e:	00003517          	auipc	a0,0x3
    3292:	64250513          	addi	a0,a0,1602 # 68d0 <malloc+0x1938>
    3296:	44f010ef          	jal	4ee4 <printf>
    exit(1);
    329a:	4505                	li	a0,1
    329c:	7fa010ef          	jal	4a96 <exit>
    printf("%s: chdir / failed\n", s);
    32a0:	85a6                	mv	a1,s1
    32a2:	00003517          	auipc	a0,0x3
    32a6:	fde50513          	addi	a0,a0,-34 # 6280 <malloc+0x12e8>
    32aa:	43b010ef          	jal	4ee4 <printf>
    exit(1);
    32ae:	4505                	li	a0,1
    32b0:	7e6010ef          	jal	4a96 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    32b4:	85a6                	mv	a1,s1
    32b6:	00003517          	auipc	a0,0x3
    32ba:	63a50513          	addi	a0,a0,1594 # 68f0 <malloc+0x1958>
    32be:	427010ef          	jal	4ee4 <printf>
    exit(1);
    32c2:	4505                	li	a0,1
    32c4:	7d2010ef          	jal	4a96 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    32c8:	85a6                	mv	a1,s1
    32ca:	00003517          	auipc	a0,0x3
    32ce:	64e50513          	addi	a0,a0,1614 # 6918 <malloc+0x1980>
    32d2:	413010ef          	jal	4ee4 <printf>
    exit(1);
    32d6:	4505                	li	a0,1
    32d8:	7be010ef          	jal	4a96 <exit>
    printf("%s: unlink dots failed!\n", s);
    32dc:	85a6                	mv	a1,s1
    32de:	00003517          	auipc	a0,0x3
    32e2:	65a50513          	addi	a0,a0,1626 # 6938 <malloc+0x19a0>
    32e6:	3ff010ef          	jal	4ee4 <printf>
    exit(1);
    32ea:	4505                	li	a0,1
    32ec:	7aa010ef          	jal	4a96 <exit>

00000000000032f0 <dirfile>:
{
    32f0:	1101                	addi	sp,sp,-32
    32f2:	ec06                	sd	ra,24(sp)
    32f4:	e822                	sd	s0,16(sp)
    32f6:	e426                	sd	s1,8(sp)
    32f8:	e04a                	sd	s2,0(sp)
    32fa:	1000                	addi	s0,sp,32
    32fc:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    32fe:	20000593          	li	a1,512
    3302:	00003517          	auipc	a0,0x3
    3306:	65650513          	addi	a0,a0,1622 # 6958 <malloc+0x19c0>
    330a:	7cc010ef          	jal	4ad6 <open>
  if(fd < 0){
    330e:	0c054563          	bltz	a0,33d8 <dirfile+0xe8>
  close(fd);
    3312:	7ac010ef          	jal	4abe <close>
  if(chdir("dirfile") == 0){
    3316:	00003517          	auipc	a0,0x3
    331a:	64250513          	addi	a0,a0,1602 # 6958 <malloc+0x19c0>
    331e:	7e8010ef          	jal	4b06 <chdir>
    3322:	c569                	beqz	a0,33ec <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    3324:	4581                	li	a1,0
    3326:	00003517          	auipc	a0,0x3
    332a:	67a50513          	addi	a0,a0,1658 # 69a0 <malloc+0x1a08>
    332e:	7a8010ef          	jal	4ad6 <open>
  if(fd >= 0){
    3332:	0c055763          	bgez	a0,3400 <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    3336:	20000593          	li	a1,512
    333a:	00003517          	auipc	a0,0x3
    333e:	66650513          	addi	a0,a0,1638 # 69a0 <malloc+0x1a08>
    3342:	794010ef          	jal	4ad6 <open>
  if(fd >= 0){
    3346:	0c055763          	bgez	a0,3414 <dirfile+0x124>
  if(mkdir("dirfile/xx") == 0){
    334a:	00003517          	auipc	a0,0x3
    334e:	65650513          	addi	a0,a0,1622 # 69a0 <malloc+0x1a08>
    3352:	7ac010ef          	jal	4afe <mkdir>
    3356:	0c050963          	beqz	a0,3428 <dirfile+0x138>
  if(unlink("dirfile/xx") == 0){
    335a:	00003517          	auipc	a0,0x3
    335e:	64650513          	addi	a0,a0,1606 # 69a0 <malloc+0x1a08>
    3362:	784010ef          	jal	4ae6 <unlink>
    3366:	0c050b63          	beqz	a0,343c <dirfile+0x14c>
  if(link("README", "dirfile/xx") == 0){
    336a:	00003597          	auipc	a1,0x3
    336e:	63658593          	addi	a1,a1,1590 # 69a0 <malloc+0x1a08>
    3372:	00002517          	auipc	a0,0x2
    3376:	f2e50513          	addi	a0,a0,-210 # 52a0 <malloc+0x308>
    337a:	77c010ef          	jal	4af6 <link>
    337e:	0c050963          	beqz	a0,3450 <dirfile+0x160>
  if(unlink("dirfile") != 0){
    3382:	00003517          	auipc	a0,0x3
    3386:	5d650513          	addi	a0,a0,1494 # 6958 <malloc+0x19c0>
    338a:	75c010ef          	jal	4ae6 <unlink>
    338e:	0c051b63          	bnez	a0,3464 <dirfile+0x174>
  fd = open(".", O_RDWR);
    3392:	4589                	li	a1,2
    3394:	00002517          	auipc	a0,0x2
    3398:	41c50513          	addi	a0,a0,1052 # 57b0 <malloc+0x818>
    339c:	73a010ef          	jal	4ad6 <open>
  if(fd >= 0){
    33a0:	0c055c63          	bgez	a0,3478 <dirfile+0x188>
  fd = open(".", 0);
    33a4:	4581                	li	a1,0
    33a6:	00002517          	auipc	a0,0x2
    33aa:	40a50513          	addi	a0,a0,1034 # 57b0 <malloc+0x818>
    33ae:	728010ef          	jal	4ad6 <open>
    33b2:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    33b4:	4605                	li	a2,1
    33b6:	00002597          	auipc	a1,0x2
    33ba:	d8258593          	addi	a1,a1,-638 # 5138 <malloc+0x1a0>
    33be:	6f8010ef          	jal	4ab6 <write>
    33c2:	0ca04563          	bgtz	a0,348c <dirfile+0x19c>
  close(fd);
    33c6:	8526                	mv	a0,s1
    33c8:	6f6010ef          	jal	4abe <close>
}
    33cc:	60e2                	ld	ra,24(sp)
    33ce:	6442                	ld	s0,16(sp)
    33d0:	64a2                	ld	s1,8(sp)
    33d2:	6902                	ld	s2,0(sp)
    33d4:	6105                	addi	sp,sp,32
    33d6:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    33d8:	85ca                	mv	a1,s2
    33da:	00003517          	auipc	a0,0x3
    33de:	58650513          	addi	a0,a0,1414 # 6960 <malloc+0x19c8>
    33e2:	303010ef          	jal	4ee4 <printf>
    exit(1);
    33e6:	4505                	li	a0,1
    33e8:	6ae010ef          	jal	4a96 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    33ec:	85ca                	mv	a1,s2
    33ee:	00003517          	auipc	a0,0x3
    33f2:	59250513          	addi	a0,a0,1426 # 6980 <malloc+0x19e8>
    33f6:	2ef010ef          	jal	4ee4 <printf>
    exit(1);
    33fa:	4505                	li	a0,1
    33fc:	69a010ef          	jal	4a96 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3400:	85ca                	mv	a1,s2
    3402:	00003517          	auipc	a0,0x3
    3406:	5ae50513          	addi	a0,a0,1454 # 69b0 <malloc+0x1a18>
    340a:	2db010ef          	jal	4ee4 <printf>
    exit(1);
    340e:	4505                	li	a0,1
    3410:	686010ef          	jal	4a96 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3414:	85ca                	mv	a1,s2
    3416:	00003517          	auipc	a0,0x3
    341a:	59a50513          	addi	a0,a0,1434 # 69b0 <malloc+0x1a18>
    341e:	2c7010ef          	jal	4ee4 <printf>
    exit(1);
    3422:	4505                	li	a0,1
    3424:	672010ef          	jal	4a96 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3428:	85ca                	mv	a1,s2
    342a:	00003517          	auipc	a0,0x3
    342e:	5ae50513          	addi	a0,a0,1454 # 69d8 <malloc+0x1a40>
    3432:	2b3010ef          	jal	4ee4 <printf>
    exit(1);
    3436:	4505                	li	a0,1
    3438:	65e010ef          	jal	4a96 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    343c:	85ca                	mv	a1,s2
    343e:	00003517          	auipc	a0,0x3
    3442:	5c250513          	addi	a0,a0,1474 # 6a00 <malloc+0x1a68>
    3446:	29f010ef          	jal	4ee4 <printf>
    exit(1);
    344a:	4505                	li	a0,1
    344c:	64a010ef          	jal	4a96 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3450:	85ca                	mv	a1,s2
    3452:	00003517          	auipc	a0,0x3
    3456:	5d650513          	addi	a0,a0,1494 # 6a28 <malloc+0x1a90>
    345a:	28b010ef          	jal	4ee4 <printf>
    exit(1);
    345e:	4505                	li	a0,1
    3460:	636010ef          	jal	4a96 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3464:	85ca                	mv	a1,s2
    3466:	00003517          	auipc	a0,0x3
    346a:	5ea50513          	addi	a0,a0,1514 # 6a50 <malloc+0x1ab8>
    346e:	277010ef          	jal	4ee4 <printf>
    exit(1);
    3472:	4505                	li	a0,1
    3474:	622010ef          	jal	4a96 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3478:	85ca                	mv	a1,s2
    347a:	00003517          	auipc	a0,0x3
    347e:	5f650513          	addi	a0,a0,1526 # 6a70 <malloc+0x1ad8>
    3482:	263010ef          	jal	4ee4 <printf>
    exit(1);
    3486:	4505                	li	a0,1
    3488:	60e010ef          	jal	4a96 <exit>
    printf("%s: write . succeeded!\n", s);
    348c:	85ca                	mv	a1,s2
    348e:	00003517          	auipc	a0,0x3
    3492:	60a50513          	addi	a0,a0,1546 # 6a98 <malloc+0x1b00>
    3496:	24f010ef          	jal	4ee4 <printf>
    exit(1);
    349a:	4505                	li	a0,1
    349c:	5fa010ef          	jal	4a96 <exit>

00000000000034a0 <iref>:
{
    34a0:	7139                	addi	sp,sp,-64
    34a2:	fc06                	sd	ra,56(sp)
    34a4:	f822                	sd	s0,48(sp)
    34a6:	f426                	sd	s1,40(sp)
    34a8:	f04a                	sd	s2,32(sp)
    34aa:	ec4e                	sd	s3,24(sp)
    34ac:	e852                	sd	s4,16(sp)
    34ae:	e456                	sd	s5,8(sp)
    34b0:	e05a                	sd	s6,0(sp)
    34b2:	0080                	addi	s0,sp,64
    34b4:	8b2a                	mv	s6,a0
    34b6:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    34ba:	00003a17          	auipc	s4,0x3
    34be:	5f6a0a13          	addi	s4,s4,1526 # 6ab0 <malloc+0x1b18>
    mkdir("");
    34c2:	00003497          	auipc	s1,0x3
    34c6:	0f648493          	addi	s1,s1,246 # 65b8 <malloc+0x1620>
    link("README", "");
    34ca:	00002a97          	auipc	s5,0x2
    34ce:	dd6a8a93          	addi	s5,s5,-554 # 52a0 <malloc+0x308>
    fd = open("xx", O_CREATE);
    34d2:	00003997          	auipc	s3,0x3
    34d6:	4d698993          	addi	s3,s3,1238 # 69a8 <malloc+0x1a10>
    34da:	a835                	j	3516 <iref+0x76>
      printf("%s: mkdir irefd failed\n", s);
    34dc:	85da                	mv	a1,s6
    34de:	00003517          	auipc	a0,0x3
    34e2:	5da50513          	addi	a0,a0,1498 # 6ab8 <malloc+0x1b20>
    34e6:	1ff010ef          	jal	4ee4 <printf>
      exit(1);
    34ea:	4505                	li	a0,1
    34ec:	5aa010ef          	jal	4a96 <exit>
      printf("%s: chdir irefd failed\n", s);
    34f0:	85da                	mv	a1,s6
    34f2:	00003517          	auipc	a0,0x3
    34f6:	5de50513          	addi	a0,a0,1502 # 6ad0 <malloc+0x1b38>
    34fa:	1eb010ef          	jal	4ee4 <printf>
      exit(1);
    34fe:	4505                	li	a0,1
    3500:	596010ef          	jal	4a96 <exit>
      close(fd);
    3504:	5ba010ef          	jal	4abe <close>
    3508:	a82d                	j	3542 <iref+0xa2>
    unlink("xx");
    350a:	854e                	mv	a0,s3
    350c:	5da010ef          	jal	4ae6 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3510:	397d                	addiw	s2,s2,-1
    3512:	04090263          	beqz	s2,3556 <iref+0xb6>
    if(mkdir("irefd") != 0){
    3516:	8552                	mv	a0,s4
    3518:	5e6010ef          	jal	4afe <mkdir>
    351c:	f161                	bnez	a0,34dc <iref+0x3c>
    if(chdir("irefd") != 0){
    351e:	8552                	mv	a0,s4
    3520:	5e6010ef          	jal	4b06 <chdir>
    3524:	f571                	bnez	a0,34f0 <iref+0x50>
    mkdir("");
    3526:	8526                	mv	a0,s1
    3528:	5d6010ef          	jal	4afe <mkdir>
    link("README", "");
    352c:	85a6                	mv	a1,s1
    352e:	8556                	mv	a0,s5
    3530:	5c6010ef          	jal	4af6 <link>
    fd = open("", O_CREATE);
    3534:	20000593          	li	a1,512
    3538:	8526                	mv	a0,s1
    353a:	59c010ef          	jal	4ad6 <open>
    if(fd >= 0)
    353e:	fc0553e3          	bgez	a0,3504 <iref+0x64>
    fd = open("xx", O_CREATE);
    3542:	20000593          	li	a1,512
    3546:	854e                	mv	a0,s3
    3548:	58e010ef          	jal	4ad6 <open>
    if(fd >= 0)
    354c:	fa054fe3          	bltz	a0,350a <iref+0x6a>
      close(fd);
    3550:	56e010ef          	jal	4abe <close>
    3554:	bf5d                	j	350a <iref+0x6a>
    3556:	03300493          	li	s1,51
    chdir("..");
    355a:	00003997          	auipc	s3,0x3
    355e:	d7698993          	addi	s3,s3,-650 # 62d0 <malloc+0x1338>
    unlink("irefd");
    3562:	00003917          	auipc	s2,0x3
    3566:	54e90913          	addi	s2,s2,1358 # 6ab0 <malloc+0x1b18>
    chdir("..");
    356a:	854e                	mv	a0,s3
    356c:	59a010ef          	jal	4b06 <chdir>
    unlink("irefd");
    3570:	854a                	mv	a0,s2
    3572:	574010ef          	jal	4ae6 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3576:	34fd                	addiw	s1,s1,-1
    3578:	f8ed                	bnez	s1,356a <iref+0xca>
  chdir("/");
    357a:	00003517          	auipc	a0,0x3
    357e:	cfe50513          	addi	a0,a0,-770 # 6278 <malloc+0x12e0>
    3582:	584010ef          	jal	4b06 <chdir>
}
    3586:	70e2                	ld	ra,56(sp)
    3588:	7442                	ld	s0,48(sp)
    358a:	74a2                	ld	s1,40(sp)
    358c:	7902                	ld	s2,32(sp)
    358e:	69e2                	ld	s3,24(sp)
    3590:	6a42                	ld	s4,16(sp)
    3592:	6aa2                	ld	s5,8(sp)
    3594:	6b02                	ld	s6,0(sp)
    3596:	6121                	addi	sp,sp,64
    3598:	8082                	ret

000000000000359a <openiputtest>:
{
    359a:	7179                	addi	sp,sp,-48
    359c:	f406                	sd	ra,40(sp)
    359e:	f022                	sd	s0,32(sp)
    35a0:	ec26                	sd	s1,24(sp)
    35a2:	1800                	addi	s0,sp,48
    35a4:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    35a6:	00003517          	auipc	a0,0x3
    35aa:	54250513          	addi	a0,a0,1346 # 6ae8 <malloc+0x1b50>
    35ae:	550010ef          	jal	4afe <mkdir>
    35b2:	02054a63          	bltz	a0,35e6 <openiputtest+0x4c>
  pid = fork();
    35b6:	4d8010ef          	jal	4a8e <fork>
  if(pid < 0){
    35ba:	04054063          	bltz	a0,35fa <openiputtest+0x60>
  if(pid == 0){
    35be:	e939                	bnez	a0,3614 <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    35c0:	4589                	li	a1,2
    35c2:	00003517          	auipc	a0,0x3
    35c6:	52650513          	addi	a0,a0,1318 # 6ae8 <malloc+0x1b50>
    35ca:	50c010ef          	jal	4ad6 <open>
    if(fd >= 0){
    35ce:	04054063          	bltz	a0,360e <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    35d2:	85a6                	mv	a1,s1
    35d4:	00003517          	auipc	a0,0x3
    35d8:	53450513          	addi	a0,a0,1332 # 6b08 <malloc+0x1b70>
    35dc:	109010ef          	jal	4ee4 <printf>
      exit(1);
    35e0:	4505                	li	a0,1
    35e2:	4b4010ef          	jal	4a96 <exit>
    printf("%s: mkdir oidir failed\n", s);
    35e6:	85a6                	mv	a1,s1
    35e8:	00003517          	auipc	a0,0x3
    35ec:	50850513          	addi	a0,a0,1288 # 6af0 <malloc+0x1b58>
    35f0:	0f5010ef          	jal	4ee4 <printf>
    exit(1);
    35f4:	4505                	li	a0,1
    35f6:	4a0010ef          	jal	4a96 <exit>
    printf("%s: fork failed\n", s);
    35fa:	85a6                	mv	a1,s1
    35fc:	00002517          	auipc	a0,0x2
    3600:	35c50513          	addi	a0,a0,860 # 5958 <malloc+0x9c0>
    3604:	0e1010ef          	jal	4ee4 <printf>
    exit(1);
    3608:	4505                	li	a0,1
    360a:	48c010ef          	jal	4a96 <exit>
    exit(0);
    360e:	4501                	li	a0,0
    3610:	486010ef          	jal	4a96 <exit>
  sleep(1);
    3614:	4505                	li	a0,1
    3616:	510010ef          	jal	4b26 <sleep>
  if(unlink("oidir") != 0){
    361a:	00003517          	auipc	a0,0x3
    361e:	4ce50513          	addi	a0,a0,1230 # 6ae8 <malloc+0x1b50>
    3622:	4c4010ef          	jal	4ae6 <unlink>
    3626:	c919                	beqz	a0,363c <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    3628:	85a6                	mv	a1,s1
    362a:	00002517          	auipc	a0,0x2
    362e:	51e50513          	addi	a0,a0,1310 # 5b48 <malloc+0xbb0>
    3632:	0b3010ef          	jal	4ee4 <printf>
    exit(1);
    3636:	4505                	li	a0,1
    3638:	45e010ef          	jal	4a96 <exit>
  wait(&xstatus);
    363c:	fdc40513          	addi	a0,s0,-36
    3640:	45e010ef          	jal	4a9e <wait>
  exit(xstatus);
    3644:	fdc42503          	lw	a0,-36(s0)
    3648:	44e010ef          	jal	4a96 <exit>

000000000000364c <forkforkfork>:
{
    364c:	1101                	addi	sp,sp,-32
    364e:	ec06                	sd	ra,24(sp)
    3650:	e822                	sd	s0,16(sp)
    3652:	e426                	sd	s1,8(sp)
    3654:	1000                	addi	s0,sp,32
    3656:	84aa                	mv	s1,a0
  unlink("stopforking");
    3658:	00003517          	auipc	a0,0x3
    365c:	4d850513          	addi	a0,a0,1240 # 6b30 <malloc+0x1b98>
    3660:	486010ef          	jal	4ae6 <unlink>
  int pid = fork();
    3664:	42a010ef          	jal	4a8e <fork>
  if(pid < 0){
    3668:	02054b63          	bltz	a0,369e <forkforkfork+0x52>
  if(pid == 0){
    366c:	c139                	beqz	a0,36b2 <forkforkfork+0x66>
  sleep(20); // two seconds
    366e:	4551                	li	a0,20
    3670:	4b6010ef          	jal	4b26 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3674:	20200593          	li	a1,514
    3678:	00003517          	auipc	a0,0x3
    367c:	4b850513          	addi	a0,a0,1208 # 6b30 <malloc+0x1b98>
    3680:	456010ef          	jal	4ad6 <open>
    3684:	43a010ef          	jal	4abe <close>
  wait(0);
    3688:	4501                	li	a0,0
    368a:	414010ef          	jal	4a9e <wait>
  sleep(10); // one second
    368e:	4529                	li	a0,10
    3690:	496010ef          	jal	4b26 <sleep>
}
    3694:	60e2                	ld	ra,24(sp)
    3696:	6442                	ld	s0,16(sp)
    3698:	64a2                	ld	s1,8(sp)
    369a:	6105                	addi	sp,sp,32
    369c:	8082                	ret
    printf("%s: fork failed", s);
    369e:	85a6                	mv	a1,s1
    36a0:	00002517          	auipc	a0,0x2
    36a4:	47850513          	addi	a0,a0,1144 # 5b18 <malloc+0xb80>
    36a8:	03d010ef          	jal	4ee4 <printf>
    exit(1);
    36ac:	4505                	li	a0,1
    36ae:	3e8010ef          	jal	4a96 <exit>
      int fd = open("stopforking", 0);
    36b2:	00003497          	auipc	s1,0x3
    36b6:	47e48493          	addi	s1,s1,1150 # 6b30 <malloc+0x1b98>
    36ba:	4581                	li	a1,0
    36bc:	8526                	mv	a0,s1
    36be:	418010ef          	jal	4ad6 <open>
      if(fd >= 0){
    36c2:	02055163          	bgez	a0,36e4 <forkforkfork+0x98>
      if(fork() < 0){
    36c6:	3c8010ef          	jal	4a8e <fork>
    36ca:	fe0558e3          	bgez	a0,36ba <forkforkfork+0x6e>
        close(open("stopforking", O_CREATE|O_RDWR));
    36ce:	20200593          	li	a1,514
    36d2:	00003517          	auipc	a0,0x3
    36d6:	45e50513          	addi	a0,a0,1118 # 6b30 <malloc+0x1b98>
    36da:	3fc010ef          	jal	4ad6 <open>
    36de:	3e0010ef          	jal	4abe <close>
    36e2:	bfe1                	j	36ba <forkforkfork+0x6e>
        exit(0);
    36e4:	4501                	li	a0,0
    36e6:	3b0010ef          	jal	4a96 <exit>

00000000000036ea <killstatus>:
{
    36ea:	7139                	addi	sp,sp,-64
    36ec:	fc06                	sd	ra,56(sp)
    36ee:	f822                	sd	s0,48(sp)
    36f0:	f426                	sd	s1,40(sp)
    36f2:	f04a                	sd	s2,32(sp)
    36f4:	ec4e                	sd	s3,24(sp)
    36f6:	e852                	sd	s4,16(sp)
    36f8:	0080                	addi	s0,sp,64
    36fa:	8a2a                	mv	s4,a0
    36fc:	06400913          	li	s2,100
    if(xst != -1) {
    3700:	59fd                	li	s3,-1
    int pid1 = fork();
    3702:	38c010ef          	jal	4a8e <fork>
    3706:	84aa                	mv	s1,a0
    if(pid1 < 0){
    3708:	02054763          	bltz	a0,3736 <killstatus+0x4c>
    if(pid1 == 0){
    370c:	cd1d                	beqz	a0,374a <killstatus+0x60>
    sleep(1);
    370e:	4505                	li	a0,1
    3710:	416010ef          	jal	4b26 <sleep>
    kill(pid1);
    3714:	8526                	mv	a0,s1
    3716:	3b0010ef          	jal	4ac6 <kill>
    wait(&xst);
    371a:	fcc40513          	addi	a0,s0,-52
    371e:	380010ef          	jal	4a9e <wait>
    if(xst != -1) {
    3722:	fcc42783          	lw	a5,-52(s0)
    3726:	03379563          	bne	a5,s3,3750 <killstatus+0x66>
  for(int i = 0; i < 100; i++){
    372a:	397d                	addiw	s2,s2,-1
    372c:	fc091be3          	bnez	s2,3702 <killstatus+0x18>
  exit(0);
    3730:	4501                	li	a0,0
    3732:	364010ef          	jal	4a96 <exit>
      printf("%s: fork failed\n", s);
    3736:	85d2                	mv	a1,s4
    3738:	00002517          	auipc	a0,0x2
    373c:	22050513          	addi	a0,a0,544 # 5958 <malloc+0x9c0>
    3740:	7a4010ef          	jal	4ee4 <printf>
      exit(1);
    3744:	4505                	li	a0,1
    3746:	350010ef          	jal	4a96 <exit>
        getpid();
    374a:	3cc010ef          	jal	4b16 <getpid>
      while(1) {
    374e:	bff5                	j	374a <killstatus+0x60>
       printf("%s: status should be -1\n", s);
    3750:	85d2                	mv	a1,s4
    3752:	00003517          	auipc	a0,0x3
    3756:	3ee50513          	addi	a0,a0,1006 # 6b40 <malloc+0x1ba8>
    375a:	78a010ef          	jal	4ee4 <printf>
       exit(1);
    375e:	4505                	li	a0,1
    3760:	336010ef          	jal	4a96 <exit>

0000000000003764 <preempt>:
{
    3764:	7139                	addi	sp,sp,-64
    3766:	fc06                	sd	ra,56(sp)
    3768:	f822                	sd	s0,48(sp)
    376a:	f426                	sd	s1,40(sp)
    376c:	f04a                	sd	s2,32(sp)
    376e:	ec4e                	sd	s3,24(sp)
    3770:	e852                	sd	s4,16(sp)
    3772:	0080                	addi	s0,sp,64
    3774:	892a                	mv	s2,a0
  pid1 = fork();
    3776:	318010ef          	jal	4a8e <fork>
  if(pid1 < 0) {
    377a:	00054563          	bltz	a0,3784 <preempt+0x20>
    377e:	84aa                	mv	s1,a0
  if(pid1 == 0)
    3780:	ed01                	bnez	a0,3798 <preempt+0x34>
    for(;;)
    3782:	a001                	j	3782 <preempt+0x1e>
    printf("%s: fork failed", s);
    3784:	85ca                	mv	a1,s2
    3786:	00002517          	auipc	a0,0x2
    378a:	39250513          	addi	a0,a0,914 # 5b18 <malloc+0xb80>
    378e:	756010ef          	jal	4ee4 <printf>
    exit(1);
    3792:	4505                	li	a0,1
    3794:	302010ef          	jal	4a96 <exit>
  pid2 = fork();
    3798:	2f6010ef          	jal	4a8e <fork>
    379c:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    379e:	00054463          	bltz	a0,37a6 <preempt+0x42>
  if(pid2 == 0)
    37a2:	ed01                	bnez	a0,37ba <preempt+0x56>
    for(;;)
    37a4:	a001                	j	37a4 <preempt+0x40>
    printf("%s: fork failed\n", s);
    37a6:	85ca                	mv	a1,s2
    37a8:	00002517          	auipc	a0,0x2
    37ac:	1b050513          	addi	a0,a0,432 # 5958 <malloc+0x9c0>
    37b0:	734010ef          	jal	4ee4 <printf>
    exit(1);
    37b4:	4505                	li	a0,1
    37b6:	2e0010ef          	jal	4a96 <exit>
  pipe(pfds);
    37ba:	fc840513          	addi	a0,s0,-56
    37be:	2e8010ef          	jal	4aa6 <pipe>
  pid3 = fork();
    37c2:	2cc010ef          	jal	4a8e <fork>
    37c6:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    37c8:	02054863          	bltz	a0,37f8 <preempt+0x94>
  if(pid3 == 0){
    37cc:	e921                	bnez	a0,381c <preempt+0xb8>
    close(pfds[0]);
    37ce:	fc842503          	lw	a0,-56(s0)
    37d2:	2ec010ef          	jal	4abe <close>
    if(write(pfds[1], "x", 1) != 1)
    37d6:	4605                	li	a2,1
    37d8:	00002597          	auipc	a1,0x2
    37dc:	96058593          	addi	a1,a1,-1696 # 5138 <malloc+0x1a0>
    37e0:	fcc42503          	lw	a0,-52(s0)
    37e4:	2d2010ef          	jal	4ab6 <write>
    37e8:	4785                	li	a5,1
    37ea:	02f51163          	bne	a0,a5,380c <preempt+0xa8>
    close(pfds[1]);
    37ee:	fcc42503          	lw	a0,-52(s0)
    37f2:	2cc010ef          	jal	4abe <close>
    for(;;)
    37f6:	a001                	j	37f6 <preempt+0x92>
     printf("%s: fork failed\n", s);
    37f8:	85ca                	mv	a1,s2
    37fa:	00002517          	auipc	a0,0x2
    37fe:	15e50513          	addi	a0,a0,350 # 5958 <malloc+0x9c0>
    3802:	6e2010ef          	jal	4ee4 <printf>
     exit(1);
    3806:	4505                	li	a0,1
    3808:	28e010ef          	jal	4a96 <exit>
      printf("%s: preempt write error", s);
    380c:	85ca                	mv	a1,s2
    380e:	00003517          	auipc	a0,0x3
    3812:	35250513          	addi	a0,a0,850 # 6b60 <malloc+0x1bc8>
    3816:	6ce010ef          	jal	4ee4 <printf>
    381a:	bfd1                	j	37ee <preempt+0x8a>
  close(pfds[1]);
    381c:	fcc42503          	lw	a0,-52(s0)
    3820:	29e010ef          	jal	4abe <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    3824:	660d                	lui	a2,0x3
    3826:	00009597          	auipc	a1,0x9
    382a:	45258593          	addi	a1,a1,1106 # cc78 <buf>
    382e:	fc842503          	lw	a0,-56(s0)
    3832:	27c010ef          	jal	4aae <read>
    3836:	4785                	li	a5,1
    3838:	02f50163          	beq	a0,a5,385a <preempt+0xf6>
    printf("%s: preempt read error", s);
    383c:	85ca                	mv	a1,s2
    383e:	00003517          	auipc	a0,0x3
    3842:	33a50513          	addi	a0,a0,826 # 6b78 <malloc+0x1be0>
    3846:	69e010ef          	jal	4ee4 <printf>
}
    384a:	70e2                	ld	ra,56(sp)
    384c:	7442                	ld	s0,48(sp)
    384e:	74a2                	ld	s1,40(sp)
    3850:	7902                	ld	s2,32(sp)
    3852:	69e2                	ld	s3,24(sp)
    3854:	6a42                	ld	s4,16(sp)
    3856:	6121                	addi	sp,sp,64
    3858:	8082                	ret
  close(pfds[0]);
    385a:	fc842503          	lw	a0,-56(s0)
    385e:	260010ef          	jal	4abe <close>
  printf("kill... ");
    3862:	00003517          	auipc	a0,0x3
    3866:	32e50513          	addi	a0,a0,814 # 6b90 <malloc+0x1bf8>
    386a:	67a010ef          	jal	4ee4 <printf>
  kill(pid1);
    386e:	8526                	mv	a0,s1
    3870:	256010ef          	jal	4ac6 <kill>
  kill(pid2);
    3874:	854e                	mv	a0,s3
    3876:	250010ef          	jal	4ac6 <kill>
  kill(pid3);
    387a:	8552                	mv	a0,s4
    387c:	24a010ef          	jal	4ac6 <kill>
  printf("wait... ");
    3880:	00003517          	auipc	a0,0x3
    3884:	32050513          	addi	a0,a0,800 # 6ba0 <malloc+0x1c08>
    3888:	65c010ef          	jal	4ee4 <printf>
  wait(0);
    388c:	4501                	li	a0,0
    388e:	210010ef          	jal	4a9e <wait>
  wait(0);
    3892:	4501                	li	a0,0
    3894:	20a010ef          	jal	4a9e <wait>
  wait(0);
    3898:	4501                	li	a0,0
    389a:	204010ef          	jal	4a9e <wait>
    389e:	b775                	j	384a <preempt+0xe6>

00000000000038a0 <reparent>:
{
    38a0:	7179                	addi	sp,sp,-48
    38a2:	f406                	sd	ra,40(sp)
    38a4:	f022                	sd	s0,32(sp)
    38a6:	ec26                	sd	s1,24(sp)
    38a8:	e84a                	sd	s2,16(sp)
    38aa:	e44e                	sd	s3,8(sp)
    38ac:	e052                	sd	s4,0(sp)
    38ae:	1800                	addi	s0,sp,48
    38b0:	89aa                	mv	s3,a0
  int master_pid = getpid();
    38b2:	264010ef          	jal	4b16 <getpid>
    38b6:	8a2a                	mv	s4,a0
    38b8:	0c800913          	li	s2,200
    int pid = fork();
    38bc:	1d2010ef          	jal	4a8e <fork>
    38c0:	84aa                	mv	s1,a0
    if(pid < 0){
    38c2:	00054e63          	bltz	a0,38de <reparent+0x3e>
    if(pid){
    38c6:	c121                	beqz	a0,3906 <reparent+0x66>
      if(wait(0) != pid){
    38c8:	4501                	li	a0,0
    38ca:	1d4010ef          	jal	4a9e <wait>
    38ce:	02951263          	bne	a0,s1,38f2 <reparent+0x52>
  for(int i = 0; i < 200; i++){
    38d2:	397d                	addiw	s2,s2,-1
    38d4:	fe0914e3          	bnez	s2,38bc <reparent+0x1c>
  exit(0);
    38d8:	4501                	li	a0,0
    38da:	1bc010ef          	jal	4a96 <exit>
      printf("%s: fork failed\n", s);
    38de:	85ce                	mv	a1,s3
    38e0:	00002517          	auipc	a0,0x2
    38e4:	07850513          	addi	a0,a0,120 # 5958 <malloc+0x9c0>
    38e8:	5fc010ef          	jal	4ee4 <printf>
      exit(1);
    38ec:	4505                	li	a0,1
    38ee:	1a8010ef          	jal	4a96 <exit>
        printf("%s: wait wrong pid\n", s);
    38f2:	85ce                	mv	a1,s3
    38f4:	00002517          	auipc	a0,0x2
    38f8:	1ec50513          	addi	a0,a0,492 # 5ae0 <malloc+0xb48>
    38fc:	5e8010ef          	jal	4ee4 <printf>
        exit(1);
    3900:	4505                	li	a0,1
    3902:	194010ef          	jal	4a96 <exit>
      int pid2 = fork();
    3906:	188010ef          	jal	4a8e <fork>
      if(pid2 < 0){
    390a:	00054563          	bltz	a0,3914 <reparent+0x74>
      exit(0);
    390e:	4501                	li	a0,0
    3910:	186010ef          	jal	4a96 <exit>
        kill(master_pid);
    3914:	8552                	mv	a0,s4
    3916:	1b0010ef          	jal	4ac6 <kill>
        exit(1);
    391a:	4505                	li	a0,1
    391c:	17a010ef          	jal	4a96 <exit>

0000000000003920 <sbrkfail>:
{
    3920:	7119                	addi	sp,sp,-128
    3922:	fc86                	sd	ra,120(sp)
    3924:	f8a2                	sd	s0,112(sp)
    3926:	f4a6                	sd	s1,104(sp)
    3928:	f0ca                	sd	s2,96(sp)
    392a:	ecce                	sd	s3,88(sp)
    392c:	e8d2                	sd	s4,80(sp)
    392e:	e4d6                	sd	s5,72(sp)
    3930:	0100                	addi	s0,sp,128
    3932:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    3934:	fb040513          	addi	a0,s0,-80
    3938:	16e010ef          	jal	4aa6 <pipe>
    393c:	e901                	bnez	a0,394c <sbrkfail+0x2c>
    393e:	f8040493          	addi	s1,s0,-128
    3942:	fa840993          	addi	s3,s0,-88
    3946:	8926                	mv	s2,s1
    if(pids[i] != -1)
    3948:	5a7d                	li	s4,-1
    394a:	a0a1                	j	3992 <sbrkfail+0x72>
    printf("%s: pipe() failed\n", s);
    394c:	85d6                	mv	a1,s5
    394e:	00002517          	auipc	a0,0x2
    3952:	11250513          	addi	a0,a0,274 # 5a60 <malloc+0xac8>
    3956:	58e010ef          	jal	4ee4 <printf>
    exit(1);
    395a:	4505                	li	a0,1
    395c:	13a010ef          	jal	4a96 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    3960:	1be010ef          	jal	4b1e <sbrk>
    3964:	064007b7          	lui	a5,0x6400
    3968:	40a7853b          	subw	a0,a5,a0
    396c:	1b2010ef          	jal	4b1e <sbrk>
      write(fds[1], "x", 1);
    3970:	4605                	li	a2,1
    3972:	00001597          	auipc	a1,0x1
    3976:	7c658593          	addi	a1,a1,1990 # 5138 <malloc+0x1a0>
    397a:	fb442503          	lw	a0,-76(s0)
    397e:	138010ef          	jal	4ab6 <write>
      for(;;) sleep(1000);
    3982:	3e800513          	li	a0,1000
    3986:	1a0010ef          	jal	4b26 <sleep>
    398a:	bfe5                	j	3982 <sbrkfail+0x62>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    398c:	0911                	addi	s2,s2,4
    398e:	03390163          	beq	s2,s3,39b0 <sbrkfail+0x90>
    if((pids[i] = fork()) == 0){
    3992:	0fc010ef          	jal	4a8e <fork>
    3996:	00a92023          	sw	a0,0(s2)
    399a:	d179                	beqz	a0,3960 <sbrkfail+0x40>
    if(pids[i] != -1)
    399c:	ff4508e3          	beq	a0,s4,398c <sbrkfail+0x6c>
      read(fds[0], &scratch, 1);
    39a0:	4605                	li	a2,1
    39a2:	faf40593          	addi	a1,s0,-81
    39a6:	fb042503          	lw	a0,-80(s0)
    39aa:	104010ef          	jal	4aae <read>
    39ae:	bff9                	j	398c <sbrkfail+0x6c>
  c = sbrk(PGSIZE);
    39b0:	6505                	lui	a0,0x1
    39b2:	16c010ef          	jal	4b1e <sbrk>
    39b6:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    39b8:	597d                	li	s2,-1
    39ba:	a021                	j	39c2 <sbrkfail+0xa2>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    39bc:	0491                	addi	s1,s1,4
    39be:	01348b63          	beq	s1,s3,39d4 <sbrkfail+0xb4>
    if(pids[i] == -1)
    39c2:	4088                	lw	a0,0(s1)
    39c4:	ff250ce3          	beq	a0,s2,39bc <sbrkfail+0x9c>
    kill(pids[i]);
    39c8:	0fe010ef          	jal	4ac6 <kill>
    wait(0);
    39cc:	4501                	li	a0,0
    39ce:	0d0010ef          	jal	4a9e <wait>
    39d2:	b7ed                	j	39bc <sbrkfail+0x9c>
  if(c == (char*)0xffffffffffffffffL){
    39d4:	57fd                	li	a5,-1
    39d6:	02fa0d63          	beq	s4,a5,3a10 <sbrkfail+0xf0>
  pid = fork();
    39da:	0b4010ef          	jal	4a8e <fork>
    39de:	84aa                	mv	s1,a0
  if(pid < 0){
    39e0:	04054263          	bltz	a0,3a24 <sbrkfail+0x104>
  if(pid == 0){
    39e4:	c931                	beqz	a0,3a38 <sbrkfail+0x118>
  wait(&xstatus);
    39e6:	fbc40513          	addi	a0,s0,-68
    39ea:	0b4010ef          	jal	4a9e <wait>
  if(xstatus != -1 && xstatus != 2)
    39ee:	fbc42783          	lw	a5,-68(s0)
    39f2:	577d                	li	a4,-1
    39f4:	00e78563          	beq	a5,a4,39fe <sbrkfail+0xde>
    39f8:	4709                	li	a4,2
    39fa:	06e79d63          	bne	a5,a4,3a74 <sbrkfail+0x154>
}
    39fe:	70e6                	ld	ra,120(sp)
    3a00:	7446                	ld	s0,112(sp)
    3a02:	74a6                	ld	s1,104(sp)
    3a04:	7906                	ld	s2,96(sp)
    3a06:	69e6                	ld	s3,88(sp)
    3a08:	6a46                	ld	s4,80(sp)
    3a0a:	6aa6                	ld	s5,72(sp)
    3a0c:	6109                	addi	sp,sp,128
    3a0e:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    3a10:	85d6                	mv	a1,s5
    3a12:	00003517          	auipc	a0,0x3
    3a16:	19e50513          	addi	a0,a0,414 # 6bb0 <malloc+0x1c18>
    3a1a:	4ca010ef          	jal	4ee4 <printf>
    exit(1);
    3a1e:	4505                	li	a0,1
    3a20:	076010ef          	jal	4a96 <exit>
    printf("%s: fork failed\n", s);
    3a24:	85d6                	mv	a1,s5
    3a26:	00002517          	auipc	a0,0x2
    3a2a:	f3250513          	addi	a0,a0,-206 # 5958 <malloc+0x9c0>
    3a2e:	4b6010ef          	jal	4ee4 <printf>
    exit(1);
    3a32:	4505                	li	a0,1
    3a34:	062010ef          	jal	4a96 <exit>
    a = sbrk(0);
    3a38:	4501                	li	a0,0
    3a3a:	0e4010ef          	jal	4b1e <sbrk>
    3a3e:	892a                	mv	s2,a0
    sbrk(10*BIG);
    3a40:	3e800537          	lui	a0,0x3e800
    3a44:	0da010ef          	jal	4b1e <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3a48:	87ca                	mv	a5,s2
    3a4a:	3e800737          	lui	a4,0x3e800
    3a4e:	993a                	add	s2,s2,a4
    3a50:	6705                	lui	a4,0x1
      n += *(a+i);
    3a52:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f0388>
    3a56:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3a58:	97ba                	add	a5,a5,a4
    3a5a:	fef91ce3          	bne	s2,a5,3a52 <sbrkfail+0x132>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    3a5e:	8626                	mv	a2,s1
    3a60:	85d6                	mv	a1,s5
    3a62:	00003517          	auipc	a0,0x3
    3a66:	16e50513          	addi	a0,a0,366 # 6bd0 <malloc+0x1c38>
    3a6a:	47a010ef          	jal	4ee4 <printf>
    exit(1);
    3a6e:	4505                	li	a0,1
    3a70:	026010ef          	jal	4a96 <exit>
    exit(1);
    3a74:	4505                	li	a0,1
    3a76:	020010ef          	jal	4a96 <exit>

0000000000003a7a <mem>:
{
    3a7a:	7139                	addi	sp,sp,-64
    3a7c:	fc06                	sd	ra,56(sp)
    3a7e:	f822                	sd	s0,48(sp)
    3a80:	f426                	sd	s1,40(sp)
    3a82:	f04a                	sd	s2,32(sp)
    3a84:	ec4e                	sd	s3,24(sp)
    3a86:	0080                	addi	s0,sp,64
    3a88:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    3a8a:	004010ef          	jal	4a8e <fork>
    m1 = 0;
    3a8e:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    3a90:	6909                	lui	s2,0x2
    3a92:	71190913          	addi	s2,s2,1809 # 2711 <fourteen+0x7d>
  if((pid = fork()) == 0){
    3a96:	cd11                	beqz	a0,3ab2 <mem+0x38>
    wait(&xstatus);
    3a98:	fcc40513          	addi	a0,s0,-52
    3a9c:	002010ef          	jal	4a9e <wait>
    if(xstatus == -1){
    3aa0:	fcc42503          	lw	a0,-52(s0)
    3aa4:	57fd                	li	a5,-1
    3aa6:	04f50363          	beq	a0,a5,3aec <mem+0x72>
    exit(xstatus);
    3aaa:	7ed000ef          	jal	4a96 <exit>
      *(char**)m2 = m1;
    3aae:	e104                	sd	s1,0(a0)
      m1 = m2;
    3ab0:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    3ab2:	854a                	mv	a0,s2
    3ab4:	4e4010ef          	jal	4f98 <malloc>
    3ab8:	f97d                	bnez	a0,3aae <mem+0x34>
    while(m1){
    3aba:	c491                	beqz	s1,3ac6 <mem+0x4c>
      m2 = *(char**)m1;
    3abc:	8526                	mv	a0,s1
    3abe:	6084                	ld	s1,0(s1)
      free(m1);
    3ac0:	456010ef          	jal	4f16 <free>
    while(m1){
    3ac4:	fce5                	bnez	s1,3abc <mem+0x42>
    m1 = malloc(1024*20);
    3ac6:	6515                	lui	a0,0x5
    3ac8:	4d0010ef          	jal	4f98 <malloc>
    if(m1 == 0){
    3acc:	c511                	beqz	a0,3ad8 <mem+0x5e>
    free(m1);
    3ace:	448010ef          	jal	4f16 <free>
    exit(0);
    3ad2:	4501                	li	a0,0
    3ad4:	7c3000ef          	jal	4a96 <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3ad8:	85ce                	mv	a1,s3
    3ada:	00003517          	auipc	a0,0x3
    3ade:	12650513          	addi	a0,a0,294 # 6c00 <malloc+0x1c68>
    3ae2:	402010ef          	jal	4ee4 <printf>
      exit(1);
    3ae6:	4505                	li	a0,1
    3ae8:	7af000ef          	jal	4a96 <exit>
      exit(0);
    3aec:	4501                	li	a0,0
    3aee:	7a9000ef          	jal	4a96 <exit>

0000000000003af2 <sharedfd>:
{
    3af2:	7159                	addi	sp,sp,-112
    3af4:	f486                	sd	ra,104(sp)
    3af6:	f0a2                	sd	s0,96(sp)
    3af8:	e0d2                	sd	s4,64(sp)
    3afa:	1880                	addi	s0,sp,112
    3afc:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    3afe:	00003517          	auipc	a0,0x3
    3b02:	12250513          	addi	a0,a0,290 # 6c20 <malloc+0x1c88>
    3b06:	7e1000ef          	jal	4ae6 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    3b0a:	20200593          	li	a1,514
    3b0e:	00003517          	auipc	a0,0x3
    3b12:	11250513          	addi	a0,a0,274 # 6c20 <malloc+0x1c88>
    3b16:	7c1000ef          	jal	4ad6 <open>
  if(fd < 0){
    3b1a:	04054863          	bltz	a0,3b6a <sharedfd+0x78>
    3b1e:	eca6                	sd	s1,88(sp)
    3b20:	e8ca                	sd	s2,80(sp)
    3b22:	e4ce                	sd	s3,72(sp)
    3b24:	fc56                	sd	s5,56(sp)
    3b26:	f85a                	sd	s6,48(sp)
    3b28:	f45e                	sd	s7,40(sp)
    3b2a:	892a                	mv	s2,a0
  pid = fork();
    3b2c:	763000ef          	jal	4a8e <fork>
    3b30:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    3b32:	07000593          	li	a1,112
    3b36:	e119                	bnez	a0,3b3c <sharedfd+0x4a>
    3b38:	06300593          	li	a1,99
    3b3c:	4629                	li	a2,10
    3b3e:	fa040513          	addi	a0,s0,-96
    3b42:	559000ef          	jal	489a <memset>
    3b46:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    3b4a:	4629                	li	a2,10
    3b4c:	fa040593          	addi	a1,s0,-96
    3b50:	854a                	mv	a0,s2
    3b52:	765000ef          	jal	4ab6 <write>
    3b56:	47a9                	li	a5,10
    3b58:	02f51963          	bne	a0,a5,3b8a <sharedfd+0x98>
  for(i = 0; i < N; i++){
    3b5c:	34fd                	addiw	s1,s1,-1
    3b5e:	f4f5                	bnez	s1,3b4a <sharedfd+0x58>
  if(pid == 0) {
    3b60:	02099f63          	bnez	s3,3b9e <sharedfd+0xac>
    exit(0);
    3b64:	4501                	li	a0,0
    3b66:	731000ef          	jal	4a96 <exit>
    3b6a:	eca6                	sd	s1,88(sp)
    3b6c:	e8ca                	sd	s2,80(sp)
    3b6e:	e4ce                	sd	s3,72(sp)
    3b70:	fc56                	sd	s5,56(sp)
    3b72:	f85a                	sd	s6,48(sp)
    3b74:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3b76:	85d2                	mv	a1,s4
    3b78:	00003517          	auipc	a0,0x3
    3b7c:	0b850513          	addi	a0,a0,184 # 6c30 <malloc+0x1c98>
    3b80:	364010ef          	jal	4ee4 <printf>
    exit(1);
    3b84:	4505                	li	a0,1
    3b86:	711000ef          	jal	4a96 <exit>
      printf("%s: write sharedfd failed\n", s);
    3b8a:	85d2                	mv	a1,s4
    3b8c:	00003517          	auipc	a0,0x3
    3b90:	0cc50513          	addi	a0,a0,204 # 6c58 <malloc+0x1cc0>
    3b94:	350010ef          	jal	4ee4 <printf>
      exit(1);
    3b98:	4505                	li	a0,1
    3b9a:	6fd000ef          	jal	4a96 <exit>
    wait(&xstatus);
    3b9e:	f9c40513          	addi	a0,s0,-100
    3ba2:	6fd000ef          	jal	4a9e <wait>
    if(xstatus != 0)
    3ba6:	f9c42983          	lw	s3,-100(s0)
    3baa:	00098563          	beqz	s3,3bb4 <sharedfd+0xc2>
      exit(xstatus);
    3bae:	854e                	mv	a0,s3
    3bb0:	6e7000ef          	jal	4a96 <exit>
  close(fd);
    3bb4:	854a                	mv	a0,s2
    3bb6:	709000ef          	jal	4abe <close>
  fd = open("sharedfd", 0);
    3bba:	4581                	li	a1,0
    3bbc:	00003517          	auipc	a0,0x3
    3bc0:	06450513          	addi	a0,a0,100 # 6c20 <malloc+0x1c88>
    3bc4:	713000ef          	jal	4ad6 <open>
    3bc8:	8baa                	mv	s7,a0
  nc = np = 0;
    3bca:	8ace                	mv	s5,s3
  if(fd < 0){
    3bcc:	02054363          	bltz	a0,3bf2 <sharedfd+0x100>
    3bd0:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    3bd4:	06300493          	li	s1,99
      if(buf[i] == 'p')
    3bd8:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3bdc:	4629                	li	a2,10
    3bde:	fa040593          	addi	a1,s0,-96
    3be2:	855e                	mv	a0,s7
    3be4:	6cb000ef          	jal	4aae <read>
    3be8:	02a05b63          	blez	a0,3c1e <sharedfd+0x12c>
    3bec:	fa040793          	addi	a5,s0,-96
    3bf0:	a839                	j	3c0e <sharedfd+0x11c>
    printf("%s: cannot open sharedfd for reading\n", s);
    3bf2:	85d2                	mv	a1,s4
    3bf4:	00003517          	auipc	a0,0x3
    3bf8:	08450513          	addi	a0,a0,132 # 6c78 <malloc+0x1ce0>
    3bfc:	2e8010ef          	jal	4ee4 <printf>
    exit(1);
    3c00:	4505                	li	a0,1
    3c02:	695000ef          	jal	4a96 <exit>
        nc++;
    3c06:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    3c08:	0785                	addi	a5,a5,1
    3c0a:	fd2789e3          	beq	a5,s2,3bdc <sharedfd+0xea>
      if(buf[i] == 'c')
    3c0e:	0007c703          	lbu	a4,0(a5)
    3c12:	fe970ae3          	beq	a4,s1,3c06 <sharedfd+0x114>
      if(buf[i] == 'p')
    3c16:	ff6719e3          	bne	a4,s6,3c08 <sharedfd+0x116>
        np++;
    3c1a:	2a85                	addiw	s5,s5,1
    3c1c:	b7f5                	j	3c08 <sharedfd+0x116>
  close(fd);
    3c1e:	855e                	mv	a0,s7
    3c20:	69f000ef          	jal	4abe <close>
  unlink("sharedfd");
    3c24:	00003517          	auipc	a0,0x3
    3c28:	ffc50513          	addi	a0,a0,-4 # 6c20 <malloc+0x1c88>
    3c2c:	6bb000ef          	jal	4ae6 <unlink>
  if(nc == N*SZ && np == N*SZ){
    3c30:	6789                	lui	a5,0x2
    3c32:	71078793          	addi	a5,a5,1808 # 2710 <fourteen+0x7c>
    3c36:	00f99763          	bne	s3,a5,3c44 <sharedfd+0x152>
    3c3a:	6789                	lui	a5,0x2
    3c3c:	71078793          	addi	a5,a5,1808 # 2710 <fourteen+0x7c>
    3c40:	00fa8c63          	beq	s5,a5,3c58 <sharedfd+0x166>
    printf("%s: nc/np test fails\n", s);
    3c44:	85d2                	mv	a1,s4
    3c46:	00003517          	auipc	a0,0x3
    3c4a:	05a50513          	addi	a0,a0,90 # 6ca0 <malloc+0x1d08>
    3c4e:	296010ef          	jal	4ee4 <printf>
    exit(1);
    3c52:	4505                	li	a0,1
    3c54:	643000ef          	jal	4a96 <exit>
    exit(0);
    3c58:	4501                	li	a0,0
    3c5a:	63d000ef          	jal	4a96 <exit>

0000000000003c5e <fourfiles>:
{
    3c5e:	7135                	addi	sp,sp,-160
    3c60:	ed06                	sd	ra,152(sp)
    3c62:	e922                	sd	s0,144(sp)
    3c64:	e526                	sd	s1,136(sp)
    3c66:	e14a                	sd	s2,128(sp)
    3c68:	fcce                	sd	s3,120(sp)
    3c6a:	f8d2                	sd	s4,112(sp)
    3c6c:	f4d6                	sd	s5,104(sp)
    3c6e:	f0da                	sd	s6,96(sp)
    3c70:	ecde                	sd	s7,88(sp)
    3c72:	e8e2                	sd	s8,80(sp)
    3c74:	e4e6                	sd	s9,72(sp)
    3c76:	e0ea                	sd	s10,64(sp)
    3c78:	fc6e                	sd	s11,56(sp)
    3c7a:	1100                	addi	s0,sp,160
    3c7c:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    3c7e:	00003797          	auipc	a5,0x3
    3c82:	03a78793          	addi	a5,a5,58 # 6cb8 <malloc+0x1d20>
    3c86:	f6f43823          	sd	a5,-144(s0)
    3c8a:	00003797          	auipc	a5,0x3
    3c8e:	03678793          	addi	a5,a5,54 # 6cc0 <malloc+0x1d28>
    3c92:	f6f43c23          	sd	a5,-136(s0)
    3c96:	00003797          	auipc	a5,0x3
    3c9a:	03278793          	addi	a5,a5,50 # 6cc8 <malloc+0x1d30>
    3c9e:	f8f43023          	sd	a5,-128(s0)
    3ca2:	00003797          	auipc	a5,0x3
    3ca6:	02e78793          	addi	a5,a5,46 # 6cd0 <malloc+0x1d38>
    3caa:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3cae:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3cb2:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    3cb4:	4481                	li	s1,0
    3cb6:	4a11                	li	s4,4
    fname = names[pi];
    3cb8:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3cbc:	854e                	mv	a0,s3
    3cbe:	629000ef          	jal	4ae6 <unlink>
    pid = fork();
    3cc2:	5cd000ef          	jal	4a8e <fork>
    if(pid < 0){
    3cc6:	02054e63          	bltz	a0,3d02 <fourfiles+0xa4>
    if(pid == 0){
    3cca:	c531                	beqz	a0,3d16 <fourfiles+0xb8>
  for(pi = 0; pi < NCHILD; pi++){
    3ccc:	2485                	addiw	s1,s1,1
    3cce:	0921                	addi	s2,s2,8
    3cd0:	ff4494e3          	bne	s1,s4,3cb8 <fourfiles+0x5a>
    3cd4:	4491                	li	s1,4
    wait(&xstatus);
    3cd6:	f6c40513          	addi	a0,s0,-148
    3cda:	5c5000ef          	jal	4a9e <wait>
    if(xstatus != 0)
    3cde:	f6c42a83          	lw	s5,-148(s0)
    3ce2:	0a0a9463          	bnez	s5,3d8a <fourfiles+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    3ce6:	34fd                	addiw	s1,s1,-1
    3ce8:	f4fd                	bnez	s1,3cd6 <fourfiles+0x78>
    3cea:	03000b13          	li	s6,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3cee:	00009a17          	auipc	s4,0x9
    3cf2:	f8aa0a13          	addi	s4,s4,-118 # cc78 <buf>
    if(total != N*SZ){
    3cf6:	6d05                	lui	s10,0x1
    3cf8:	770d0d13          	addi	s10,s10,1904 # 1770 <forkfork+0x1e>
  for(i = 0; i < NCHILD; i++){
    3cfc:	03400d93          	li	s11,52
    3d00:	a0ed                	j	3dea <fourfiles+0x18c>
      printf("%s: fork failed\n", s);
    3d02:	85e6                	mv	a1,s9
    3d04:	00002517          	auipc	a0,0x2
    3d08:	c5450513          	addi	a0,a0,-940 # 5958 <malloc+0x9c0>
    3d0c:	1d8010ef          	jal	4ee4 <printf>
      exit(1);
    3d10:	4505                	li	a0,1
    3d12:	585000ef          	jal	4a96 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3d16:	20200593          	li	a1,514
    3d1a:	854e                	mv	a0,s3
    3d1c:	5bb000ef          	jal	4ad6 <open>
    3d20:	892a                	mv	s2,a0
      if(fd < 0){
    3d22:	04054163          	bltz	a0,3d64 <fourfiles+0x106>
      memset(buf, '0'+pi, SZ);
    3d26:	1f400613          	li	a2,500
    3d2a:	0304859b          	addiw	a1,s1,48
    3d2e:	00009517          	auipc	a0,0x9
    3d32:	f4a50513          	addi	a0,a0,-182 # cc78 <buf>
    3d36:	365000ef          	jal	489a <memset>
    3d3a:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3d3c:	00009997          	auipc	s3,0x9
    3d40:	f3c98993          	addi	s3,s3,-196 # cc78 <buf>
    3d44:	1f400613          	li	a2,500
    3d48:	85ce                	mv	a1,s3
    3d4a:	854a                	mv	a0,s2
    3d4c:	56b000ef          	jal	4ab6 <write>
    3d50:	85aa                	mv	a1,a0
    3d52:	1f400793          	li	a5,500
    3d56:	02f51163          	bne	a0,a5,3d78 <fourfiles+0x11a>
      for(i = 0; i < N; i++){
    3d5a:	34fd                	addiw	s1,s1,-1
    3d5c:	f4e5                	bnez	s1,3d44 <fourfiles+0xe6>
      exit(0);
    3d5e:	4501                	li	a0,0
    3d60:	537000ef          	jal	4a96 <exit>
        printf("%s: create failed\n", s);
    3d64:	85e6                	mv	a1,s9
    3d66:	00002517          	auipc	a0,0x2
    3d6a:	c8a50513          	addi	a0,a0,-886 # 59f0 <malloc+0xa58>
    3d6e:	176010ef          	jal	4ee4 <printf>
        exit(1);
    3d72:	4505                	li	a0,1
    3d74:	523000ef          	jal	4a96 <exit>
          printf("write failed %d\n", n);
    3d78:	00003517          	auipc	a0,0x3
    3d7c:	f6050513          	addi	a0,a0,-160 # 6cd8 <malloc+0x1d40>
    3d80:	164010ef          	jal	4ee4 <printf>
          exit(1);
    3d84:	4505                	li	a0,1
    3d86:	511000ef          	jal	4a96 <exit>
      exit(xstatus);
    3d8a:	8556                	mv	a0,s5
    3d8c:	50b000ef          	jal	4a96 <exit>
          printf("%s: wrong char\n", s);
    3d90:	85e6                	mv	a1,s9
    3d92:	00003517          	auipc	a0,0x3
    3d96:	f5e50513          	addi	a0,a0,-162 # 6cf0 <malloc+0x1d58>
    3d9a:	14a010ef          	jal	4ee4 <printf>
          exit(1);
    3d9e:	4505                	li	a0,1
    3da0:	4f7000ef          	jal	4a96 <exit>
      total += n;
    3da4:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3da8:	660d                	lui	a2,0x3
    3daa:	85d2                	mv	a1,s4
    3dac:	854e                	mv	a0,s3
    3dae:	501000ef          	jal	4aae <read>
    3db2:	02a05063          	blez	a0,3dd2 <fourfiles+0x174>
    3db6:	00009797          	auipc	a5,0x9
    3dba:	ec278793          	addi	a5,a5,-318 # cc78 <buf>
    3dbe:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    3dc2:	0007c703          	lbu	a4,0(a5)
    3dc6:	fc9715e3          	bne	a4,s1,3d90 <fourfiles+0x132>
      for(j = 0; j < n; j++){
    3dca:	0785                	addi	a5,a5,1
    3dcc:	fed79be3          	bne	a5,a3,3dc2 <fourfiles+0x164>
    3dd0:	bfd1                	j	3da4 <fourfiles+0x146>
    close(fd);
    3dd2:	854e                	mv	a0,s3
    3dd4:	4eb000ef          	jal	4abe <close>
    if(total != N*SZ){
    3dd8:	03a91463          	bne	s2,s10,3e00 <fourfiles+0x1a2>
    unlink(fname);
    3ddc:	8562                	mv	a0,s8
    3dde:	509000ef          	jal	4ae6 <unlink>
  for(i = 0; i < NCHILD; i++){
    3de2:	0ba1                	addi	s7,s7,8
    3de4:	2b05                	addiw	s6,s6,1
    3de6:	03bb0763          	beq	s6,s11,3e14 <fourfiles+0x1b6>
    fname = names[i];
    3dea:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    3dee:	4581                	li	a1,0
    3df0:	8562                	mv	a0,s8
    3df2:	4e5000ef          	jal	4ad6 <open>
    3df6:	89aa                	mv	s3,a0
    total = 0;
    3df8:	8956                	mv	s2,s5
        if(buf[j] != '0'+i){
    3dfa:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3dfe:	b76d                	j	3da8 <fourfiles+0x14a>
      printf("wrong length %d\n", total);
    3e00:	85ca                	mv	a1,s2
    3e02:	00003517          	auipc	a0,0x3
    3e06:	efe50513          	addi	a0,a0,-258 # 6d00 <malloc+0x1d68>
    3e0a:	0da010ef          	jal	4ee4 <printf>
      exit(1);
    3e0e:	4505                	li	a0,1
    3e10:	487000ef          	jal	4a96 <exit>
}
    3e14:	60ea                	ld	ra,152(sp)
    3e16:	644a                	ld	s0,144(sp)
    3e18:	64aa                	ld	s1,136(sp)
    3e1a:	690a                	ld	s2,128(sp)
    3e1c:	79e6                	ld	s3,120(sp)
    3e1e:	7a46                	ld	s4,112(sp)
    3e20:	7aa6                	ld	s5,104(sp)
    3e22:	7b06                	ld	s6,96(sp)
    3e24:	6be6                	ld	s7,88(sp)
    3e26:	6c46                	ld	s8,80(sp)
    3e28:	6ca6                	ld	s9,72(sp)
    3e2a:	6d06                	ld	s10,64(sp)
    3e2c:	7de2                	ld	s11,56(sp)
    3e2e:	610d                	addi	sp,sp,160
    3e30:	8082                	ret

0000000000003e32 <concreate>:
{
    3e32:	7135                	addi	sp,sp,-160
    3e34:	ed06                	sd	ra,152(sp)
    3e36:	e922                	sd	s0,144(sp)
    3e38:	e526                	sd	s1,136(sp)
    3e3a:	e14a                	sd	s2,128(sp)
    3e3c:	fcce                	sd	s3,120(sp)
    3e3e:	f8d2                	sd	s4,112(sp)
    3e40:	f4d6                	sd	s5,104(sp)
    3e42:	f0da                	sd	s6,96(sp)
    3e44:	ecde                	sd	s7,88(sp)
    3e46:	1100                	addi	s0,sp,160
    3e48:	89aa                	mv	s3,a0
  file[0] = 'C';
    3e4a:	04300793          	li	a5,67
    3e4e:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    3e52:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    3e56:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    3e58:	4b0d                	li	s6,3
    3e5a:	4a85                	li	s5,1
      link("C0", file);
    3e5c:	00003b97          	auipc	s7,0x3
    3e60:	ebcb8b93          	addi	s7,s7,-324 # 6d18 <malloc+0x1d80>
  for(i = 0; i < N; i++){
    3e64:	02800a13          	li	s4,40
    3e68:	a41d                	j	408e <concreate+0x25c>
      link("C0", file);
    3e6a:	fa840593          	addi	a1,s0,-88
    3e6e:	855e                	mv	a0,s7
    3e70:	487000ef          	jal	4af6 <link>
    if(pid == 0) {
    3e74:	a411                	j	4078 <concreate+0x246>
    } else if(pid == 0 && (i % 5) == 1){
    3e76:	4795                	li	a5,5
    3e78:	02f9693b          	remw	s2,s2,a5
    3e7c:	4785                	li	a5,1
    3e7e:	02f90563          	beq	s2,a5,3ea8 <concreate+0x76>
      fd = open(file, O_CREATE | O_RDWR);
    3e82:	20200593          	li	a1,514
    3e86:	fa840513          	addi	a0,s0,-88
    3e8a:	44d000ef          	jal	4ad6 <open>
      if(fd < 0){
    3e8e:	1e055063          	bgez	a0,406e <concreate+0x23c>
        printf("concreate create %s failed\n", file);
    3e92:	fa840593          	addi	a1,s0,-88
    3e96:	00003517          	auipc	a0,0x3
    3e9a:	e8a50513          	addi	a0,a0,-374 # 6d20 <malloc+0x1d88>
    3e9e:	046010ef          	jal	4ee4 <printf>
        exit(1);
    3ea2:	4505                	li	a0,1
    3ea4:	3f3000ef          	jal	4a96 <exit>
      link("C0", file);
    3ea8:	fa840593          	addi	a1,s0,-88
    3eac:	00003517          	auipc	a0,0x3
    3eb0:	e6c50513          	addi	a0,a0,-404 # 6d18 <malloc+0x1d80>
    3eb4:	443000ef          	jal	4af6 <link>
      exit(0);
    3eb8:	4501                	li	a0,0
    3eba:	3dd000ef          	jal	4a96 <exit>
        exit(1);
    3ebe:	4505                	li	a0,1
    3ec0:	3d7000ef          	jal	4a96 <exit>
  memset(fa, 0, sizeof(fa));
    3ec4:	02800613          	li	a2,40
    3ec8:	4581                	li	a1,0
    3eca:	f8040513          	addi	a0,s0,-128
    3ece:	1cd000ef          	jal	489a <memset>
  fd = open(".", 0);
    3ed2:	4581                	li	a1,0
    3ed4:	00002517          	auipc	a0,0x2
    3ed8:	8dc50513          	addi	a0,a0,-1828 # 57b0 <malloc+0x818>
    3edc:	3fb000ef          	jal	4ad6 <open>
    3ee0:	892a                	mv	s2,a0
  n = 0;
    3ee2:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3ee4:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    3ee8:	02700b13          	li	s6,39
      fa[i] = 1;
    3eec:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    3eee:	4641                	li	a2,16
    3ef0:	f7040593          	addi	a1,s0,-144
    3ef4:	854a                	mv	a0,s2
    3ef6:	3b9000ef          	jal	4aae <read>
    3efa:	06a05a63          	blez	a0,3f6e <concreate+0x13c>
    if(de.inum == 0)
    3efe:	f7045783          	lhu	a5,-144(s0)
    3f02:	d7f5                	beqz	a5,3eee <concreate+0xbc>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3f04:	f7244783          	lbu	a5,-142(s0)
    3f08:	ff4793e3          	bne	a5,s4,3eee <concreate+0xbc>
    3f0c:	f7444783          	lbu	a5,-140(s0)
    3f10:	fff9                	bnez	a5,3eee <concreate+0xbc>
      i = de.name[1] - '0';
    3f12:	f7344783          	lbu	a5,-141(s0)
    3f16:	fd07879b          	addiw	a5,a5,-48
    3f1a:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    3f1e:	02eb6063          	bltu	s6,a4,3f3e <concreate+0x10c>
      if(fa[i]){
    3f22:	fb070793          	addi	a5,a4,-80 # fb0 <bigdir+0x112>
    3f26:	97a2                	add	a5,a5,s0
    3f28:	fd07c783          	lbu	a5,-48(a5)
    3f2c:	e78d                	bnez	a5,3f56 <concreate+0x124>
      fa[i] = 1;
    3f2e:	fb070793          	addi	a5,a4,-80
    3f32:	00878733          	add	a4,a5,s0
    3f36:	fd770823          	sb	s7,-48(a4)
      n++;
    3f3a:	2a85                	addiw	s5,s5,1
    3f3c:	bf4d                	j	3eee <concreate+0xbc>
        printf("%s: concreate weird file %s\n", s, de.name);
    3f3e:	f7240613          	addi	a2,s0,-142
    3f42:	85ce                	mv	a1,s3
    3f44:	00003517          	auipc	a0,0x3
    3f48:	dfc50513          	addi	a0,a0,-516 # 6d40 <malloc+0x1da8>
    3f4c:	799000ef          	jal	4ee4 <printf>
        exit(1);
    3f50:	4505                	li	a0,1
    3f52:	345000ef          	jal	4a96 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    3f56:	f7240613          	addi	a2,s0,-142
    3f5a:	85ce                	mv	a1,s3
    3f5c:	00003517          	auipc	a0,0x3
    3f60:	e0450513          	addi	a0,a0,-508 # 6d60 <malloc+0x1dc8>
    3f64:	781000ef          	jal	4ee4 <printf>
        exit(1);
    3f68:	4505                	li	a0,1
    3f6a:	32d000ef          	jal	4a96 <exit>
  close(fd);
    3f6e:	854a                	mv	a0,s2
    3f70:	34f000ef          	jal	4abe <close>
  if(n != N){
    3f74:	02800793          	li	a5,40
    3f78:	00fa9763          	bne	s5,a5,3f86 <concreate+0x154>
    if(((i % 3) == 0 && pid == 0) ||
    3f7c:	4a8d                	li	s5,3
    3f7e:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    3f80:	02800a13          	li	s4,40
    3f84:	a079                	j	4012 <concreate+0x1e0>
    printf("%s: concreate not enough files in directory listing\n", s);
    3f86:	85ce                	mv	a1,s3
    3f88:	00003517          	auipc	a0,0x3
    3f8c:	e0050513          	addi	a0,a0,-512 # 6d88 <malloc+0x1df0>
    3f90:	755000ef          	jal	4ee4 <printf>
    exit(1);
    3f94:	4505                	li	a0,1
    3f96:	301000ef          	jal	4a96 <exit>
      printf("%s: fork failed\n", s);
    3f9a:	85ce                	mv	a1,s3
    3f9c:	00002517          	auipc	a0,0x2
    3fa0:	9bc50513          	addi	a0,a0,-1604 # 5958 <malloc+0x9c0>
    3fa4:	741000ef          	jal	4ee4 <printf>
      exit(1);
    3fa8:	4505                	li	a0,1
    3faa:	2ed000ef          	jal	4a96 <exit>
      close(open(file, 0));
    3fae:	4581                	li	a1,0
    3fb0:	fa840513          	addi	a0,s0,-88
    3fb4:	323000ef          	jal	4ad6 <open>
    3fb8:	307000ef          	jal	4abe <close>
      close(open(file, 0));
    3fbc:	4581                	li	a1,0
    3fbe:	fa840513          	addi	a0,s0,-88
    3fc2:	315000ef          	jal	4ad6 <open>
    3fc6:	2f9000ef          	jal	4abe <close>
      close(open(file, 0));
    3fca:	4581                	li	a1,0
    3fcc:	fa840513          	addi	a0,s0,-88
    3fd0:	307000ef          	jal	4ad6 <open>
    3fd4:	2eb000ef          	jal	4abe <close>
      close(open(file, 0));
    3fd8:	4581                	li	a1,0
    3fda:	fa840513          	addi	a0,s0,-88
    3fde:	2f9000ef          	jal	4ad6 <open>
    3fe2:	2dd000ef          	jal	4abe <close>
      close(open(file, 0));
    3fe6:	4581                	li	a1,0
    3fe8:	fa840513          	addi	a0,s0,-88
    3fec:	2eb000ef          	jal	4ad6 <open>
    3ff0:	2cf000ef          	jal	4abe <close>
      close(open(file, 0));
    3ff4:	4581                	li	a1,0
    3ff6:	fa840513          	addi	a0,s0,-88
    3ffa:	2dd000ef          	jal	4ad6 <open>
    3ffe:	2c1000ef          	jal	4abe <close>
    if(pid == 0)
    4002:	06090363          	beqz	s2,4068 <concreate+0x236>
      wait(0);
    4006:	4501                	li	a0,0
    4008:	297000ef          	jal	4a9e <wait>
  for(i = 0; i < N; i++){
    400c:	2485                	addiw	s1,s1,1
    400e:	0b448963          	beq	s1,s4,40c0 <concreate+0x28e>
    file[1] = '0' + i;
    4012:	0304879b          	addiw	a5,s1,48
    4016:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    401a:	275000ef          	jal	4a8e <fork>
    401e:	892a                	mv	s2,a0
    if(pid < 0){
    4020:	f6054de3          	bltz	a0,3f9a <concreate+0x168>
    if(((i % 3) == 0 && pid == 0) ||
    4024:	0354e73b          	remw	a4,s1,s5
    4028:	00a767b3          	or	a5,a4,a0
    402c:	2781                	sext.w	a5,a5
    402e:	d3c1                	beqz	a5,3fae <concreate+0x17c>
    4030:	01671363          	bne	a4,s6,4036 <concreate+0x204>
       ((i % 3) == 1 && pid != 0)){
    4034:	fd2d                	bnez	a0,3fae <concreate+0x17c>
      unlink(file);
    4036:	fa840513          	addi	a0,s0,-88
    403a:	2ad000ef          	jal	4ae6 <unlink>
      unlink(file);
    403e:	fa840513          	addi	a0,s0,-88
    4042:	2a5000ef          	jal	4ae6 <unlink>
      unlink(file);
    4046:	fa840513          	addi	a0,s0,-88
    404a:	29d000ef          	jal	4ae6 <unlink>
      unlink(file);
    404e:	fa840513          	addi	a0,s0,-88
    4052:	295000ef          	jal	4ae6 <unlink>
      unlink(file);
    4056:	fa840513          	addi	a0,s0,-88
    405a:	28d000ef          	jal	4ae6 <unlink>
      unlink(file);
    405e:	fa840513          	addi	a0,s0,-88
    4062:	285000ef          	jal	4ae6 <unlink>
    4066:	bf71                	j	4002 <concreate+0x1d0>
      exit(0);
    4068:	4501                	li	a0,0
    406a:	22d000ef          	jal	4a96 <exit>
      close(fd);
    406e:	251000ef          	jal	4abe <close>
    if(pid == 0) {
    4072:	b599                	j	3eb8 <concreate+0x86>
      close(fd);
    4074:	24b000ef          	jal	4abe <close>
      wait(&xstatus);
    4078:	f6c40513          	addi	a0,s0,-148
    407c:	223000ef          	jal	4a9e <wait>
      if(xstatus != 0)
    4080:	f6c42483          	lw	s1,-148(s0)
    4084:	e2049de3          	bnez	s1,3ebe <concreate+0x8c>
  for(i = 0; i < N; i++){
    4088:	2905                	addiw	s2,s2,1
    408a:	e3490de3          	beq	s2,s4,3ec4 <concreate+0x92>
    file[1] = '0' + i;
    408e:	0309079b          	addiw	a5,s2,48
    4092:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    4096:	fa840513          	addi	a0,s0,-88
    409a:	24d000ef          	jal	4ae6 <unlink>
    pid = fork();
    409e:	1f1000ef          	jal	4a8e <fork>
    if(pid && (i % 3) == 1){
    40a2:	dc050ae3          	beqz	a0,3e76 <concreate+0x44>
    40a6:	036967bb          	remw	a5,s2,s6
    40aa:	dd5780e3          	beq	a5,s5,3e6a <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    40ae:	20200593          	li	a1,514
    40b2:	fa840513          	addi	a0,s0,-88
    40b6:	221000ef          	jal	4ad6 <open>
      if(fd < 0){
    40ba:	fa055de3          	bgez	a0,4074 <concreate+0x242>
    40be:	bbd1                	j	3e92 <concreate+0x60>
}
    40c0:	60ea                	ld	ra,152(sp)
    40c2:	644a                	ld	s0,144(sp)
    40c4:	64aa                	ld	s1,136(sp)
    40c6:	690a                	ld	s2,128(sp)
    40c8:	79e6                	ld	s3,120(sp)
    40ca:	7a46                	ld	s4,112(sp)
    40cc:	7aa6                	ld	s5,104(sp)
    40ce:	7b06                	ld	s6,96(sp)
    40d0:	6be6                	ld	s7,88(sp)
    40d2:	610d                	addi	sp,sp,160
    40d4:	8082                	ret

00000000000040d6 <bigfile>:
{
    40d6:	7139                	addi	sp,sp,-64
    40d8:	fc06                	sd	ra,56(sp)
    40da:	f822                	sd	s0,48(sp)
    40dc:	f426                	sd	s1,40(sp)
    40de:	f04a                	sd	s2,32(sp)
    40e0:	ec4e                	sd	s3,24(sp)
    40e2:	e852                	sd	s4,16(sp)
    40e4:	e456                	sd	s5,8(sp)
    40e6:	0080                	addi	s0,sp,64
    40e8:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    40ea:	00003517          	auipc	a0,0x3
    40ee:	cd650513          	addi	a0,a0,-810 # 6dc0 <malloc+0x1e28>
    40f2:	1f5000ef          	jal	4ae6 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    40f6:	20200593          	li	a1,514
    40fa:	00003517          	auipc	a0,0x3
    40fe:	cc650513          	addi	a0,a0,-826 # 6dc0 <malloc+0x1e28>
    4102:	1d5000ef          	jal	4ad6 <open>
    4106:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    4108:	4481                	li	s1,0
    memset(buf, i, SZ);
    410a:	00009917          	auipc	s2,0x9
    410e:	b6e90913          	addi	s2,s2,-1170 # cc78 <buf>
  for(i = 0; i < N; i++){
    4112:	4a51                	li	s4,20
  if(fd < 0){
    4114:	08054663          	bltz	a0,41a0 <bigfile+0xca>
    memset(buf, i, SZ);
    4118:	25800613          	li	a2,600
    411c:	85a6                	mv	a1,s1
    411e:	854a                	mv	a0,s2
    4120:	77a000ef          	jal	489a <memset>
    if(write(fd, buf, SZ) != SZ){
    4124:	25800613          	li	a2,600
    4128:	85ca                	mv	a1,s2
    412a:	854e                	mv	a0,s3
    412c:	18b000ef          	jal	4ab6 <write>
    4130:	25800793          	li	a5,600
    4134:	08f51063          	bne	a0,a5,41b4 <bigfile+0xde>
  for(i = 0; i < N; i++){
    4138:	2485                	addiw	s1,s1,1
    413a:	fd449fe3          	bne	s1,s4,4118 <bigfile+0x42>
  close(fd);
    413e:	854e                	mv	a0,s3
    4140:	17f000ef          	jal	4abe <close>
  fd = open("bigfile.dat", 0);
    4144:	4581                	li	a1,0
    4146:	00003517          	auipc	a0,0x3
    414a:	c7a50513          	addi	a0,a0,-902 # 6dc0 <malloc+0x1e28>
    414e:	189000ef          	jal	4ad6 <open>
    4152:	8a2a                	mv	s4,a0
  total = 0;
    4154:	4981                	li	s3,0
  for(i = 0; ; i++){
    4156:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4158:	00009917          	auipc	s2,0x9
    415c:	b2090913          	addi	s2,s2,-1248 # cc78 <buf>
  if(fd < 0){
    4160:	06054463          	bltz	a0,41c8 <bigfile+0xf2>
    cc = read(fd, buf, SZ/2);
    4164:	12c00613          	li	a2,300
    4168:	85ca                	mv	a1,s2
    416a:	8552                	mv	a0,s4
    416c:	143000ef          	jal	4aae <read>
    if(cc < 0){
    4170:	06054663          	bltz	a0,41dc <bigfile+0x106>
    if(cc == 0)
    4174:	c155                	beqz	a0,4218 <bigfile+0x142>
    if(cc != SZ/2){
    4176:	12c00793          	li	a5,300
    417a:	06f51b63          	bne	a0,a5,41f0 <bigfile+0x11a>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    417e:	01f4d79b          	srliw	a5,s1,0x1f
    4182:	9fa5                	addw	a5,a5,s1
    4184:	4017d79b          	sraiw	a5,a5,0x1
    4188:	00094703          	lbu	a4,0(s2)
    418c:	06f71c63          	bne	a4,a5,4204 <bigfile+0x12e>
    4190:	12b94703          	lbu	a4,299(s2)
    4194:	06f71863          	bne	a4,a5,4204 <bigfile+0x12e>
    total += cc;
    4198:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    419c:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    419e:	b7d9                	j	4164 <bigfile+0x8e>
    printf("%s: cannot create bigfile", s);
    41a0:	85d6                	mv	a1,s5
    41a2:	00003517          	auipc	a0,0x3
    41a6:	c2e50513          	addi	a0,a0,-978 # 6dd0 <malloc+0x1e38>
    41aa:	53b000ef          	jal	4ee4 <printf>
    exit(1);
    41ae:	4505                	li	a0,1
    41b0:	0e7000ef          	jal	4a96 <exit>
      printf("%s: write bigfile failed\n", s);
    41b4:	85d6                	mv	a1,s5
    41b6:	00003517          	auipc	a0,0x3
    41ba:	c3a50513          	addi	a0,a0,-966 # 6df0 <malloc+0x1e58>
    41be:	527000ef          	jal	4ee4 <printf>
      exit(1);
    41c2:	4505                	li	a0,1
    41c4:	0d3000ef          	jal	4a96 <exit>
    printf("%s: cannot open bigfile\n", s);
    41c8:	85d6                	mv	a1,s5
    41ca:	00003517          	auipc	a0,0x3
    41ce:	c4650513          	addi	a0,a0,-954 # 6e10 <malloc+0x1e78>
    41d2:	513000ef          	jal	4ee4 <printf>
    exit(1);
    41d6:	4505                	li	a0,1
    41d8:	0bf000ef          	jal	4a96 <exit>
      printf("%s: read bigfile failed\n", s);
    41dc:	85d6                	mv	a1,s5
    41de:	00003517          	auipc	a0,0x3
    41e2:	c5250513          	addi	a0,a0,-942 # 6e30 <malloc+0x1e98>
    41e6:	4ff000ef          	jal	4ee4 <printf>
      exit(1);
    41ea:	4505                	li	a0,1
    41ec:	0ab000ef          	jal	4a96 <exit>
      printf("%s: short read bigfile\n", s);
    41f0:	85d6                	mv	a1,s5
    41f2:	00003517          	auipc	a0,0x3
    41f6:	c5e50513          	addi	a0,a0,-930 # 6e50 <malloc+0x1eb8>
    41fa:	4eb000ef          	jal	4ee4 <printf>
      exit(1);
    41fe:	4505                	li	a0,1
    4200:	097000ef          	jal	4a96 <exit>
      printf("%s: read bigfile wrong data\n", s);
    4204:	85d6                	mv	a1,s5
    4206:	00003517          	auipc	a0,0x3
    420a:	c6250513          	addi	a0,a0,-926 # 6e68 <malloc+0x1ed0>
    420e:	4d7000ef          	jal	4ee4 <printf>
      exit(1);
    4212:	4505                	li	a0,1
    4214:	083000ef          	jal	4a96 <exit>
  close(fd);
    4218:	8552                	mv	a0,s4
    421a:	0a5000ef          	jal	4abe <close>
  if(total != N*SZ){
    421e:	678d                	lui	a5,0x3
    4220:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x304>
    4224:	02f99163          	bne	s3,a5,4246 <bigfile+0x170>
  unlink("bigfile.dat");
    4228:	00003517          	auipc	a0,0x3
    422c:	b9850513          	addi	a0,a0,-1128 # 6dc0 <malloc+0x1e28>
    4230:	0b7000ef          	jal	4ae6 <unlink>
}
    4234:	70e2                	ld	ra,56(sp)
    4236:	7442                	ld	s0,48(sp)
    4238:	74a2                	ld	s1,40(sp)
    423a:	7902                	ld	s2,32(sp)
    423c:	69e2                	ld	s3,24(sp)
    423e:	6a42                	ld	s4,16(sp)
    4240:	6aa2                	ld	s5,8(sp)
    4242:	6121                	addi	sp,sp,64
    4244:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    4246:	85d6                	mv	a1,s5
    4248:	00003517          	auipc	a0,0x3
    424c:	c4050513          	addi	a0,a0,-960 # 6e88 <malloc+0x1ef0>
    4250:	495000ef          	jal	4ee4 <printf>
    exit(1);
    4254:	4505                	li	a0,1
    4256:	041000ef          	jal	4a96 <exit>

000000000000425a <bigargtest>:
{
    425a:	7121                	addi	sp,sp,-448
    425c:	ff06                	sd	ra,440(sp)
    425e:	fb22                	sd	s0,432(sp)
    4260:	f726                	sd	s1,424(sp)
    4262:	0380                	addi	s0,sp,448
    4264:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    4266:	00003517          	auipc	a0,0x3
    426a:	c4250513          	addi	a0,a0,-958 # 6ea8 <malloc+0x1f10>
    426e:	079000ef          	jal	4ae6 <unlink>
  pid = fork();
    4272:	01d000ef          	jal	4a8e <fork>
  if(pid == 0){
    4276:	c915                	beqz	a0,42aa <bigargtest+0x50>
  } else if(pid < 0){
    4278:	08054a63          	bltz	a0,430c <bigargtest+0xb2>
  wait(&xstatus);
    427c:	fdc40513          	addi	a0,s0,-36
    4280:	01f000ef          	jal	4a9e <wait>
  if(xstatus != 0)
    4284:	fdc42503          	lw	a0,-36(s0)
    4288:	ed41                	bnez	a0,4320 <bigargtest+0xc6>
  fd = open("bigarg-ok", 0);
    428a:	4581                	li	a1,0
    428c:	00003517          	auipc	a0,0x3
    4290:	c1c50513          	addi	a0,a0,-996 # 6ea8 <malloc+0x1f10>
    4294:	043000ef          	jal	4ad6 <open>
  if(fd < 0){
    4298:	08054663          	bltz	a0,4324 <bigargtest+0xca>
  close(fd);
    429c:	023000ef          	jal	4abe <close>
}
    42a0:	70fa                	ld	ra,440(sp)
    42a2:	745a                	ld	s0,432(sp)
    42a4:	74ba                	ld	s1,424(sp)
    42a6:	6139                	addi	sp,sp,448
    42a8:	8082                	ret
    memset(big, ' ', sizeof(big));
    42aa:	19000613          	li	a2,400
    42ae:	02000593          	li	a1,32
    42b2:	e4840513          	addi	a0,s0,-440
    42b6:	5e4000ef          	jal	489a <memset>
    big[sizeof(big)-1] = '\0';
    42ba:	fc040ba3          	sb	zero,-41(s0)
    for(i = 0; i < MAXARG-1; i++)
    42be:	00005797          	auipc	a5,0x5
    42c2:	1a278793          	addi	a5,a5,418 # 9460 <args.1>
    42c6:	00005697          	auipc	a3,0x5
    42ca:	29268693          	addi	a3,a3,658 # 9558 <args.1+0xf8>
      args[i] = big;
    42ce:	e4840713          	addi	a4,s0,-440
    42d2:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    42d4:	07a1                	addi	a5,a5,8
    42d6:	fed79ee3          	bne	a5,a3,42d2 <bigargtest+0x78>
    args[MAXARG-1] = 0;
    42da:	00005597          	auipc	a1,0x5
    42de:	18658593          	addi	a1,a1,390 # 9460 <args.1>
    42e2:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    42e6:	00001517          	auipc	a0,0x1
    42ea:	de250513          	addi	a0,a0,-542 # 50c8 <malloc+0x130>
    42ee:	7e0000ef          	jal	4ace <exec>
    fd = open("bigarg-ok", O_CREATE);
    42f2:	20000593          	li	a1,512
    42f6:	00003517          	auipc	a0,0x3
    42fa:	bb250513          	addi	a0,a0,-1102 # 6ea8 <malloc+0x1f10>
    42fe:	7d8000ef          	jal	4ad6 <open>
    close(fd);
    4302:	7bc000ef          	jal	4abe <close>
    exit(0);
    4306:	4501                	li	a0,0
    4308:	78e000ef          	jal	4a96 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    430c:	85a6                	mv	a1,s1
    430e:	00003517          	auipc	a0,0x3
    4312:	baa50513          	addi	a0,a0,-1110 # 6eb8 <malloc+0x1f20>
    4316:	3cf000ef          	jal	4ee4 <printf>
    exit(1);
    431a:	4505                	li	a0,1
    431c:	77a000ef          	jal	4a96 <exit>
    exit(xstatus);
    4320:	776000ef          	jal	4a96 <exit>
    printf("%s: bigarg test failed!\n", s);
    4324:	85a6                	mv	a1,s1
    4326:	00003517          	auipc	a0,0x3
    432a:	bb250513          	addi	a0,a0,-1102 # 6ed8 <malloc+0x1f40>
    432e:	3b7000ef          	jal	4ee4 <printf>
    exit(1);
    4332:	4505                	li	a0,1
    4334:	762000ef          	jal	4a96 <exit>

0000000000004338 <fsfull>:
{
    4338:	7135                	addi	sp,sp,-160
    433a:	ed06                	sd	ra,152(sp)
    433c:	e922                	sd	s0,144(sp)
    433e:	e526                	sd	s1,136(sp)
    4340:	e14a                	sd	s2,128(sp)
    4342:	fcce                	sd	s3,120(sp)
    4344:	f8d2                	sd	s4,112(sp)
    4346:	f4d6                	sd	s5,104(sp)
    4348:	f0da                	sd	s6,96(sp)
    434a:	ecde                	sd	s7,88(sp)
    434c:	e8e2                	sd	s8,80(sp)
    434e:	e4e6                	sd	s9,72(sp)
    4350:	e0ea                	sd	s10,64(sp)
    4352:	1100                	addi	s0,sp,160
  printf("fsfull test\n");
    4354:	00003517          	auipc	a0,0x3
    4358:	ba450513          	addi	a0,a0,-1116 # 6ef8 <malloc+0x1f60>
    435c:	389000ef          	jal	4ee4 <printf>
  for(nfiles = 0; ; nfiles++){
    4360:	4481                	li	s1,0
    name[0] = 'f';
    4362:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    4366:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    436a:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    436e:	4b29                	li	s6,10
    printf("writing %s\n", name);
    4370:	00003c97          	auipc	s9,0x3
    4374:	b98c8c93          	addi	s9,s9,-1128 # 6f08 <malloc+0x1f70>
    name[0] = 'f';
    4378:	f7a40023          	sb	s10,-160(s0)
    name[1] = '0' + nfiles / 1000;
    437c:	0384c7bb          	divw	a5,s1,s8
    4380:	0307879b          	addiw	a5,a5,48
    4384:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4388:	0384e7bb          	remw	a5,s1,s8
    438c:	0377c7bb          	divw	a5,a5,s7
    4390:	0307879b          	addiw	a5,a5,48
    4394:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4398:	0374e7bb          	remw	a5,s1,s7
    439c:	0367c7bb          	divw	a5,a5,s6
    43a0:	0307879b          	addiw	a5,a5,48
    43a4:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    43a8:	0364e7bb          	remw	a5,s1,s6
    43ac:	0307879b          	addiw	a5,a5,48
    43b0:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    43b4:	f60402a3          	sb	zero,-155(s0)
    printf("writing %s\n", name);
    43b8:	f6040593          	addi	a1,s0,-160
    43bc:	8566                	mv	a0,s9
    43be:	327000ef          	jal	4ee4 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    43c2:	20200593          	li	a1,514
    43c6:	f6040513          	addi	a0,s0,-160
    43ca:	70c000ef          	jal	4ad6 <open>
    43ce:	892a                	mv	s2,a0
    if(fd < 0){
    43d0:	08055f63          	bgez	a0,446e <fsfull+0x136>
      printf("open %s failed\n", name);
    43d4:	f6040593          	addi	a1,s0,-160
    43d8:	00003517          	auipc	a0,0x3
    43dc:	b4050513          	addi	a0,a0,-1216 # 6f18 <malloc+0x1f80>
    43e0:	305000ef          	jal	4ee4 <printf>
  while(nfiles >= 0){
    43e4:	0604c163          	bltz	s1,4446 <fsfull+0x10e>
    name[0] = 'f';
    43e8:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    43ec:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    43f0:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    43f4:	4929                	li	s2,10
  while(nfiles >= 0){
    43f6:	5afd                	li	s5,-1
    name[0] = 'f';
    43f8:	f7640023          	sb	s6,-160(s0)
    name[1] = '0' + nfiles / 1000;
    43fc:	0344c7bb          	divw	a5,s1,s4
    4400:	0307879b          	addiw	a5,a5,48
    4404:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4408:	0344e7bb          	remw	a5,s1,s4
    440c:	0337c7bb          	divw	a5,a5,s3
    4410:	0307879b          	addiw	a5,a5,48
    4414:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4418:	0334e7bb          	remw	a5,s1,s3
    441c:	0327c7bb          	divw	a5,a5,s2
    4420:	0307879b          	addiw	a5,a5,48
    4424:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    4428:	0324e7bb          	remw	a5,s1,s2
    442c:	0307879b          	addiw	a5,a5,48
    4430:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    4434:	f60402a3          	sb	zero,-155(s0)
    unlink(name);
    4438:	f6040513          	addi	a0,s0,-160
    443c:	6aa000ef          	jal	4ae6 <unlink>
    nfiles--;
    4440:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    4442:	fb549be3          	bne	s1,s5,43f8 <fsfull+0xc0>
  printf("fsfull test finished\n");
    4446:	00003517          	auipc	a0,0x3
    444a:	af250513          	addi	a0,a0,-1294 # 6f38 <malloc+0x1fa0>
    444e:	297000ef          	jal	4ee4 <printf>
}
    4452:	60ea                	ld	ra,152(sp)
    4454:	644a                	ld	s0,144(sp)
    4456:	64aa                	ld	s1,136(sp)
    4458:	690a                	ld	s2,128(sp)
    445a:	79e6                	ld	s3,120(sp)
    445c:	7a46                	ld	s4,112(sp)
    445e:	7aa6                	ld	s5,104(sp)
    4460:	7b06                	ld	s6,96(sp)
    4462:	6be6                	ld	s7,88(sp)
    4464:	6c46                	ld	s8,80(sp)
    4466:	6ca6                	ld	s9,72(sp)
    4468:	6d06                	ld	s10,64(sp)
    446a:	610d                	addi	sp,sp,160
    446c:	8082                	ret
    int total = 0;
    446e:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    4470:	00009a97          	auipc	s5,0x9
    4474:	808a8a93          	addi	s5,s5,-2040 # cc78 <buf>
      if(cc < BSIZE)
    4478:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    447c:	40000613          	li	a2,1024
    4480:	85d6                	mv	a1,s5
    4482:	854a                	mv	a0,s2
    4484:	632000ef          	jal	4ab6 <write>
      if(cc < BSIZE)
    4488:	00aa5563          	bge	s4,a0,4492 <fsfull+0x15a>
      total += cc;
    448c:	00a989bb          	addw	s3,s3,a0
    while(1){
    4490:	b7f5                	j	447c <fsfull+0x144>
    printf("wrote %d bytes\n", total);
    4492:	85ce                	mv	a1,s3
    4494:	00003517          	auipc	a0,0x3
    4498:	a9450513          	addi	a0,a0,-1388 # 6f28 <malloc+0x1f90>
    449c:	249000ef          	jal	4ee4 <printf>
    close(fd);
    44a0:	854a                	mv	a0,s2
    44a2:	61c000ef          	jal	4abe <close>
    if(total == 0)
    44a6:	f2098fe3          	beqz	s3,43e4 <fsfull+0xac>
  for(nfiles = 0; ; nfiles++){
    44aa:	2485                	addiw	s1,s1,1
    44ac:	b5f1                	j	4378 <fsfull+0x40>

00000000000044ae <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    44ae:	7179                	addi	sp,sp,-48
    44b0:	f406                	sd	ra,40(sp)
    44b2:	f022                	sd	s0,32(sp)
    44b4:	ec26                	sd	s1,24(sp)
    44b6:	e84a                	sd	s2,16(sp)
    44b8:	1800                	addi	s0,sp,48
    44ba:	84aa                	mv	s1,a0
    44bc:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    44be:	00003517          	auipc	a0,0x3
    44c2:	a9250513          	addi	a0,a0,-1390 # 6f50 <malloc+0x1fb8>
    44c6:	21f000ef          	jal	4ee4 <printf>
  if((pid = fork()) < 0) {
    44ca:	5c4000ef          	jal	4a8e <fork>
    44ce:	02054a63          	bltz	a0,4502 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    44d2:	c129                	beqz	a0,4514 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    44d4:	fdc40513          	addi	a0,s0,-36
    44d8:	5c6000ef          	jal	4a9e <wait>
    if(xstatus != 0) 
    44dc:	fdc42783          	lw	a5,-36(s0)
    44e0:	cf9d                	beqz	a5,451e <run+0x70>
      printf("FAILED\n");
    44e2:	00003517          	auipc	a0,0x3
    44e6:	a9650513          	addi	a0,a0,-1386 # 6f78 <malloc+0x1fe0>
    44ea:	1fb000ef          	jal	4ee4 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    44ee:	fdc42503          	lw	a0,-36(s0)
  }
}
    44f2:	00153513          	seqz	a0,a0
    44f6:	70a2                	ld	ra,40(sp)
    44f8:	7402                	ld	s0,32(sp)
    44fa:	64e2                	ld	s1,24(sp)
    44fc:	6942                	ld	s2,16(sp)
    44fe:	6145                	addi	sp,sp,48
    4500:	8082                	ret
    printf("runtest: fork error\n");
    4502:	00003517          	auipc	a0,0x3
    4506:	a5e50513          	addi	a0,a0,-1442 # 6f60 <malloc+0x1fc8>
    450a:	1db000ef          	jal	4ee4 <printf>
    exit(1);
    450e:	4505                	li	a0,1
    4510:	586000ef          	jal	4a96 <exit>
    f(s);
    4514:	854a                	mv	a0,s2
    4516:	9482                	jalr	s1
    exit(0);
    4518:	4501                	li	a0,0
    451a:	57c000ef          	jal	4a96 <exit>
      printf("OK\n");
    451e:	00003517          	auipc	a0,0x3
    4522:	a6250513          	addi	a0,a0,-1438 # 6f80 <malloc+0x1fe8>
    4526:	1bf000ef          	jal	4ee4 <printf>
    452a:	b7d1                	j	44ee <run+0x40>

000000000000452c <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    452c:	7139                	addi	sp,sp,-64
    452e:	fc06                	sd	ra,56(sp)
    4530:	f822                	sd	s0,48(sp)
    4532:	f04a                	sd	s2,32(sp)
    4534:	0080                	addi	s0,sp,64
  for (struct test *t = tests; t->s != 0; t++) {
    4536:	00853903          	ld	s2,8(a0)
    453a:	06090463          	beqz	s2,45a2 <runtests+0x76>
    453e:	f426                	sd	s1,40(sp)
    4540:	ec4e                	sd	s3,24(sp)
    4542:	e852                	sd	s4,16(sp)
    4544:	e456                	sd	s5,8(sp)
    4546:	84aa                	mv	s1,a0
    4548:	89ae                	mv	s3,a1
    454a:	8a32                	mv	s4,a2
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s)){
        if(continuous != 2){
    454c:	4a89                	li	s5,2
    454e:	a031                	j	455a <runtests+0x2e>
  for (struct test *t = tests; t->s != 0; t++) {
    4550:	04c1                	addi	s1,s1,16
    4552:	0084b903          	ld	s2,8(s1)
    4556:	02090c63          	beqz	s2,458e <runtests+0x62>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    455a:	00098763          	beqz	s3,4568 <runtests+0x3c>
    455e:	85ce                	mv	a1,s3
    4560:	854a                	mv	a0,s2
    4562:	2e2000ef          	jal	4844 <strcmp>
    4566:	f56d                	bnez	a0,4550 <runtests+0x24>
      if(!run(t->f, t->s)){
    4568:	85ca                	mv	a1,s2
    456a:	6088                	ld	a0,0(s1)
    456c:	f43ff0ef          	jal	44ae <run>
    4570:	f165                	bnez	a0,4550 <runtests+0x24>
        if(continuous != 2){
    4572:	fd5a0fe3          	beq	s4,s5,4550 <runtests+0x24>
          printf("SOME TESTS FAILED\n");
    4576:	00003517          	auipc	a0,0x3
    457a:	a1250513          	addi	a0,a0,-1518 # 6f88 <malloc+0x1ff0>
    457e:	167000ef          	jal	4ee4 <printf>
          return 1;
    4582:	4505                	li	a0,1
    4584:	74a2                	ld	s1,40(sp)
    4586:	69e2                	ld	s3,24(sp)
    4588:	6a42                	ld	s4,16(sp)
    458a:	6aa2                	ld	s5,8(sp)
    458c:	a031                	j	4598 <runtests+0x6c>
        }
      }
    }
  }
  return 0;
    458e:	4501                	li	a0,0
    4590:	74a2                	ld	s1,40(sp)
    4592:	69e2                	ld	s3,24(sp)
    4594:	6a42                	ld	s4,16(sp)
    4596:	6aa2                	ld	s5,8(sp)
}
    4598:	70e2                	ld	ra,56(sp)
    459a:	7442                	ld	s0,48(sp)
    459c:	7902                	ld	s2,32(sp)
    459e:	6121                	addi	sp,sp,64
    45a0:	8082                	ret
  return 0;
    45a2:	4501                	li	a0,0
    45a4:	bfd5                	j	4598 <runtests+0x6c>

00000000000045a6 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    45a6:	7139                	addi	sp,sp,-64
    45a8:	fc06                	sd	ra,56(sp)
    45aa:	f822                	sd	s0,48(sp)
    45ac:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    45ae:	fc840513          	addi	a0,s0,-56
    45b2:	4f4000ef          	jal	4aa6 <pipe>
    45b6:	04054e63          	bltz	a0,4612 <countfree+0x6c>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    45ba:	4d4000ef          	jal	4a8e <fork>

  if(pid < 0){
    45be:	06054663          	bltz	a0,462a <countfree+0x84>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    45c2:	e159                	bnez	a0,4648 <countfree+0xa2>
    45c4:	f426                	sd	s1,40(sp)
    45c6:	f04a                	sd	s2,32(sp)
    45c8:	ec4e                	sd	s3,24(sp)
    close(fds[0]);
    45ca:	fc842503          	lw	a0,-56(s0)
    45ce:	4f0000ef          	jal	4abe <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    45d2:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    45d4:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    45d6:	00001997          	auipc	s3,0x1
    45da:	b6298993          	addi	s3,s3,-1182 # 5138 <malloc+0x1a0>
      uint64 a = (uint64) sbrk(4096);
    45de:	6505                	lui	a0,0x1
    45e0:	53e000ef          	jal	4b1e <sbrk>
      if(a == 0xffffffffffffffff){
    45e4:	05250f63          	beq	a0,s2,4642 <countfree+0x9c>
      *(char *)(a + 4096 - 1) = 1;
    45e8:	6785                	lui	a5,0x1
    45ea:	97aa                	add	a5,a5,a0
    45ec:	fe978fa3          	sb	s1,-1(a5) # fff <pgbug+0x2b>
      if(write(fds[1], "x", 1) != 1){
    45f0:	8626                	mv	a2,s1
    45f2:	85ce                	mv	a1,s3
    45f4:	fcc42503          	lw	a0,-52(s0)
    45f8:	4be000ef          	jal	4ab6 <write>
    45fc:	fe9501e3          	beq	a0,s1,45de <countfree+0x38>
        printf("write() failed in countfree()\n");
    4600:	00003517          	auipc	a0,0x3
    4604:	9e050513          	addi	a0,a0,-1568 # 6fe0 <malloc+0x2048>
    4608:	0dd000ef          	jal	4ee4 <printf>
        exit(1);
    460c:	4505                	li	a0,1
    460e:	488000ef          	jal	4a96 <exit>
    4612:	f426                	sd	s1,40(sp)
    4614:	f04a                	sd	s2,32(sp)
    4616:	ec4e                	sd	s3,24(sp)
    printf("pipe() failed in countfree()\n");
    4618:	00003517          	auipc	a0,0x3
    461c:	98850513          	addi	a0,a0,-1656 # 6fa0 <malloc+0x2008>
    4620:	0c5000ef          	jal	4ee4 <printf>
    exit(1);
    4624:	4505                	li	a0,1
    4626:	470000ef          	jal	4a96 <exit>
    462a:	f426                	sd	s1,40(sp)
    462c:	f04a                	sd	s2,32(sp)
    462e:	ec4e                	sd	s3,24(sp)
    printf("fork failed in countfree()\n");
    4630:	00003517          	auipc	a0,0x3
    4634:	99050513          	addi	a0,a0,-1648 # 6fc0 <malloc+0x2028>
    4638:	0ad000ef          	jal	4ee4 <printf>
    exit(1);
    463c:	4505                	li	a0,1
    463e:	458000ef          	jal	4a96 <exit>
      }
    }

    exit(0);
    4642:	4501                	li	a0,0
    4644:	452000ef          	jal	4a96 <exit>
    4648:	f426                	sd	s1,40(sp)
  }

  close(fds[1]);
    464a:	fcc42503          	lw	a0,-52(s0)
    464e:	470000ef          	jal	4abe <close>

  int n = 0;
    4652:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    4654:	4605                	li	a2,1
    4656:	fc740593          	addi	a1,s0,-57
    465a:	fc842503          	lw	a0,-56(s0)
    465e:	450000ef          	jal	4aae <read>
    if(cc < 0){
    4662:	00054563          	bltz	a0,466c <countfree+0xc6>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    4666:	cd11                	beqz	a0,4682 <countfree+0xdc>
      break;
    n += 1;
    4668:	2485                	addiw	s1,s1,1
  while(1){
    466a:	b7ed                	j	4654 <countfree+0xae>
    466c:	f04a                	sd	s2,32(sp)
    466e:	ec4e                	sd	s3,24(sp)
      printf("read() failed in countfree()\n");
    4670:	00003517          	auipc	a0,0x3
    4674:	99050513          	addi	a0,a0,-1648 # 7000 <malloc+0x2068>
    4678:	06d000ef          	jal	4ee4 <printf>
      exit(1);
    467c:	4505                	li	a0,1
    467e:	418000ef          	jal	4a96 <exit>
  }

  close(fds[0]);
    4682:	fc842503          	lw	a0,-56(s0)
    4686:	438000ef          	jal	4abe <close>
  wait((int*)0);
    468a:	4501                	li	a0,0
    468c:	412000ef          	jal	4a9e <wait>
  
  return n;
}
    4690:	8526                	mv	a0,s1
    4692:	74a2                	ld	s1,40(sp)
    4694:	70e2                	ld	ra,56(sp)
    4696:	7442                	ld	s0,48(sp)
    4698:	6121                	addi	sp,sp,64
    469a:	8082                	ret

000000000000469c <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    469c:	711d                	addi	sp,sp,-96
    469e:	ec86                	sd	ra,88(sp)
    46a0:	e8a2                	sd	s0,80(sp)
    46a2:	e4a6                	sd	s1,72(sp)
    46a4:	e0ca                	sd	s2,64(sp)
    46a6:	fc4e                	sd	s3,56(sp)
    46a8:	f852                	sd	s4,48(sp)
    46aa:	f456                	sd	s5,40(sp)
    46ac:	f05a                	sd	s6,32(sp)
    46ae:	ec5e                	sd	s7,24(sp)
    46b0:	e862                	sd	s8,16(sp)
    46b2:	e466                	sd	s9,8(sp)
    46b4:	e06a                	sd	s10,0(sp)
    46b6:	1080                	addi	s0,sp,96
    46b8:	8aaa                	mv	s5,a0
    46ba:	892e                	mv	s2,a1
    46bc:	89b2                	mv	s3,a2
  do {
    printf("usertests starting\n");
    46be:	00003b97          	auipc	s7,0x3
    46c2:	962b8b93          	addi	s7,s7,-1694 # 7020 <malloc+0x2088>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone, continuous)) {
    46c6:	00005b17          	auipc	s6,0x5
    46ca:	94ab0b13          	addi	s6,s6,-1718 # 9010 <quicktests>
      if(continuous != 2) {
    46ce:	4a09                	li	s4,2
      }
    }
    if(!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      if (runtests(slowtests, justone, continuous)) {
    46d0:	00005c17          	auipc	s8,0x5
    46d4:	d10c0c13          	addi	s8,s8,-752 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    46d8:	00003d17          	auipc	s10,0x3
    46dc:	960d0d13          	addi	s10,s10,-1696 # 7038 <malloc+0x20a0>
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    46e0:	00003c97          	auipc	s9,0x3
    46e4:	978c8c93          	addi	s9,s9,-1672 # 7058 <malloc+0x20c0>
    46e8:	a819                	j	46fe <drivetests+0x62>
        printf("usertests slow tests starting\n");
    46ea:	856a                	mv	a0,s10
    46ec:	7f8000ef          	jal	4ee4 <printf>
    46f0:	a80d                	j	4722 <drivetests+0x86>
    if((free1 = countfree()) < free0) {
    46f2:	eb5ff0ef          	jal	45a6 <countfree>
    46f6:	04954063          	blt	a0,s1,4736 <drivetests+0x9a>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    46fa:	04090963          	beqz	s2,474c <drivetests+0xb0>
    printf("usertests starting\n");
    46fe:	855e                	mv	a0,s7
    4700:	7e4000ef          	jal	4ee4 <printf>
    int free0 = countfree();
    4704:	ea3ff0ef          	jal	45a6 <countfree>
    4708:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone, continuous)) {
    470a:	864a                	mv	a2,s2
    470c:	85ce                	mv	a1,s3
    470e:	855a                	mv	a0,s6
    4710:	e1dff0ef          	jal	452c <runtests>
    4714:	c119                	beqz	a0,471a <drivetests+0x7e>
      if(continuous != 2) {
    4716:	03491963          	bne	s2,s4,4748 <drivetests+0xac>
    if(!quick) {
    471a:	fc0a9ce3          	bnez	s5,46f2 <drivetests+0x56>
      if (justone == 0)
    471e:	fc0986e3          	beqz	s3,46ea <drivetests+0x4e>
      if (runtests(slowtests, justone, continuous)) {
    4722:	864a                	mv	a2,s2
    4724:	85ce                	mv	a1,s3
    4726:	8562                	mv	a0,s8
    4728:	e05ff0ef          	jal	452c <runtests>
    472c:	d179                	beqz	a0,46f2 <drivetests+0x56>
        if(continuous != 2) {
    472e:	fd4902e3          	beq	s2,s4,46f2 <drivetests+0x56>
          return 1;
    4732:	4505                	li	a0,1
    4734:	a829                	j	474e <drivetests+0xb2>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4736:	8626                	mv	a2,s1
    4738:	85aa                	mv	a1,a0
    473a:	8566                	mv	a0,s9
    473c:	7a8000ef          	jal	4ee4 <printf>
      if(continuous != 2) {
    4740:	fb490fe3          	beq	s2,s4,46fe <drivetests+0x62>
        return 1;
    4744:	4505                	li	a0,1
    4746:	a021                	j	474e <drivetests+0xb2>
        return 1;
    4748:	4505                	li	a0,1
    474a:	a011                	j	474e <drivetests+0xb2>
  return 0;
    474c:	854a                	mv	a0,s2
}
    474e:	60e6                	ld	ra,88(sp)
    4750:	6446                	ld	s0,80(sp)
    4752:	64a6                	ld	s1,72(sp)
    4754:	6906                	ld	s2,64(sp)
    4756:	79e2                	ld	s3,56(sp)
    4758:	7a42                	ld	s4,48(sp)
    475a:	7aa2                	ld	s5,40(sp)
    475c:	7b02                	ld	s6,32(sp)
    475e:	6be2                	ld	s7,24(sp)
    4760:	6c42                	ld	s8,16(sp)
    4762:	6ca2                	ld	s9,8(sp)
    4764:	6d02                	ld	s10,0(sp)
    4766:	6125                	addi	sp,sp,96
    4768:	8082                	ret

000000000000476a <main>:

int
main(int argc, char *argv[])
{
    476a:	1101                	addi	sp,sp,-32
    476c:	ec06                	sd	ra,24(sp)
    476e:	e822                	sd	s0,16(sp)
    4770:	e426                	sd	s1,8(sp)
    4772:	e04a                	sd	s2,0(sp)
    4774:	1000                	addi	s0,sp,32
    4776:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4778:	4789                	li	a5,2
    477a:	00f50f63          	beq	a0,a5,4798 <main+0x2e>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    477e:	4785                	li	a5,1
    4780:	06a7c063          	blt	a5,a0,47e0 <main+0x76>
  char *justone = 0;
    4784:	4901                	li	s2,0
  int quick = 0;
    4786:	4501                	li	a0,0
  int continuous = 0;
    4788:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    478a:	864a                	mv	a2,s2
    478c:	f11ff0ef          	jal	469c <drivetests>
    4790:	c935                	beqz	a0,4804 <main+0x9a>
    exit(1);
    4792:	4505                	li	a0,1
    4794:	302000ef          	jal	4a96 <exit>
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4798:	0085b903          	ld	s2,8(a1)
    479c:	00003597          	auipc	a1,0x3
    47a0:	8ec58593          	addi	a1,a1,-1812 # 7088 <malloc+0x20f0>
    47a4:	854a                	mv	a0,s2
    47a6:	09e000ef          	jal	4844 <strcmp>
    47aa:	85aa                	mv	a1,a0
    47ac:	c139                	beqz	a0,47f2 <main+0x88>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    47ae:	00003597          	auipc	a1,0x3
    47b2:	8e258593          	addi	a1,a1,-1822 # 7090 <malloc+0x20f8>
    47b6:	854a                	mv	a0,s2
    47b8:	08c000ef          	jal	4844 <strcmp>
    47bc:	cd15                	beqz	a0,47f8 <main+0x8e>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    47be:	00003597          	auipc	a1,0x3
    47c2:	8da58593          	addi	a1,a1,-1830 # 7098 <malloc+0x2100>
    47c6:	854a                	mv	a0,s2
    47c8:	07c000ef          	jal	4844 <strcmp>
    47cc:	c90d                	beqz	a0,47fe <main+0x94>
  } else if(argc == 2 && argv[1][0] != '-'){
    47ce:	00094703          	lbu	a4,0(s2)
    47d2:	02d00793          	li	a5,45
    47d6:	00f70563          	beq	a4,a5,47e0 <main+0x76>
  int quick = 0;
    47da:	4501                	li	a0,0
  int continuous = 0;
    47dc:	4581                	li	a1,0
    47de:	b775                	j	478a <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    47e0:	00003517          	auipc	a0,0x3
    47e4:	8c050513          	addi	a0,a0,-1856 # 70a0 <malloc+0x2108>
    47e8:	6fc000ef          	jal	4ee4 <printf>
    exit(1);
    47ec:	4505                	li	a0,1
    47ee:	2a8000ef          	jal	4a96 <exit>
  char *justone = 0;
    47f2:	4901                	li	s2,0
    quick = 1;
    47f4:	4505                	li	a0,1
    47f6:	bf51                	j	478a <main+0x20>
  char *justone = 0;
    47f8:	4901                	li	s2,0
    continuous = 1;
    47fa:	4585                	li	a1,1
    47fc:	b779                	j	478a <main+0x20>
    continuous = 2;
    47fe:	85a6                	mv	a1,s1
  char *justone = 0;
    4800:	4901                	li	s2,0
    4802:	b761                	j	478a <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    4804:	00003517          	auipc	a0,0x3
    4808:	8cc50513          	addi	a0,a0,-1844 # 70d0 <malloc+0x2138>
    480c:	6d8000ef          	jal	4ee4 <printf>
  exit(0);
    4810:	4501                	li	a0,0
    4812:	284000ef          	jal	4a96 <exit>

0000000000004816 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
    4816:	1141                	addi	sp,sp,-16
    4818:	e406                	sd	ra,8(sp)
    481a:	e022                	sd	s0,0(sp)
    481c:	0800                	addi	s0,sp,16
  extern int main();
  main();
    481e:	f4dff0ef          	jal	476a <main>
  exit(0);
    4822:	4501                	li	a0,0
    4824:	272000ef          	jal	4a96 <exit>

0000000000004828 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    4828:	1141                	addi	sp,sp,-16
    482a:	e422                	sd	s0,8(sp)
    482c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    482e:	87aa                	mv	a5,a0
    4830:	0585                	addi	a1,a1,1
    4832:	0785                	addi	a5,a5,1
    4834:	fff5c703          	lbu	a4,-1(a1)
    4838:	fee78fa3          	sb	a4,-1(a5)
    483c:	fb75                	bnez	a4,4830 <strcpy+0x8>
    ;
  return os;
}
    483e:	6422                	ld	s0,8(sp)
    4840:	0141                	addi	sp,sp,16
    4842:	8082                	ret

0000000000004844 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4844:	1141                	addi	sp,sp,-16
    4846:	e422                	sd	s0,8(sp)
    4848:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    484a:	00054783          	lbu	a5,0(a0)
    484e:	cb91                	beqz	a5,4862 <strcmp+0x1e>
    4850:	0005c703          	lbu	a4,0(a1)
    4854:	00f71763          	bne	a4,a5,4862 <strcmp+0x1e>
    p++, q++;
    4858:	0505                	addi	a0,a0,1
    485a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    485c:	00054783          	lbu	a5,0(a0)
    4860:	fbe5                	bnez	a5,4850 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    4862:	0005c503          	lbu	a0,0(a1)
}
    4866:	40a7853b          	subw	a0,a5,a0
    486a:	6422                	ld	s0,8(sp)
    486c:	0141                	addi	sp,sp,16
    486e:	8082                	ret

0000000000004870 <strlen>:

uint
strlen(const char *s)
{
    4870:	1141                	addi	sp,sp,-16
    4872:	e422                	sd	s0,8(sp)
    4874:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    4876:	00054783          	lbu	a5,0(a0)
    487a:	cf91                	beqz	a5,4896 <strlen+0x26>
    487c:	0505                	addi	a0,a0,1
    487e:	87aa                	mv	a5,a0
    4880:	86be                	mv	a3,a5
    4882:	0785                	addi	a5,a5,1
    4884:	fff7c703          	lbu	a4,-1(a5)
    4888:	ff65                	bnez	a4,4880 <strlen+0x10>
    488a:	40a6853b          	subw	a0,a3,a0
    488e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    4890:	6422                	ld	s0,8(sp)
    4892:	0141                	addi	sp,sp,16
    4894:	8082                	ret
  for(n = 0; s[n]; n++)
    4896:	4501                	li	a0,0
    4898:	bfe5                	j	4890 <strlen+0x20>

000000000000489a <memset>:

void*
memset(void *dst, int c, uint n)
{
    489a:	1141                	addi	sp,sp,-16
    489c:	e422                	sd	s0,8(sp)
    489e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    48a0:	ca19                	beqz	a2,48b6 <memset+0x1c>
    48a2:	87aa                	mv	a5,a0
    48a4:	1602                	slli	a2,a2,0x20
    48a6:	9201                	srli	a2,a2,0x20
    48a8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    48ac:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    48b0:	0785                	addi	a5,a5,1
    48b2:	fee79de3          	bne	a5,a4,48ac <memset+0x12>
  }
  return dst;
}
    48b6:	6422                	ld	s0,8(sp)
    48b8:	0141                	addi	sp,sp,16
    48ba:	8082                	ret

00000000000048bc <strchr>:

char*
strchr(const char *s, char c)
{
    48bc:	1141                	addi	sp,sp,-16
    48be:	e422                	sd	s0,8(sp)
    48c0:	0800                	addi	s0,sp,16
  for(; *s; s++)
    48c2:	00054783          	lbu	a5,0(a0)
    48c6:	cb99                	beqz	a5,48dc <strchr+0x20>
    if(*s == c)
    48c8:	00f58763          	beq	a1,a5,48d6 <strchr+0x1a>
  for(; *s; s++)
    48cc:	0505                	addi	a0,a0,1
    48ce:	00054783          	lbu	a5,0(a0)
    48d2:	fbfd                	bnez	a5,48c8 <strchr+0xc>
      return (char*)s;
  return 0;
    48d4:	4501                	li	a0,0
}
    48d6:	6422                	ld	s0,8(sp)
    48d8:	0141                	addi	sp,sp,16
    48da:	8082                	ret
  return 0;
    48dc:	4501                	li	a0,0
    48de:	bfe5                	j	48d6 <strchr+0x1a>

00000000000048e0 <gets>:

char*
gets(char *buf, int max)
{
    48e0:	711d                	addi	sp,sp,-96
    48e2:	ec86                	sd	ra,88(sp)
    48e4:	e8a2                	sd	s0,80(sp)
    48e6:	e4a6                	sd	s1,72(sp)
    48e8:	e0ca                	sd	s2,64(sp)
    48ea:	fc4e                	sd	s3,56(sp)
    48ec:	f852                	sd	s4,48(sp)
    48ee:	f456                	sd	s5,40(sp)
    48f0:	f05a                	sd	s6,32(sp)
    48f2:	ec5e                	sd	s7,24(sp)
    48f4:	1080                	addi	s0,sp,96
    48f6:	8baa                	mv	s7,a0
    48f8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    48fa:	892a                	mv	s2,a0
    48fc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    48fe:	4aa9                	li	s5,10
    4900:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    4902:	89a6                	mv	s3,s1
    4904:	2485                	addiw	s1,s1,1
    4906:	0344d663          	bge	s1,s4,4932 <gets+0x52>
    cc = read(0, &c, 1);
    490a:	4605                	li	a2,1
    490c:	faf40593          	addi	a1,s0,-81
    4910:	4501                	li	a0,0
    4912:	19c000ef          	jal	4aae <read>
    if(cc < 1)
    4916:	00a05e63          	blez	a0,4932 <gets+0x52>
    buf[i++] = c;
    491a:	faf44783          	lbu	a5,-81(s0)
    491e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    4922:	01578763          	beq	a5,s5,4930 <gets+0x50>
    4926:	0905                	addi	s2,s2,1
    4928:	fd679de3          	bne	a5,s6,4902 <gets+0x22>
    buf[i++] = c;
    492c:	89a6                	mv	s3,s1
    492e:	a011                	j	4932 <gets+0x52>
    4930:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    4932:	99de                	add	s3,s3,s7
    4934:	00098023          	sb	zero,0(s3)
  return buf;
}
    4938:	855e                	mv	a0,s7
    493a:	60e6                	ld	ra,88(sp)
    493c:	6446                	ld	s0,80(sp)
    493e:	64a6                	ld	s1,72(sp)
    4940:	6906                	ld	s2,64(sp)
    4942:	79e2                	ld	s3,56(sp)
    4944:	7a42                	ld	s4,48(sp)
    4946:	7aa2                	ld	s5,40(sp)
    4948:	7b02                	ld	s6,32(sp)
    494a:	6be2                	ld	s7,24(sp)
    494c:	6125                	addi	sp,sp,96
    494e:	8082                	ret

0000000000004950 <stat>:

int
stat(const char *n, struct stat *st)
{
    4950:	1101                	addi	sp,sp,-32
    4952:	ec06                	sd	ra,24(sp)
    4954:	e822                	sd	s0,16(sp)
    4956:	e04a                	sd	s2,0(sp)
    4958:	1000                	addi	s0,sp,32
    495a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    495c:	4581                	li	a1,0
    495e:	178000ef          	jal	4ad6 <open>
  if(fd < 0)
    4962:	02054263          	bltz	a0,4986 <stat+0x36>
    4966:	e426                	sd	s1,8(sp)
    4968:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    496a:	85ca                	mv	a1,s2
    496c:	182000ef          	jal	4aee <fstat>
    4970:	892a                	mv	s2,a0
  close(fd);
    4972:	8526                	mv	a0,s1
    4974:	14a000ef          	jal	4abe <close>
  return r;
    4978:	64a2                	ld	s1,8(sp)
}
    497a:	854a                	mv	a0,s2
    497c:	60e2                	ld	ra,24(sp)
    497e:	6442                	ld	s0,16(sp)
    4980:	6902                	ld	s2,0(sp)
    4982:	6105                	addi	sp,sp,32
    4984:	8082                	ret
    return -1;
    4986:	597d                	li	s2,-1
    4988:	bfcd                	j	497a <stat+0x2a>

000000000000498a <atoi>:

int
atoi(const char *s)
{
    498a:	1141                	addi	sp,sp,-16
    498c:	e422                	sd	s0,8(sp)
    498e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4990:	00054683          	lbu	a3,0(a0)
    4994:	fd06879b          	addiw	a5,a3,-48
    4998:	0ff7f793          	zext.b	a5,a5
    499c:	4625                	li	a2,9
    499e:	02f66863          	bltu	a2,a5,49ce <atoi+0x44>
    49a2:	872a                	mv	a4,a0
  n = 0;
    49a4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    49a6:	0705                	addi	a4,a4,1
    49a8:	0025179b          	slliw	a5,a0,0x2
    49ac:	9fa9                	addw	a5,a5,a0
    49ae:	0017979b          	slliw	a5,a5,0x1
    49b2:	9fb5                	addw	a5,a5,a3
    49b4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    49b8:	00074683          	lbu	a3,0(a4)
    49bc:	fd06879b          	addiw	a5,a3,-48
    49c0:	0ff7f793          	zext.b	a5,a5
    49c4:	fef671e3          	bgeu	a2,a5,49a6 <atoi+0x1c>
  return n;
}
    49c8:	6422                	ld	s0,8(sp)
    49ca:	0141                	addi	sp,sp,16
    49cc:	8082                	ret
  n = 0;
    49ce:	4501                	li	a0,0
    49d0:	bfe5                	j	49c8 <atoi+0x3e>

00000000000049d2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    49d2:	1141                	addi	sp,sp,-16
    49d4:	e422                	sd	s0,8(sp)
    49d6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    49d8:	02b57463          	bgeu	a0,a1,4a00 <memmove+0x2e>
    while(n-- > 0)
    49dc:	00c05f63          	blez	a2,49fa <memmove+0x28>
    49e0:	1602                	slli	a2,a2,0x20
    49e2:	9201                	srli	a2,a2,0x20
    49e4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    49e8:	872a                	mv	a4,a0
      *dst++ = *src++;
    49ea:	0585                	addi	a1,a1,1
    49ec:	0705                	addi	a4,a4,1
    49ee:	fff5c683          	lbu	a3,-1(a1)
    49f2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    49f6:	fef71ae3          	bne	a4,a5,49ea <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    49fa:	6422                	ld	s0,8(sp)
    49fc:	0141                	addi	sp,sp,16
    49fe:	8082                	ret
    dst += n;
    4a00:	00c50733          	add	a4,a0,a2
    src += n;
    4a04:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    4a06:	fec05ae3          	blez	a2,49fa <memmove+0x28>
    4a0a:	fff6079b          	addiw	a5,a2,-1 # 2fff <subdir+0x423>
    4a0e:	1782                	slli	a5,a5,0x20
    4a10:	9381                	srli	a5,a5,0x20
    4a12:	fff7c793          	not	a5,a5
    4a16:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    4a18:	15fd                	addi	a1,a1,-1
    4a1a:	177d                	addi	a4,a4,-1
    4a1c:	0005c683          	lbu	a3,0(a1)
    4a20:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    4a24:	fee79ae3          	bne	a5,a4,4a18 <memmove+0x46>
    4a28:	bfc9                	j	49fa <memmove+0x28>

0000000000004a2a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    4a2a:	1141                	addi	sp,sp,-16
    4a2c:	e422                	sd	s0,8(sp)
    4a2e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    4a30:	ca05                	beqz	a2,4a60 <memcmp+0x36>
    4a32:	fff6069b          	addiw	a3,a2,-1
    4a36:	1682                	slli	a3,a3,0x20
    4a38:	9281                	srli	a3,a3,0x20
    4a3a:	0685                	addi	a3,a3,1
    4a3c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    4a3e:	00054783          	lbu	a5,0(a0)
    4a42:	0005c703          	lbu	a4,0(a1)
    4a46:	00e79863          	bne	a5,a4,4a56 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    4a4a:	0505                	addi	a0,a0,1
    p2++;
    4a4c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    4a4e:	fed518e3          	bne	a0,a3,4a3e <memcmp+0x14>
  }
  return 0;
    4a52:	4501                	li	a0,0
    4a54:	a019                	j	4a5a <memcmp+0x30>
      return *p1 - *p2;
    4a56:	40e7853b          	subw	a0,a5,a4
}
    4a5a:	6422                	ld	s0,8(sp)
    4a5c:	0141                	addi	sp,sp,16
    4a5e:	8082                	ret
  return 0;
    4a60:	4501                	li	a0,0
    4a62:	bfe5                	j	4a5a <memcmp+0x30>

0000000000004a64 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    4a64:	1141                	addi	sp,sp,-16
    4a66:	e406                	sd	ra,8(sp)
    4a68:	e022                	sd	s0,0(sp)
    4a6a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    4a6c:	f67ff0ef          	jal	49d2 <memmove>
}
    4a70:	60a2                	ld	ra,8(sp)
    4a72:	6402                	ld	s0,0(sp)
    4a74:	0141                	addi	sp,sp,16
    4a76:	8082                	ret

0000000000004a78 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
    4a78:	1141                	addi	sp,sp,-16
    4a7a:	e422                	sd	s0,8(sp)
    4a7c:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
    4a7e:	040007b7          	lui	a5,0x4000
    4a82:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ff0385>
    4a84:	07b2                	slli	a5,a5,0xc
}
    4a86:	4388                	lw	a0,0(a5)
    4a88:	6422                	ld	s0,8(sp)
    4a8a:	0141                	addi	sp,sp,16
    4a8c:	8082                	ret

0000000000004a8e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    4a8e:	4885                	li	a7,1
 ecall
    4a90:	00000073          	ecall
 ret
    4a94:	8082                	ret

0000000000004a96 <exit>:
.global exit
exit:
 li a7, SYS_exit
    4a96:	4889                	li	a7,2
 ecall
    4a98:	00000073          	ecall
 ret
    4a9c:	8082                	ret

0000000000004a9e <wait>:
.global wait
wait:
 li a7, SYS_wait
    4a9e:	488d                	li	a7,3
 ecall
    4aa0:	00000073          	ecall
 ret
    4aa4:	8082                	ret

0000000000004aa6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4aa6:	4891                	li	a7,4
 ecall
    4aa8:	00000073          	ecall
 ret
    4aac:	8082                	ret

0000000000004aae <read>:
.global read
read:
 li a7, SYS_read
    4aae:	4895                	li	a7,5
 ecall
    4ab0:	00000073          	ecall
 ret
    4ab4:	8082                	ret

0000000000004ab6 <write>:
.global write
write:
 li a7, SYS_write
    4ab6:	48c1                	li	a7,16
 ecall
    4ab8:	00000073          	ecall
 ret
    4abc:	8082                	ret

0000000000004abe <close>:
.global close
close:
 li a7, SYS_close
    4abe:	48d5                	li	a7,21
 ecall
    4ac0:	00000073          	ecall
 ret
    4ac4:	8082                	ret

0000000000004ac6 <kill>:
.global kill
kill:
 li a7, SYS_kill
    4ac6:	4899                	li	a7,6
 ecall
    4ac8:	00000073          	ecall
 ret
    4acc:	8082                	ret

0000000000004ace <exec>:
.global exec
exec:
 li a7, SYS_exec
    4ace:	489d                	li	a7,7
 ecall
    4ad0:	00000073          	ecall
 ret
    4ad4:	8082                	ret

0000000000004ad6 <open>:
.global open
open:
 li a7, SYS_open
    4ad6:	48bd                	li	a7,15
 ecall
    4ad8:	00000073          	ecall
 ret
    4adc:	8082                	ret

0000000000004ade <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    4ade:	48c5                	li	a7,17
 ecall
    4ae0:	00000073          	ecall
 ret
    4ae4:	8082                	ret

0000000000004ae6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    4ae6:	48c9                	li	a7,18
 ecall
    4ae8:	00000073          	ecall
 ret
    4aec:	8082                	ret

0000000000004aee <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4aee:	48a1                	li	a7,8
 ecall
    4af0:	00000073          	ecall
 ret
    4af4:	8082                	ret

0000000000004af6 <link>:
.global link
link:
 li a7, SYS_link
    4af6:	48cd                	li	a7,19
 ecall
    4af8:	00000073          	ecall
 ret
    4afc:	8082                	ret

0000000000004afe <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4afe:	48d1                	li	a7,20
 ecall
    4b00:	00000073          	ecall
 ret
    4b04:	8082                	ret

0000000000004b06 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4b06:	48a5                	li	a7,9
 ecall
    4b08:	00000073          	ecall
 ret
    4b0c:	8082                	ret

0000000000004b0e <dup>:
.global dup
dup:
 li a7, SYS_dup
    4b0e:	48a9                	li	a7,10
 ecall
    4b10:	00000073          	ecall
 ret
    4b14:	8082                	ret

0000000000004b16 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4b16:	48ad                	li	a7,11
 ecall
    4b18:	00000073          	ecall
 ret
    4b1c:	8082                	ret

0000000000004b1e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    4b1e:	48b1                	li	a7,12
 ecall
    4b20:	00000073          	ecall
 ret
    4b24:	8082                	ret

0000000000004b26 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    4b26:	48b5                	li	a7,13
 ecall
    4b28:	00000073          	ecall
 ret
    4b2c:	8082                	ret

0000000000004b2e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4b2e:	48b9                	li	a7,14
 ecall
    4b30:	00000073          	ecall
 ret
    4b34:	8082                	ret

0000000000004b36 <bind>:
.global bind
bind:
 li a7, SYS_bind
    4b36:	48f5                	li	a7,29
 ecall
    4b38:	00000073          	ecall
 ret
    4b3c:	8082                	ret

0000000000004b3e <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
    4b3e:	48f9                	li	a7,30
 ecall
    4b40:	00000073          	ecall
 ret
    4b44:	8082                	ret

0000000000004b46 <send>:
.global send
send:
 li a7, SYS_send
    4b46:	48fd                	li	a7,31
 ecall
    4b48:	00000073          	ecall
 ret
    4b4c:	8082                	ret

0000000000004b4e <recv>:
.global recv
recv:
 li a7, SYS_recv
    4b4e:	02000893          	li	a7,32
 ecall
    4b52:	00000073          	ecall
 ret
    4b56:	8082                	ret

0000000000004b58 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
    4b58:	02100893          	li	a7,33
 ecall
    4b5c:	00000073          	ecall
 ret
    4b60:	8082                	ret

0000000000004b62 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
    4b62:	02200893          	li	a7,34
 ecall
    4b66:	00000073          	ecall
 ret
    4b6a:	8082                	ret

0000000000004b6c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    4b6c:	1101                	addi	sp,sp,-32
    4b6e:	ec06                	sd	ra,24(sp)
    4b70:	e822                	sd	s0,16(sp)
    4b72:	1000                	addi	s0,sp,32
    4b74:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4b78:	4605                	li	a2,1
    4b7a:	fef40593          	addi	a1,s0,-17
    4b7e:	f39ff0ef          	jal	4ab6 <write>
}
    4b82:	60e2                	ld	ra,24(sp)
    4b84:	6442                	ld	s0,16(sp)
    4b86:	6105                	addi	sp,sp,32
    4b88:	8082                	ret

0000000000004b8a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4b8a:	7139                	addi	sp,sp,-64
    4b8c:	fc06                	sd	ra,56(sp)
    4b8e:	f822                	sd	s0,48(sp)
    4b90:	f426                	sd	s1,40(sp)
    4b92:	0080                	addi	s0,sp,64
    4b94:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4b96:	c299                	beqz	a3,4b9c <printint+0x12>
    4b98:	0805c963          	bltz	a1,4c2a <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    4b9c:	2581                	sext.w	a1,a1
  neg = 0;
    4b9e:	4881                	li	a7,0
    4ba0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    4ba4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    4ba6:	2601                	sext.w	a2,a2
    4ba8:	00003517          	auipc	a0,0x3
    4bac:	8f850513          	addi	a0,a0,-1800 # 74a0 <digits>
    4bb0:	883a                	mv	a6,a4
    4bb2:	2705                	addiw	a4,a4,1
    4bb4:	02c5f7bb          	remuw	a5,a1,a2
    4bb8:	1782                	slli	a5,a5,0x20
    4bba:	9381                	srli	a5,a5,0x20
    4bbc:	97aa                	add	a5,a5,a0
    4bbe:	0007c783          	lbu	a5,0(a5)
    4bc2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    4bc6:	0005879b          	sext.w	a5,a1
    4bca:	02c5d5bb          	divuw	a1,a1,a2
    4bce:	0685                	addi	a3,a3,1
    4bd0:	fec7f0e3          	bgeu	a5,a2,4bb0 <printint+0x26>
  if(neg)
    4bd4:	00088c63          	beqz	a7,4bec <printint+0x62>
    buf[i++] = '-';
    4bd8:	fd070793          	addi	a5,a4,-48
    4bdc:	00878733          	add	a4,a5,s0
    4be0:	02d00793          	li	a5,45
    4be4:	fef70823          	sb	a5,-16(a4)
    4be8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    4bec:	02e05a63          	blez	a4,4c20 <printint+0x96>
    4bf0:	f04a                	sd	s2,32(sp)
    4bf2:	ec4e                	sd	s3,24(sp)
    4bf4:	fc040793          	addi	a5,s0,-64
    4bf8:	00e78933          	add	s2,a5,a4
    4bfc:	fff78993          	addi	s3,a5,-1
    4c00:	99ba                	add	s3,s3,a4
    4c02:	377d                	addiw	a4,a4,-1
    4c04:	1702                	slli	a4,a4,0x20
    4c06:	9301                	srli	a4,a4,0x20
    4c08:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    4c0c:	fff94583          	lbu	a1,-1(s2)
    4c10:	8526                	mv	a0,s1
    4c12:	f5bff0ef          	jal	4b6c <putc>
  while(--i >= 0)
    4c16:	197d                	addi	s2,s2,-1
    4c18:	ff391ae3          	bne	s2,s3,4c0c <printint+0x82>
    4c1c:	7902                	ld	s2,32(sp)
    4c1e:	69e2                	ld	s3,24(sp)
}
    4c20:	70e2                	ld	ra,56(sp)
    4c22:	7442                	ld	s0,48(sp)
    4c24:	74a2                	ld	s1,40(sp)
    4c26:	6121                	addi	sp,sp,64
    4c28:	8082                	ret
    x = -xx;
    4c2a:	40b005bb          	negw	a1,a1
    neg = 1;
    4c2e:	4885                	li	a7,1
    x = -xx;
    4c30:	bf85                	j	4ba0 <printint+0x16>

0000000000004c32 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    4c32:	711d                	addi	sp,sp,-96
    4c34:	ec86                	sd	ra,88(sp)
    4c36:	e8a2                	sd	s0,80(sp)
    4c38:	e0ca                	sd	s2,64(sp)
    4c3a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    4c3c:	0005c903          	lbu	s2,0(a1)
    4c40:	26090863          	beqz	s2,4eb0 <vprintf+0x27e>
    4c44:	e4a6                	sd	s1,72(sp)
    4c46:	fc4e                	sd	s3,56(sp)
    4c48:	f852                	sd	s4,48(sp)
    4c4a:	f456                	sd	s5,40(sp)
    4c4c:	f05a                	sd	s6,32(sp)
    4c4e:	ec5e                	sd	s7,24(sp)
    4c50:	e862                	sd	s8,16(sp)
    4c52:	e466                	sd	s9,8(sp)
    4c54:	8b2a                	mv	s6,a0
    4c56:	8a2e                	mv	s4,a1
    4c58:	8bb2                	mv	s7,a2
  state = 0;
    4c5a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    4c5c:	4481                	li	s1,0
    4c5e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    4c60:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    4c64:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    4c68:	06c00c93          	li	s9,108
    4c6c:	a005                	j	4c8c <vprintf+0x5a>
        putc(fd, c0);
    4c6e:	85ca                	mv	a1,s2
    4c70:	855a                	mv	a0,s6
    4c72:	efbff0ef          	jal	4b6c <putc>
    4c76:	a019                	j	4c7c <vprintf+0x4a>
    } else if(state == '%'){
    4c78:	03598263          	beq	s3,s5,4c9c <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
    4c7c:	2485                	addiw	s1,s1,1
    4c7e:	8726                	mv	a4,s1
    4c80:	009a07b3          	add	a5,s4,s1
    4c84:	0007c903          	lbu	s2,0(a5)
    4c88:	20090c63          	beqz	s2,4ea0 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
    4c8c:	0009079b          	sext.w	a5,s2
    if(state == 0){
    4c90:	fe0994e3          	bnez	s3,4c78 <vprintf+0x46>
      if(c0 == '%'){
    4c94:	fd579de3          	bne	a5,s5,4c6e <vprintf+0x3c>
        state = '%';
    4c98:	89be                	mv	s3,a5
    4c9a:	b7cd                	j	4c7c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
    4c9c:	00ea06b3          	add	a3,s4,a4
    4ca0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    4ca4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
    4ca6:	c681                	beqz	a3,4cae <vprintf+0x7c>
    4ca8:	9752                	add	a4,a4,s4
    4caa:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    4cae:	03878f63          	beq	a5,s8,4cec <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
    4cb2:	05978963          	beq	a5,s9,4d04 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    4cb6:	07500713          	li	a4,117
    4cba:	0ee78363          	beq	a5,a4,4da0 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    4cbe:	07800713          	li	a4,120
    4cc2:	12e78563          	beq	a5,a4,4dec <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    4cc6:	07000713          	li	a4,112
    4cca:	14e78a63          	beq	a5,a4,4e1e <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
    4cce:	07300713          	li	a4,115
    4cd2:	18e78a63          	beq	a5,a4,4e66 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    4cd6:	02500713          	li	a4,37
    4cda:	04e79563          	bne	a5,a4,4d24 <vprintf+0xf2>
        putc(fd, '%');
    4cde:	02500593          	li	a1,37
    4ce2:	855a                	mv	a0,s6
    4ce4:	e89ff0ef          	jal	4b6c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
    4ce8:	4981                	li	s3,0
    4cea:	bf49                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    4cec:	008b8913          	addi	s2,s7,8
    4cf0:	4685                	li	a3,1
    4cf2:	4629                	li	a2,10
    4cf4:	000ba583          	lw	a1,0(s7)
    4cf8:	855a                	mv	a0,s6
    4cfa:	e91ff0ef          	jal	4b8a <printint>
    4cfe:	8bca                	mv	s7,s2
      state = 0;
    4d00:	4981                	li	s3,0
    4d02:	bfad                	j	4c7c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    4d04:	06400793          	li	a5,100
    4d08:	02f68963          	beq	a3,a5,4d3a <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    4d0c:	06c00793          	li	a5,108
    4d10:	04f68263          	beq	a3,a5,4d54 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
    4d14:	07500793          	li	a5,117
    4d18:	0af68063          	beq	a3,a5,4db8 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
    4d1c:	07800793          	li	a5,120
    4d20:	0ef68263          	beq	a3,a5,4e04 <vprintf+0x1d2>
        putc(fd, '%');
    4d24:	02500593          	li	a1,37
    4d28:	855a                	mv	a0,s6
    4d2a:	e43ff0ef          	jal	4b6c <putc>
        putc(fd, c0);
    4d2e:	85ca                	mv	a1,s2
    4d30:	855a                	mv	a0,s6
    4d32:	e3bff0ef          	jal	4b6c <putc>
      state = 0;
    4d36:	4981                	li	s3,0
    4d38:	b791                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    4d3a:	008b8913          	addi	s2,s7,8
    4d3e:	4685                	li	a3,1
    4d40:	4629                	li	a2,10
    4d42:	000ba583          	lw	a1,0(s7)
    4d46:	855a                	mv	a0,s6
    4d48:	e43ff0ef          	jal	4b8a <printint>
        i += 1;
    4d4c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    4d4e:	8bca                	mv	s7,s2
      state = 0;
    4d50:	4981                	li	s3,0
        i += 1;
    4d52:	b72d                	j	4c7c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    4d54:	06400793          	li	a5,100
    4d58:	02f60763          	beq	a2,a5,4d86 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    4d5c:	07500793          	li	a5,117
    4d60:	06f60963          	beq	a2,a5,4dd2 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    4d64:	07800793          	li	a5,120
    4d68:	faf61ee3          	bne	a2,a5,4d24 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
    4d6c:	008b8913          	addi	s2,s7,8
    4d70:	4681                	li	a3,0
    4d72:	4641                	li	a2,16
    4d74:	000ba583          	lw	a1,0(s7)
    4d78:	855a                	mv	a0,s6
    4d7a:	e11ff0ef          	jal	4b8a <printint>
        i += 2;
    4d7e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    4d80:	8bca                	mv	s7,s2
      state = 0;
    4d82:	4981                	li	s3,0
        i += 2;
    4d84:	bde5                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    4d86:	008b8913          	addi	s2,s7,8
    4d8a:	4685                	li	a3,1
    4d8c:	4629                	li	a2,10
    4d8e:	000ba583          	lw	a1,0(s7)
    4d92:	855a                	mv	a0,s6
    4d94:	df7ff0ef          	jal	4b8a <printint>
        i += 2;
    4d98:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    4d9a:	8bca                	mv	s7,s2
      state = 0;
    4d9c:	4981                	li	s3,0
        i += 2;
    4d9e:	bdf9                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
    4da0:	008b8913          	addi	s2,s7,8
    4da4:	4681                	li	a3,0
    4da6:	4629                	li	a2,10
    4da8:	000ba583          	lw	a1,0(s7)
    4dac:	855a                	mv	a0,s6
    4dae:	dddff0ef          	jal	4b8a <printint>
    4db2:	8bca                	mv	s7,s2
      state = 0;
    4db4:	4981                	li	s3,0
    4db6:	b5d9                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    4db8:	008b8913          	addi	s2,s7,8
    4dbc:	4681                	li	a3,0
    4dbe:	4629                	li	a2,10
    4dc0:	000ba583          	lw	a1,0(s7)
    4dc4:	855a                	mv	a0,s6
    4dc6:	dc5ff0ef          	jal	4b8a <printint>
        i += 1;
    4dca:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    4dcc:	8bca                	mv	s7,s2
      state = 0;
    4dce:	4981                	li	s3,0
        i += 1;
    4dd0:	b575                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    4dd2:	008b8913          	addi	s2,s7,8
    4dd6:	4681                	li	a3,0
    4dd8:	4629                	li	a2,10
    4dda:	000ba583          	lw	a1,0(s7)
    4dde:	855a                	mv	a0,s6
    4de0:	dabff0ef          	jal	4b8a <printint>
        i += 2;
    4de4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    4de6:	8bca                	mv	s7,s2
      state = 0;
    4de8:	4981                	li	s3,0
        i += 2;
    4dea:	bd49                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
    4dec:	008b8913          	addi	s2,s7,8
    4df0:	4681                	li	a3,0
    4df2:	4641                	li	a2,16
    4df4:	000ba583          	lw	a1,0(s7)
    4df8:	855a                	mv	a0,s6
    4dfa:	d91ff0ef          	jal	4b8a <printint>
    4dfe:	8bca                	mv	s7,s2
      state = 0;
    4e00:	4981                	li	s3,0
    4e02:	bdad                	j	4c7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    4e04:	008b8913          	addi	s2,s7,8
    4e08:	4681                	li	a3,0
    4e0a:	4641                	li	a2,16
    4e0c:	000ba583          	lw	a1,0(s7)
    4e10:	855a                	mv	a0,s6
    4e12:	d79ff0ef          	jal	4b8a <printint>
        i += 1;
    4e16:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    4e18:	8bca                	mv	s7,s2
      state = 0;
    4e1a:	4981                	li	s3,0
        i += 1;
    4e1c:	b585                	j	4c7c <vprintf+0x4a>
    4e1e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    4e20:	008b8d13          	addi	s10,s7,8
    4e24:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    4e28:	03000593          	li	a1,48
    4e2c:	855a                	mv	a0,s6
    4e2e:	d3fff0ef          	jal	4b6c <putc>
  putc(fd, 'x');
    4e32:	07800593          	li	a1,120
    4e36:	855a                	mv	a0,s6
    4e38:	d35ff0ef          	jal	4b6c <putc>
    4e3c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    4e3e:	00002b97          	auipc	s7,0x2
    4e42:	662b8b93          	addi	s7,s7,1634 # 74a0 <digits>
    4e46:	03c9d793          	srli	a5,s3,0x3c
    4e4a:	97de                	add	a5,a5,s7
    4e4c:	0007c583          	lbu	a1,0(a5)
    4e50:	855a                	mv	a0,s6
    4e52:	d1bff0ef          	jal	4b6c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    4e56:	0992                	slli	s3,s3,0x4
    4e58:	397d                	addiw	s2,s2,-1
    4e5a:	fe0916e3          	bnez	s2,4e46 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
    4e5e:	8bea                	mv	s7,s10
      state = 0;
    4e60:	4981                	li	s3,0
    4e62:	6d02                	ld	s10,0(sp)
    4e64:	bd21                	j	4c7c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    4e66:	008b8993          	addi	s3,s7,8
    4e6a:	000bb903          	ld	s2,0(s7)
    4e6e:	00090f63          	beqz	s2,4e8c <vprintf+0x25a>
        for(; *s; s++)
    4e72:	00094583          	lbu	a1,0(s2)
    4e76:	c195                	beqz	a1,4e9a <vprintf+0x268>
          putc(fd, *s);
    4e78:	855a                	mv	a0,s6
    4e7a:	cf3ff0ef          	jal	4b6c <putc>
        for(; *s; s++)
    4e7e:	0905                	addi	s2,s2,1
    4e80:	00094583          	lbu	a1,0(s2)
    4e84:	f9f5                	bnez	a1,4e78 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    4e86:	8bce                	mv	s7,s3
      state = 0;
    4e88:	4981                	li	s3,0
    4e8a:	bbcd                	j	4c7c <vprintf+0x4a>
          s = "(null)";
    4e8c:	00002917          	auipc	s2,0x2
    4e90:	59490913          	addi	s2,s2,1428 # 7420 <malloc+0x2488>
        for(; *s; s++)
    4e94:	02800593          	li	a1,40
    4e98:	b7c5                	j	4e78 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    4e9a:	8bce                	mv	s7,s3
      state = 0;
    4e9c:	4981                	li	s3,0
    4e9e:	bbf9                	j	4c7c <vprintf+0x4a>
    4ea0:	64a6                	ld	s1,72(sp)
    4ea2:	79e2                	ld	s3,56(sp)
    4ea4:	7a42                	ld	s4,48(sp)
    4ea6:	7aa2                	ld	s5,40(sp)
    4ea8:	7b02                	ld	s6,32(sp)
    4eaa:	6be2                	ld	s7,24(sp)
    4eac:	6c42                	ld	s8,16(sp)
    4eae:	6ca2                	ld	s9,8(sp)
    }
  }
}
    4eb0:	60e6                	ld	ra,88(sp)
    4eb2:	6446                	ld	s0,80(sp)
    4eb4:	6906                	ld	s2,64(sp)
    4eb6:	6125                	addi	sp,sp,96
    4eb8:	8082                	ret

0000000000004eba <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    4eba:	715d                	addi	sp,sp,-80
    4ebc:	ec06                	sd	ra,24(sp)
    4ebe:	e822                	sd	s0,16(sp)
    4ec0:	1000                	addi	s0,sp,32
    4ec2:	e010                	sd	a2,0(s0)
    4ec4:	e414                	sd	a3,8(s0)
    4ec6:	e818                	sd	a4,16(s0)
    4ec8:	ec1c                	sd	a5,24(s0)
    4eca:	03043023          	sd	a6,32(s0)
    4ece:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    4ed2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    4ed6:	8622                	mv	a2,s0
    4ed8:	d5bff0ef          	jal	4c32 <vprintf>
}
    4edc:	60e2                	ld	ra,24(sp)
    4ede:	6442                	ld	s0,16(sp)
    4ee0:	6161                	addi	sp,sp,80
    4ee2:	8082                	ret

0000000000004ee4 <printf>:

void
printf(const char *fmt, ...)
{
    4ee4:	711d                	addi	sp,sp,-96
    4ee6:	ec06                	sd	ra,24(sp)
    4ee8:	e822                	sd	s0,16(sp)
    4eea:	1000                	addi	s0,sp,32
    4eec:	e40c                	sd	a1,8(s0)
    4eee:	e810                	sd	a2,16(s0)
    4ef0:	ec14                	sd	a3,24(s0)
    4ef2:	f018                	sd	a4,32(s0)
    4ef4:	f41c                	sd	a5,40(s0)
    4ef6:	03043823          	sd	a6,48(s0)
    4efa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    4efe:	00840613          	addi	a2,s0,8
    4f02:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    4f06:	85aa                	mv	a1,a0
    4f08:	4505                	li	a0,1
    4f0a:	d29ff0ef          	jal	4c32 <vprintf>
}
    4f0e:	60e2                	ld	ra,24(sp)
    4f10:	6442                	ld	s0,16(sp)
    4f12:	6125                	addi	sp,sp,96
    4f14:	8082                	ret

0000000000004f16 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4f16:	1141                	addi	sp,sp,-16
    4f18:	e422                	sd	s0,8(sp)
    4f1a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4f1c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4f20:	00004797          	auipc	a5,0x4
    4f24:	5307b783          	ld	a5,1328(a5) # 9450 <freep>
    4f28:	a02d                	j	4f52 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    4f2a:	4618                	lw	a4,8(a2)
    4f2c:	9f2d                	addw	a4,a4,a1
    4f2e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    4f32:	6398                	ld	a4,0(a5)
    4f34:	6310                	ld	a2,0(a4)
    4f36:	a83d                	j	4f74 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    4f38:	ff852703          	lw	a4,-8(a0)
    4f3c:	9f31                	addw	a4,a4,a2
    4f3e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    4f40:	ff053683          	ld	a3,-16(a0)
    4f44:	a091                	j	4f88 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4f46:	6398                	ld	a4,0(a5)
    4f48:	00e7e463          	bltu	a5,a4,4f50 <free+0x3a>
    4f4c:	00e6ea63          	bltu	a3,a4,4f60 <free+0x4a>
{
    4f50:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4f52:	fed7fae3          	bgeu	a5,a3,4f46 <free+0x30>
    4f56:	6398                	ld	a4,0(a5)
    4f58:	00e6e463          	bltu	a3,a4,4f60 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4f5c:	fee7eae3          	bltu	a5,a4,4f50 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    4f60:	ff852583          	lw	a1,-8(a0)
    4f64:	6390                	ld	a2,0(a5)
    4f66:	02059813          	slli	a6,a1,0x20
    4f6a:	01c85713          	srli	a4,a6,0x1c
    4f6e:	9736                	add	a4,a4,a3
    4f70:	fae60de3          	beq	a2,a4,4f2a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    4f74:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    4f78:	4790                	lw	a2,8(a5)
    4f7a:	02061593          	slli	a1,a2,0x20
    4f7e:	01c5d713          	srli	a4,a1,0x1c
    4f82:	973e                	add	a4,a4,a5
    4f84:	fae68ae3          	beq	a3,a4,4f38 <free+0x22>
    p->s.ptr = bp->s.ptr;
    4f88:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    4f8a:	00004717          	auipc	a4,0x4
    4f8e:	4cf73323          	sd	a5,1222(a4) # 9450 <freep>
}
    4f92:	6422                	ld	s0,8(sp)
    4f94:	0141                	addi	sp,sp,16
    4f96:	8082                	ret

0000000000004f98 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4f98:	7139                	addi	sp,sp,-64
    4f9a:	fc06                	sd	ra,56(sp)
    4f9c:	f822                	sd	s0,48(sp)
    4f9e:	f426                	sd	s1,40(sp)
    4fa0:	ec4e                	sd	s3,24(sp)
    4fa2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4fa4:	02051493          	slli	s1,a0,0x20
    4fa8:	9081                	srli	s1,s1,0x20
    4faa:	04bd                	addi	s1,s1,15
    4fac:	8091                	srli	s1,s1,0x4
    4fae:	0014899b          	addiw	s3,s1,1
    4fb2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    4fb4:	00004517          	auipc	a0,0x4
    4fb8:	49c53503          	ld	a0,1180(a0) # 9450 <freep>
    4fbc:	c915                	beqz	a0,4ff0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4fbe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4fc0:	4798                	lw	a4,8(a5)
    4fc2:	08977a63          	bgeu	a4,s1,5056 <malloc+0xbe>
    4fc6:	f04a                	sd	s2,32(sp)
    4fc8:	e852                	sd	s4,16(sp)
    4fca:	e456                	sd	s5,8(sp)
    4fcc:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    4fce:	8a4e                	mv	s4,s3
    4fd0:	0009871b          	sext.w	a4,s3
    4fd4:	6685                	lui	a3,0x1
    4fd6:	00d77363          	bgeu	a4,a3,4fdc <malloc+0x44>
    4fda:	6a05                	lui	s4,0x1
    4fdc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    4fe0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4fe4:	00004917          	auipc	s2,0x4
    4fe8:	46c90913          	addi	s2,s2,1132 # 9450 <freep>
  if(p == (char*)-1)
    4fec:	5afd                	li	s5,-1
    4fee:	a081                	j	502e <malloc+0x96>
    4ff0:	f04a                	sd	s2,32(sp)
    4ff2:	e852                	sd	s4,16(sp)
    4ff4:	e456                	sd	s5,8(sp)
    4ff6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    4ff8:	0000b797          	auipc	a5,0xb
    4ffc:	c8078793          	addi	a5,a5,-896 # fc78 <base>
    5000:	00004717          	auipc	a4,0x4
    5004:	44f73823          	sd	a5,1104(a4) # 9450 <freep>
    5008:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    500a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    500e:	b7c1                	j	4fce <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    5010:	6398                	ld	a4,0(a5)
    5012:	e118                	sd	a4,0(a0)
    5014:	a8a9                	j	506e <malloc+0xd6>
  hp->s.size = nu;
    5016:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    501a:	0541                	addi	a0,a0,16
    501c:	efbff0ef          	jal	4f16 <free>
  return freep;
    5020:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    5024:	c12d                	beqz	a0,5086 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5026:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5028:	4798                	lw	a4,8(a5)
    502a:	02977263          	bgeu	a4,s1,504e <malloc+0xb6>
    if(p == freep)
    502e:	00093703          	ld	a4,0(s2)
    5032:	853e                	mv	a0,a5
    5034:	fef719e3          	bne	a4,a5,5026 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    5038:	8552                	mv	a0,s4
    503a:	ae5ff0ef          	jal	4b1e <sbrk>
  if(p == (char*)-1)
    503e:	fd551ce3          	bne	a0,s5,5016 <malloc+0x7e>
        return 0;
    5042:	4501                	li	a0,0
    5044:	7902                	ld	s2,32(sp)
    5046:	6a42                	ld	s4,16(sp)
    5048:	6aa2                	ld	s5,8(sp)
    504a:	6b02                	ld	s6,0(sp)
    504c:	a03d                	j	507a <malloc+0xe2>
    504e:	7902                	ld	s2,32(sp)
    5050:	6a42                	ld	s4,16(sp)
    5052:	6aa2                	ld	s5,8(sp)
    5054:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    5056:	fae48de3          	beq	s1,a4,5010 <malloc+0x78>
        p->s.size -= nunits;
    505a:	4137073b          	subw	a4,a4,s3
    505e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    5060:	02071693          	slli	a3,a4,0x20
    5064:	01c6d713          	srli	a4,a3,0x1c
    5068:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    506a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    506e:	00004717          	auipc	a4,0x4
    5072:	3ea73123          	sd	a0,994(a4) # 9450 <freep>
      return (void*)(p + 1);
    5076:	01078513          	addi	a0,a5,16
  }
}
    507a:	70e2                	ld	ra,56(sp)
    507c:	7442                	ld	s0,48(sp)
    507e:	74a2                	ld	s1,40(sp)
    5080:	69e2                	ld	s3,24(sp)
    5082:	6121                	addi	sp,sp,64
    5084:	8082                	ret
    5086:	7902                	ld	s2,32(sp)
    5088:	6a42                	ld	s4,16(sp)
    508a:	6aa2                	ld	s5,8(sp)
    508c:	6b02                	ld	s6,0(sp)
    508e:	b7f5                	j	507a <malloc+0xe2>
