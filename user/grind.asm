
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	f99ff0ef          	jal	0 <do_rand>
}
      6c:	60a2                	ld	ra,8(sp)
      6e:	6402                	ld	s0,0(sp)
      70:	0141                	addi	sp,sp,16
      72:	8082                	ret

0000000000000074 <go>:

void
go(int which_child)
{
      74:	7119                	addi	sp,sp,-128
      76:	fc86                	sd	ra,120(sp)
      78:	f8a2                	sd	s0,112(sp)
      7a:	f4a6                	sd	s1,104(sp)
      7c:	e4d6                	sd	s5,72(sp)
      7e:	0100                	addi	s0,sp,128
      80:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      82:	4501                	li	a0,0
      84:	369000ef          	jal	bec <sbrk>
      88:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      8a:	00001517          	auipc	a0,0x1
      8e:	0d650513          	addi	a0,a0,214 # 1160 <malloc+0xfa>
      92:	33b000ef          	jal	bcc <mkdir>
  if(chdir("grindir") != 0){
      96:	00001517          	auipc	a0,0x1
      9a:	0ca50513          	addi	a0,a0,202 # 1160 <malloc+0xfa>
      9e:	337000ef          	jal	bd4 <chdir>
      a2:	cd19                	beqz	a0,c0 <go+0x4c>
      a4:	f0ca                	sd	s2,96(sp)
      a6:	ecce                	sd	s3,88(sp)
      a8:	e8d2                	sd	s4,80(sp)
      aa:	e0da                	sd	s6,64(sp)
      ac:	fc5e                	sd	s7,56(sp)
    printf("grind: chdir grindir failed\n");
      ae:	00001517          	auipc	a0,0x1
      b2:	0ba50513          	addi	a0,a0,186 # 1168 <malloc+0x102>
      b6:	6fd000ef          	jal	fb2 <printf>
    exit(1);
      ba:	4505                	li	a0,1
      bc:	2a9000ef          	jal	b64 <exit>
      c0:	f0ca                	sd	s2,96(sp)
      c2:	ecce                	sd	s3,88(sp)
      c4:	e8d2                	sd	s4,80(sp)
      c6:	e0da                	sd	s6,64(sp)
      c8:	fc5e                	sd	s7,56(sp)
  }
  chdir("/");
      ca:	00001517          	auipc	a0,0x1
      ce:	0c650513          	addi	a0,a0,198 # 1190 <malloc+0x12a>
      d2:	303000ef          	jal	bd4 <chdir>
      d6:	00001997          	auipc	s3,0x1
      da:	0ca98993          	addi	s3,s3,202 # 11a0 <malloc+0x13a>
      de:	c489                	beqz	s1,e8 <go+0x74>
      e0:	00001997          	auipc	s3,0x1
      e4:	0b898993          	addi	s3,s3,184 # 1198 <malloc+0x132>
  uint64 iters = 0;
      e8:	4481                	li	s1,0
  int fd = -1;
      ea:	5a7d                	li	s4,-1
      ec:	00001917          	auipc	s2,0x1
      f0:	38490913          	addi	s2,s2,900 # 1470 <malloc+0x40a>
      f4:	a819                	j	10a <go+0x96>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
      f6:	20200593          	li	a1,514
      fa:	00001517          	auipc	a0,0x1
      fe:	0ae50513          	addi	a0,a0,174 # 11a8 <malloc+0x142>
     102:	2a3000ef          	jal	ba4 <open>
     106:	287000ef          	jal	b8c <close>
    iters++;
     10a:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     10c:	1f400793          	li	a5,500
     110:	02f4f7b3          	remu	a5,s1,a5
     114:	e791                	bnez	a5,120 <go+0xac>
      write(1, which_child?"B":"A", 1);
     116:	4605                	li	a2,1
     118:	85ce                	mv	a1,s3
     11a:	4505                	li	a0,1
     11c:	269000ef          	jal	b84 <write>
    int what = rand() % 23;
     120:	f39ff0ef          	jal	58 <rand>
     124:	47dd                	li	a5,23
     126:	02f5653b          	remw	a0,a0,a5
     12a:	0005071b          	sext.w	a4,a0
     12e:	47d9                	li	a5,22
     130:	fce7ede3          	bltu	a5,a4,10a <go+0x96>
     134:	02051793          	slli	a5,a0,0x20
     138:	01e7d513          	srli	a0,a5,0x1e
     13c:	954a                	add	a0,a0,s2
     13e:	411c                	lw	a5,0(a0)
     140:	97ca                	add	a5,a5,s2
     142:	8782                	jr	a5
    } else if(what == 2){
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     144:	20200593          	li	a1,514
     148:	00001517          	auipc	a0,0x1
     14c:	07050513          	addi	a0,a0,112 # 11b8 <malloc+0x152>
     150:	255000ef          	jal	ba4 <open>
     154:	239000ef          	jal	b8c <close>
     158:	bf4d                	j	10a <go+0x96>
    } else if(what == 3){
      unlink("grindir/../a");
     15a:	00001517          	auipc	a0,0x1
     15e:	04e50513          	addi	a0,a0,78 # 11a8 <malloc+0x142>
     162:	253000ef          	jal	bb4 <unlink>
     166:	b755                	j	10a <go+0x96>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     168:	00001517          	auipc	a0,0x1
     16c:	ff850513          	addi	a0,a0,-8 # 1160 <malloc+0xfa>
     170:	265000ef          	jal	bd4 <chdir>
     174:	ed11                	bnez	a0,190 <go+0x11c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     176:	00001517          	auipc	a0,0x1
     17a:	05a50513          	addi	a0,a0,90 # 11d0 <malloc+0x16a>
     17e:	237000ef          	jal	bb4 <unlink>
      chdir("/");
     182:	00001517          	auipc	a0,0x1
     186:	00e50513          	addi	a0,a0,14 # 1190 <malloc+0x12a>
     18a:	24b000ef          	jal	bd4 <chdir>
     18e:	bfb5                	j	10a <go+0x96>
        printf("grind: chdir grindir failed\n");
     190:	00001517          	auipc	a0,0x1
     194:	fd850513          	addi	a0,a0,-40 # 1168 <malloc+0x102>
     198:	61b000ef          	jal	fb2 <printf>
        exit(1);
     19c:	4505                	li	a0,1
     19e:	1c7000ef          	jal	b64 <exit>
    } else if(what == 5){
      close(fd);
     1a2:	8552                	mv	a0,s4
     1a4:	1e9000ef          	jal	b8c <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1a8:	20200593          	li	a1,514
     1ac:	00001517          	auipc	a0,0x1
     1b0:	02c50513          	addi	a0,a0,44 # 11d8 <malloc+0x172>
     1b4:	1f1000ef          	jal	ba4 <open>
     1b8:	8a2a                	mv	s4,a0
     1ba:	bf81                	j	10a <go+0x96>
    } else if(what == 6){
      close(fd);
     1bc:	8552                	mv	a0,s4
     1be:	1cf000ef          	jal	b8c <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     1c2:	20200593          	li	a1,514
     1c6:	00001517          	auipc	a0,0x1
     1ca:	02250513          	addi	a0,a0,34 # 11e8 <malloc+0x182>
     1ce:	1d7000ef          	jal	ba4 <open>
     1d2:	8a2a                	mv	s4,a0
     1d4:	bf1d                	j	10a <go+0x96>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     1d6:	3e700613          	li	a2,999
     1da:	00002597          	auipc	a1,0x2
     1de:	e4658593          	addi	a1,a1,-442 # 2020 <buf.0>
     1e2:	8552                	mv	a0,s4
     1e4:	1a1000ef          	jal	b84 <write>
     1e8:	b70d                	j	10a <go+0x96>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     1ea:	3e700613          	li	a2,999
     1ee:	00002597          	auipc	a1,0x2
     1f2:	e3258593          	addi	a1,a1,-462 # 2020 <buf.0>
     1f6:	8552                	mv	a0,s4
     1f8:	185000ef          	jal	b7c <read>
     1fc:	b739                	j	10a <go+0x96>
    } else if(what == 9){
      mkdir("grindir/../a");
     1fe:	00001517          	auipc	a0,0x1
     202:	faa50513          	addi	a0,a0,-86 # 11a8 <malloc+0x142>
     206:	1c7000ef          	jal	bcc <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	ff250513          	addi	a0,a0,-14 # 1200 <malloc+0x19a>
     216:	18f000ef          	jal	ba4 <open>
     21a:	173000ef          	jal	b8c <close>
      unlink("a/a");
     21e:	00001517          	auipc	a0,0x1
     222:	ff250513          	addi	a0,a0,-14 # 1210 <malloc+0x1aa>
     226:	18f000ef          	jal	bb4 <unlink>
     22a:	b5c5                	j	10a <go+0x96>
    } else if(what == 10){
      mkdir("/../b");
     22c:	00001517          	auipc	a0,0x1
     230:	fec50513          	addi	a0,a0,-20 # 1218 <malloc+0x1b2>
     234:	199000ef          	jal	bcc <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     238:	20200593          	li	a1,514
     23c:	00001517          	auipc	a0,0x1
     240:	fe450513          	addi	a0,a0,-28 # 1220 <malloc+0x1ba>
     244:	161000ef          	jal	ba4 <open>
     248:	145000ef          	jal	b8c <close>
      unlink("b/b");
     24c:	00001517          	auipc	a0,0x1
     250:	fe450513          	addi	a0,a0,-28 # 1230 <malloc+0x1ca>
     254:	161000ef          	jal	bb4 <unlink>
     258:	bd4d                	j	10a <go+0x96>
    } else if(what == 11){
      unlink("b");
     25a:	00001517          	auipc	a0,0x1
     25e:	fde50513          	addi	a0,a0,-34 # 1238 <malloc+0x1d2>
     262:	153000ef          	jal	bb4 <unlink>
      link("../grindir/./../a", "../b");
     266:	00001597          	auipc	a1,0x1
     26a:	f6a58593          	addi	a1,a1,-150 # 11d0 <malloc+0x16a>
     26e:	00001517          	auipc	a0,0x1
     272:	fd250513          	addi	a0,a0,-46 # 1240 <malloc+0x1da>
     276:	14f000ef          	jal	bc4 <link>
     27a:	bd41                	j	10a <go+0x96>
    } else if(what == 12){
      unlink("../grindir/../a");
     27c:	00001517          	auipc	a0,0x1
     280:	fdc50513          	addi	a0,a0,-36 # 1258 <malloc+0x1f2>
     284:	131000ef          	jal	bb4 <unlink>
      link(".././b", "/grindir/../a");
     288:	00001597          	auipc	a1,0x1
     28c:	f5058593          	addi	a1,a1,-176 # 11d8 <malloc+0x172>
     290:	00001517          	auipc	a0,0x1
     294:	fd850513          	addi	a0,a0,-40 # 1268 <malloc+0x202>
     298:	12d000ef          	jal	bc4 <link>
     29c:	b5bd                	j	10a <go+0x96>
    } else if(what == 13){
      int pid = fork();
     29e:	0bf000ef          	jal	b5c <fork>
      if(pid == 0){
     2a2:	c519                	beqz	a0,2b0 <go+0x23c>
        exit(0);
      } else if(pid < 0){
     2a4:	00054863          	bltz	a0,2b4 <go+0x240>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2a8:	4501                	li	a0,0
     2aa:	0c3000ef          	jal	b6c <wait>
     2ae:	bdb1                	j	10a <go+0x96>
        exit(0);
     2b0:	0b5000ef          	jal	b64 <exit>
        printf("grind: fork failed\n");
     2b4:	00001517          	auipc	a0,0x1
     2b8:	fbc50513          	addi	a0,a0,-68 # 1270 <malloc+0x20a>
     2bc:	4f7000ef          	jal	fb2 <printf>
        exit(1);
     2c0:	4505                	li	a0,1
     2c2:	0a3000ef          	jal	b64 <exit>
    } else if(what == 14){
      int pid = fork();
     2c6:	097000ef          	jal	b5c <fork>
      if(pid == 0){
     2ca:	c519                	beqz	a0,2d8 <go+0x264>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     2cc:	00054d63          	bltz	a0,2e6 <go+0x272>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2d0:	4501                	li	a0,0
     2d2:	09b000ef          	jal	b6c <wait>
     2d6:	bd15                	j	10a <go+0x96>
        fork();
     2d8:	085000ef          	jal	b5c <fork>
        fork();
     2dc:	081000ef          	jal	b5c <fork>
        exit(0);
     2e0:	4501                	li	a0,0
     2e2:	083000ef          	jal	b64 <exit>
        printf("grind: fork failed\n");
     2e6:	00001517          	auipc	a0,0x1
     2ea:	f8a50513          	addi	a0,a0,-118 # 1270 <malloc+0x20a>
     2ee:	4c5000ef          	jal	fb2 <printf>
        exit(1);
     2f2:	4505                	li	a0,1
     2f4:	071000ef          	jal	b64 <exit>
    } else if(what == 15){
      sbrk(6011);
     2f8:	6505                	lui	a0,0x1
     2fa:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x2ab>
     2fe:	0ef000ef          	jal	bec <sbrk>
     302:	b521                	j	10a <go+0x96>
    } else if(what == 16){
      if(sbrk(0) > break0)
     304:	4501                	li	a0,0
     306:	0e7000ef          	jal	bec <sbrk>
     30a:	e0aaf0e3          	bgeu	s5,a0,10a <go+0x96>
        sbrk(-(sbrk(0) - break0));
     30e:	4501                	li	a0,0
     310:	0dd000ef          	jal	bec <sbrk>
     314:	40aa853b          	subw	a0,s5,a0
     318:	0d5000ef          	jal	bec <sbrk>
     31c:	b3fd                	j	10a <go+0x96>
    } else if(what == 17){
      int pid = fork();
     31e:	03f000ef          	jal	b5c <fork>
     322:	8b2a                	mv	s6,a0
      if(pid == 0){
     324:	c10d                	beqz	a0,346 <go+0x2d2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     326:	02054d63          	bltz	a0,360 <go+0x2ec>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     32a:	00001517          	auipc	a0,0x1
     32e:	f6650513          	addi	a0,a0,-154 # 1290 <malloc+0x22a>
     332:	0a3000ef          	jal	bd4 <chdir>
     336:	ed15                	bnez	a0,372 <go+0x2fe>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     338:	855a                	mv	a0,s6
     33a:	05b000ef          	jal	b94 <kill>
      wait(0);
     33e:	4501                	li	a0,0
     340:	02d000ef          	jal	b6c <wait>
     344:	b3d9                	j	10a <go+0x96>
        close(open("a", O_CREATE|O_RDWR));
     346:	20200593          	li	a1,514
     34a:	00001517          	auipc	a0,0x1
     34e:	f3e50513          	addi	a0,a0,-194 # 1288 <malloc+0x222>
     352:	053000ef          	jal	ba4 <open>
     356:	037000ef          	jal	b8c <close>
        exit(0);
     35a:	4501                	li	a0,0
     35c:	009000ef          	jal	b64 <exit>
        printf("grind: fork failed\n");
     360:	00001517          	auipc	a0,0x1
     364:	f1050513          	addi	a0,a0,-240 # 1270 <malloc+0x20a>
     368:	44b000ef          	jal	fb2 <printf>
        exit(1);
     36c:	4505                	li	a0,1
     36e:	7f6000ef          	jal	b64 <exit>
        printf("grind: chdir failed\n");
     372:	00001517          	auipc	a0,0x1
     376:	f2e50513          	addi	a0,a0,-210 # 12a0 <malloc+0x23a>
     37a:	439000ef          	jal	fb2 <printf>
        exit(1);
     37e:	4505                	li	a0,1
     380:	7e4000ef          	jal	b64 <exit>
    } else if(what == 18){
      int pid = fork();
     384:	7d8000ef          	jal	b5c <fork>
      if(pid == 0){
     388:	c519                	beqz	a0,396 <go+0x322>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     38a:	00054d63          	bltz	a0,3a4 <go+0x330>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     38e:	4501                	li	a0,0
     390:	7dc000ef          	jal	b6c <wait>
     394:	bb9d                	j	10a <go+0x96>
        kill(getpid());
     396:	04f000ef          	jal	be4 <getpid>
     39a:	7fa000ef          	jal	b94 <kill>
        exit(0);
     39e:	4501                	li	a0,0
     3a0:	7c4000ef          	jal	b64 <exit>
        printf("grind: fork failed\n");
     3a4:	00001517          	auipc	a0,0x1
     3a8:	ecc50513          	addi	a0,a0,-308 # 1270 <malloc+0x20a>
     3ac:	407000ef          	jal	fb2 <printf>
        exit(1);
     3b0:	4505                	li	a0,1
     3b2:	7b2000ef          	jal	b64 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     3b6:	f9840513          	addi	a0,s0,-104
     3ba:	7ba000ef          	jal	b74 <pipe>
     3be:	02054363          	bltz	a0,3e4 <go+0x370>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     3c2:	79a000ef          	jal	b5c <fork>
      if(pid == 0){
     3c6:	c905                	beqz	a0,3f6 <go+0x382>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     3c8:	08054263          	bltz	a0,44c <go+0x3d8>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     3cc:	f9842503          	lw	a0,-104(s0)
     3d0:	7bc000ef          	jal	b8c <close>
      close(fds[1]);
     3d4:	f9c42503          	lw	a0,-100(s0)
     3d8:	7b4000ef          	jal	b8c <close>
      wait(0);
     3dc:	4501                	li	a0,0
     3de:	78e000ef          	jal	b6c <wait>
     3e2:	b325                	j	10a <go+0x96>
        printf("grind: pipe failed\n");
     3e4:	00001517          	auipc	a0,0x1
     3e8:	ed450513          	addi	a0,a0,-300 # 12b8 <malloc+0x252>
     3ec:	3c7000ef          	jal	fb2 <printf>
        exit(1);
     3f0:	4505                	li	a0,1
     3f2:	772000ef          	jal	b64 <exit>
        fork();
     3f6:	766000ef          	jal	b5c <fork>
        fork();
     3fa:	762000ef          	jal	b5c <fork>
        if(write(fds[1], "x", 1) != 1)
     3fe:	4605                	li	a2,1
     400:	00001597          	auipc	a1,0x1
     404:	ed058593          	addi	a1,a1,-304 # 12d0 <malloc+0x26a>
     408:	f9c42503          	lw	a0,-100(s0)
     40c:	778000ef          	jal	b84 <write>
     410:	4785                	li	a5,1
     412:	00f51f63          	bne	a0,a5,430 <go+0x3bc>
        if(read(fds[0], &c, 1) != 1)
     416:	4605                	li	a2,1
     418:	f9040593          	addi	a1,s0,-112
     41c:	f9842503          	lw	a0,-104(s0)
     420:	75c000ef          	jal	b7c <read>
     424:	4785                	li	a5,1
     426:	00f51c63          	bne	a0,a5,43e <go+0x3ca>
        exit(0);
     42a:	4501                	li	a0,0
     42c:	738000ef          	jal	b64 <exit>
          printf("grind: pipe write failed\n");
     430:	00001517          	auipc	a0,0x1
     434:	ea850513          	addi	a0,a0,-344 # 12d8 <malloc+0x272>
     438:	37b000ef          	jal	fb2 <printf>
     43c:	bfe9                	j	416 <go+0x3a2>
          printf("grind: pipe read failed\n");
     43e:	00001517          	auipc	a0,0x1
     442:	eba50513          	addi	a0,a0,-326 # 12f8 <malloc+0x292>
     446:	36d000ef          	jal	fb2 <printf>
     44a:	b7c5                	j	42a <go+0x3b6>
        printf("grind: fork failed\n");
     44c:	00001517          	auipc	a0,0x1
     450:	e2450513          	addi	a0,a0,-476 # 1270 <malloc+0x20a>
     454:	35f000ef          	jal	fb2 <printf>
        exit(1);
     458:	4505                	li	a0,1
     45a:	70a000ef          	jal	b64 <exit>
    } else if(what == 20){
      int pid = fork();
     45e:	6fe000ef          	jal	b5c <fork>
      if(pid == 0){
     462:	c519                	beqz	a0,470 <go+0x3fc>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     464:	04054f63          	bltz	a0,4c2 <go+0x44e>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     468:	4501                	li	a0,0
     46a:	702000ef          	jal	b6c <wait>
     46e:	b971                	j	10a <go+0x96>
        unlink("a");
     470:	00001517          	auipc	a0,0x1
     474:	e1850513          	addi	a0,a0,-488 # 1288 <malloc+0x222>
     478:	73c000ef          	jal	bb4 <unlink>
        mkdir("a");
     47c:	00001517          	auipc	a0,0x1
     480:	e0c50513          	addi	a0,a0,-500 # 1288 <malloc+0x222>
     484:	748000ef          	jal	bcc <mkdir>
        chdir("a");
     488:	00001517          	auipc	a0,0x1
     48c:	e0050513          	addi	a0,a0,-512 # 1288 <malloc+0x222>
     490:	744000ef          	jal	bd4 <chdir>
        unlink("../a");
     494:	00001517          	auipc	a0,0x1
     498:	e8450513          	addi	a0,a0,-380 # 1318 <malloc+0x2b2>
     49c:	718000ef          	jal	bb4 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     4a0:	20200593          	li	a1,514
     4a4:	00001517          	auipc	a0,0x1
     4a8:	e2c50513          	addi	a0,a0,-468 # 12d0 <malloc+0x26a>
     4ac:	6f8000ef          	jal	ba4 <open>
        unlink("x");
     4b0:	00001517          	auipc	a0,0x1
     4b4:	e2050513          	addi	a0,a0,-480 # 12d0 <malloc+0x26a>
     4b8:	6fc000ef          	jal	bb4 <unlink>
        exit(0);
     4bc:	4501                	li	a0,0
     4be:	6a6000ef          	jal	b64 <exit>
        printf("grind: fork failed\n");
     4c2:	00001517          	auipc	a0,0x1
     4c6:	dae50513          	addi	a0,a0,-594 # 1270 <malloc+0x20a>
     4ca:	2e9000ef          	jal	fb2 <printf>
        exit(1);
     4ce:	4505                	li	a0,1
     4d0:	694000ef          	jal	b64 <exit>
    } else if(what == 21){
      unlink("c");
     4d4:	00001517          	auipc	a0,0x1
     4d8:	e4c50513          	addi	a0,a0,-436 # 1320 <malloc+0x2ba>
     4dc:	6d8000ef          	jal	bb4 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     4e0:	20200593          	li	a1,514
     4e4:	00001517          	auipc	a0,0x1
     4e8:	e3c50513          	addi	a0,a0,-452 # 1320 <malloc+0x2ba>
     4ec:	6b8000ef          	jal	ba4 <open>
     4f0:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     4f2:	04054763          	bltz	a0,540 <go+0x4cc>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     4f6:	4605                	li	a2,1
     4f8:	00001597          	auipc	a1,0x1
     4fc:	dd858593          	addi	a1,a1,-552 # 12d0 <malloc+0x26a>
     500:	684000ef          	jal	b84 <write>
     504:	4785                	li	a5,1
     506:	04f51663          	bne	a0,a5,552 <go+0x4de>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     50a:	f9840593          	addi	a1,s0,-104
     50e:	855a                	mv	a0,s6
     510:	6ac000ef          	jal	bbc <fstat>
     514:	e921                	bnez	a0,564 <go+0x4f0>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     516:	fa843583          	ld	a1,-88(s0)
     51a:	4785                	li	a5,1
     51c:	04f59d63          	bne	a1,a5,576 <go+0x502>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     520:	f9c42583          	lw	a1,-100(s0)
     524:	0c800793          	li	a5,200
     528:	06b7e163          	bltu	a5,a1,58a <go+0x516>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     52c:	855a                	mv	a0,s6
     52e:	65e000ef          	jal	b8c <close>
      unlink("c");
     532:	00001517          	auipc	a0,0x1
     536:	dee50513          	addi	a0,a0,-530 # 1320 <malloc+0x2ba>
     53a:	67a000ef          	jal	bb4 <unlink>
     53e:	b6f1                	j	10a <go+0x96>
        printf("grind: create c failed\n");
     540:	00001517          	auipc	a0,0x1
     544:	de850513          	addi	a0,a0,-536 # 1328 <malloc+0x2c2>
     548:	26b000ef          	jal	fb2 <printf>
        exit(1);
     54c:	4505                	li	a0,1
     54e:	616000ef          	jal	b64 <exit>
        printf("grind: write c failed\n");
     552:	00001517          	auipc	a0,0x1
     556:	dee50513          	addi	a0,a0,-530 # 1340 <malloc+0x2da>
     55a:	259000ef          	jal	fb2 <printf>
        exit(1);
     55e:	4505                	li	a0,1
     560:	604000ef          	jal	b64 <exit>
        printf("grind: fstat failed\n");
     564:	00001517          	auipc	a0,0x1
     568:	df450513          	addi	a0,a0,-524 # 1358 <malloc+0x2f2>
     56c:	247000ef          	jal	fb2 <printf>
        exit(1);
     570:	4505                	li	a0,1
     572:	5f2000ef          	jal	b64 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     576:	2581                	sext.w	a1,a1
     578:	00001517          	auipc	a0,0x1
     57c:	df850513          	addi	a0,a0,-520 # 1370 <malloc+0x30a>
     580:	233000ef          	jal	fb2 <printf>
        exit(1);
     584:	4505                	li	a0,1
     586:	5de000ef          	jal	b64 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     58a:	00001517          	auipc	a0,0x1
     58e:	e0e50513          	addi	a0,a0,-498 # 1398 <malloc+0x332>
     592:	221000ef          	jal	fb2 <printf>
        exit(1);
     596:	4505                	li	a0,1
     598:	5cc000ef          	jal	b64 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     59c:	f8840513          	addi	a0,s0,-120
     5a0:	5d4000ef          	jal	b74 <pipe>
     5a4:	0a054563          	bltz	a0,64e <go+0x5da>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     5a8:	f9040513          	addi	a0,s0,-112
     5ac:	5c8000ef          	jal	b74 <pipe>
     5b0:	0a054963          	bltz	a0,662 <go+0x5ee>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     5b4:	5a8000ef          	jal	b5c <fork>
      if(pid1 == 0){
     5b8:	cd5d                	beqz	a0,676 <go+0x602>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     5ba:	14054263          	bltz	a0,6fe <go+0x68a>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     5be:	59e000ef          	jal	b5c <fork>
      if(pid2 == 0){
     5c2:	14050863          	beqz	a0,712 <go+0x69e>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     5c6:	1e054663          	bltz	a0,7b2 <go+0x73e>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     5ca:	f8842503          	lw	a0,-120(s0)
     5ce:	5be000ef          	jal	b8c <close>
      close(aa[1]);
     5d2:	f8c42503          	lw	a0,-116(s0)
     5d6:	5b6000ef          	jal	b8c <close>
      close(bb[1]);
     5da:	f9442503          	lw	a0,-108(s0)
     5de:	5ae000ef          	jal	b8c <close>
      char buf[4] = { 0, 0, 0, 0 };
     5e2:	f8042023          	sw	zero,-128(s0)
      read(bb[0], buf+0, 1);
     5e6:	4605                	li	a2,1
     5e8:	f8040593          	addi	a1,s0,-128
     5ec:	f9042503          	lw	a0,-112(s0)
     5f0:	58c000ef          	jal	b7c <read>
      read(bb[0], buf+1, 1);
     5f4:	4605                	li	a2,1
     5f6:	f8140593          	addi	a1,s0,-127
     5fa:	f9042503          	lw	a0,-112(s0)
     5fe:	57e000ef          	jal	b7c <read>
      read(bb[0], buf+2, 1);
     602:	4605                	li	a2,1
     604:	f8240593          	addi	a1,s0,-126
     608:	f9042503          	lw	a0,-112(s0)
     60c:	570000ef          	jal	b7c <read>
      close(bb[0]);
     610:	f9042503          	lw	a0,-112(s0)
     614:	578000ef          	jal	b8c <close>
      int st1, st2;
      wait(&st1);
     618:	f8440513          	addi	a0,s0,-124
     61c:	550000ef          	jal	b6c <wait>
      wait(&st2);
     620:	f9840513          	addi	a0,s0,-104
     624:	548000ef          	jal	b6c <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     628:	f8442783          	lw	a5,-124(s0)
     62c:	f9842b83          	lw	s7,-104(s0)
     630:	0177eb33          	or	s6,a5,s7
     634:	180b1963          	bnez	s6,7c6 <go+0x752>
     638:	00001597          	auipc	a1,0x1
     63c:	e0058593          	addi	a1,a1,-512 # 1438 <malloc+0x3d2>
     640:	f8040513          	addi	a0,s0,-128
     644:	2ce000ef          	jal	912 <strcmp>
     648:	ac0501e3          	beqz	a0,10a <go+0x96>
     64c:	aab5                	j	7c8 <go+0x754>
        fprintf(2, "grind: pipe failed\n");
     64e:	00001597          	auipc	a1,0x1
     652:	c6a58593          	addi	a1,a1,-918 # 12b8 <malloc+0x252>
     656:	4509                	li	a0,2
     658:	131000ef          	jal	f88 <fprintf>
        exit(1);
     65c:	4505                	li	a0,1
     65e:	506000ef          	jal	b64 <exit>
        fprintf(2, "grind: pipe failed\n");
     662:	00001597          	auipc	a1,0x1
     666:	c5658593          	addi	a1,a1,-938 # 12b8 <malloc+0x252>
     66a:	4509                	li	a0,2
     66c:	11d000ef          	jal	f88 <fprintf>
        exit(1);
     670:	4505                	li	a0,1
     672:	4f2000ef          	jal	b64 <exit>
        close(bb[0]);
     676:	f9042503          	lw	a0,-112(s0)
     67a:	512000ef          	jal	b8c <close>
        close(bb[1]);
     67e:	f9442503          	lw	a0,-108(s0)
     682:	50a000ef          	jal	b8c <close>
        close(aa[0]);
     686:	f8842503          	lw	a0,-120(s0)
     68a:	502000ef          	jal	b8c <close>
        close(1);
     68e:	4505                	li	a0,1
     690:	4fc000ef          	jal	b8c <close>
        if(dup(aa[1]) != 1){
     694:	f8c42503          	lw	a0,-116(s0)
     698:	544000ef          	jal	bdc <dup>
     69c:	4785                	li	a5,1
     69e:	00f50c63          	beq	a0,a5,6b6 <go+0x642>
          fprintf(2, "grind: dup failed\n");
     6a2:	00001597          	auipc	a1,0x1
     6a6:	d1e58593          	addi	a1,a1,-738 # 13c0 <malloc+0x35a>
     6aa:	4509                	li	a0,2
     6ac:	0dd000ef          	jal	f88 <fprintf>
          exit(1);
     6b0:	4505                	li	a0,1
     6b2:	4b2000ef          	jal	b64 <exit>
        close(aa[1]);
     6b6:	f8c42503          	lw	a0,-116(s0)
     6ba:	4d2000ef          	jal	b8c <close>
        char *args[3] = { "echo", "hi", 0 };
     6be:	00001797          	auipc	a5,0x1
     6c2:	d1a78793          	addi	a5,a5,-742 # 13d8 <malloc+0x372>
     6c6:	f8f43c23          	sd	a5,-104(s0)
     6ca:	00001797          	auipc	a5,0x1
     6ce:	d1678793          	addi	a5,a5,-746 # 13e0 <malloc+0x37a>
     6d2:	faf43023          	sd	a5,-96(s0)
     6d6:	fa043423          	sd	zero,-88(s0)
        exec("grindir/../echo", args);
     6da:	f9840593          	addi	a1,s0,-104
     6de:	00001517          	auipc	a0,0x1
     6e2:	d0a50513          	addi	a0,a0,-758 # 13e8 <malloc+0x382>
     6e6:	4b6000ef          	jal	b9c <exec>
        fprintf(2, "grind: echo: not found\n");
     6ea:	00001597          	auipc	a1,0x1
     6ee:	d0e58593          	addi	a1,a1,-754 # 13f8 <malloc+0x392>
     6f2:	4509                	li	a0,2
     6f4:	095000ef          	jal	f88 <fprintf>
        exit(2);
     6f8:	4509                	li	a0,2
     6fa:	46a000ef          	jal	b64 <exit>
        fprintf(2, "grind: fork failed\n");
     6fe:	00001597          	auipc	a1,0x1
     702:	b7258593          	addi	a1,a1,-1166 # 1270 <malloc+0x20a>
     706:	4509                	li	a0,2
     708:	081000ef          	jal	f88 <fprintf>
        exit(3);
     70c:	450d                	li	a0,3
     70e:	456000ef          	jal	b64 <exit>
        close(aa[1]);
     712:	f8c42503          	lw	a0,-116(s0)
     716:	476000ef          	jal	b8c <close>
        close(bb[0]);
     71a:	f9042503          	lw	a0,-112(s0)
     71e:	46e000ef          	jal	b8c <close>
        close(0);
     722:	4501                	li	a0,0
     724:	468000ef          	jal	b8c <close>
        if(dup(aa[0]) != 0){
     728:	f8842503          	lw	a0,-120(s0)
     72c:	4b0000ef          	jal	bdc <dup>
     730:	c919                	beqz	a0,746 <go+0x6d2>
          fprintf(2, "grind: dup failed\n");
     732:	00001597          	auipc	a1,0x1
     736:	c8e58593          	addi	a1,a1,-882 # 13c0 <malloc+0x35a>
     73a:	4509                	li	a0,2
     73c:	04d000ef          	jal	f88 <fprintf>
          exit(4);
     740:	4511                	li	a0,4
     742:	422000ef          	jal	b64 <exit>
        close(aa[0]);
     746:	f8842503          	lw	a0,-120(s0)
     74a:	442000ef          	jal	b8c <close>
        close(1);
     74e:	4505                	li	a0,1
     750:	43c000ef          	jal	b8c <close>
        if(dup(bb[1]) != 1){
     754:	f9442503          	lw	a0,-108(s0)
     758:	484000ef          	jal	bdc <dup>
     75c:	4785                	li	a5,1
     75e:	00f50c63          	beq	a0,a5,776 <go+0x702>
          fprintf(2, "grind: dup failed\n");
     762:	00001597          	auipc	a1,0x1
     766:	c5e58593          	addi	a1,a1,-930 # 13c0 <malloc+0x35a>
     76a:	4509                	li	a0,2
     76c:	01d000ef          	jal	f88 <fprintf>
          exit(5);
     770:	4515                	li	a0,5
     772:	3f2000ef          	jal	b64 <exit>
        close(bb[1]);
     776:	f9442503          	lw	a0,-108(s0)
     77a:	412000ef          	jal	b8c <close>
        char *args[2] = { "cat", 0 };
     77e:	00001797          	auipc	a5,0x1
     782:	c9278793          	addi	a5,a5,-878 # 1410 <malloc+0x3aa>
     786:	f8f43c23          	sd	a5,-104(s0)
     78a:	fa043023          	sd	zero,-96(s0)
        exec("/cat", args);
     78e:	f9840593          	addi	a1,s0,-104
     792:	00001517          	auipc	a0,0x1
     796:	c8650513          	addi	a0,a0,-890 # 1418 <malloc+0x3b2>
     79a:	402000ef          	jal	b9c <exec>
        fprintf(2, "grind: cat: not found\n");
     79e:	00001597          	auipc	a1,0x1
     7a2:	c8258593          	addi	a1,a1,-894 # 1420 <malloc+0x3ba>
     7a6:	4509                	li	a0,2
     7a8:	7e0000ef          	jal	f88 <fprintf>
        exit(6);
     7ac:	4519                	li	a0,6
     7ae:	3b6000ef          	jal	b64 <exit>
        fprintf(2, "grind: fork failed\n");
     7b2:	00001597          	auipc	a1,0x1
     7b6:	abe58593          	addi	a1,a1,-1346 # 1270 <malloc+0x20a>
     7ba:	4509                	li	a0,2
     7bc:	7cc000ef          	jal	f88 <fprintf>
        exit(7);
     7c0:	451d                	li	a0,7
     7c2:	3a2000ef          	jal	b64 <exit>
     7c6:	8b3e                	mv	s6,a5
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     7c8:	f8040693          	addi	a3,s0,-128
     7cc:	865e                	mv	a2,s7
     7ce:	85da                	mv	a1,s6
     7d0:	00001517          	auipc	a0,0x1
     7d4:	c7050513          	addi	a0,a0,-912 # 1440 <malloc+0x3da>
     7d8:	7da000ef          	jal	fb2 <printf>
        exit(1);
     7dc:	4505                	li	a0,1
     7de:	386000ef          	jal	b64 <exit>

00000000000007e2 <iter>:
  }
}

void
iter()
{
     7e2:	7179                	addi	sp,sp,-48
     7e4:	f406                	sd	ra,40(sp)
     7e6:	f022                	sd	s0,32(sp)
     7e8:	1800                	addi	s0,sp,48
  unlink("a");
     7ea:	00001517          	auipc	a0,0x1
     7ee:	a9e50513          	addi	a0,a0,-1378 # 1288 <malloc+0x222>
     7f2:	3c2000ef          	jal	bb4 <unlink>
  unlink("b");
     7f6:	00001517          	auipc	a0,0x1
     7fa:	a4250513          	addi	a0,a0,-1470 # 1238 <malloc+0x1d2>
     7fe:	3b6000ef          	jal	bb4 <unlink>
  
  int pid1 = fork();
     802:	35a000ef          	jal	b5c <fork>
  if(pid1 < 0){
     806:	02054163          	bltz	a0,828 <iter+0x46>
     80a:	ec26                	sd	s1,24(sp)
     80c:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     80e:	e905                	bnez	a0,83e <iter+0x5c>
     810:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     812:	00001717          	auipc	a4,0x1
     816:	7ee70713          	addi	a4,a4,2030 # 2000 <rand_next>
     81a:	631c                	ld	a5,0(a4)
     81c:	01f7c793          	xori	a5,a5,31
     820:	e31c                	sd	a5,0(a4)
    go(0);
     822:	4501                	li	a0,0
     824:	851ff0ef          	jal	74 <go>
     828:	ec26                	sd	s1,24(sp)
     82a:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     82c:	00001517          	auipc	a0,0x1
     830:	a4450513          	addi	a0,a0,-1468 # 1270 <malloc+0x20a>
     834:	77e000ef          	jal	fb2 <printf>
    exit(1);
     838:	4505                	li	a0,1
     83a:	32a000ef          	jal	b64 <exit>
     83e:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     840:	31c000ef          	jal	b5c <fork>
     844:	892a                	mv	s2,a0
  if(pid2 < 0){
     846:	02054063          	bltz	a0,866 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     84a:	e51d                	bnez	a0,878 <iter+0x96>
    rand_next ^= 7177;
     84c:	00001697          	auipc	a3,0x1
     850:	7b468693          	addi	a3,a3,1972 # 2000 <rand_next>
     854:	629c                	ld	a5,0(a3)
     856:	6709                	lui	a4,0x2
     858:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x739>
     85c:	8fb9                	xor	a5,a5,a4
     85e:	e29c                	sd	a5,0(a3)
    go(1);
     860:	4505                	li	a0,1
     862:	813ff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     866:	00001517          	auipc	a0,0x1
     86a:	a0a50513          	addi	a0,a0,-1526 # 1270 <malloc+0x20a>
     86e:	744000ef          	jal	fb2 <printf>
    exit(1);
     872:	4505                	li	a0,1
     874:	2f0000ef          	jal	b64 <exit>
    exit(0);
  }

  int st1 = -1;
     878:	57fd                	li	a5,-1
     87a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     87e:	fdc40513          	addi	a0,s0,-36
     882:	2ea000ef          	jal	b6c <wait>
  if(st1 != 0){
     886:	fdc42783          	lw	a5,-36(s0)
     88a:	eb99                	bnez	a5,8a0 <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     88c:	57fd                	li	a5,-1
     88e:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     892:	fd840513          	addi	a0,s0,-40
     896:	2d6000ef          	jal	b6c <wait>

  exit(0);
     89a:	4501                	li	a0,0
     89c:	2c8000ef          	jal	b64 <exit>
    kill(pid1);
     8a0:	8526                	mv	a0,s1
     8a2:	2f2000ef          	jal	b94 <kill>
    kill(pid2);
     8a6:	854a                	mv	a0,s2
     8a8:	2ec000ef          	jal	b94 <kill>
     8ac:	b7c5                	j	88c <iter+0xaa>

00000000000008ae <main>:
}

int
main()
{
     8ae:	1101                	addi	sp,sp,-32
     8b0:	ec06                	sd	ra,24(sp)
     8b2:	e822                	sd	s0,16(sp)
     8b4:	e426                	sd	s1,8(sp)
     8b6:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     8b8:	00001497          	auipc	s1,0x1
     8bc:	74848493          	addi	s1,s1,1864 # 2000 <rand_next>
     8c0:	a809                	j	8d2 <main+0x24>
      iter();
     8c2:	f21ff0ef          	jal	7e2 <iter>
    sleep(20);
     8c6:	4551                	li	a0,20
     8c8:	32c000ef          	jal	bf4 <sleep>
    rand_next += 1;
     8cc:	609c                	ld	a5,0(s1)
     8ce:	0785                	addi	a5,a5,1
     8d0:	e09c                	sd	a5,0(s1)
    int pid = fork();
     8d2:	28a000ef          	jal	b5c <fork>
    if(pid == 0){
     8d6:	d575                	beqz	a0,8c2 <main+0x14>
    if(pid > 0){
     8d8:	fea057e3          	blez	a0,8c6 <main+0x18>
      wait(0);
     8dc:	4501                	li	a0,0
     8de:	28e000ef          	jal	b6c <wait>
     8e2:	b7d5                	j	8c6 <main+0x18>

00000000000008e4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     8e4:	1141                	addi	sp,sp,-16
     8e6:	e406                	sd	ra,8(sp)
     8e8:	e022                	sd	s0,0(sp)
     8ea:	0800                	addi	s0,sp,16
  extern int main();
  main();
     8ec:	fc3ff0ef          	jal	8ae <main>
  exit(0);
     8f0:	4501                	li	a0,0
     8f2:	272000ef          	jal	b64 <exit>

00000000000008f6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     8f6:	1141                	addi	sp,sp,-16
     8f8:	e422                	sd	s0,8(sp)
     8fa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8fc:	87aa                	mv	a5,a0
     8fe:	0585                	addi	a1,a1,1
     900:	0785                	addi	a5,a5,1
     902:	fff5c703          	lbu	a4,-1(a1)
     906:	fee78fa3          	sb	a4,-1(a5)
     90a:	fb75                	bnez	a4,8fe <strcpy+0x8>
    ;
  return os;
}
     90c:	6422                	ld	s0,8(sp)
     90e:	0141                	addi	sp,sp,16
     910:	8082                	ret

0000000000000912 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     912:	1141                	addi	sp,sp,-16
     914:	e422                	sd	s0,8(sp)
     916:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     918:	00054783          	lbu	a5,0(a0)
     91c:	cb91                	beqz	a5,930 <strcmp+0x1e>
     91e:	0005c703          	lbu	a4,0(a1)
     922:	00f71763          	bne	a4,a5,930 <strcmp+0x1e>
    p++, q++;
     926:	0505                	addi	a0,a0,1
     928:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     92a:	00054783          	lbu	a5,0(a0)
     92e:	fbe5                	bnez	a5,91e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     930:	0005c503          	lbu	a0,0(a1)
}
     934:	40a7853b          	subw	a0,a5,a0
     938:	6422                	ld	s0,8(sp)
     93a:	0141                	addi	sp,sp,16
     93c:	8082                	ret

000000000000093e <strlen>:

uint
strlen(const char *s)
{
     93e:	1141                	addi	sp,sp,-16
     940:	e422                	sd	s0,8(sp)
     942:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     944:	00054783          	lbu	a5,0(a0)
     948:	cf91                	beqz	a5,964 <strlen+0x26>
     94a:	0505                	addi	a0,a0,1
     94c:	87aa                	mv	a5,a0
     94e:	86be                	mv	a3,a5
     950:	0785                	addi	a5,a5,1
     952:	fff7c703          	lbu	a4,-1(a5)
     956:	ff65                	bnez	a4,94e <strlen+0x10>
     958:	40a6853b          	subw	a0,a3,a0
     95c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     95e:	6422                	ld	s0,8(sp)
     960:	0141                	addi	sp,sp,16
     962:	8082                	ret
  for(n = 0; s[n]; n++)
     964:	4501                	li	a0,0
     966:	bfe5                	j	95e <strlen+0x20>

0000000000000968 <memset>:

void*
memset(void *dst, int c, uint n)
{
     968:	1141                	addi	sp,sp,-16
     96a:	e422                	sd	s0,8(sp)
     96c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     96e:	ca19                	beqz	a2,984 <memset+0x1c>
     970:	87aa                	mv	a5,a0
     972:	1602                	slli	a2,a2,0x20
     974:	9201                	srli	a2,a2,0x20
     976:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     97a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     97e:	0785                	addi	a5,a5,1
     980:	fee79de3          	bne	a5,a4,97a <memset+0x12>
  }
  return dst;
}
     984:	6422                	ld	s0,8(sp)
     986:	0141                	addi	sp,sp,16
     988:	8082                	ret

000000000000098a <strchr>:

char*
strchr(const char *s, char c)
{
     98a:	1141                	addi	sp,sp,-16
     98c:	e422                	sd	s0,8(sp)
     98e:	0800                	addi	s0,sp,16
  for(; *s; s++)
     990:	00054783          	lbu	a5,0(a0)
     994:	cb99                	beqz	a5,9aa <strchr+0x20>
    if(*s == c)
     996:	00f58763          	beq	a1,a5,9a4 <strchr+0x1a>
  for(; *s; s++)
     99a:	0505                	addi	a0,a0,1
     99c:	00054783          	lbu	a5,0(a0)
     9a0:	fbfd                	bnez	a5,996 <strchr+0xc>
      return (char*)s;
  return 0;
     9a2:	4501                	li	a0,0
}
     9a4:	6422                	ld	s0,8(sp)
     9a6:	0141                	addi	sp,sp,16
     9a8:	8082                	ret
  return 0;
     9aa:	4501                	li	a0,0
     9ac:	bfe5                	j	9a4 <strchr+0x1a>

00000000000009ae <gets>:

char*
gets(char *buf, int max)
{
     9ae:	711d                	addi	sp,sp,-96
     9b0:	ec86                	sd	ra,88(sp)
     9b2:	e8a2                	sd	s0,80(sp)
     9b4:	e4a6                	sd	s1,72(sp)
     9b6:	e0ca                	sd	s2,64(sp)
     9b8:	fc4e                	sd	s3,56(sp)
     9ba:	f852                	sd	s4,48(sp)
     9bc:	f456                	sd	s5,40(sp)
     9be:	f05a                	sd	s6,32(sp)
     9c0:	ec5e                	sd	s7,24(sp)
     9c2:	1080                	addi	s0,sp,96
     9c4:	8baa                	mv	s7,a0
     9c6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9c8:	892a                	mv	s2,a0
     9ca:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9cc:	4aa9                	li	s5,10
     9ce:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     9d0:	89a6                	mv	s3,s1
     9d2:	2485                	addiw	s1,s1,1
     9d4:	0344d663          	bge	s1,s4,a00 <gets+0x52>
    cc = read(0, &c, 1);
     9d8:	4605                	li	a2,1
     9da:	faf40593          	addi	a1,s0,-81
     9de:	4501                	li	a0,0
     9e0:	19c000ef          	jal	b7c <read>
    if(cc < 1)
     9e4:	00a05e63          	blez	a0,a00 <gets+0x52>
    buf[i++] = c;
     9e8:	faf44783          	lbu	a5,-81(s0)
     9ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     9f0:	01578763          	beq	a5,s5,9fe <gets+0x50>
     9f4:	0905                	addi	s2,s2,1
     9f6:	fd679de3          	bne	a5,s6,9d0 <gets+0x22>
    buf[i++] = c;
     9fa:	89a6                	mv	s3,s1
     9fc:	a011                	j	a00 <gets+0x52>
     9fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     a00:	99de                	add	s3,s3,s7
     a02:	00098023          	sb	zero,0(s3)
  return buf;
}
     a06:	855e                	mv	a0,s7
     a08:	60e6                	ld	ra,88(sp)
     a0a:	6446                	ld	s0,80(sp)
     a0c:	64a6                	ld	s1,72(sp)
     a0e:	6906                	ld	s2,64(sp)
     a10:	79e2                	ld	s3,56(sp)
     a12:	7a42                	ld	s4,48(sp)
     a14:	7aa2                	ld	s5,40(sp)
     a16:	7b02                	ld	s6,32(sp)
     a18:	6be2                	ld	s7,24(sp)
     a1a:	6125                	addi	sp,sp,96
     a1c:	8082                	ret

0000000000000a1e <stat>:

int
stat(const char *n, struct stat *st)
{
     a1e:	1101                	addi	sp,sp,-32
     a20:	ec06                	sd	ra,24(sp)
     a22:	e822                	sd	s0,16(sp)
     a24:	e04a                	sd	s2,0(sp)
     a26:	1000                	addi	s0,sp,32
     a28:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a2a:	4581                	li	a1,0
     a2c:	178000ef          	jal	ba4 <open>
  if(fd < 0)
     a30:	02054263          	bltz	a0,a54 <stat+0x36>
     a34:	e426                	sd	s1,8(sp)
     a36:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a38:	85ca                	mv	a1,s2
     a3a:	182000ef          	jal	bbc <fstat>
     a3e:	892a                	mv	s2,a0
  close(fd);
     a40:	8526                	mv	a0,s1
     a42:	14a000ef          	jal	b8c <close>
  return r;
     a46:	64a2                	ld	s1,8(sp)
}
     a48:	854a                	mv	a0,s2
     a4a:	60e2                	ld	ra,24(sp)
     a4c:	6442                	ld	s0,16(sp)
     a4e:	6902                	ld	s2,0(sp)
     a50:	6105                	addi	sp,sp,32
     a52:	8082                	ret
    return -1;
     a54:	597d                	li	s2,-1
     a56:	bfcd                	j	a48 <stat+0x2a>

0000000000000a58 <atoi>:

int
atoi(const char *s)
{
     a58:	1141                	addi	sp,sp,-16
     a5a:	e422                	sd	s0,8(sp)
     a5c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a5e:	00054683          	lbu	a3,0(a0)
     a62:	fd06879b          	addiw	a5,a3,-48
     a66:	0ff7f793          	zext.b	a5,a5
     a6a:	4625                	li	a2,9
     a6c:	02f66863          	bltu	a2,a5,a9c <atoi+0x44>
     a70:	872a                	mv	a4,a0
  n = 0;
     a72:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     a74:	0705                	addi	a4,a4,1
     a76:	0025179b          	slliw	a5,a0,0x2
     a7a:	9fa9                	addw	a5,a5,a0
     a7c:	0017979b          	slliw	a5,a5,0x1
     a80:	9fb5                	addw	a5,a5,a3
     a82:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     a86:	00074683          	lbu	a3,0(a4)
     a8a:	fd06879b          	addiw	a5,a3,-48
     a8e:	0ff7f793          	zext.b	a5,a5
     a92:	fef671e3          	bgeu	a2,a5,a74 <atoi+0x1c>
  return n;
}
     a96:	6422                	ld	s0,8(sp)
     a98:	0141                	addi	sp,sp,16
     a9a:	8082                	ret
  n = 0;
     a9c:	4501                	li	a0,0
     a9e:	bfe5                	j	a96 <atoi+0x3e>

0000000000000aa0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     aa0:	1141                	addi	sp,sp,-16
     aa2:	e422                	sd	s0,8(sp)
     aa4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     aa6:	02b57463          	bgeu	a0,a1,ace <memmove+0x2e>
    while(n-- > 0)
     aaa:	00c05f63          	blez	a2,ac8 <memmove+0x28>
     aae:	1602                	slli	a2,a2,0x20
     ab0:	9201                	srli	a2,a2,0x20
     ab2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     ab6:	872a                	mv	a4,a0
      *dst++ = *src++;
     ab8:	0585                	addi	a1,a1,1
     aba:	0705                	addi	a4,a4,1
     abc:	fff5c683          	lbu	a3,-1(a1)
     ac0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     ac4:	fef71ae3          	bne	a4,a5,ab8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ac8:	6422                	ld	s0,8(sp)
     aca:	0141                	addi	sp,sp,16
     acc:	8082                	ret
    dst += n;
     ace:	00c50733          	add	a4,a0,a2
    src += n;
     ad2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ad4:	fec05ae3          	blez	a2,ac8 <memmove+0x28>
     ad8:	fff6079b          	addiw	a5,a2,-1
     adc:	1782                	slli	a5,a5,0x20
     ade:	9381                	srli	a5,a5,0x20
     ae0:	fff7c793          	not	a5,a5
     ae4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ae6:	15fd                	addi	a1,a1,-1
     ae8:	177d                	addi	a4,a4,-1
     aea:	0005c683          	lbu	a3,0(a1)
     aee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     af2:	fee79ae3          	bne	a5,a4,ae6 <memmove+0x46>
     af6:	bfc9                	j	ac8 <memmove+0x28>

0000000000000af8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     af8:	1141                	addi	sp,sp,-16
     afa:	e422                	sd	s0,8(sp)
     afc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     afe:	ca05                	beqz	a2,b2e <memcmp+0x36>
     b00:	fff6069b          	addiw	a3,a2,-1
     b04:	1682                	slli	a3,a3,0x20
     b06:	9281                	srli	a3,a3,0x20
     b08:	0685                	addi	a3,a3,1
     b0a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b0c:	00054783          	lbu	a5,0(a0)
     b10:	0005c703          	lbu	a4,0(a1)
     b14:	00e79863          	bne	a5,a4,b24 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b18:	0505                	addi	a0,a0,1
    p2++;
     b1a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     b1c:	fed518e3          	bne	a0,a3,b0c <memcmp+0x14>
  }
  return 0;
     b20:	4501                	li	a0,0
     b22:	a019                	j	b28 <memcmp+0x30>
      return *p1 - *p2;
     b24:	40e7853b          	subw	a0,a5,a4
}
     b28:	6422                	ld	s0,8(sp)
     b2a:	0141                	addi	sp,sp,16
     b2c:	8082                	ret
  return 0;
     b2e:	4501                	li	a0,0
     b30:	bfe5                	j	b28 <memcmp+0x30>

0000000000000b32 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b32:	1141                	addi	sp,sp,-16
     b34:	e406                	sd	ra,8(sp)
     b36:	e022                	sd	s0,0(sp)
     b38:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     b3a:	f67ff0ef          	jal	aa0 <memmove>
}
     b3e:	60a2                	ld	ra,8(sp)
     b40:	6402                	ld	s0,0(sp)
     b42:	0141                	addi	sp,sp,16
     b44:	8082                	ret

0000000000000b46 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
     b46:	1141                	addi	sp,sp,-16
     b48:	e422                	sd	s0,8(sp)
     b4a:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
     b4c:	040007b7          	lui	a5,0x4000
     b50:	17f5                	addi	a5,a5,-3 # 3fffffd <base+0x3ffdbf5>
     b52:	07b2                	slli	a5,a5,0xc
}
     b54:	4388                	lw	a0,0(a5)
     b56:	6422                	ld	s0,8(sp)
     b58:	0141                	addi	sp,sp,16
     b5a:	8082                	ret

0000000000000b5c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     b5c:	4885                	li	a7,1
 ecall
     b5e:	00000073          	ecall
 ret
     b62:	8082                	ret

0000000000000b64 <exit>:
.global exit
exit:
 li a7, SYS_exit
     b64:	4889                	li	a7,2
 ecall
     b66:	00000073          	ecall
 ret
     b6a:	8082                	ret

0000000000000b6c <wait>:
.global wait
wait:
 li a7, SYS_wait
     b6c:	488d                	li	a7,3
 ecall
     b6e:	00000073          	ecall
 ret
     b72:	8082                	ret

0000000000000b74 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b74:	4891                	li	a7,4
 ecall
     b76:	00000073          	ecall
 ret
     b7a:	8082                	ret

0000000000000b7c <read>:
.global read
read:
 li a7, SYS_read
     b7c:	4895                	li	a7,5
 ecall
     b7e:	00000073          	ecall
 ret
     b82:	8082                	ret

0000000000000b84 <write>:
.global write
write:
 li a7, SYS_write
     b84:	48c1                	li	a7,16
 ecall
     b86:	00000073          	ecall
 ret
     b8a:	8082                	ret

0000000000000b8c <close>:
.global close
close:
 li a7, SYS_close
     b8c:	48d5                	li	a7,21
 ecall
     b8e:	00000073          	ecall
 ret
     b92:	8082                	ret

0000000000000b94 <kill>:
.global kill
kill:
 li a7, SYS_kill
     b94:	4899                	li	a7,6
 ecall
     b96:	00000073          	ecall
 ret
     b9a:	8082                	ret

0000000000000b9c <exec>:
.global exec
exec:
 li a7, SYS_exec
     b9c:	489d                	li	a7,7
 ecall
     b9e:	00000073          	ecall
 ret
     ba2:	8082                	ret

0000000000000ba4 <open>:
.global open
open:
 li a7, SYS_open
     ba4:	48bd                	li	a7,15
 ecall
     ba6:	00000073          	ecall
 ret
     baa:	8082                	ret

0000000000000bac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     bac:	48c5                	li	a7,17
 ecall
     bae:	00000073          	ecall
 ret
     bb2:	8082                	ret

0000000000000bb4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     bb4:	48c9                	li	a7,18
 ecall
     bb6:	00000073          	ecall
 ret
     bba:	8082                	ret

0000000000000bbc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     bbc:	48a1                	li	a7,8
 ecall
     bbe:	00000073          	ecall
 ret
     bc2:	8082                	ret

0000000000000bc4 <link>:
.global link
link:
 li a7, SYS_link
     bc4:	48cd                	li	a7,19
 ecall
     bc6:	00000073          	ecall
 ret
     bca:	8082                	ret

0000000000000bcc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     bcc:	48d1                	li	a7,20
 ecall
     bce:	00000073          	ecall
 ret
     bd2:	8082                	ret

0000000000000bd4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     bd4:	48a5                	li	a7,9
 ecall
     bd6:	00000073          	ecall
 ret
     bda:	8082                	ret

0000000000000bdc <dup>:
.global dup
dup:
 li a7, SYS_dup
     bdc:	48a9                	li	a7,10
 ecall
     bde:	00000073          	ecall
 ret
     be2:	8082                	ret

0000000000000be4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     be4:	48ad                	li	a7,11
 ecall
     be6:	00000073          	ecall
 ret
     bea:	8082                	ret

0000000000000bec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     bec:	48b1                	li	a7,12
 ecall
     bee:	00000073          	ecall
 ret
     bf2:	8082                	ret

0000000000000bf4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     bf4:	48b5                	li	a7,13
 ecall
     bf6:	00000073          	ecall
 ret
     bfa:	8082                	ret

0000000000000bfc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     bfc:	48b9                	li	a7,14
 ecall
     bfe:	00000073          	ecall
 ret
     c02:	8082                	ret

0000000000000c04 <bind>:
.global bind
bind:
 li a7, SYS_bind
     c04:	48f5                	li	a7,29
 ecall
     c06:	00000073          	ecall
 ret
     c0a:	8082                	ret

0000000000000c0c <unbind>:
.global unbind
unbind:
 li a7, SYS_unbind
     c0c:	48f9                	li	a7,30
 ecall
     c0e:	00000073          	ecall
 ret
     c12:	8082                	ret

0000000000000c14 <send>:
.global send
send:
 li a7, SYS_send
     c14:	48fd                	li	a7,31
 ecall
     c16:	00000073          	ecall
 ret
     c1a:	8082                	ret

0000000000000c1c <recv>:
.global recv
recv:
 li a7, SYS_recv
     c1c:	02000893          	li	a7,32
 ecall
     c20:	00000073          	ecall
 ret
     c24:	8082                	ret

0000000000000c26 <pgpte>:
.global pgpte
pgpte:
 li a7, SYS_pgpte
     c26:	02100893          	li	a7,33
 ecall
     c2a:	00000073          	ecall
 ret
     c2e:	8082                	ret

0000000000000c30 <kpgtbl>:
.global kpgtbl
kpgtbl:
 li a7, SYS_kpgtbl
     c30:	02200893          	li	a7,34
 ecall
     c34:	00000073          	ecall
 ret
     c38:	8082                	ret

0000000000000c3a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     c3a:	1101                	addi	sp,sp,-32
     c3c:	ec06                	sd	ra,24(sp)
     c3e:	e822                	sd	s0,16(sp)
     c40:	1000                	addi	s0,sp,32
     c42:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     c46:	4605                	li	a2,1
     c48:	fef40593          	addi	a1,s0,-17
     c4c:	f39ff0ef          	jal	b84 <write>
}
     c50:	60e2                	ld	ra,24(sp)
     c52:	6442                	ld	s0,16(sp)
     c54:	6105                	addi	sp,sp,32
     c56:	8082                	ret

0000000000000c58 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     c58:	7139                	addi	sp,sp,-64
     c5a:	fc06                	sd	ra,56(sp)
     c5c:	f822                	sd	s0,48(sp)
     c5e:	f426                	sd	s1,40(sp)
     c60:	0080                	addi	s0,sp,64
     c62:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c64:	c299                	beqz	a3,c6a <printint+0x12>
     c66:	0805c963          	bltz	a1,cf8 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     c6a:	2581                	sext.w	a1,a1
  neg = 0;
     c6c:	4881                	li	a7,0
     c6e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     c72:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     c74:	2601                	sext.w	a2,a2
     c76:	00001517          	auipc	a0,0x1
     c7a:	85a50513          	addi	a0,a0,-1958 # 14d0 <digits>
     c7e:	883a                	mv	a6,a4
     c80:	2705                	addiw	a4,a4,1
     c82:	02c5f7bb          	remuw	a5,a1,a2
     c86:	1782                	slli	a5,a5,0x20
     c88:	9381                	srli	a5,a5,0x20
     c8a:	97aa                	add	a5,a5,a0
     c8c:	0007c783          	lbu	a5,0(a5)
     c90:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     c94:	0005879b          	sext.w	a5,a1
     c98:	02c5d5bb          	divuw	a1,a1,a2
     c9c:	0685                	addi	a3,a3,1
     c9e:	fec7f0e3          	bgeu	a5,a2,c7e <printint+0x26>
  if(neg)
     ca2:	00088c63          	beqz	a7,cba <printint+0x62>
    buf[i++] = '-';
     ca6:	fd070793          	addi	a5,a4,-48
     caa:	00878733          	add	a4,a5,s0
     cae:	02d00793          	li	a5,45
     cb2:	fef70823          	sb	a5,-16(a4)
     cb6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     cba:	02e05a63          	blez	a4,cee <printint+0x96>
     cbe:	f04a                	sd	s2,32(sp)
     cc0:	ec4e                	sd	s3,24(sp)
     cc2:	fc040793          	addi	a5,s0,-64
     cc6:	00e78933          	add	s2,a5,a4
     cca:	fff78993          	addi	s3,a5,-1
     cce:	99ba                	add	s3,s3,a4
     cd0:	377d                	addiw	a4,a4,-1
     cd2:	1702                	slli	a4,a4,0x20
     cd4:	9301                	srli	a4,a4,0x20
     cd6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     cda:	fff94583          	lbu	a1,-1(s2)
     cde:	8526                	mv	a0,s1
     ce0:	f5bff0ef          	jal	c3a <putc>
  while(--i >= 0)
     ce4:	197d                	addi	s2,s2,-1
     ce6:	ff391ae3          	bne	s2,s3,cda <printint+0x82>
     cea:	7902                	ld	s2,32(sp)
     cec:	69e2                	ld	s3,24(sp)
}
     cee:	70e2                	ld	ra,56(sp)
     cf0:	7442                	ld	s0,48(sp)
     cf2:	74a2                	ld	s1,40(sp)
     cf4:	6121                	addi	sp,sp,64
     cf6:	8082                	ret
    x = -xx;
     cf8:	40b005bb          	negw	a1,a1
    neg = 1;
     cfc:	4885                	li	a7,1
    x = -xx;
     cfe:	bf85                	j	c6e <printint+0x16>

0000000000000d00 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d00:	711d                	addi	sp,sp,-96
     d02:	ec86                	sd	ra,88(sp)
     d04:	e8a2                	sd	s0,80(sp)
     d06:	e0ca                	sd	s2,64(sp)
     d08:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d0a:	0005c903          	lbu	s2,0(a1)
     d0e:	26090863          	beqz	s2,f7e <vprintf+0x27e>
     d12:	e4a6                	sd	s1,72(sp)
     d14:	fc4e                	sd	s3,56(sp)
     d16:	f852                	sd	s4,48(sp)
     d18:	f456                	sd	s5,40(sp)
     d1a:	f05a                	sd	s6,32(sp)
     d1c:	ec5e                	sd	s7,24(sp)
     d1e:	e862                	sd	s8,16(sp)
     d20:	e466                	sd	s9,8(sp)
     d22:	8b2a                	mv	s6,a0
     d24:	8a2e                	mv	s4,a1
     d26:	8bb2                	mv	s7,a2
  state = 0;
     d28:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     d2a:	4481                	li	s1,0
     d2c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     d2e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     d32:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     d36:	06c00c93          	li	s9,108
     d3a:	a005                	j	d5a <vprintf+0x5a>
        putc(fd, c0);
     d3c:	85ca                	mv	a1,s2
     d3e:	855a                	mv	a0,s6
     d40:	efbff0ef          	jal	c3a <putc>
     d44:	a019                	j	d4a <vprintf+0x4a>
    } else if(state == '%'){
     d46:	03598263          	beq	s3,s5,d6a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     d4a:	2485                	addiw	s1,s1,1
     d4c:	8726                	mv	a4,s1
     d4e:	009a07b3          	add	a5,s4,s1
     d52:	0007c903          	lbu	s2,0(a5)
     d56:	20090c63          	beqz	s2,f6e <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     d5a:	0009079b          	sext.w	a5,s2
    if(state == 0){
     d5e:	fe0994e3          	bnez	s3,d46 <vprintf+0x46>
      if(c0 == '%'){
     d62:	fd579de3          	bne	a5,s5,d3c <vprintf+0x3c>
        state = '%';
     d66:	89be                	mv	s3,a5
     d68:	b7cd                	j	d4a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     d6a:	00ea06b3          	add	a3,s4,a4
     d6e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     d72:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     d74:	c681                	beqz	a3,d7c <vprintf+0x7c>
     d76:	9752                	add	a4,a4,s4
     d78:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     d7c:	03878f63          	beq	a5,s8,dba <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
     d80:	05978963          	beq	a5,s9,dd2 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     d84:	07500713          	li	a4,117
     d88:	0ee78363          	beq	a5,a4,e6e <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     d8c:	07800713          	li	a4,120
     d90:	12e78563          	beq	a5,a4,eba <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     d94:	07000713          	li	a4,112
     d98:	14e78a63          	beq	a5,a4,eec <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     d9c:	07300713          	li	a4,115
     da0:	18e78a63          	beq	a5,a4,f34 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     da4:	02500713          	li	a4,37
     da8:	04e79563          	bne	a5,a4,df2 <vprintf+0xf2>
        putc(fd, '%');
     dac:	02500593          	li	a1,37
     db0:	855a                	mv	a0,s6
     db2:	e89ff0ef          	jal	c3a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     db6:	4981                	li	s3,0
     db8:	bf49                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     dba:	008b8913          	addi	s2,s7,8
     dbe:	4685                	li	a3,1
     dc0:	4629                	li	a2,10
     dc2:	000ba583          	lw	a1,0(s7)
     dc6:	855a                	mv	a0,s6
     dc8:	e91ff0ef          	jal	c58 <printint>
     dcc:	8bca                	mv	s7,s2
      state = 0;
     dce:	4981                	li	s3,0
     dd0:	bfad                	j	d4a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     dd2:	06400793          	li	a5,100
     dd6:	02f68963          	beq	a3,a5,e08 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     dda:	06c00793          	li	a5,108
     dde:	04f68263          	beq	a3,a5,e22 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
     de2:	07500793          	li	a5,117
     de6:	0af68063          	beq	a3,a5,e86 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
     dea:	07800793          	li	a5,120
     dee:	0ef68263          	beq	a3,a5,ed2 <vprintf+0x1d2>
        putc(fd, '%');
     df2:	02500593          	li	a1,37
     df6:	855a                	mv	a0,s6
     df8:	e43ff0ef          	jal	c3a <putc>
        putc(fd, c0);
     dfc:	85ca                	mv	a1,s2
     dfe:	855a                	mv	a0,s6
     e00:	e3bff0ef          	jal	c3a <putc>
      state = 0;
     e04:	4981                	li	s3,0
     e06:	b791                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e08:	008b8913          	addi	s2,s7,8
     e0c:	4685                	li	a3,1
     e0e:	4629                	li	a2,10
     e10:	000ba583          	lw	a1,0(s7)
     e14:	855a                	mv	a0,s6
     e16:	e43ff0ef          	jal	c58 <printint>
        i += 1;
     e1a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     e1c:	8bca                	mv	s7,s2
      state = 0;
     e1e:	4981                	li	s3,0
        i += 1;
     e20:	b72d                	j	d4a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e22:	06400793          	li	a5,100
     e26:	02f60763          	beq	a2,a5,e54 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     e2a:	07500793          	li	a5,117
     e2e:	06f60963          	beq	a2,a5,ea0 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     e32:	07800793          	li	a5,120
     e36:	faf61ee3          	bne	a2,a5,df2 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e3a:	008b8913          	addi	s2,s7,8
     e3e:	4681                	li	a3,0
     e40:	4641                	li	a2,16
     e42:	000ba583          	lw	a1,0(s7)
     e46:	855a                	mv	a0,s6
     e48:	e11ff0ef          	jal	c58 <printint>
        i += 2;
     e4c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     e4e:	8bca                	mv	s7,s2
      state = 0;
     e50:	4981                	li	s3,0
        i += 2;
     e52:	bde5                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e54:	008b8913          	addi	s2,s7,8
     e58:	4685                	li	a3,1
     e5a:	4629                	li	a2,10
     e5c:	000ba583          	lw	a1,0(s7)
     e60:	855a                	mv	a0,s6
     e62:	df7ff0ef          	jal	c58 <printint>
        i += 2;
     e66:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     e68:	8bca                	mv	s7,s2
      state = 0;
     e6a:	4981                	li	s3,0
        i += 2;
     e6c:	bdf9                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
     e6e:	008b8913          	addi	s2,s7,8
     e72:	4681                	li	a3,0
     e74:	4629                	li	a2,10
     e76:	000ba583          	lw	a1,0(s7)
     e7a:	855a                	mv	a0,s6
     e7c:	dddff0ef          	jal	c58 <printint>
     e80:	8bca                	mv	s7,s2
      state = 0;
     e82:	4981                	li	s3,0
     e84:	b5d9                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e86:	008b8913          	addi	s2,s7,8
     e8a:	4681                	li	a3,0
     e8c:	4629                	li	a2,10
     e8e:	000ba583          	lw	a1,0(s7)
     e92:	855a                	mv	a0,s6
     e94:	dc5ff0ef          	jal	c58 <printint>
        i += 1;
     e98:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     e9a:	8bca                	mv	s7,s2
      state = 0;
     e9c:	4981                	li	s3,0
        i += 1;
     e9e:	b575                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ea0:	008b8913          	addi	s2,s7,8
     ea4:	4681                	li	a3,0
     ea6:	4629                	li	a2,10
     ea8:	000ba583          	lw	a1,0(s7)
     eac:	855a                	mv	a0,s6
     eae:	dabff0ef          	jal	c58 <printint>
        i += 2;
     eb2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     eb4:	8bca                	mv	s7,s2
      state = 0;
     eb6:	4981                	li	s3,0
        i += 2;
     eb8:	bd49                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
     eba:	008b8913          	addi	s2,s7,8
     ebe:	4681                	li	a3,0
     ec0:	4641                	li	a2,16
     ec2:	000ba583          	lw	a1,0(s7)
     ec6:	855a                	mv	a0,s6
     ec8:	d91ff0ef          	jal	c58 <printint>
     ecc:	8bca                	mv	s7,s2
      state = 0;
     ece:	4981                	li	s3,0
     ed0:	bdad                	j	d4a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     ed2:	008b8913          	addi	s2,s7,8
     ed6:	4681                	li	a3,0
     ed8:	4641                	li	a2,16
     eda:	000ba583          	lw	a1,0(s7)
     ede:	855a                	mv	a0,s6
     ee0:	d79ff0ef          	jal	c58 <printint>
        i += 1;
     ee4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     ee6:	8bca                	mv	s7,s2
      state = 0;
     ee8:	4981                	li	s3,0
        i += 1;
     eea:	b585                	j	d4a <vprintf+0x4a>
     eec:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     eee:	008b8d13          	addi	s10,s7,8
     ef2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     ef6:	03000593          	li	a1,48
     efa:	855a                	mv	a0,s6
     efc:	d3fff0ef          	jal	c3a <putc>
  putc(fd, 'x');
     f00:	07800593          	li	a1,120
     f04:	855a                	mv	a0,s6
     f06:	d35ff0ef          	jal	c3a <putc>
     f0a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f0c:	00000b97          	auipc	s7,0x0
     f10:	5c4b8b93          	addi	s7,s7,1476 # 14d0 <digits>
     f14:	03c9d793          	srli	a5,s3,0x3c
     f18:	97de                	add	a5,a5,s7
     f1a:	0007c583          	lbu	a1,0(a5)
     f1e:	855a                	mv	a0,s6
     f20:	d1bff0ef          	jal	c3a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     f24:	0992                	slli	s3,s3,0x4
     f26:	397d                	addiw	s2,s2,-1
     f28:	fe0916e3          	bnez	s2,f14 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
     f2c:	8bea                	mv	s7,s10
      state = 0;
     f2e:	4981                	li	s3,0
     f30:	6d02                	ld	s10,0(sp)
     f32:	bd21                	j	d4a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     f34:	008b8993          	addi	s3,s7,8
     f38:	000bb903          	ld	s2,0(s7)
     f3c:	00090f63          	beqz	s2,f5a <vprintf+0x25a>
        for(; *s; s++)
     f40:	00094583          	lbu	a1,0(s2)
     f44:	c195                	beqz	a1,f68 <vprintf+0x268>
          putc(fd, *s);
     f46:	855a                	mv	a0,s6
     f48:	cf3ff0ef          	jal	c3a <putc>
        for(; *s; s++)
     f4c:	0905                	addi	s2,s2,1
     f4e:	00094583          	lbu	a1,0(s2)
     f52:	f9f5                	bnez	a1,f46 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f54:	8bce                	mv	s7,s3
      state = 0;
     f56:	4981                	li	s3,0
     f58:	bbcd                	j	d4a <vprintf+0x4a>
          s = "(null)";
     f5a:	00000917          	auipc	s2,0x0
     f5e:	50e90913          	addi	s2,s2,1294 # 1468 <malloc+0x402>
        for(; *s; s++)
     f62:	02800593          	li	a1,40
     f66:	b7c5                	j	f46 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f68:	8bce                	mv	s7,s3
      state = 0;
     f6a:	4981                	li	s3,0
     f6c:	bbf9                	j	d4a <vprintf+0x4a>
     f6e:	64a6                	ld	s1,72(sp)
     f70:	79e2                	ld	s3,56(sp)
     f72:	7a42                	ld	s4,48(sp)
     f74:	7aa2                	ld	s5,40(sp)
     f76:	7b02                	ld	s6,32(sp)
     f78:	6be2                	ld	s7,24(sp)
     f7a:	6c42                	ld	s8,16(sp)
     f7c:	6ca2                	ld	s9,8(sp)
    }
  }
}
     f7e:	60e6                	ld	ra,88(sp)
     f80:	6446                	ld	s0,80(sp)
     f82:	6906                	ld	s2,64(sp)
     f84:	6125                	addi	sp,sp,96
     f86:	8082                	ret

0000000000000f88 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     f88:	715d                	addi	sp,sp,-80
     f8a:	ec06                	sd	ra,24(sp)
     f8c:	e822                	sd	s0,16(sp)
     f8e:	1000                	addi	s0,sp,32
     f90:	e010                	sd	a2,0(s0)
     f92:	e414                	sd	a3,8(s0)
     f94:	e818                	sd	a4,16(s0)
     f96:	ec1c                	sd	a5,24(s0)
     f98:	03043023          	sd	a6,32(s0)
     f9c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     fa0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     fa4:	8622                	mv	a2,s0
     fa6:	d5bff0ef          	jal	d00 <vprintf>
}
     faa:	60e2                	ld	ra,24(sp)
     fac:	6442                	ld	s0,16(sp)
     fae:	6161                	addi	sp,sp,80
     fb0:	8082                	ret

0000000000000fb2 <printf>:

void
printf(const char *fmt, ...)
{
     fb2:	711d                	addi	sp,sp,-96
     fb4:	ec06                	sd	ra,24(sp)
     fb6:	e822                	sd	s0,16(sp)
     fb8:	1000                	addi	s0,sp,32
     fba:	e40c                	sd	a1,8(s0)
     fbc:	e810                	sd	a2,16(s0)
     fbe:	ec14                	sd	a3,24(s0)
     fc0:	f018                	sd	a4,32(s0)
     fc2:	f41c                	sd	a5,40(s0)
     fc4:	03043823          	sd	a6,48(s0)
     fc8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     fcc:	00840613          	addi	a2,s0,8
     fd0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     fd4:	85aa                	mv	a1,a0
     fd6:	4505                	li	a0,1
     fd8:	d29ff0ef          	jal	d00 <vprintf>
}
     fdc:	60e2                	ld	ra,24(sp)
     fde:	6442                	ld	s0,16(sp)
     fe0:	6125                	addi	sp,sp,96
     fe2:	8082                	ret

0000000000000fe4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fe4:	1141                	addi	sp,sp,-16
     fe6:	e422                	sd	s0,8(sp)
     fe8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
     fea:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fee:	00001797          	auipc	a5,0x1
     ff2:	0227b783          	ld	a5,34(a5) # 2010 <freep>
     ff6:	a02d                	j	1020 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
     ff8:	4618                	lw	a4,8(a2)
     ffa:	9f2d                	addw	a4,a4,a1
     ffc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1000:	6398                	ld	a4,0(a5)
    1002:	6310                	ld	a2,0(a4)
    1004:	a83d                	j	1042 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1006:	ff852703          	lw	a4,-8(a0)
    100a:	9f31                	addw	a4,a4,a2
    100c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    100e:	ff053683          	ld	a3,-16(a0)
    1012:	a091                	j	1056 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1014:	6398                	ld	a4,0(a5)
    1016:	00e7e463          	bltu	a5,a4,101e <free+0x3a>
    101a:	00e6ea63          	bltu	a3,a4,102e <free+0x4a>
{
    101e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1020:	fed7fae3          	bgeu	a5,a3,1014 <free+0x30>
    1024:	6398                	ld	a4,0(a5)
    1026:	00e6e463          	bltu	a3,a4,102e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    102a:	fee7eae3          	bltu	a5,a4,101e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    102e:	ff852583          	lw	a1,-8(a0)
    1032:	6390                	ld	a2,0(a5)
    1034:	02059813          	slli	a6,a1,0x20
    1038:	01c85713          	srli	a4,a6,0x1c
    103c:	9736                	add	a4,a4,a3
    103e:	fae60de3          	beq	a2,a4,ff8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1042:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1046:	4790                	lw	a2,8(a5)
    1048:	02061593          	slli	a1,a2,0x20
    104c:	01c5d713          	srli	a4,a1,0x1c
    1050:	973e                	add	a4,a4,a5
    1052:	fae68ae3          	beq	a3,a4,1006 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1056:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1058:	00001717          	auipc	a4,0x1
    105c:	faf73c23          	sd	a5,-72(a4) # 2010 <freep>
}
    1060:	6422                	ld	s0,8(sp)
    1062:	0141                	addi	sp,sp,16
    1064:	8082                	ret

0000000000001066 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1066:	7139                	addi	sp,sp,-64
    1068:	fc06                	sd	ra,56(sp)
    106a:	f822                	sd	s0,48(sp)
    106c:	f426                	sd	s1,40(sp)
    106e:	ec4e                	sd	s3,24(sp)
    1070:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1072:	02051493          	slli	s1,a0,0x20
    1076:	9081                	srli	s1,s1,0x20
    1078:	04bd                	addi	s1,s1,15
    107a:	8091                	srli	s1,s1,0x4
    107c:	0014899b          	addiw	s3,s1,1
    1080:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1082:	00001517          	auipc	a0,0x1
    1086:	f8e53503          	ld	a0,-114(a0) # 2010 <freep>
    108a:	c915                	beqz	a0,10be <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    108c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    108e:	4798                	lw	a4,8(a5)
    1090:	08977a63          	bgeu	a4,s1,1124 <malloc+0xbe>
    1094:	f04a                	sd	s2,32(sp)
    1096:	e852                	sd	s4,16(sp)
    1098:	e456                	sd	s5,8(sp)
    109a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    109c:	8a4e                	mv	s4,s3
    109e:	0009871b          	sext.w	a4,s3
    10a2:	6685                	lui	a3,0x1
    10a4:	00d77363          	bgeu	a4,a3,10aa <malloc+0x44>
    10a8:	6a05                	lui	s4,0x1
    10aa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    10ae:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10b2:	00001917          	auipc	s2,0x1
    10b6:	f5e90913          	addi	s2,s2,-162 # 2010 <freep>
  if(p == (char*)-1)
    10ba:	5afd                	li	s5,-1
    10bc:	a081                	j	10fc <malloc+0x96>
    10be:	f04a                	sd	s2,32(sp)
    10c0:	e852                	sd	s4,16(sp)
    10c2:	e456                	sd	s5,8(sp)
    10c4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    10c6:	00001797          	auipc	a5,0x1
    10ca:	34278793          	addi	a5,a5,834 # 2408 <base>
    10ce:	00001717          	auipc	a4,0x1
    10d2:	f4f73123          	sd	a5,-190(a4) # 2010 <freep>
    10d6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    10d8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    10dc:	b7c1                	j	109c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    10de:	6398                	ld	a4,0(a5)
    10e0:	e118                	sd	a4,0(a0)
    10e2:	a8a9                	j	113c <malloc+0xd6>
  hp->s.size = nu;
    10e4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    10e8:	0541                	addi	a0,a0,16
    10ea:	efbff0ef          	jal	fe4 <free>
  return freep;
    10ee:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    10f2:	c12d                	beqz	a0,1154 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10f6:	4798                	lw	a4,8(a5)
    10f8:	02977263          	bgeu	a4,s1,111c <malloc+0xb6>
    if(p == freep)
    10fc:	00093703          	ld	a4,0(s2)
    1100:	853e                	mv	a0,a5
    1102:	fef719e3          	bne	a4,a5,10f4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1106:	8552                	mv	a0,s4
    1108:	ae5ff0ef          	jal	bec <sbrk>
  if(p == (char*)-1)
    110c:	fd551ce3          	bne	a0,s5,10e4 <malloc+0x7e>
        return 0;
    1110:	4501                	li	a0,0
    1112:	7902                	ld	s2,32(sp)
    1114:	6a42                	ld	s4,16(sp)
    1116:	6aa2                	ld	s5,8(sp)
    1118:	6b02                	ld	s6,0(sp)
    111a:	a03d                	j	1148 <malloc+0xe2>
    111c:	7902                	ld	s2,32(sp)
    111e:	6a42                	ld	s4,16(sp)
    1120:	6aa2                	ld	s5,8(sp)
    1122:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1124:	fae48de3          	beq	s1,a4,10de <malloc+0x78>
        p->s.size -= nunits;
    1128:	4137073b          	subw	a4,a4,s3
    112c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    112e:	02071693          	slli	a3,a4,0x20
    1132:	01c6d713          	srli	a4,a3,0x1c
    1136:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1138:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    113c:	00001717          	auipc	a4,0x1
    1140:	eca73a23          	sd	a0,-300(a4) # 2010 <freep>
      return (void*)(p + 1);
    1144:	01078513          	addi	a0,a5,16
  }
}
    1148:	70e2                	ld	ra,56(sp)
    114a:	7442                	ld	s0,48(sp)
    114c:	74a2                	ld	s1,40(sp)
    114e:	69e2                	ld	s3,24(sp)
    1150:	6121                	addi	sp,sp,64
    1152:	8082                	ret
    1154:	7902                	ld	s2,32(sp)
    1156:	6a42                	ld	s4,16(sp)
    1158:	6aa2                	ld	s5,8(sp)
    115a:	6b02                	ld	s6,0(sp)
    115c:	b7f5                	j	1148 <malloc+0xe2>
