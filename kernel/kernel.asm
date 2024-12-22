
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	2d013103          	ld	sp,720(sp) # 8000a2d0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	5d9040ef          	jal	80004dee <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	e7a9                	bnez	a5,80000076 <kfree+0x5a>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00024797          	auipc	a5,0x24
    80000034:	82078793          	addi	a5,a5,-2016 # 80023850 <end>
    80000038:	02f56f63          	bltu	a0,a5,80000076 <kfree+0x5a>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	02f57b63          	bgeu	a0,a5,80000076 <kfree+0x5a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	106000ef          	jal	8000014e <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    8000004c:	0000a917          	auipc	s2,0xa
    80000050:	2d490913          	addi	s2,s2,724 # 8000a320 <kmem>
    80000054:	854a                	mv	a0,s2
    80000056:	7fa050ef          	jal	80005850 <acquire>
  r->next = kmem.freelist;
    8000005a:	01893783          	ld	a5,24(s2)
    8000005e:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000060:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000064:	854a                	mv	a0,s2
    80000066:	083050ef          	jal	800058e8 <release>
}
    8000006a:	60e2                	ld	ra,24(sp)
    8000006c:	6442                	ld	s0,16(sp)
    8000006e:	64a2                	ld	s1,8(sp)
    80000070:	6902                	ld	s2,0(sp)
    80000072:	6105                	addi	sp,sp,32
    80000074:	8082                	ret
    panic("kfree");
    80000076:	00007517          	auipc	a0,0x7
    8000007a:	f8a50513          	addi	a0,a0,-118 # 80007000 <etext>
    8000007e:	4a4050ef          	jal	80005522 <panic>

0000000080000082 <freerange>:
{
    80000082:	7179                	addi	sp,sp,-48
    80000084:	f406                	sd	ra,40(sp)
    80000086:	f022                	sd	s0,32(sp)
    80000088:	ec26                	sd	s1,24(sp)
    8000008a:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000008c:	6785                	lui	a5,0x1
    8000008e:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000092:	00e504b3          	add	s1,a0,a4
    80000096:	777d                	lui	a4,0xfffff
    80000098:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000009a:	94be                	add	s1,s1,a5
    8000009c:	0295e263          	bltu	a1,s1,800000c0 <freerange+0x3e>
    800000a0:	e84a                	sd	s2,16(sp)
    800000a2:	e44e                	sd	s3,8(sp)
    800000a4:	e052                	sd	s4,0(sp)
    800000a6:	892e                	mv	s2,a1
    kfree(p);
    800000a8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000aa:	6985                	lui	s3,0x1
    kfree(p);
    800000ac:	01448533          	add	a0,s1,s4
    800000b0:	f6dff0ef          	jal	8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b4:	94ce                	add	s1,s1,s3
    800000b6:	fe997be3          	bgeu	s2,s1,800000ac <freerange+0x2a>
    800000ba:	6942                	ld	s2,16(sp)
    800000bc:	69a2                	ld	s3,8(sp)
    800000be:	6a02                	ld	s4,0(sp)
}
    800000c0:	70a2                	ld	ra,40(sp)
    800000c2:	7402                	ld	s0,32(sp)
    800000c4:	64e2                	ld	s1,24(sp)
    800000c6:	6145                	addi	sp,sp,48
    800000c8:	8082                	ret

00000000800000ca <kinit>:
{
    800000ca:	1141                	addi	sp,sp,-16
    800000cc:	e406                	sd	ra,8(sp)
    800000ce:	e022                	sd	s0,0(sp)
    800000d0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000d2:	00007597          	auipc	a1,0x7
    800000d6:	f3e58593          	addi	a1,a1,-194 # 80007010 <etext+0x10>
    800000da:	0000a517          	auipc	a0,0xa
    800000de:	24650513          	addi	a0,a0,582 # 8000a320 <kmem>
    800000e2:	6ee050ef          	jal	800057d0 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000e6:	45c5                	li	a1,17
    800000e8:	05ee                	slli	a1,a1,0x1b
    800000ea:	00023517          	auipc	a0,0x23
    800000ee:	76650513          	addi	a0,a0,1894 # 80023850 <end>
    800000f2:	f91ff0ef          	jal	80000082 <freerange>
}
    800000f6:	60a2                	ld	ra,8(sp)
    800000f8:	6402                	ld	s0,0(sp)
    800000fa:	0141                	addi	sp,sp,16
    800000fc:	8082                	ret

00000000800000fe <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    800000fe:	1101                	addi	sp,sp,-32
    80000100:	ec06                	sd	ra,24(sp)
    80000102:	e822                	sd	s0,16(sp)
    80000104:	e426                	sd	s1,8(sp)
    80000106:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000108:	0000a497          	auipc	s1,0xa
    8000010c:	21848493          	addi	s1,s1,536 # 8000a320 <kmem>
    80000110:	8526                	mv	a0,s1
    80000112:	73e050ef          	jal	80005850 <acquire>
  r = kmem.freelist;
    80000116:	6c84                	ld	s1,24(s1)
  if(r)
    80000118:	c485                	beqz	s1,80000140 <kalloc+0x42>
    kmem.freelist = r->next;
    8000011a:	609c                	ld	a5,0(s1)
    8000011c:	0000a517          	auipc	a0,0xa
    80000120:	20450513          	addi	a0,a0,516 # 8000a320 <kmem>
    80000124:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000126:	7c2050ef          	jal	800058e8 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000012a:	6605                	lui	a2,0x1
    8000012c:	4595                	li	a1,5
    8000012e:	8526                	mv	a0,s1
    80000130:	01e000ef          	jal	8000014e <memset>
  return (void*)r;
}
    80000134:	8526                	mv	a0,s1
    80000136:	60e2                	ld	ra,24(sp)
    80000138:	6442                	ld	s0,16(sp)
    8000013a:	64a2                	ld	s1,8(sp)
    8000013c:	6105                	addi	sp,sp,32
    8000013e:	8082                	ret
  release(&kmem.lock);
    80000140:	0000a517          	auipc	a0,0xa
    80000144:	1e050513          	addi	a0,a0,480 # 8000a320 <kmem>
    80000148:	7a0050ef          	jal	800058e8 <release>
  if(r)
    8000014c:	b7e5                	j	80000134 <kalloc+0x36>

000000008000014e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000014e:	1141                	addi	sp,sp,-16
    80000150:	e422                	sd	s0,8(sp)
    80000152:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000154:	ca19                	beqz	a2,8000016a <memset+0x1c>
    80000156:	87aa                	mv	a5,a0
    80000158:	1602                	slli	a2,a2,0x20
    8000015a:	9201                	srli	a2,a2,0x20
    8000015c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000160:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000164:	0785                	addi	a5,a5,1
    80000166:	fee79de3          	bne	a5,a4,80000160 <memset+0x12>
  }
  return dst;
}
    8000016a:	6422                	ld	s0,8(sp)
    8000016c:	0141                	addi	sp,sp,16
    8000016e:	8082                	ret

0000000080000170 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000170:	1141                	addi	sp,sp,-16
    80000172:	e422                	sd	s0,8(sp)
    80000174:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000176:	ca05                	beqz	a2,800001a6 <memcmp+0x36>
    80000178:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    8000017c:	1682                	slli	a3,a3,0x20
    8000017e:	9281                	srli	a3,a3,0x20
    80000180:	0685                	addi	a3,a3,1
    80000182:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000184:	00054783          	lbu	a5,0(a0)
    80000188:	0005c703          	lbu	a4,0(a1)
    8000018c:	00e79863          	bne	a5,a4,8000019c <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000190:	0505                	addi	a0,a0,1
    80000192:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000194:	fed518e3          	bne	a0,a3,80000184 <memcmp+0x14>
  }

  return 0;
    80000198:	4501                	li	a0,0
    8000019a:	a019                	j	800001a0 <memcmp+0x30>
      return *s1 - *s2;
    8000019c:	40e7853b          	subw	a0,a5,a4
}
    800001a0:	6422                	ld	s0,8(sp)
    800001a2:	0141                	addi	sp,sp,16
    800001a4:	8082                	ret
  return 0;
    800001a6:	4501                	li	a0,0
    800001a8:	bfe5                	j	800001a0 <memcmp+0x30>

00000000800001aa <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001aa:	1141                	addi	sp,sp,-16
    800001ac:	e422                	sd	s0,8(sp)
    800001ae:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001b0:	c205                	beqz	a2,800001d0 <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001b2:	02a5e263          	bltu	a1,a0,800001d6 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001b6:	1602                	slli	a2,a2,0x20
    800001b8:	9201                	srli	a2,a2,0x20
    800001ba:	00c587b3          	add	a5,a1,a2
{
    800001be:	872a                	mv	a4,a0
      *d++ = *s++;
    800001c0:	0585                	addi	a1,a1,1
    800001c2:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdb7b1>
    800001c4:	fff5c683          	lbu	a3,-1(a1)
    800001c8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001cc:	feb79ae3          	bne	a5,a1,800001c0 <memmove+0x16>

  return dst;
}
    800001d0:	6422                	ld	s0,8(sp)
    800001d2:	0141                	addi	sp,sp,16
    800001d4:	8082                	ret
  if(s < d && s + n > d){
    800001d6:	02061693          	slli	a3,a2,0x20
    800001da:	9281                	srli	a3,a3,0x20
    800001dc:	00d58733          	add	a4,a1,a3
    800001e0:	fce57be3          	bgeu	a0,a4,800001b6 <memmove+0xc>
    d += n;
    800001e4:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800001e6:	fff6079b          	addiw	a5,a2,-1
    800001ea:	1782                	slli	a5,a5,0x20
    800001ec:	9381                	srli	a5,a5,0x20
    800001ee:	fff7c793          	not	a5,a5
    800001f2:	97ba                	add	a5,a5,a4
      *--d = *--s;
    800001f4:	177d                	addi	a4,a4,-1
    800001f6:	16fd                	addi	a3,a3,-1
    800001f8:	00074603          	lbu	a2,0(a4)
    800001fc:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000200:	fef71ae3          	bne	a4,a5,800001f4 <memmove+0x4a>
    80000204:	b7f1                	j	800001d0 <memmove+0x26>

0000000080000206 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000206:	1141                	addi	sp,sp,-16
    80000208:	e406                	sd	ra,8(sp)
    8000020a:	e022                	sd	s0,0(sp)
    8000020c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000020e:	f9dff0ef          	jal	800001aa <memmove>
}
    80000212:	60a2                	ld	ra,8(sp)
    80000214:	6402                	ld	s0,0(sp)
    80000216:	0141                	addi	sp,sp,16
    80000218:	8082                	ret

000000008000021a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000021a:	1141                	addi	sp,sp,-16
    8000021c:	e422                	sd	s0,8(sp)
    8000021e:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000220:	ce11                	beqz	a2,8000023c <strncmp+0x22>
    80000222:	00054783          	lbu	a5,0(a0)
    80000226:	cf89                	beqz	a5,80000240 <strncmp+0x26>
    80000228:	0005c703          	lbu	a4,0(a1)
    8000022c:	00f71a63          	bne	a4,a5,80000240 <strncmp+0x26>
    n--, p++, q++;
    80000230:	367d                	addiw	a2,a2,-1
    80000232:	0505                	addi	a0,a0,1
    80000234:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000236:	f675                	bnez	a2,80000222 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000238:	4501                	li	a0,0
    8000023a:	a801                	j	8000024a <strncmp+0x30>
    8000023c:	4501                	li	a0,0
    8000023e:	a031                	j	8000024a <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
    80000240:	00054503          	lbu	a0,0(a0)
    80000244:	0005c783          	lbu	a5,0(a1)
    80000248:	9d1d                	subw	a0,a0,a5
}
    8000024a:	6422                	ld	s0,8(sp)
    8000024c:	0141                	addi	sp,sp,16
    8000024e:	8082                	ret

0000000080000250 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000250:	1141                	addi	sp,sp,-16
    80000252:	e422                	sd	s0,8(sp)
    80000254:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000256:	87aa                	mv	a5,a0
    80000258:	86b2                	mv	a3,a2
    8000025a:	367d                	addiw	a2,a2,-1
    8000025c:	02d05563          	blez	a3,80000286 <strncpy+0x36>
    80000260:	0785                	addi	a5,a5,1
    80000262:	0005c703          	lbu	a4,0(a1)
    80000266:	fee78fa3          	sb	a4,-1(a5)
    8000026a:	0585                	addi	a1,a1,1
    8000026c:	f775                	bnez	a4,80000258 <strncpy+0x8>
    ;
  while(n-- > 0)
    8000026e:	873e                	mv	a4,a5
    80000270:	9fb5                	addw	a5,a5,a3
    80000272:	37fd                	addiw	a5,a5,-1
    80000274:	00c05963          	blez	a2,80000286 <strncpy+0x36>
    *s++ = 0;
    80000278:	0705                	addi	a4,a4,1
    8000027a:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    8000027e:	40e786bb          	subw	a3,a5,a4
    80000282:	fed04be3          	bgtz	a3,80000278 <strncpy+0x28>
  return os;
}
    80000286:	6422                	ld	s0,8(sp)
    80000288:	0141                	addi	sp,sp,16
    8000028a:	8082                	ret

000000008000028c <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    8000028c:	1141                	addi	sp,sp,-16
    8000028e:	e422                	sd	s0,8(sp)
    80000290:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000292:	02c05363          	blez	a2,800002b8 <safestrcpy+0x2c>
    80000296:	fff6069b          	addiw	a3,a2,-1
    8000029a:	1682                	slli	a3,a3,0x20
    8000029c:	9281                	srli	a3,a3,0x20
    8000029e:	96ae                	add	a3,a3,a1
    800002a0:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002a2:	00d58963          	beq	a1,a3,800002b4 <safestrcpy+0x28>
    800002a6:	0585                	addi	a1,a1,1
    800002a8:	0785                	addi	a5,a5,1
    800002aa:	fff5c703          	lbu	a4,-1(a1)
    800002ae:	fee78fa3          	sb	a4,-1(a5)
    800002b2:	fb65                	bnez	a4,800002a2 <safestrcpy+0x16>
    ;
  *s = 0;
    800002b4:	00078023          	sb	zero,0(a5)
  return os;
}
    800002b8:	6422                	ld	s0,8(sp)
    800002ba:	0141                	addi	sp,sp,16
    800002bc:	8082                	ret

00000000800002be <strlen>:

int
strlen(const char *s)
{
    800002be:	1141                	addi	sp,sp,-16
    800002c0:	e422                	sd	s0,8(sp)
    800002c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002c4:	00054783          	lbu	a5,0(a0)
    800002c8:	cf91                	beqz	a5,800002e4 <strlen+0x26>
    800002ca:	0505                	addi	a0,a0,1
    800002cc:	87aa                	mv	a5,a0
    800002ce:	86be                	mv	a3,a5
    800002d0:	0785                	addi	a5,a5,1
    800002d2:	fff7c703          	lbu	a4,-1(a5)
    800002d6:	ff65                	bnez	a4,800002ce <strlen+0x10>
    800002d8:	40a6853b          	subw	a0,a3,a0
    800002dc:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    800002de:	6422                	ld	s0,8(sp)
    800002e0:	0141                	addi	sp,sp,16
    800002e2:	8082                	ret
  for(n = 0; s[n]; n++)
    800002e4:	4501                	li	a0,0
    800002e6:	bfe5                	j	800002de <strlen+0x20>

00000000800002e8 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800002e8:	1141                	addi	sp,sp,-16
    800002ea:	e406                	sd	ra,8(sp)
    800002ec:	e022                	sd	s0,0(sp)
    800002ee:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800002f0:	285000ef          	jal	80000d74 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    800002f4:	0000a717          	auipc	a4,0xa
    800002f8:	ffc70713          	addi	a4,a4,-4 # 8000a2f0 <started>
  if(cpuid() == 0){
    800002fc:	c51d                	beqz	a0,8000032a <main+0x42>
    while(started == 0)
    800002fe:	431c                	lw	a5,0(a4)
    80000300:	2781                	sext.w	a5,a5
    80000302:	dff5                	beqz	a5,800002fe <main+0x16>
      ;
    __sync_synchronize();
    80000304:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000308:	26d000ef          	jal	80000d74 <cpuid>
    8000030c:	85aa                	mv	a1,a0
    8000030e:	00007517          	auipc	a0,0x7
    80000312:	d2a50513          	addi	a0,a0,-726 # 80007038 <etext+0x38>
    80000316:	73b040ef          	jal	80005250 <printf>
    kvminithart();    // turn on paging
    8000031a:	080000ef          	jal	8000039a <kvminithart>
    trapinithart();   // install kernel trap vector
    8000031e:	612010ef          	jal	80001930 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000322:	4e6040ef          	jal	80004808 <plicinithart>
  }

  scheduler();        
    80000326:	74f000ef          	jal	80001274 <scheduler>
    consoleinit();
    8000032a:	651040ef          	jal	8000517a <consoleinit>
    printfinit();
    8000032e:	22e050ef          	jal	8000555c <printfinit>
    printf("\n");
    80000332:	00007517          	auipc	a0,0x7
    80000336:	ce650513          	addi	a0,a0,-794 # 80007018 <etext+0x18>
    8000033a:	717040ef          	jal	80005250 <printf>
    printf("xv6 kernel is booting\n");
    8000033e:	00007517          	auipc	a0,0x7
    80000342:	ce250513          	addi	a0,a0,-798 # 80007020 <etext+0x20>
    80000346:	70b040ef          	jal	80005250 <printf>
    printf("\n");
    8000034a:	00007517          	auipc	a0,0x7
    8000034e:	cce50513          	addi	a0,a0,-818 # 80007018 <etext+0x18>
    80000352:	6ff040ef          	jal	80005250 <printf>
    kinit();         // physical page allocator
    80000356:	d75ff0ef          	jal	800000ca <kinit>
    kvminit();       // create kernel page table
    8000035a:	2d4000ef          	jal	8000062e <kvminit>
    kvminithart();   // turn on paging
    8000035e:	03c000ef          	jal	8000039a <kvminithart>
    procinit();      // process table
    80000362:	15f000ef          	jal	80000cc0 <procinit>
    trapinit();      // trap vectors
    80000366:	5a6010ef          	jal	8000190c <trapinit>
    trapinithart();  // install kernel trap vector
    8000036a:	5c6010ef          	jal	80001930 <trapinithart>
    plicinit();      // set up interrupt controller
    8000036e:	480040ef          	jal	800047ee <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000372:	496040ef          	jal	80004808 <plicinithart>
    binit();         // buffer cache
    80000376:	441010ef          	jal	80001fb6 <binit>
    iinit();         // inode table
    8000037a:	232020ef          	jal	800025ac <iinit>
    fileinit();      // file table
    8000037e:	7df020ef          	jal	8000335c <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000382:	576040ef          	jal	800048f8 <virtio_disk_init>
    userinit();      // first user process
    80000386:	523000ef          	jal	800010a8 <userinit>
    __sync_synchronize();
    8000038a:	0330000f          	fence	rw,rw
    started = 1;
    8000038e:	4785                	li	a5,1
    80000390:	0000a717          	auipc	a4,0xa
    80000394:	f6f72023          	sw	a5,-160(a4) # 8000a2f0 <started>
    80000398:	b779                	j	80000326 <main+0x3e>

000000008000039a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000039a:	1141                	addi	sp,sp,-16
    8000039c:	e422                	sd	s0,8(sp)
    8000039e:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800003a0:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800003a4:	0000a797          	auipc	a5,0xa
    800003a8:	f547b783          	ld	a5,-172(a5) # 8000a2f8 <kernel_pagetable>
    800003ac:	83b1                	srli	a5,a5,0xc
    800003ae:	577d                	li	a4,-1
    800003b0:	177e                	slli	a4,a4,0x3f
    800003b2:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800003b4:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800003b8:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800003bc:	6422                	ld	s0,8(sp)
    800003be:	0141                	addi	sp,sp,16
    800003c0:	8082                	ret

00000000800003c2 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800003c2:	7139                	addi	sp,sp,-64
    800003c4:	fc06                	sd	ra,56(sp)
    800003c6:	f822                	sd	s0,48(sp)
    800003c8:	f426                	sd	s1,40(sp)
    800003ca:	f04a                	sd	s2,32(sp)
    800003cc:	ec4e                	sd	s3,24(sp)
    800003ce:	e852                	sd	s4,16(sp)
    800003d0:	e456                	sd	s5,8(sp)
    800003d2:	e05a                	sd	s6,0(sp)
    800003d4:	0080                	addi	s0,sp,64
    800003d6:	892a                	mv	s2,a0
    800003d8:	89ae                	mv	s3,a1
    800003da:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    800003dc:	57fd                	li	a5,-1
    800003de:	83e9                	srli	a5,a5,0x1a
    800003e0:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800003e2:	4b31                	li	s6,12
  if(va >= MAXVA)
    800003e4:	02b7fb63          	bgeu	a5,a1,8000041a <walk+0x58>
    panic("walk");
    800003e8:	00007517          	auipc	a0,0x7
    800003ec:	c6850513          	addi	a0,a0,-920 # 80007050 <etext+0x50>
    800003f0:	132050ef          	jal	80005522 <panic>
      if(PTE_LEAF(*pte)) {
        return pte;
      }
#endif
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800003f4:	060a8563          	beqz	s5,8000045e <walk+0x9c>
    800003f8:	d07ff0ef          	jal	800000fe <kalloc>
    800003fc:	892a                	mv	s2,a0
    800003fe:	c135                	beqz	a0,80000462 <walk+0xa0>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000400:	6605                	lui	a2,0x1
    80000402:	4581                	li	a1,0
    80000404:	d4bff0ef          	jal	8000014e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000408:	00c95793          	srli	a5,s2,0xc
    8000040c:	07aa                	slli	a5,a5,0xa
    8000040e:	0017e793          	ori	a5,a5,1
    80000412:	e09c                	sd	a5,0(s1)
  for(int level = 2; level > 0; level--) {
    80000414:	3a5d                	addiw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffdb7a7>
    80000416:	036a0263          	beq	s4,s6,8000043a <walk+0x78>
    pte_t *pte = &pagetable[PX(level, va)];
    8000041a:	0149d4b3          	srl	s1,s3,s4
    8000041e:	1ff4f493          	andi	s1,s1,511
    80000422:	048e                	slli	s1,s1,0x3
    80000424:	94ca                	add	s1,s1,s2
    if(*pte & PTE_V) {
    80000426:	609c                	ld	a5,0(s1)
    80000428:	0017f713          	andi	a4,a5,1
    8000042c:	d761                	beqz	a4,800003f4 <walk+0x32>
      pagetable = (pagetable_t)PTE2PA(*pte);
    8000042e:	00a7d913          	srli	s2,a5,0xa
    80000432:	0932                	slli	s2,s2,0xc
      if(PTE_LEAF(*pte)) {
    80000434:	8bb9                	andi	a5,a5,14
    80000436:	dff9                	beqz	a5,80000414 <walk+0x52>
    80000438:	a801                	j	80000448 <walk+0x86>
    }
  }
  return &pagetable[PX(0, va)];
    8000043a:	00c9d993          	srli	s3,s3,0xc
    8000043e:	1ff9f993          	andi	s3,s3,511
    80000442:	098e                	slli	s3,s3,0x3
    80000444:	013904b3          	add	s1,s2,s3
}
    80000448:	8526                	mv	a0,s1
    8000044a:	70e2                	ld	ra,56(sp)
    8000044c:	7442                	ld	s0,48(sp)
    8000044e:	74a2                	ld	s1,40(sp)
    80000450:	7902                	ld	s2,32(sp)
    80000452:	69e2                	ld	s3,24(sp)
    80000454:	6a42                	ld	s4,16(sp)
    80000456:	6aa2                	ld	s5,8(sp)
    80000458:	6b02                	ld	s6,0(sp)
    8000045a:	6121                	addi	sp,sp,64
    8000045c:	8082                	ret
        return 0;
    8000045e:	4481                	li	s1,0
    80000460:	b7e5                	j	80000448 <walk+0x86>
    80000462:	84aa                	mv	s1,a0
    80000464:	b7d5                	j	80000448 <walk+0x86>

0000000080000466 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000466:	57fd                	li	a5,-1
    80000468:	83e9                	srli	a5,a5,0x1a
    8000046a:	00b7f463          	bgeu	a5,a1,80000472 <walkaddr+0xc>
    return 0;
    8000046e:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000470:	8082                	ret
{
    80000472:	1141                	addi	sp,sp,-16
    80000474:	e406                	sd	ra,8(sp)
    80000476:	e022                	sd	s0,0(sp)
    80000478:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000047a:	4601                	li	a2,0
    8000047c:	f47ff0ef          	jal	800003c2 <walk>
  if(pte == 0)
    80000480:	c105                	beqz	a0,800004a0 <walkaddr+0x3a>
  if((*pte & PTE_V) == 0)
    80000482:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000484:	0117f693          	andi	a3,a5,17
    80000488:	4745                	li	a4,17
    return 0;
    8000048a:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000048c:	00e68663          	beq	a3,a4,80000498 <walkaddr+0x32>
}
    80000490:	60a2                	ld	ra,8(sp)
    80000492:	6402                	ld	s0,0(sp)
    80000494:	0141                	addi	sp,sp,16
    80000496:	8082                	ret
  pa = PTE2PA(*pte);
    80000498:	83a9                	srli	a5,a5,0xa
    8000049a:	00c79513          	slli	a0,a5,0xc
  return pa;
    8000049e:	bfcd                	j	80000490 <walkaddr+0x2a>
    return 0;
    800004a0:	4501                	li	a0,0
    800004a2:	b7fd                	j	80000490 <walkaddr+0x2a>

00000000800004a4 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800004a4:	715d                	addi	sp,sp,-80
    800004a6:	e486                	sd	ra,72(sp)
    800004a8:	e0a2                	sd	s0,64(sp)
    800004aa:	fc26                	sd	s1,56(sp)
    800004ac:	f84a                	sd	s2,48(sp)
    800004ae:	f44e                	sd	s3,40(sp)
    800004b0:	f052                	sd	s4,32(sp)
    800004b2:	ec56                	sd	s5,24(sp)
    800004b4:	e85a                	sd	s6,16(sp)
    800004b6:	e45e                	sd	s7,8(sp)
    800004b8:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800004ba:	03459793          	slli	a5,a1,0x34
    800004be:	e7a9                	bnez	a5,80000508 <mappages+0x64>
    800004c0:	8aaa                	mv	s5,a0
    800004c2:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800004c4:	03461793          	slli	a5,a2,0x34
    800004c8:	e7b1                	bnez	a5,80000514 <mappages+0x70>
    panic("mappages: size not aligned");

  if(size == 0)
    800004ca:	ca39                	beqz	a2,80000520 <mappages+0x7c>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800004cc:	77fd                	lui	a5,0xfffff
    800004ce:	963e                	add	a2,a2,a5
    800004d0:	00b609b3          	add	s3,a2,a1
  a = va;
    800004d4:	892e                	mv	s2,a1
    800004d6:	40b68a33          	sub	s4,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800004da:	6b85                	lui	s7,0x1
    800004dc:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    800004e0:	4605                	li	a2,1
    800004e2:	85ca                	mv	a1,s2
    800004e4:	8556                	mv	a0,s5
    800004e6:	eddff0ef          	jal	800003c2 <walk>
    800004ea:	c539                	beqz	a0,80000538 <mappages+0x94>
    if(*pte & PTE_V)
    800004ec:	611c                	ld	a5,0(a0)
    800004ee:	8b85                	andi	a5,a5,1
    800004f0:	ef95                	bnez	a5,8000052c <mappages+0x88>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800004f2:	80b1                	srli	s1,s1,0xc
    800004f4:	04aa                	slli	s1,s1,0xa
    800004f6:	0164e4b3          	or	s1,s1,s6
    800004fa:	0014e493          	ori	s1,s1,1
    800004fe:	e104                	sd	s1,0(a0)
    if(a == last)
    80000500:	05390863          	beq	s2,s3,80000550 <mappages+0xac>
    a += PGSIZE;
    80000504:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    80000506:	bfd9                	j	800004dc <mappages+0x38>
    panic("mappages: va not aligned");
    80000508:	00007517          	auipc	a0,0x7
    8000050c:	b5050513          	addi	a0,a0,-1200 # 80007058 <etext+0x58>
    80000510:	012050ef          	jal	80005522 <panic>
    panic("mappages: size not aligned");
    80000514:	00007517          	auipc	a0,0x7
    80000518:	b6450513          	addi	a0,a0,-1180 # 80007078 <etext+0x78>
    8000051c:	006050ef          	jal	80005522 <panic>
    panic("mappages: size");
    80000520:	00007517          	auipc	a0,0x7
    80000524:	b7850513          	addi	a0,a0,-1160 # 80007098 <etext+0x98>
    80000528:	7fb040ef          	jal	80005522 <panic>
      panic("mappages: remap");
    8000052c:	00007517          	auipc	a0,0x7
    80000530:	b7c50513          	addi	a0,a0,-1156 # 800070a8 <etext+0xa8>
    80000534:	7ef040ef          	jal	80005522 <panic>
      return -1;
    80000538:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    8000053a:	60a6                	ld	ra,72(sp)
    8000053c:	6406                	ld	s0,64(sp)
    8000053e:	74e2                	ld	s1,56(sp)
    80000540:	7942                	ld	s2,48(sp)
    80000542:	79a2                	ld	s3,40(sp)
    80000544:	7a02                	ld	s4,32(sp)
    80000546:	6ae2                	ld	s5,24(sp)
    80000548:	6b42                	ld	s6,16(sp)
    8000054a:	6ba2                	ld	s7,8(sp)
    8000054c:	6161                	addi	sp,sp,80
    8000054e:	8082                	ret
  return 0;
    80000550:	4501                	li	a0,0
    80000552:	b7e5                	j	8000053a <mappages+0x96>

0000000080000554 <kvmmap>:
{
    80000554:	1141                	addi	sp,sp,-16
    80000556:	e406                	sd	ra,8(sp)
    80000558:	e022                	sd	s0,0(sp)
    8000055a:	0800                	addi	s0,sp,16
    8000055c:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000055e:	86b2                	mv	a3,a2
    80000560:	863e                	mv	a2,a5
    80000562:	f43ff0ef          	jal	800004a4 <mappages>
    80000566:	e509                	bnez	a0,80000570 <kvmmap+0x1c>
}
    80000568:	60a2                	ld	ra,8(sp)
    8000056a:	6402                	ld	s0,0(sp)
    8000056c:	0141                	addi	sp,sp,16
    8000056e:	8082                	ret
    panic("kvmmap");
    80000570:	00007517          	auipc	a0,0x7
    80000574:	b4850513          	addi	a0,a0,-1208 # 800070b8 <etext+0xb8>
    80000578:	7ab040ef          	jal	80005522 <panic>

000000008000057c <kvmmake>:
{
    8000057c:	1101                	addi	sp,sp,-32
    8000057e:	ec06                	sd	ra,24(sp)
    80000580:	e822                	sd	s0,16(sp)
    80000582:	e426                	sd	s1,8(sp)
    80000584:	e04a                	sd	s2,0(sp)
    80000586:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000588:	b77ff0ef          	jal	800000fe <kalloc>
    8000058c:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000058e:	6605                	lui	a2,0x1
    80000590:	4581                	li	a1,0
    80000592:	bbdff0ef          	jal	8000014e <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000596:	4719                	li	a4,6
    80000598:	6685                	lui	a3,0x1
    8000059a:	10000637          	lui	a2,0x10000
    8000059e:	100005b7          	lui	a1,0x10000
    800005a2:	8526                	mv	a0,s1
    800005a4:	fb1ff0ef          	jal	80000554 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800005a8:	4719                	li	a4,6
    800005aa:	6685                	lui	a3,0x1
    800005ac:	10001637          	lui	a2,0x10001
    800005b0:	100015b7          	lui	a1,0x10001
    800005b4:	8526                	mv	a0,s1
    800005b6:	f9fff0ef          	jal	80000554 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800005ba:	4719                	li	a4,6
    800005bc:	040006b7          	lui	a3,0x4000
    800005c0:	0c000637          	lui	a2,0xc000
    800005c4:	0c0005b7          	lui	a1,0xc000
    800005c8:	8526                	mv	a0,s1
    800005ca:	f8bff0ef          	jal	80000554 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800005ce:	00007917          	auipc	s2,0x7
    800005d2:	a3290913          	addi	s2,s2,-1486 # 80007000 <etext>
    800005d6:	4729                	li	a4,10
    800005d8:	80007697          	auipc	a3,0x80007
    800005dc:	a2868693          	addi	a3,a3,-1496 # 7000 <_entry-0x7fff9000>
    800005e0:	4605                	li	a2,1
    800005e2:	067e                	slli	a2,a2,0x1f
    800005e4:	85b2                	mv	a1,a2
    800005e6:	8526                	mv	a0,s1
    800005e8:	f6dff0ef          	jal	80000554 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800005ec:	46c5                	li	a3,17
    800005ee:	06ee                	slli	a3,a3,0x1b
    800005f0:	4719                	li	a4,6
    800005f2:	412686b3          	sub	a3,a3,s2
    800005f6:	864a                	mv	a2,s2
    800005f8:	85ca                	mv	a1,s2
    800005fa:	8526                	mv	a0,s1
    800005fc:	f59ff0ef          	jal	80000554 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80000600:	4729                	li	a4,10
    80000602:	6685                	lui	a3,0x1
    80000604:	00006617          	auipc	a2,0x6
    80000608:	9fc60613          	addi	a2,a2,-1540 # 80006000 <_trampoline>
    8000060c:	040005b7          	lui	a1,0x4000
    80000610:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000612:	05b2                	slli	a1,a1,0xc
    80000614:	8526                	mv	a0,s1
    80000616:	f3fff0ef          	jal	80000554 <kvmmap>
  proc_mapstacks(kpgtbl);
    8000061a:	8526                	mv	a0,s1
    8000061c:	60e000ef          	jal	80000c2a <proc_mapstacks>
}
    80000620:	8526                	mv	a0,s1
    80000622:	60e2                	ld	ra,24(sp)
    80000624:	6442                	ld	s0,16(sp)
    80000626:	64a2                	ld	s1,8(sp)
    80000628:	6902                	ld	s2,0(sp)
    8000062a:	6105                	addi	sp,sp,32
    8000062c:	8082                	ret

000000008000062e <kvminit>:
{
    8000062e:	1141                	addi	sp,sp,-16
    80000630:	e406                	sd	ra,8(sp)
    80000632:	e022                	sd	s0,0(sp)
    80000634:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000636:	f47ff0ef          	jal	8000057c <kvmmake>
    8000063a:	0000a797          	auipc	a5,0xa
    8000063e:	caa7bf23          	sd	a0,-834(a5) # 8000a2f8 <kernel_pagetable>
}
    80000642:	60a2                	ld	ra,8(sp)
    80000644:	6402                	ld	s0,0(sp)
    80000646:	0141                	addi	sp,sp,16
    80000648:	8082                	ret

000000008000064a <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000064a:	715d                	addi	sp,sp,-80
    8000064c:	e486                	sd	ra,72(sp)
    8000064e:	e0a2                	sd	s0,64(sp)
    80000650:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;
  int sz;

  if((va % PGSIZE) != 0)
    80000652:	03459793          	slli	a5,a1,0x34
    80000656:	e39d                	bnez	a5,8000067c <uvmunmap+0x32>
    80000658:	f84a                	sd	s2,48(sp)
    8000065a:	f44e                	sd	s3,40(sp)
    8000065c:	f052                	sd	s4,32(sp)
    8000065e:	ec56                	sd	s5,24(sp)
    80000660:	e85a                	sd	s6,16(sp)
    80000662:	e45e                	sd	s7,8(sp)
    80000664:	8a2a                	mv	s4,a0
    80000666:	892e                	mv	s2,a1
    80000668:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += sz){
    8000066a:	0632                	slli	a2,a2,0xc
    8000066c:	00b609b3          	add	s3,a2,a1
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0) {
      printf("va=%ld pte=%ld\n", a, *pte);
      panic("uvmunmap: not mapped");
    }
    if(PTE_FLAGS(*pte) == PTE_V)
    80000670:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += sz){
    80000672:	6b05                	lui	s6,0x1
    80000674:	0935f763          	bgeu	a1,s3,80000702 <uvmunmap+0xb8>
    80000678:	fc26                	sd	s1,56(sp)
    8000067a:	a8a1                	j	800006d2 <uvmunmap+0x88>
    8000067c:	fc26                	sd	s1,56(sp)
    8000067e:	f84a                	sd	s2,48(sp)
    80000680:	f44e                	sd	s3,40(sp)
    80000682:	f052                	sd	s4,32(sp)
    80000684:	ec56                	sd	s5,24(sp)
    80000686:	e85a                	sd	s6,16(sp)
    80000688:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    8000068a:	00007517          	auipc	a0,0x7
    8000068e:	a3650513          	addi	a0,a0,-1482 # 800070c0 <etext+0xc0>
    80000692:	691040ef          	jal	80005522 <panic>
      panic("uvmunmap: walk");
    80000696:	00007517          	auipc	a0,0x7
    8000069a:	a4250513          	addi	a0,a0,-1470 # 800070d8 <etext+0xd8>
    8000069e:	685040ef          	jal	80005522 <panic>
      printf("va=%ld pte=%ld\n", a, *pte);
    800006a2:	85ca                	mv	a1,s2
    800006a4:	00007517          	auipc	a0,0x7
    800006a8:	a4450513          	addi	a0,a0,-1468 # 800070e8 <etext+0xe8>
    800006ac:	3a5040ef          	jal	80005250 <printf>
      panic("uvmunmap: not mapped");
    800006b0:	00007517          	auipc	a0,0x7
    800006b4:	a4850513          	addi	a0,a0,-1464 # 800070f8 <etext+0xf8>
    800006b8:	66b040ef          	jal	80005522 <panic>
      panic("uvmunmap: not a leaf");
    800006bc:	00007517          	auipc	a0,0x7
    800006c0:	a5450513          	addi	a0,a0,-1452 # 80007110 <etext+0x110>
    800006c4:	65f040ef          	jal	80005522 <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800006c8:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += sz){
    800006cc:	995a                	add	s2,s2,s6
    800006ce:	03397963          	bgeu	s2,s3,80000700 <uvmunmap+0xb6>
    if((pte = walk(pagetable, a, 0)) == 0)
    800006d2:	4601                	li	a2,0
    800006d4:	85ca                	mv	a1,s2
    800006d6:	8552                	mv	a0,s4
    800006d8:	cebff0ef          	jal	800003c2 <walk>
    800006dc:	84aa                	mv	s1,a0
    800006de:	dd45                	beqz	a0,80000696 <uvmunmap+0x4c>
    if((*pte & PTE_V) == 0) {
    800006e0:	6110                	ld	a2,0(a0)
    800006e2:	00167793          	andi	a5,a2,1
    800006e6:	dfd5                	beqz	a5,800006a2 <uvmunmap+0x58>
    if(PTE_FLAGS(*pte) == PTE_V)
    800006e8:	3ff67793          	andi	a5,a2,1023
    800006ec:	fd7788e3          	beq	a5,s7,800006bc <uvmunmap+0x72>
    if(do_free){
    800006f0:	fc0a8ce3          	beqz	s5,800006c8 <uvmunmap+0x7e>
      uint64 pa = PTE2PA(*pte);
    800006f4:	8229                	srli	a2,a2,0xa
      kfree((void*)pa);
    800006f6:	00c61513          	slli	a0,a2,0xc
    800006fa:	923ff0ef          	jal	8000001c <kfree>
    800006fe:	b7e9                	j	800006c8 <uvmunmap+0x7e>
    80000700:	74e2                	ld	s1,56(sp)
    80000702:	7942                	ld	s2,48(sp)
    80000704:	79a2                	ld	s3,40(sp)
    80000706:	7a02                	ld	s4,32(sp)
    80000708:	6ae2                	ld	s5,24(sp)
    8000070a:	6b42                	ld	s6,16(sp)
    8000070c:	6ba2                	ld	s7,8(sp)
  }
}
    8000070e:	60a6                	ld	ra,72(sp)
    80000710:	6406                	ld	s0,64(sp)
    80000712:	6161                	addi	sp,sp,80
    80000714:	8082                	ret

0000000080000716 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000716:	1101                	addi	sp,sp,-32
    80000718:	ec06                	sd	ra,24(sp)
    8000071a:	e822                	sd	s0,16(sp)
    8000071c:	e426                	sd	s1,8(sp)
    8000071e:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000720:	9dfff0ef          	jal	800000fe <kalloc>
    80000724:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000726:	c509                	beqz	a0,80000730 <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000728:	6605                	lui	a2,0x1
    8000072a:	4581                	li	a1,0
    8000072c:	a23ff0ef          	jal	8000014e <memset>
  return pagetable;
}
    80000730:	8526                	mv	a0,s1
    80000732:	60e2                	ld	ra,24(sp)
    80000734:	6442                	ld	s0,16(sp)
    80000736:	64a2                	ld	s1,8(sp)
    80000738:	6105                	addi	sp,sp,32
    8000073a:	8082                	ret

000000008000073c <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    8000073c:	7179                	addi	sp,sp,-48
    8000073e:	f406                	sd	ra,40(sp)
    80000740:	f022                	sd	s0,32(sp)
    80000742:	ec26                	sd	s1,24(sp)
    80000744:	e84a                	sd	s2,16(sp)
    80000746:	e44e                	sd	s3,8(sp)
    80000748:	e052                	sd	s4,0(sp)
    8000074a:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    8000074c:	6785                	lui	a5,0x1
    8000074e:	04f67063          	bgeu	a2,a5,8000078e <uvmfirst+0x52>
    80000752:	8a2a                	mv	s4,a0
    80000754:	89ae                	mv	s3,a1
    80000756:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80000758:	9a7ff0ef          	jal	800000fe <kalloc>
    8000075c:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000075e:	6605                	lui	a2,0x1
    80000760:	4581                	li	a1,0
    80000762:	9edff0ef          	jal	8000014e <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000766:	4779                	li	a4,30
    80000768:	86ca                	mv	a3,s2
    8000076a:	6605                	lui	a2,0x1
    8000076c:	4581                	li	a1,0
    8000076e:	8552                	mv	a0,s4
    80000770:	d35ff0ef          	jal	800004a4 <mappages>
  memmove(mem, src, sz);
    80000774:	8626                	mv	a2,s1
    80000776:	85ce                	mv	a1,s3
    80000778:	854a                	mv	a0,s2
    8000077a:	a31ff0ef          	jal	800001aa <memmove>
}
    8000077e:	70a2                	ld	ra,40(sp)
    80000780:	7402                	ld	s0,32(sp)
    80000782:	64e2                	ld	s1,24(sp)
    80000784:	6942                	ld	s2,16(sp)
    80000786:	69a2                	ld	s3,8(sp)
    80000788:	6a02                	ld	s4,0(sp)
    8000078a:	6145                	addi	sp,sp,48
    8000078c:	8082                	ret
    panic("uvmfirst: more than a page");
    8000078e:	00007517          	auipc	a0,0x7
    80000792:	99a50513          	addi	a0,a0,-1638 # 80007128 <etext+0x128>
    80000796:	58d040ef          	jal	80005522 <panic>

000000008000079a <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000079a:	1101                	addi	sp,sp,-32
    8000079c:	ec06                	sd	ra,24(sp)
    8000079e:	e822                	sd	s0,16(sp)
    800007a0:	e426                	sd	s1,8(sp)
    800007a2:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800007a4:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800007a6:	00b67d63          	bgeu	a2,a1,800007c0 <uvmdealloc+0x26>
    800007aa:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800007ac:	6785                	lui	a5,0x1
    800007ae:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800007b0:	00f60733          	add	a4,a2,a5
    800007b4:	76fd                	lui	a3,0xfffff
    800007b6:	8f75                	and	a4,a4,a3
    800007b8:	97ae                	add	a5,a5,a1
    800007ba:	8ff5                	and	a5,a5,a3
    800007bc:	00f76863          	bltu	a4,a5,800007cc <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800007c0:	8526                	mv	a0,s1
    800007c2:	60e2                	ld	ra,24(sp)
    800007c4:	6442                	ld	s0,16(sp)
    800007c6:	64a2                	ld	s1,8(sp)
    800007c8:	6105                	addi	sp,sp,32
    800007ca:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800007cc:	8f99                	sub	a5,a5,a4
    800007ce:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800007d0:	4685                	li	a3,1
    800007d2:	0007861b          	sext.w	a2,a5
    800007d6:	85ba                	mv	a1,a4
    800007d8:	e73ff0ef          	jal	8000064a <uvmunmap>
    800007dc:	b7d5                	j	800007c0 <uvmdealloc+0x26>

00000000800007de <uvmalloc>:
  if(newsz < oldsz)
    800007de:	08b66f63          	bltu	a2,a1,8000087c <uvmalloc+0x9e>
{
    800007e2:	7139                	addi	sp,sp,-64
    800007e4:	fc06                	sd	ra,56(sp)
    800007e6:	f822                	sd	s0,48(sp)
    800007e8:	ec4e                	sd	s3,24(sp)
    800007ea:	e852                	sd	s4,16(sp)
    800007ec:	e456                	sd	s5,8(sp)
    800007ee:	0080                	addi	s0,sp,64
    800007f0:	8aaa                	mv	s5,a0
    800007f2:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800007f4:	6785                	lui	a5,0x1
    800007f6:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800007f8:	95be                	add	a1,a1,a5
    800007fa:	77fd                	lui	a5,0xfffff
    800007fc:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += sz){
    80000800:	08c9f063          	bgeu	s3,a2,80000880 <uvmalloc+0xa2>
    80000804:	f426                	sd	s1,40(sp)
    80000806:	f04a                	sd	s2,32(sp)
    80000808:	e05a                	sd	s6,0(sp)
    8000080a:	894e                	mv	s2,s3
    if(mappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000080c:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000810:	8efff0ef          	jal	800000fe <kalloc>
    80000814:	84aa                	mv	s1,a0
    if(mem == 0){
    80000816:	c515                	beqz	a0,80000842 <uvmalloc+0x64>
    memset(mem, 0, sz);
    80000818:	6605                	lui	a2,0x1
    8000081a:	4581                	li	a1,0
    8000081c:	933ff0ef          	jal	8000014e <memset>
    if(mappages(pagetable, a, sz, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000820:	875a                	mv	a4,s6
    80000822:	86a6                	mv	a3,s1
    80000824:	6605                	lui	a2,0x1
    80000826:	85ca                	mv	a1,s2
    80000828:	8556                	mv	a0,s5
    8000082a:	c7bff0ef          	jal	800004a4 <mappages>
    8000082e:	e915                	bnez	a0,80000862 <uvmalloc+0x84>
  for(a = oldsz; a < newsz; a += sz){
    80000830:	6785                	lui	a5,0x1
    80000832:	993e                	add	s2,s2,a5
    80000834:	fd496ee3          	bltu	s2,s4,80000810 <uvmalloc+0x32>
  return newsz;
    80000838:	8552                	mv	a0,s4
    8000083a:	74a2                	ld	s1,40(sp)
    8000083c:	7902                	ld	s2,32(sp)
    8000083e:	6b02                	ld	s6,0(sp)
    80000840:	a811                	j	80000854 <uvmalloc+0x76>
      uvmdealloc(pagetable, a, oldsz);
    80000842:	864e                	mv	a2,s3
    80000844:	85ca                	mv	a1,s2
    80000846:	8556                	mv	a0,s5
    80000848:	f53ff0ef          	jal	8000079a <uvmdealloc>
      return 0;
    8000084c:	4501                	li	a0,0
    8000084e:	74a2                	ld	s1,40(sp)
    80000850:	7902                	ld	s2,32(sp)
    80000852:	6b02                	ld	s6,0(sp)
}
    80000854:	70e2                	ld	ra,56(sp)
    80000856:	7442                	ld	s0,48(sp)
    80000858:	69e2                	ld	s3,24(sp)
    8000085a:	6a42                	ld	s4,16(sp)
    8000085c:	6aa2                	ld	s5,8(sp)
    8000085e:	6121                	addi	sp,sp,64
    80000860:	8082                	ret
      kfree(mem);
    80000862:	8526                	mv	a0,s1
    80000864:	fb8ff0ef          	jal	8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000868:	864e                	mv	a2,s3
    8000086a:	85ca                	mv	a1,s2
    8000086c:	8556                	mv	a0,s5
    8000086e:	f2dff0ef          	jal	8000079a <uvmdealloc>
      return 0;
    80000872:	4501                	li	a0,0
    80000874:	74a2                	ld	s1,40(sp)
    80000876:	7902                	ld	s2,32(sp)
    80000878:	6b02                	ld	s6,0(sp)
    8000087a:	bfe9                	j	80000854 <uvmalloc+0x76>
    return oldsz;
    8000087c:	852e                	mv	a0,a1
}
    8000087e:	8082                	ret
  return newsz;
    80000880:	8532                	mv	a0,a2
    80000882:	bfc9                	j	80000854 <uvmalloc+0x76>

0000000080000884 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000884:	7179                	addi	sp,sp,-48
    80000886:	f406                	sd	ra,40(sp)
    80000888:	f022                	sd	s0,32(sp)
    8000088a:	ec26                	sd	s1,24(sp)
    8000088c:	e84a                	sd	s2,16(sp)
    8000088e:	e44e                	sd	s3,8(sp)
    80000890:	e052                	sd	s4,0(sp)
    80000892:	1800                	addi	s0,sp,48
    80000894:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000896:	84aa                	mv	s1,a0
    80000898:	6905                	lui	s2,0x1
    8000089a:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000089c:	4985                	li	s3,1
    8000089e:	a819                	j	800008b4 <freewalk+0x30>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800008a0:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800008a2:	00c79513          	slli	a0,a5,0xc
    800008a6:	fdfff0ef          	jal	80000884 <freewalk>
      pagetable[i] = 0;
    800008aa:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800008ae:	04a1                	addi	s1,s1,8
    800008b0:	01248f63          	beq	s1,s2,800008ce <freewalk+0x4a>
    pte_t pte = pagetable[i];
    800008b4:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800008b6:	00f7f713          	andi	a4,a5,15
    800008ba:	ff3703e3          	beq	a4,s3,800008a0 <freewalk+0x1c>
    } else if(pte & PTE_V){
    800008be:	8b85                	andi	a5,a5,1
    800008c0:	d7fd                	beqz	a5,800008ae <freewalk+0x2a>
      panic("freewalk: leaf");
    800008c2:	00007517          	auipc	a0,0x7
    800008c6:	88650513          	addi	a0,a0,-1914 # 80007148 <etext+0x148>
    800008ca:	459040ef          	jal	80005522 <panic>
    }
  }
  kfree((void*)pagetable);
    800008ce:	8552                	mv	a0,s4
    800008d0:	f4cff0ef          	jal	8000001c <kfree>
}
    800008d4:	70a2                	ld	ra,40(sp)
    800008d6:	7402                	ld	s0,32(sp)
    800008d8:	64e2                	ld	s1,24(sp)
    800008da:	6942                	ld	s2,16(sp)
    800008dc:	69a2                	ld	s3,8(sp)
    800008de:	6a02                	ld	s4,0(sp)
    800008e0:	6145                	addi	sp,sp,48
    800008e2:	8082                	ret

00000000800008e4 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800008e4:	1101                	addi	sp,sp,-32
    800008e6:	ec06                	sd	ra,24(sp)
    800008e8:	e822                	sd	s0,16(sp)
    800008ea:	e426                	sd	s1,8(sp)
    800008ec:	1000                	addi	s0,sp,32
    800008ee:	84aa                	mv	s1,a0
  if(sz > 0)
    800008f0:	e989                	bnez	a1,80000902 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800008f2:	8526                	mv	a0,s1
    800008f4:	f91ff0ef          	jal	80000884 <freewalk>
}
    800008f8:	60e2                	ld	ra,24(sp)
    800008fa:	6442                	ld	s0,16(sp)
    800008fc:	64a2                	ld	s1,8(sp)
    800008fe:	6105                	addi	sp,sp,32
    80000900:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000902:	6785                	lui	a5,0x1
    80000904:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000906:	95be                	add	a1,a1,a5
    80000908:	4685                	li	a3,1
    8000090a:	00c5d613          	srli	a2,a1,0xc
    8000090e:	4581                	li	a1,0
    80000910:	d3bff0ef          	jal	8000064a <uvmunmap>
    80000914:	bff9                	j	800008f2 <uvmfree+0xe>

0000000080000916 <uvmcopy>:
  uint64 pa, i;
  uint flags;
  char *mem;
  int szinc;

  for(i = 0; i < sz; i += szinc){
    80000916:	c65d                	beqz	a2,800009c4 <uvmcopy+0xae>
{
    80000918:	715d                	addi	sp,sp,-80
    8000091a:	e486                	sd	ra,72(sp)
    8000091c:	e0a2                	sd	s0,64(sp)
    8000091e:	fc26                	sd	s1,56(sp)
    80000920:	f84a                	sd	s2,48(sp)
    80000922:	f44e                	sd	s3,40(sp)
    80000924:	f052                	sd	s4,32(sp)
    80000926:	ec56                	sd	s5,24(sp)
    80000928:	e85a                	sd	s6,16(sp)
    8000092a:	e45e                	sd	s7,8(sp)
    8000092c:	0880                	addi	s0,sp,80
    8000092e:	8b2a                	mv	s6,a0
    80000930:	8aae                	mv	s5,a1
    80000932:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += szinc){
    80000934:	4981                	li	s3,0
    szinc = PGSIZE;
    szinc = PGSIZE;
    if((pte = walk(old, i, 0)) == 0)
    80000936:	4601                	li	a2,0
    80000938:	85ce                	mv	a1,s3
    8000093a:	855a                	mv	a0,s6
    8000093c:	a87ff0ef          	jal	800003c2 <walk>
    80000940:	c121                	beqz	a0,80000980 <uvmcopy+0x6a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000942:	6118                	ld	a4,0(a0)
    80000944:	00177793          	andi	a5,a4,1
    80000948:	c3b1                	beqz	a5,8000098c <uvmcopy+0x76>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    8000094a:	00a75593          	srli	a1,a4,0xa
    8000094e:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000952:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000956:	fa8ff0ef          	jal	800000fe <kalloc>
    8000095a:	892a                	mv	s2,a0
    8000095c:	c129                	beqz	a0,8000099e <uvmcopy+0x88>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000095e:	6605                	lui	a2,0x1
    80000960:	85de                	mv	a1,s7
    80000962:	849ff0ef          	jal	800001aa <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000966:	8726                	mv	a4,s1
    80000968:	86ca                	mv	a3,s2
    8000096a:	6605                	lui	a2,0x1
    8000096c:	85ce                	mv	a1,s3
    8000096e:	8556                	mv	a0,s5
    80000970:	b35ff0ef          	jal	800004a4 <mappages>
    80000974:	e115                	bnez	a0,80000998 <uvmcopy+0x82>
  for(i = 0; i < sz; i += szinc){
    80000976:	6785                	lui	a5,0x1
    80000978:	99be                	add	s3,s3,a5
    8000097a:	fb49eee3          	bltu	s3,s4,80000936 <uvmcopy+0x20>
    8000097e:	a805                	j	800009ae <uvmcopy+0x98>
      panic("uvmcopy: pte should exist");
    80000980:	00006517          	auipc	a0,0x6
    80000984:	7d850513          	addi	a0,a0,2008 # 80007158 <etext+0x158>
    80000988:	39b040ef          	jal	80005522 <panic>
      panic("uvmcopy: page not present");
    8000098c:	00006517          	auipc	a0,0x6
    80000990:	7ec50513          	addi	a0,a0,2028 # 80007178 <etext+0x178>
    80000994:	38f040ef          	jal	80005522 <panic>
      kfree(mem);
    80000998:	854a                	mv	a0,s2
    8000099a:	e82ff0ef          	jal	8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    8000099e:	4685                	li	a3,1
    800009a0:	00c9d613          	srli	a2,s3,0xc
    800009a4:	4581                	li	a1,0
    800009a6:	8556                	mv	a0,s5
    800009a8:	ca3ff0ef          	jal	8000064a <uvmunmap>
  return -1;
    800009ac:	557d                	li	a0,-1
}
    800009ae:	60a6                	ld	ra,72(sp)
    800009b0:	6406                	ld	s0,64(sp)
    800009b2:	74e2                	ld	s1,56(sp)
    800009b4:	7942                	ld	s2,48(sp)
    800009b6:	79a2                	ld	s3,40(sp)
    800009b8:	7a02                	ld	s4,32(sp)
    800009ba:	6ae2                	ld	s5,24(sp)
    800009bc:	6b42                	ld	s6,16(sp)
    800009be:	6ba2                	ld	s7,8(sp)
    800009c0:	6161                	addi	sp,sp,80
    800009c2:	8082                	ret
  return 0;
    800009c4:	4501                	li	a0,0
}
    800009c6:	8082                	ret

00000000800009c8 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    800009c8:	1141                	addi	sp,sp,-16
    800009ca:	e406                	sd	ra,8(sp)
    800009cc:	e022                	sd	s0,0(sp)
    800009ce:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800009d0:	4601                	li	a2,0
    800009d2:	9f1ff0ef          	jal	800003c2 <walk>
  if(pte == 0)
    800009d6:	c901                	beqz	a0,800009e6 <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    800009d8:	611c                	ld	a5,0(a0)
    800009da:	9bbd                	andi	a5,a5,-17
    800009dc:	e11c                	sd	a5,0(a0)
}
    800009de:	60a2                	ld	ra,8(sp)
    800009e0:	6402                	ld	s0,0(sp)
    800009e2:	0141                	addi	sp,sp,16
    800009e4:	8082                	ret
    panic("uvmclear");
    800009e6:	00006517          	auipc	a0,0x6
    800009ea:	7b250513          	addi	a0,a0,1970 # 80007198 <etext+0x198>
    800009ee:	335040ef          	jal	80005522 <panic>

00000000800009f2 <copyout>:
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    800009f2:	cac1                	beqz	a3,80000a82 <copyout+0x90>
{
    800009f4:	711d                	addi	sp,sp,-96
    800009f6:	ec86                	sd	ra,88(sp)
    800009f8:	e8a2                	sd	s0,80(sp)
    800009fa:	e4a6                	sd	s1,72(sp)
    800009fc:	fc4e                	sd	s3,56(sp)
    800009fe:	f852                	sd	s4,48(sp)
    80000a00:	f456                	sd	s5,40(sp)
    80000a02:	f05a                	sd	s6,32(sp)
    80000a04:	1080                	addi	s0,sp,96
    80000a06:	8b2a                	mv	s6,a0
    80000a08:	8a2e                	mv	s4,a1
    80000a0a:	8ab2                	mv	s5,a2
    80000a0c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000a0e:	74fd                	lui	s1,0xfffff
    80000a10:	8ced                	and	s1,s1,a1
    if (va0 >= MAXVA)
    80000a12:	57fd                	li	a5,-1
    80000a14:	83e9                	srli	a5,a5,0x1a
    80000a16:	0697e863          	bltu	a5,s1,80000a86 <copyout+0x94>
    80000a1a:	e0ca                	sd	s2,64(sp)
    80000a1c:	ec5e                	sd	s7,24(sp)
    80000a1e:	e862                	sd	s8,16(sp)
    80000a20:	e466                	sd	s9,8(sp)
    80000a22:	6c05                	lui	s8,0x1
    80000a24:	8bbe                	mv	s7,a5
    80000a26:	a015                	j	80000a4a <copyout+0x58>
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000a28:	409a04b3          	sub	s1,s4,s1
    80000a2c:	0009061b          	sext.w	a2,s2
    80000a30:	85d6                	mv	a1,s5
    80000a32:	9526                	add	a0,a0,s1
    80000a34:	f76ff0ef          	jal	800001aa <memmove>

    len -= n;
    80000a38:	412989b3          	sub	s3,s3,s2
    src += n;
    80000a3c:	9aca                	add	s5,s5,s2
  while(len > 0){
    80000a3e:	02098c63          	beqz	s3,80000a76 <copyout+0x84>
    if (va0 >= MAXVA)
    80000a42:	059be463          	bltu	s7,s9,80000a8a <copyout+0x98>
    80000a46:	84e6                	mv	s1,s9
    80000a48:	8a66                	mv	s4,s9
    if((pte = walk(pagetable, va0, 0)) == 0) {
    80000a4a:	4601                	li	a2,0
    80000a4c:	85a6                	mv	a1,s1
    80000a4e:	855a                	mv	a0,s6
    80000a50:	973ff0ef          	jal	800003c2 <walk>
    80000a54:	c129                	beqz	a0,80000a96 <copyout+0xa4>
    if((*pte & PTE_W) == 0)
    80000a56:	611c                	ld	a5,0(a0)
    80000a58:	8b91                	andi	a5,a5,4
    80000a5a:	cfa1                	beqz	a5,80000ab2 <copyout+0xc0>
    pa0 = walkaddr(pagetable, va0);
    80000a5c:	85a6                	mv	a1,s1
    80000a5e:	855a                	mv	a0,s6
    80000a60:	a07ff0ef          	jal	80000466 <walkaddr>
    if(pa0 == 0)
    80000a64:	cd29                	beqz	a0,80000abe <copyout+0xcc>
    n = PGSIZE - (dstva - va0);
    80000a66:	01848cb3          	add	s9,s1,s8
    80000a6a:	414c8933          	sub	s2,s9,s4
    if(n > len)
    80000a6e:	fb29fde3          	bgeu	s3,s2,80000a28 <copyout+0x36>
    80000a72:	894e                	mv	s2,s3
    80000a74:	bf55                	j	80000a28 <copyout+0x36>
    dstva = va0 + PGSIZE;
  }
  return 0;
    80000a76:	4501                	li	a0,0
    80000a78:	6906                	ld	s2,64(sp)
    80000a7a:	6be2                	ld	s7,24(sp)
    80000a7c:	6c42                	ld	s8,16(sp)
    80000a7e:	6ca2                	ld	s9,8(sp)
    80000a80:	a005                	j	80000aa0 <copyout+0xae>
    80000a82:	4501                	li	a0,0
}
    80000a84:	8082                	ret
      return -1;
    80000a86:	557d                	li	a0,-1
    80000a88:	a821                	j	80000aa0 <copyout+0xae>
    80000a8a:	557d                	li	a0,-1
    80000a8c:	6906                	ld	s2,64(sp)
    80000a8e:	6be2                	ld	s7,24(sp)
    80000a90:	6c42                	ld	s8,16(sp)
    80000a92:	6ca2                	ld	s9,8(sp)
    80000a94:	a031                	j	80000aa0 <copyout+0xae>
      return -1;
    80000a96:	557d                	li	a0,-1
    80000a98:	6906                	ld	s2,64(sp)
    80000a9a:	6be2                	ld	s7,24(sp)
    80000a9c:	6c42                	ld	s8,16(sp)
    80000a9e:	6ca2                	ld	s9,8(sp)
}
    80000aa0:	60e6                	ld	ra,88(sp)
    80000aa2:	6446                	ld	s0,80(sp)
    80000aa4:	64a6                	ld	s1,72(sp)
    80000aa6:	79e2                	ld	s3,56(sp)
    80000aa8:	7a42                	ld	s4,48(sp)
    80000aaa:	7aa2                	ld	s5,40(sp)
    80000aac:	7b02                	ld	s6,32(sp)
    80000aae:	6125                	addi	sp,sp,96
    80000ab0:	8082                	ret
      return -1;
    80000ab2:	557d                	li	a0,-1
    80000ab4:	6906                	ld	s2,64(sp)
    80000ab6:	6be2                	ld	s7,24(sp)
    80000ab8:	6c42                	ld	s8,16(sp)
    80000aba:	6ca2                	ld	s9,8(sp)
    80000abc:	b7d5                	j	80000aa0 <copyout+0xae>
      return -1;
    80000abe:	557d                	li	a0,-1
    80000ac0:	6906                	ld	s2,64(sp)
    80000ac2:	6be2                	ld	s7,24(sp)
    80000ac4:	6c42                	ld	s8,16(sp)
    80000ac6:	6ca2                	ld	s9,8(sp)
    80000ac8:	bfe1                	j	80000aa0 <copyout+0xae>

0000000080000aca <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;
  
  while(len > 0){
    80000aca:	c6a5                	beqz	a3,80000b32 <copyin+0x68>
{
    80000acc:	715d                	addi	sp,sp,-80
    80000ace:	e486                	sd	ra,72(sp)
    80000ad0:	e0a2                	sd	s0,64(sp)
    80000ad2:	fc26                	sd	s1,56(sp)
    80000ad4:	f84a                	sd	s2,48(sp)
    80000ad6:	f44e                	sd	s3,40(sp)
    80000ad8:	f052                	sd	s4,32(sp)
    80000ada:	ec56                	sd	s5,24(sp)
    80000adc:	e85a                	sd	s6,16(sp)
    80000ade:	e45e                	sd	s7,8(sp)
    80000ae0:	e062                	sd	s8,0(sp)
    80000ae2:	0880                	addi	s0,sp,80
    80000ae4:	8b2a                	mv	s6,a0
    80000ae6:	8a2e                	mv	s4,a1
    80000ae8:	8c32                	mv	s8,a2
    80000aea:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000aec:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000aee:	6a85                	lui	s5,0x1
    80000af0:	a00d                	j	80000b12 <copyin+0x48>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000af2:	018505b3          	add	a1,a0,s8
    80000af6:	0004861b          	sext.w	a2,s1
    80000afa:	412585b3          	sub	a1,a1,s2
    80000afe:	8552                	mv	a0,s4
    80000b00:	eaaff0ef          	jal	800001aa <memmove>

    len -= n;
    80000b04:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000b08:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000b0a:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b0e:	02098063          	beqz	s3,80000b2e <copyin+0x64>
    va0 = PGROUNDDOWN(srcva);
    80000b12:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b16:	85ca                	mv	a1,s2
    80000b18:	855a                	mv	a0,s6
    80000b1a:	94dff0ef          	jal	80000466 <walkaddr>
    if(pa0 == 0)
    80000b1e:	cd01                	beqz	a0,80000b36 <copyin+0x6c>
    n = PGSIZE - (srcva - va0);
    80000b20:	418904b3          	sub	s1,s2,s8
    80000b24:	94d6                	add	s1,s1,s5
    if(n > len)
    80000b26:	fc99f6e3          	bgeu	s3,s1,80000af2 <copyin+0x28>
    80000b2a:	84ce                	mv	s1,s3
    80000b2c:	b7d9                	j	80000af2 <copyin+0x28>
  }
  return 0;
    80000b2e:	4501                	li	a0,0
    80000b30:	a021                	j	80000b38 <copyin+0x6e>
    80000b32:	4501                	li	a0,0
}
    80000b34:	8082                	ret
      return -1;
    80000b36:	557d                	li	a0,-1
}
    80000b38:	60a6                	ld	ra,72(sp)
    80000b3a:	6406                	ld	s0,64(sp)
    80000b3c:	74e2                	ld	s1,56(sp)
    80000b3e:	7942                	ld	s2,48(sp)
    80000b40:	79a2                	ld	s3,40(sp)
    80000b42:	7a02                	ld	s4,32(sp)
    80000b44:	6ae2                	ld	s5,24(sp)
    80000b46:	6b42                	ld	s6,16(sp)
    80000b48:	6ba2                	ld	s7,8(sp)
    80000b4a:	6c02                	ld	s8,0(sp)
    80000b4c:	6161                	addi	sp,sp,80
    80000b4e:	8082                	ret

0000000080000b50 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000b50:	c6dd                	beqz	a3,80000bfe <copyinstr+0xae>
{
    80000b52:	715d                	addi	sp,sp,-80
    80000b54:	e486                	sd	ra,72(sp)
    80000b56:	e0a2                	sd	s0,64(sp)
    80000b58:	fc26                	sd	s1,56(sp)
    80000b5a:	f84a                	sd	s2,48(sp)
    80000b5c:	f44e                	sd	s3,40(sp)
    80000b5e:	f052                	sd	s4,32(sp)
    80000b60:	ec56                	sd	s5,24(sp)
    80000b62:	e85a                	sd	s6,16(sp)
    80000b64:	e45e                	sd	s7,8(sp)
    80000b66:	0880                	addi	s0,sp,80
    80000b68:	8a2a                	mv	s4,a0
    80000b6a:	8b2e                	mv	s6,a1
    80000b6c:	8bb2                	mv	s7,a2
    80000b6e:	8936                	mv	s2,a3
    va0 = PGROUNDDOWN(srcva);
    80000b70:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000b72:	6985                	lui	s3,0x1
    80000b74:	a825                	j	80000bac <copyinstr+0x5c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000b76:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000b7a:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000b7c:	37fd                	addiw	a5,a5,-1
    80000b7e:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000b82:	60a6                	ld	ra,72(sp)
    80000b84:	6406                	ld	s0,64(sp)
    80000b86:	74e2                	ld	s1,56(sp)
    80000b88:	7942                	ld	s2,48(sp)
    80000b8a:	79a2                	ld	s3,40(sp)
    80000b8c:	7a02                	ld	s4,32(sp)
    80000b8e:	6ae2                	ld	s5,24(sp)
    80000b90:	6b42                	ld	s6,16(sp)
    80000b92:	6ba2                	ld	s7,8(sp)
    80000b94:	6161                	addi	sp,sp,80
    80000b96:	8082                	ret
    80000b98:	fff90713          	addi	a4,s2,-1 # fff <_entry-0x7ffff001>
    80000b9c:	9742                	add	a4,a4,a6
      --max;
    80000b9e:	40b70933          	sub	s2,a4,a1
    srcva = va0 + PGSIZE;
    80000ba2:	01348bb3          	add	s7,s1,s3
  while(got_null == 0 && max > 0){
    80000ba6:	04e58463          	beq	a1,a4,80000bee <copyinstr+0x9e>
{
    80000baa:	8b3e                	mv	s6,a5
    va0 = PGROUNDDOWN(srcva);
    80000bac:	015bf4b3          	and	s1,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000bb0:	85a6                	mv	a1,s1
    80000bb2:	8552                	mv	a0,s4
    80000bb4:	8b3ff0ef          	jal	80000466 <walkaddr>
    if(pa0 == 0)
    80000bb8:	cd0d                	beqz	a0,80000bf2 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80000bba:	417486b3          	sub	a3,s1,s7
    80000bbe:	96ce                	add	a3,a3,s3
    if(n > max)
    80000bc0:	00d97363          	bgeu	s2,a3,80000bc6 <copyinstr+0x76>
    80000bc4:	86ca                	mv	a3,s2
    char *p = (char *) (pa0 + (srcva - va0));
    80000bc6:	955e                	add	a0,a0,s7
    80000bc8:	8d05                	sub	a0,a0,s1
    while(n > 0){
    80000bca:	c695                	beqz	a3,80000bf6 <copyinstr+0xa6>
    80000bcc:	87da                	mv	a5,s6
    80000bce:	885a                	mv	a6,s6
      if(*p == '\0'){
    80000bd0:	41650633          	sub	a2,a0,s6
    while(n > 0){
    80000bd4:	96da                	add	a3,a3,s6
    80000bd6:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000bd8:	00f60733          	add	a4,a2,a5
    80000bdc:	00074703          	lbu	a4,0(a4)
    80000be0:	db59                	beqz	a4,80000b76 <copyinstr+0x26>
        *dst = *p;
    80000be2:	00e78023          	sb	a4,0(a5)
      dst++;
    80000be6:	0785                	addi	a5,a5,1
    while(n > 0){
    80000be8:	fed797e3          	bne	a5,a3,80000bd6 <copyinstr+0x86>
    80000bec:	b775                	j	80000b98 <copyinstr+0x48>
    80000bee:	4781                	li	a5,0
    80000bf0:	b771                	j	80000b7c <copyinstr+0x2c>
      return -1;
    80000bf2:	557d                	li	a0,-1
    80000bf4:	b779                	j	80000b82 <copyinstr+0x32>
    srcva = va0 + PGSIZE;
    80000bf6:	6b85                	lui	s7,0x1
    80000bf8:	9ba6                	add	s7,s7,s1
    80000bfa:	87da                	mv	a5,s6
    80000bfc:	b77d                	j	80000baa <copyinstr+0x5a>
  int got_null = 0;
    80000bfe:	4781                	li	a5,0
  if(got_null){
    80000c00:	37fd                	addiw	a5,a5,-1
    80000c02:	0007851b          	sext.w	a0,a5
}
    80000c06:	8082                	ret

0000000080000c08 <vmprint>:


#ifdef LAB_PGTBL
void
vmprint(pagetable_t pagetable) {
    80000c08:	1141                	addi	sp,sp,-16
    80000c0a:	e422                	sd	s0,8(sp)
    80000c0c:	0800                	addi	s0,sp,16
  // your code here
}
    80000c0e:	6422                	ld	s0,8(sp)
    80000c10:	0141                	addi	sp,sp,16
    80000c12:	8082                	ret

0000000080000c14 <pgpte>:



#ifdef LAB_PGTBL
pte_t*
pgpte(pagetable_t pagetable, uint64 va) {
    80000c14:	1141                	addi	sp,sp,-16
    80000c16:	e406                	sd	ra,8(sp)
    80000c18:	e022                	sd	s0,0(sp)
    80000c1a:	0800                	addi	s0,sp,16
  return walk(pagetable, va, 0);
    80000c1c:	4601                	li	a2,0
    80000c1e:	fa4ff0ef          	jal	800003c2 <walk>
}
    80000c22:	60a2                	ld	ra,8(sp)
    80000c24:	6402                	ld	s0,0(sp)
    80000c26:	0141                	addi	sp,sp,16
    80000c28:	8082                	ret

0000000080000c2a <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000c2a:	7139                	addi	sp,sp,-64
    80000c2c:	fc06                	sd	ra,56(sp)
    80000c2e:	f822                	sd	s0,48(sp)
    80000c30:	f426                	sd	s1,40(sp)
    80000c32:	f04a                	sd	s2,32(sp)
    80000c34:	ec4e                	sd	s3,24(sp)
    80000c36:	e852                	sd	s4,16(sp)
    80000c38:	e456                	sd	s5,8(sp)
    80000c3a:	e05a                	sd	s6,0(sp)
    80000c3c:	0080                	addi	s0,sp,64
    80000c3e:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c40:	0000a497          	auipc	s1,0xa
    80000c44:	b3048493          	addi	s1,s1,-1232 # 8000a770 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000c48:	8b26                	mv	s6,s1
    80000c4a:	ff4df937          	lui	s2,0xff4df
    80000c4e:	9bd90913          	addi	s2,s2,-1603 # ffffffffff4de9bd <end+0xffffffff7f4bb16d>
    80000c52:	0936                	slli	s2,s2,0xd
    80000c54:	6f590913          	addi	s2,s2,1781
    80000c58:	0936                	slli	s2,s2,0xd
    80000c5a:	bd390913          	addi	s2,s2,-1069
    80000c5e:	0932                	slli	s2,s2,0xc
    80000c60:	7a790913          	addi	s2,s2,1959
    80000c64:	010009b7          	lui	s3,0x1000
    80000c68:	19fd                	addi	s3,s3,-1 # ffffff <_entry-0x7f000001>
    80000c6a:	09ba                	slli	s3,s3,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c6c:	0000fa97          	auipc	s5,0xf
    80000c70:	704a8a93          	addi	s5,s5,1796 # 80010370 <tickslock>
    char *pa = kalloc();
    80000c74:	c8aff0ef          	jal	800000fe <kalloc>
    80000c78:	862a                	mv	a2,a0
    if(pa == 0)
    80000c7a:	cd0d                	beqz	a0,80000cb4 <proc_mapstacks+0x8a>
    uint64 va = KSTACK((int) (p - proc));
    80000c7c:	416485b3          	sub	a1,s1,s6
    80000c80:	8591                	srai	a1,a1,0x4
    80000c82:	032585b3          	mul	a1,a1,s2
    80000c86:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c8a:	4719                	li	a4,6
    80000c8c:	6685                	lui	a3,0x1
    80000c8e:	40b985b3          	sub	a1,s3,a1
    80000c92:	8552                	mv	a0,s4
    80000c94:	8c1ff0ef          	jal	80000554 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c98:	17048493          	addi	s1,s1,368
    80000c9c:	fd549ce3          	bne	s1,s5,80000c74 <proc_mapstacks+0x4a>
  }
}
    80000ca0:	70e2                	ld	ra,56(sp)
    80000ca2:	7442                	ld	s0,48(sp)
    80000ca4:	74a2                	ld	s1,40(sp)
    80000ca6:	7902                	ld	s2,32(sp)
    80000ca8:	69e2                	ld	s3,24(sp)
    80000caa:	6a42                	ld	s4,16(sp)
    80000cac:	6aa2                	ld	s5,8(sp)
    80000cae:	6b02                	ld	s6,0(sp)
    80000cb0:	6121                	addi	sp,sp,64
    80000cb2:	8082                	ret
      panic("kalloc");
    80000cb4:	00006517          	auipc	a0,0x6
    80000cb8:	4f450513          	addi	a0,a0,1268 # 800071a8 <etext+0x1a8>
    80000cbc:	067040ef          	jal	80005522 <panic>

0000000080000cc0 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000cc0:	7139                	addi	sp,sp,-64
    80000cc2:	fc06                	sd	ra,56(sp)
    80000cc4:	f822                	sd	s0,48(sp)
    80000cc6:	f426                	sd	s1,40(sp)
    80000cc8:	f04a                	sd	s2,32(sp)
    80000cca:	ec4e                	sd	s3,24(sp)
    80000ccc:	e852                	sd	s4,16(sp)
    80000cce:	e456                	sd	s5,8(sp)
    80000cd0:	e05a                	sd	s6,0(sp)
    80000cd2:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000cd4:	00006597          	auipc	a1,0x6
    80000cd8:	4dc58593          	addi	a1,a1,1244 # 800071b0 <etext+0x1b0>
    80000cdc:	00009517          	auipc	a0,0x9
    80000ce0:	66450513          	addi	a0,a0,1636 # 8000a340 <pid_lock>
    80000ce4:	2ed040ef          	jal	800057d0 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000ce8:	00006597          	auipc	a1,0x6
    80000cec:	4d058593          	addi	a1,a1,1232 # 800071b8 <etext+0x1b8>
    80000cf0:	00009517          	auipc	a0,0x9
    80000cf4:	66850513          	addi	a0,a0,1640 # 8000a358 <wait_lock>
    80000cf8:	2d9040ef          	jal	800057d0 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cfc:	0000a497          	auipc	s1,0xa
    80000d00:	a7448493          	addi	s1,s1,-1420 # 8000a770 <proc>
      initlock(&p->lock, "proc");
    80000d04:	00006b17          	auipc	s6,0x6
    80000d08:	4c4b0b13          	addi	s6,s6,1220 # 800071c8 <etext+0x1c8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000d0c:	8aa6                	mv	s5,s1
    80000d0e:	ff4df937          	lui	s2,0xff4df
    80000d12:	9bd90913          	addi	s2,s2,-1603 # ffffffffff4de9bd <end+0xffffffff7f4bb16d>
    80000d16:	0936                	slli	s2,s2,0xd
    80000d18:	6f590913          	addi	s2,s2,1781
    80000d1c:	0936                	slli	s2,s2,0xd
    80000d1e:	bd390913          	addi	s2,s2,-1069
    80000d22:	0932                	slli	s2,s2,0xc
    80000d24:	7a790913          	addi	s2,s2,1959
    80000d28:	010009b7          	lui	s3,0x1000
    80000d2c:	19fd                	addi	s3,s3,-1 # ffffff <_entry-0x7f000001>
    80000d2e:	09ba                	slli	s3,s3,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d30:	0000fa17          	auipc	s4,0xf
    80000d34:	640a0a13          	addi	s4,s4,1600 # 80010370 <tickslock>
      initlock(&p->lock, "proc");
    80000d38:	85da                	mv	a1,s6
    80000d3a:	8526                	mv	a0,s1
    80000d3c:	295040ef          	jal	800057d0 <initlock>
      p->state = UNUSED;
    80000d40:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000d44:	415487b3          	sub	a5,s1,s5
    80000d48:	8791                	srai	a5,a5,0x4
    80000d4a:	032787b3          	mul	a5,a5,s2
    80000d4e:	00d7979b          	slliw	a5,a5,0xd
    80000d52:	40f987b3          	sub	a5,s3,a5
    80000d56:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d58:	17048493          	addi	s1,s1,368
    80000d5c:	fd449ee3          	bne	s1,s4,80000d38 <procinit+0x78>
  }
}
    80000d60:	70e2                	ld	ra,56(sp)
    80000d62:	7442                	ld	s0,48(sp)
    80000d64:	74a2                	ld	s1,40(sp)
    80000d66:	7902                	ld	s2,32(sp)
    80000d68:	69e2                	ld	s3,24(sp)
    80000d6a:	6a42                	ld	s4,16(sp)
    80000d6c:	6aa2                	ld	s5,8(sp)
    80000d6e:	6b02                	ld	s6,0(sp)
    80000d70:	6121                	addi	sp,sp,64
    80000d72:	8082                	ret

0000000080000d74 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000d74:	1141                	addi	sp,sp,-16
    80000d76:	e422                	sd	s0,8(sp)
    80000d78:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000d7a:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000d7c:	2501                	sext.w	a0,a0
    80000d7e:	6422                	ld	s0,8(sp)
    80000d80:	0141                	addi	sp,sp,16
    80000d82:	8082                	ret

0000000080000d84 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000d84:	1141                	addi	sp,sp,-16
    80000d86:	e422                	sd	s0,8(sp)
    80000d88:	0800                	addi	s0,sp,16
    80000d8a:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000d8c:	2781                	sext.w	a5,a5
    80000d8e:	079e                	slli	a5,a5,0x7
  return c;
}
    80000d90:	00009517          	auipc	a0,0x9
    80000d94:	5e050513          	addi	a0,a0,1504 # 8000a370 <cpus>
    80000d98:	953e                	add	a0,a0,a5
    80000d9a:	6422                	ld	s0,8(sp)
    80000d9c:	0141                	addi	sp,sp,16
    80000d9e:	8082                	ret

0000000080000da0 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000da0:	1101                	addi	sp,sp,-32
    80000da2:	ec06                	sd	ra,24(sp)
    80000da4:	e822                	sd	s0,16(sp)
    80000da6:	e426                	sd	s1,8(sp)
    80000da8:	1000                	addi	s0,sp,32
  push_off();
    80000daa:	267040ef          	jal	80005810 <push_off>
    80000dae:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000db0:	2781                	sext.w	a5,a5
    80000db2:	079e                	slli	a5,a5,0x7
    80000db4:	00009717          	auipc	a4,0x9
    80000db8:	58c70713          	addi	a4,a4,1420 # 8000a340 <pid_lock>
    80000dbc:	97ba                	add	a5,a5,a4
    80000dbe:	7b84                	ld	s1,48(a5)
  pop_off();
    80000dc0:	2d5040ef          	jal	80005894 <pop_off>
  return p;
}
    80000dc4:	8526                	mv	a0,s1
    80000dc6:	60e2                	ld	ra,24(sp)
    80000dc8:	6442                	ld	s0,16(sp)
    80000dca:	64a2                	ld	s1,8(sp)
    80000dcc:	6105                	addi	sp,sp,32
    80000dce:	8082                	ret

0000000080000dd0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000dd0:	1141                	addi	sp,sp,-16
    80000dd2:	e406                	sd	ra,8(sp)
    80000dd4:	e022                	sd	s0,0(sp)
    80000dd6:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000dd8:	fc9ff0ef          	jal	80000da0 <myproc>
    80000ddc:	30d040ef          	jal	800058e8 <release>

  if (first) {
    80000de0:	00009797          	auipc	a5,0x9
    80000de4:	4a07a783          	lw	a5,1184(a5) # 8000a280 <first.1>
    80000de8:	e799                	bnez	a5,80000df6 <forkret+0x26>
    first = 0;
    // ensure other cores see first=0.
    __sync_synchronize();
  }

  usertrapret();
    80000dea:	35f000ef          	jal	80001948 <usertrapret>
}
    80000dee:	60a2                	ld	ra,8(sp)
    80000df0:	6402                	ld	s0,0(sp)
    80000df2:	0141                	addi	sp,sp,16
    80000df4:	8082                	ret
    fsinit(ROOTDEV);
    80000df6:	4505                	li	a0,1
    80000df8:	748010ef          	jal	80002540 <fsinit>
    first = 0;
    80000dfc:	00009797          	auipc	a5,0x9
    80000e00:	4807a223          	sw	zero,1156(a5) # 8000a280 <first.1>
    __sync_synchronize();
    80000e04:	0330000f          	fence	rw,rw
    80000e08:	b7cd                	j	80000dea <forkret+0x1a>

0000000080000e0a <allocpid>:
{
    80000e0a:	1101                	addi	sp,sp,-32
    80000e0c:	ec06                	sd	ra,24(sp)
    80000e0e:	e822                	sd	s0,16(sp)
    80000e10:	e426                	sd	s1,8(sp)
    80000e12:	e04a                	sd	s2,0(sp)
    80000e14:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000e16:	00009917          	auipc	s2,0x9
    80000e1a:	52a90913          	addi	s2,s2,1322 # 8000a340 <pid_lock>
    80000e1e:	854a                	mv	a0,s2
    80000e20:	231040ef          	jal	80005850 <acquire>
  pid = nextpid;
    80000e24:	00009797          	auipc	a5,0x9
    80000e28:	46078793          	addi	a5,a5,1120 # 8000a284 <nextpid>
    80000e2c:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000e2e:	0014871b          	addiw	a4,s1,1
    80000e32:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000e34:	854a                	mv	a0,s2
    80000e36:	2b3040ef          	jal	800058e8 <release>
}
    80000e3a:	8526                	mv	a0,s1
    80000e3c:	60e2                	ld	ra,24(sp)
    80000e3e:	6442                	ld	s0,16(sp)
    80000e40:	64a2                	ld	s1,8(sp)
    80000e42:	6902                	ld	s2,0(sp)
    80000e44:	6105                	addi	sp,sp,32
    80000e46:	8082                	ret

0000000080000e48 <proc_pagetable>:
{
    80000e48:	1101                	addi	sp,sp,-32
    80000e4a:	ec06                	sd	ra,24(sp)
    80000e4c:	e822                	sd	s0,16(sp)
    80000e4e:	e426                	sd	s1,8(sp)
    80000e50:	e04a                	sd	s2,0(sp)
    80000e52:	1000                	addi	s0,sp,32
    80000e54:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000e56:	8c1ff0ef          	jal	80000716 <uvmcreate>
    80000e5a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000e5c:	c929                	beqz	a0,80000eae <proc_pagetable+0x66>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000e5e:	4729                	li	a4,10
    80000e60:	00005697          	auipc	a3,0x5
    80000e64:	1a068693          	addi	a3,a3,416 # 80006000 <_trampoline>
    80000e68:	6605                	lui	a2,0x1
    80000e6a:	040005b7          	lui	a1,0x4000
    80000e6e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000e70:	05b2                	slli	a1,a1,0xc
    80000e72:	e32ff0ef          	jal	800004a4 <mappages>
    80000e76:	04054363          	bltz	a0,80000ebc <proc_pagetable+0x74>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000e7a:	4719                	li	a4,6
    80000e7c:	05893683          	ld	a3,88(s2)
    80000e80:	6605                	lui	a2,0x1
    80000e82:	020005b7          	lui	a1,0x2000
    80000e86:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000e88:	05b6                	slli	a1,a1,0xd
    80000e8a:	8526                	mv	a0,s1
    80000e8c:	e18ff0ef          	jal	800004a4 <mappages>
    80000e90:	02054c63          	bltz	a0,80000ec8 <proc_pagetable+0x80>
  if(mappages(pagetable, USYSCALL, PGSIZE,
    80000e94:	4749                	li	a4,18
    80000e96:	16893683          	ld	a3,360(s2)
    80000e9a:	6605                	lui	a2,0x1
    80000e9c:	040005b7          	lui	a1,0x4000
    80000ea0:	15f5                	addi	a1,a1,-3 # 3fffffd <_entry-0x7c000003>
    80000ea2:	05b2                	slli	a1,a1,0xc
    80000ea4:	8526                	mv	a0,s1
    80000ea6:	dfeff0ef          	jal	800004a4 <mappages>
    80000eaa:	02054e63          	bltz	a0,80000ee6 <proc_pagetable+0x9e>
}
    80000eae:	8526                	mv	a0,s1
    80000eb0:	60e2                	ld	ra,24(sp)
    80000eb2:	6442                	ld	s0,16(sp)
    80000eb4:	64a2                	ld	s1,8(sp)
    80000eb6:	6902                	ld	s2,0(sp)
    80000eb8:	6105                	addi	sp,sp,32
    80000eba:	8082                	ret
    uvmfree(pagetable, 0);
    80000ebc:	4581                	li	a1,0
    80000ebe:	8526                	mv	a0,s1
    80000ec0:	a25ff0ef          	jal	800008e4 <uvmfree>
    return 0;
    80000ec4:	4481                	li	s1,0
    80000ec6:	b7e5                	j	80000eae <proc_pagetable+0x66>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000ec8:	4681                	li	a3,0
    80000eca:	4605                	li	a2,1
    80000ecc:	040005b7          	lui	a1,0x4000
    80000ed0:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ed2:	05b2                	slli	a1,a1,0xc
    80000ed4:	8526                	mv	a0,s1
    80000ed6:	f74ff0ef          	jal	8000064a <uvmunmap>
    uvmfree(pagetable, 0);
    80000eda:	4581                	li	a1,0
    80000edc:	8526                	mv	a0,s1
    80000ede:	a07ff0ef          	jal	800008e4 <uvmfree>
    return 0;
    80000ee2:	4481                	li	s1,0
    80000ee4:	b7e9                	j	80000eae <proc_pagetable+0x66>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000ee6:	4681                	li	a3,0
    80000ee8:	4605                	li	a2,1
    80000eea:	040005b7          	lui	a1,0x4000
    80000eee:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ef0:	05b2                	slli	a1,a1,0xc
    80000ef2:	8526                	mv	a0,s1
    80000ef4:	f56ff0ef          	jal	8000064a <uvmunmap>
    uvmfree(pagetable, 0);
    80000ef8:	4581                	li	a1,0
    80000efa:	8526                	mv	a0,s1
    80000efc:	9e9ff0ef          	jal	800008e4 <uvmfree>
    return 0;
    80000f00:	4481                	li	s1,0
    80000f02:	b775                	j	80000eae <proc_pagetable+0x66>

0000000080000f04 <proc_freepagetable>:
{
    80000f04:	1101                	addi	sp,sp,-32
    80000f06:	ec06                	sd	ra,24(sp)
    80000f08:	e822                	sd	s0,16(sp)
    80000f0a:	e426                	sd	s1,8(sp)
    80000f0c:	e04a                	sd	s2,0(sp)
    80000f0e:	1000                	addi	s0,sp,32
    80000f10:	84aa                	mv	s1,a0
    80000f12:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f14:	4681                	li	a3,0
    80000f16:	4605                	li	a2,1
    80000f18:	040005b7          	lui	a1,0x4000
    80000f1c:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f1e:	05b2                	slli	a1,a1,0xc
    80000f20:	f2aff0ef          	jal	8000064a <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000f24:	4681                	li	a3,0
    80000f26:	4605                	li	a2,1
    80000f28:	020005b7          	lui	a1,0x2000
    80000f2c:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000f2e:	05b6                	slli	a1,a1,0xd
    80000f30:	8526                	mv	a0,s1
    80000f32:	f18ff0ef          	jal	8000064a <uvmunmap>
  uvmunmap(pagetable, USYSCALL, 1, 0);
    80000f36:	4681                	li	a3,0
    80000f38:	4605                	li	a2,1
    80000f3a:	040005b7          	lui	a1,0x4000
    80000f3e:	15f5                	addi	a1,a1,-3 # 3fffffd <_entry-0x7c000003>
    80000f40:	05b2                	slli	a1,a1,0xc
    80000f42:	8526                	mv	a0,s1
    80000f44:	f06ff0ef          	jal	8000064a <uvmunmap>
  uvmfree(pagetable, sz);
    80000f48:	85ca                	mv	a1,s2
    80000f4a:	8526                	mv	a0,s1
    80000f4c:	999ff0ef          	jal	800008e4 <uvmfree>
}
    80000f50:	60e2                	ld	ra,24(sp)
    80000f52:	6442                	ld	s0,16(sp)
    80000f54:	64a2                	ld	s1,8(sp)
    80000f56:	6902                	ld	s2,0(sp)
    80000f58:	6105                	addi	sp,sp,32
    80000f5a:	8082                	ret

0000000080000f5c <freeproc>:
{
    80000f5c:	1101                	addi	sp,sp,-32
    80000f5e:	ec06                	sd	ra,24(sp)
    80000f60:	e822                	sd	s0,16(sp)
    80000f62:	e426                	sd	s1,8(sp)
    80000f64:	1000                	addi	s0,sp,32
    80000f66:	84aa                	mv	s1,a0
  if(p->trapframe)
    80000f68:	6d28                	ld	a0,88(a0)
    80000f6a:	c119                	beqz	a0,80000f70 <freeproc+0x14>
    kfree((void*)p->trapframe);
    80000f6c:	8b0ff0ef          	jal	8000001c <kfree>
  p->trapframe = 0;
    80000f70:	0404bc23          	sd	zero,88(s1)
  if(p->usyscall)
    80000f74:	1684b503          	ld	a0,360(s1)
    80000f78:	c119                	beqz	a0,80000f7e <freeproc+0x22>
    kfree((void*)p->usyscall);
    80000f7a:	8a2ff0ef          	jal	8000001c <kfree>
  p->usyscall = 0;
    80000f7e:	1604b423          	sd	zero,360(s1)
  if(p->pagetable)
    80000f82:	68a8                	ld	a0,80(s1)
    80000f84:	c501                	beqz	a0,80000f8c <freeproc+0x30>
    proc_freepagetable(p->pagetable, p->sz);
    80000f86:	64ac                	ld	a1,72(s1)
    80000f88:	f7dff0ef          	jal	80000f04 <proc_freepagetable>
  p->pagetable = 0;
    80000f8c:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80000f90:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80000f94:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80000f98:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80000f9c:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80000fa0:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80000fa4:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80000fa8:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80000fac:	0004ac23          	sw	zero,24(s1)
}
    80000fb0:	60e2                	ld	ra,24(sp)
    80000fb2:	6442                	ld	s0,16(sp)
    80000fb4:	64a2                	ld	s1,8(sp)
    80000fb6:	6105                	addi	sp,sp,32
    80000fb8:	8082                	ret

0000000080000fba <allocproc>:
{
    80000fba:	1101                	addi	sp,sp,-32
    80000fbc:	ec06                	sd	ra,24(sp)
    80000fbe:	e822                	sd	s0,16(sp)
    80000fc0:	e426                	sd	s1,8(sp)
    80000fc2:	e04a                	sd	s2,0(sp)
    80000fc4:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fc6:	00009497          	auipc	s1,0x9
    80000fca:	7aa48493          	addi	s1,s1,1962 # 8000a770 <proc>
    80000fce:	0000f917          	auipc	s2,0xf
    80000fd2:	3a290913          	addi	s2,s2,930 # 80010370 <tickslock>
    acquire(&p->lock);
    80000fd6:	8526                	mv	a0,s1
    80000fd8:	079040ef          	jal	80005850 <acquire>
    if(p->state == UNUSED) {
    80000fdc:	4c9c                	lw	a5,24(s1)
    80000fde:	c385                	beqz	a5,80000ffe <allocproc+0x44>
      release(&p->lock);
    80000fe0:	8526                	mv	a0,s1
    80000fe2:	107040ef          	jal	800058e8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fe6:	17048493          	addi	s1,s1,368
    80000fea:	ff2496e3          	bne	s1,s2,80000fd6 <allocproc+0x1c>
  if ((p->trapframe = (struct trapframe *)kalloc()) == 0) {
    80000fee:	910ff0ef          	jal	800000fe <kalloc>
    80000ff2:	892a                	mv	s2,a0
    80000ff4:	0000f797          	auipc	a5,0xf
    80000ff8:	3ca7ba23          	sd	a0,980(a5) # 800103c8 <bcache+0x40>
    80000ffc:	c125                	beqz	a0,8000105c <allocproc+0xa2>
  p->pid = allocpid();
    80000ffe:	e0dff0ef          	jal	80000e0a <allocpid>
    80001002:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001004:	4785                	li	a5,1
    80001006:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001008:	8f6ff0ef          	jal	800000fe <kalloc>
    8000100c:	892a                	mv	s2,a0
    8000100e:	eca8                	sd	a0,88(s1)
    80001010:	c525                	beqz	a0,80001078 <allocproc+0xbe>
  if ((p->usyscall = (struct usyscall *) kalloc()) == 0) {
    80001012:	8ecff0ef          	jal	800000fe <kalloc>
    80001016:	892a                	mv	s2,a0
    80001018:	16a4b423          	sd	a0,360(s1)
    8000101c:	c535                	beqz	a0,80001088 <allocproc+0xce>
  p->usyscall->pid = p->pid;
    8000101e:	589c                	lw	a5,48(s1)
    80001020:	c11c                	sw	a5,0(a0)
  p->pagetable = proc_pagetable(p);
    80001022:	8526                	mv	a0,s1
    80001024:	e25ff0ef          	jal	80000e48 <proc_pagetable>
    80001028:	892a                	mv	s2,a0
    8000102a:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    8000102c:	c535                	beqz	a0,80001098 <allocproc+0xde>
  memset(&p->context, 0, sizeof(p->context));
    8000102e:	07000613          	li	a2,112
    80001032:	4581                	li	a1,0
    80001034:	06048513          	addi	a0,s1,96
    80001038:	916ff0ef          	jal	8000014e <memset>
  p->context.ra = (uint64)forkret;
    8000103c:	00000797          	auipc	a5,0x0
    80001040:	d9478793          	addi	a5,a5,-620 # 80000dd0 <forkret>
    80001044:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001046:	60bc                	ld	a5,64(s1)
    80001048:	6705                	lui	a4,0x1
    8000104a:	97ba                	add	a5,a5,a4
    8000104c:	f4bc                	sd	a5,104(s1)
}
    8000104e:	8526                	mv	a0,s1
    80001050:	60e2                	ld	ra,24(sp)
    80001052:	6442                	ld	s0,16(sp)
    80001054:	64a2                	ld	s1,8(sp)
    80001056:	6902                	ld	s2,0(sp)
    80001058:	6105                	addi	sp,sp,32
    8000105a:	8082                	ret
    freeproc(p);
    8000105c:	0000f517          	auipc	a0,0xf
    80001060:	31450513          	addi	a0,a0,788 # 80010370 <tickslock>
    80001064:	ef9ff0ef          	jal	80000f5c <freeproc>
    release(&p->lock);
    80001068:	0000f517          	auipc	a0,0xf
    8000106c:	30850513          	addi	a0,a0,776 # 80010370 <tickslock>
    80001070:	079040ef          	jal	800058e8 <release>
    return 0;
    80001074:	84ca                	mv	s1,s2
    80001076:	bfe1                	j	8000104e <allocproc+0x94>
    freeproc(p);
    80001078:	8526                	mv	a0,s1
    8000107a:	ee3ff0ef          	jal	80000f5c <freeproc>
    release(&p->lock);
    8000107e:	8526                	mv	a0,s1
    80001080:	069040ef          	jal	800058e8 <release>
    return 0;
    80001084:	84ca                	mv	s1,s2
    80001086:	b7e1                	j	8000104e <allocproc+0x94>
      freeproc(p);
    80001088:	8526                	mv	a0,s1
    8000108a:	ed3ff0ef          	jal	80000f5c <freeproc>
      release(&p->lock);
    8000108e:	8526                	mv	a0,s1
    80001090:	059040ef          	jal	800058e8 <release>
      return 0;
    80001094:	84ca                	mv	s1,s2
    80001096:	bf65                	j	8000104e <allocproc+0x94>
    freeproc(p);
    80001098:	8526                	mv	a0,s1
    8000109a:	ec3ff0ef          	jal	80000f5c <freeproc>
    release(&p->lock);
    8000109e:	8526                	mv	a0,s1
    800010a0:	049040ef          	jal	800058e8 <release>
    return 0;
    800010a4:	84ca                	mv	s1,s2
    800010a6:	b765                	j	8000104e <allocproc+0x94>

00000000800010a8 <userinit>:
{
    800010a8:	1101                	addi	sp,sp,-32
    800010aa:	ec06                	sd	ra,24(sp)
    800010ac:	e822                	sd	s0,16(sp)
    800010ae:	e426                	sd	s1,8(sp)
    800010b0:	1000                	addi	s0,sp,32
  p = allocproc();
    800010b2:	f09ff0ef          	jal	80000fba <allocproc>
    800010b6:	84aa                	mv	s1,a0
  initproc = p;
    800010b8:	00009797          	auipc	a5,0x9
    800010bc:	24a7b423          	sd	a0,584(a5) # 8000a300 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800010c0:	03400613          	li	a2,52
    800010c4:	00009597          	auipc	a1,0x9
    800010c8:	1cc58593          	addi	a1,a1,460 # 8000a290 <initcode>
    800010cc:	6928                	ld	a0,80(a0)
    800010ce:	e6eff0ef          	jal	8000073c <uvmfirst>
  p->sz = PGSIZE;
    800010d2:	6785                	lui	a5,0x1
    800010d4:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    800010d6:	6cb8                	ld	a4,88(s1)
    800010d8:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800010dc:	6cb8                	ld	a4,88(s1)
    800010de:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800010e0:	4641                	li	a2,16
    800010e2:	00006597          	auipc	a1,0x6
    800010e6:	0ee58593          	addi	a1,a1,238 # 800071d0 <etext+0x1d0>
    800010ea:	15848513          	addi	a0,s1,344
    800010ee:	99eff0ef          	jal	8000028c <safestrcpy>
  p->cwd = namei("/");
    800010f2:	00006517          	auipc	a0,0x6
    800010f6:	0ee50513          	addi	a0,a0,238 # 800071e0 <etext+0x1e0>
    800010fa:	555010ef          	jal	80002e4e <namei>
    800010fe:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001102:	478d                	li	a5,3
    80001104:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001106:	8526                	mv	a0,s1
    80001108:	7e0040ef          	jal	800058e8 <release>
}
    8000110c:	60e2                	ld	ra,24(sp)
    8000110e:	6442                	ld	s0,16(sp)
    80001110:	64a2                	ld	s1,8(sp)
    80001112:	6105                	addi	sp,sp,32
    80001114:	8082                	ret

0000000080001116 <growproc>:
{
    80001116:	1101                	addi	sp,sp,-32
    80001118:	ec06                	sd	ra,24(sp)
    8000111a:	e822                	sd	s0,16(sp)
    8000111c:	e426                	sd	s1,8(sp)
    8000111e:	e04a                	sd	s2,0(sp)
    80001120:	1000                	addi	s0,sp,32
    80001122:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001124:	c7dff0ef          	jal	80000da0 <myproc>
    80001128:	84aa                	mv	s1,a0
  sz = p->sz;
    8000112a:	652c                	ld	a1,72(a0)
  if(n > 0){
    8000112c:	01204c63          	bgtz	s2,80001144 <growproc+0x2e>
  } else if(n < 0){
    80001130:	02094463          	bltz	s2,80001158 <growproc+0x42>
  p->sz = sz;
    80001134:	e4ac                	sd	a1,72(s1)
  return 0;
    80001136:	4501                	li	a0,0
}
    80001138:	60e2                	ld	ra,24(sp)
    8000113a:	6442                	ld	s0,16(sp)
    8000113c:	64a2                	ld	s1,8(sp)
    8000113e:	6902                	ld	s2,0(sp)
    80001140:	6105                	addi	sp,sp,32
    80001142:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001144:	4691                	li	a3,4
    80001146:	00b90633          	add	a2,s2,a1
    8000114a:	6928                	ld	a0,80(a0)
    8000114c:	e92ff0ef          	jal	800007de <uvmalloc>
    80001150:	85aa                	mv	a1,a0
    80001152:	f16d                	bnez	a0,80001134 <growproc+0x1e>
      return -1;
    80001154:	557d                	li	a0,-1
    80001156:	b7cd                	j	80001138 <growproc+0x22>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001158:	00b90633          	add	a2,s2,a1
    8000115c:	6928                	ld	a0,80(a0)
    8000115e:	e3cff0ef          	jal	8000079a <uvmdealloc>
    80001162:	85aa                	mv	a1,a0
    80001164:	bfc1                	j	80001134 <growproc+0x1e>

0000000080001166 <fork>:
{
    80001166:	7139                	addi	sp,sp,-64
    80001168:	fc06                	sd	ra,56(sp)
    8000116a:	f822                	sd	s0,48(sp)
    8000116c:	f04a                	sd	s2,32(sp)
    8000116e:	e456                	sd	s5,8(sp)
    80001170:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001172:	c2fff0ef          	jal	80000da0 <myproc>
    80001176:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001178:	e43ff0ef          	jal	80000fba <allocproc>
    8000117c:	0e050a63          	beqz	a0,80001270 <fork+0x10a>
    80001180:	e852                	sd	s4,16(sp)
    80001182:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001184:	048ab603          	ld	a2,72(s5)
    80001188:	692c                	ld	a1,80(a0)
    8000118a:	050ab503          	ld	a0,80(s5)
    8000118e:	f88ff0ef          	jal	80000916 <uvmcopy>
    80001192:	04054a63          	bltz	a0,800011e6 <fork+0x80>
    80001196:	f426                	sd	s1,40(sp)
    80001198:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    8000119a:	048ab783          	ld	a5,72(s5)
    8000119e:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    800011a2:	058ab683          	ld	a3,88(s5)
    800011a6:	87b6                	mv	a5,a3
    800011a8:	058a3703          	ld	a4,88(s4)
    800011ac:	12068693          	addi	a3,a3,288
    800011b0:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800011b4:	6788                	ld	a0,8(a5)
    800011b6:	6b8c                	ld	a1,16(a5)
    800011b8:	6f90                	ld	a2,24(a5)
    800011ba:	01073023          	sd	a6,0(a4)
    800011be:	e708                	sd	a0,8(a4)
    800011c0:	eb0c                	sd	a1,16(a4)
    800011c2:	ef10                	sd	a2,24(a4)
    800011c4:	02078793          	addi	a5,a5,32
    800011c8:	02070713          	addi	a4,a4,32
    800011cc:	fed792e3          	bne	a5,a3,800011b0 <fork+0x4a>
  np->trapframe->a0 = 0;
    800011d0:	058a3783          	ld	a5,88(s4)
    800011d4:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    800011d8:	0d0a8493          	addi	s1,s5,208
    800011dc:	0d0a0913          	addi	s2,s4,208
    800011e0:	150a8993          	addi	s3,s5,336
    800011e4:	a831                	j	80001200 <fork+0x9a>
    freeproc(np);
    800011e6:	8552                	mv	a0,s4
    800011e8:	d75ff0ef          	jal	80000f5c <freeproc>
    release(&np->lock);
    800011ec:	8552                	mv	a0,s4
    800011ee:	6fa040ef          	jal	800058e8 <release>
    return -1;
    800011f2:	597d                	li	s2,-1
    800011f4:	6a42                	ld	s4,16(sp)
    800011f6:	a0b5                	j	80001262 <fork+0xfc>
  for(i = 0; i < NOFILE; i++)
    800011f8:	04a1                	addi	s1,s1,8
    800011fa:	0921                	addi	s2,s2,8
    800011fc:	01348963          	beq	s1,s3,8000120e <fork+0xa8>
    if(p->ofile[i])
    80001200:	6088                	ld	a0,0(s1)
    80001202:	d97d                	beqz	a0,800011f8 <fork+0x92>
      np->ofile[i] = filedup(p->ofile[i]);
    80001204:	1da020ef          	jal	800033de <filedup>
    80001208:	00a93023          	sd	a0,0(s2)
    8000120c:	b7f5                	j	800011f8 <fork+0x92>
  np->cwd = idup(p->cwd);
    8000120e:	150ab503          	ld	a0,336(s5)
    80001212:	52c010ef          	jal	8000273e <idup>
    80001216:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    8000121a:	4641                	li	a2,16
    8000121c:	158a8593          	addi	a1,s5,344
    80001220:	158a0513          	addi	a0,s4,344
    80001224:	868ff0ef          	jal	8000028c <safestrcpy>
  pid = np->pid;
    80001228:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    8000122c:	8552                	mv	a0,s4
    8000122e:	6ba040ef          	jal	800058e8 <release>
  acquire(&wait_lock);
    80001232:	00009497          	auipc	s1,0x9
    80001236:	12648493          	addi	s1,s1,294 # 8000a358 <wait_lock>
    8000123a:	8526                	mv	a0,s1
    8000123c:	614040ef          	jal	80005850 <acquire>
  np->parent = p;
    80001240:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001244:	8526                	mv	a0,s1
    80001246:	6a2040ef          	jal	800058e8 <release>
  acquire(&np->lock);
    8000124a:	8552                	mv	a0,s4
    8000124c:	604040ef          	jal	80005850 <acquire>
  np->state = RUNNABLE;
    80001250:	478d                	li	a5,3
    80001252:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001256:	8552                	mv	a0,s4
    80001258:	690040ef          	jal	800058e8 <release>
  return pid;
    8000125c:	74a2                	ld	s1,40(sp)
    8000125e:	69e2                	ld	s3,24(sp)
    80001260:	6a42                	ld	s4,16(sp)
}
    80001262:	854a                	mv	a0,s2
    80001264:	70e2                	ld	ra,56(sp)
    80001266:	7442                	ld	s0,48(sp)
    80001268:	7902                	ld	s2,32(sp)
    8000126a:	6aa2                	ld	s5,8(sp)
    8000126c:	6121                	addi	sp,sp,64
    8000126e:	8082                	ret
    return -1;
    80001270:	597d                	li	s2,-1
    80001272:	bfc5                	j	80001262 <fork+0xfc>

0000000080001274 <scheduler>:
{
    80001274:	715d                	addi	sp,sp,-80
    80001276:	e486                	sd	ra,72(sp)
    80001278:	e0a2                	sd	s0,64(sp)
    8000127a:	fc26                	sd	s1,56(sp)
    8000127c:	f84a                	sd	s2,48(sp)
    8000127e:	f44e                	sd	s3,40(sp)
    80001280:	f052                	sd	s4,32(sp)
    80001282:	ec56                	sd	s5,24(sp)
    80001284:	e85a                	sd	s6,16(sp)
    80001286:	e45e                	sd	s7,8(sp)
    80001288:	e062                	sd	s8,0(sp)
    8000128a:	0880                	addi	s0,sp,80
    8000128c:	8792                	mv	a5,tp
  int id = r_tp();
    8000128e:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001290:	00779b13          	slli	s6,a5,0x7
    80001294:	00009717          	auipc	a4,0x9
    80001298:	0ac70713          	addi	a4,a4,172 # 8000a340 <pid_lock>
    8000129c:	975a                	add	a4,a4,s6
    8000129e:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800012a2:	00009717          	auipc	a4,0x9
    800012a6:	0d670713          	addi	a4,a4,214 # 8000a378 <cpus+0x8>
    800012aa:	9b3a                	add	s6,s6,a4
        p->state = RUNNING;
    800012ac:	4c11                	li	s8,4
        c->proc = p;
    800012ae:	079e                	slli	a5,a5,0x7
    800012b0:	00009a17          	auipc	s4,0x9
    800012b4:	090a0a13          	addi	s4,s4,144 # 8000a340 <pid_lock>
    800012b8:	9a3e                	add	s4,s4,a5
        found = 1;
    800012ba:	4b85                	li	s7,1
    for(p = proc; p < &proc[NPROC]; p++) {
    800012bc:	0000f997          	auipc	s3,0xf
    800012c0:	0b498993          	addi	s3,s3,180 # 80010370 <tickslock>
    800012c4:	a0a9                	j	8000130e <scheduler+0x9a>
      release(&p->lock);
    800012c6:	8526                	mv	a0,s1
    800012c8:	620040ef          	jal	800058e8 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800012cc:	17048493          	addi	s1,s1,368
    800012d0:	03348563          	beq	s1,s3,800012fa <scheduler+0x86>
      acquire(&p->lock);
    800012d4:	8526                	mv	a0,s1
    800012d6:	57a040ef          	jal	80005850 <acquire>
      if(p->state == RUNNABLE) {
    800012da:	4c9c                	lw	a5,24(s1)
    800012dc:	ff2795e3          	bne	a5,s2,800012c6 <scheduler+0x52>
        p->state = RUNNING;
    800012e0:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    800012e4:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800012e8:	06048593          	addi	a1,s1,96
    800012ec:	855a                	mv	a0,s6
    800012ee:	5b4000ef          	jal	800018a2 <swtch>
        c->proc = 0;
    800012f2:	020a3823          	sd	zero,48(s4)
        found = 1;
    800012f6:	8ade                	mv	s5,s7
    800012f8:	b7f9                	j	800012c6 <scheduler+0x52>
    if(found == 0) {
    800012fa:	000a9a63          	bnez	s5,8000130e <scheduler+0x9a>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800012fe:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001302:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001306:	10079073          	csrw	sstatus,a5
      asm volatile("wfi");
    8000130a:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000130e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001312:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001316:	10079073          	csrw	sstatus,a5
    int found = 0;
    8000131a:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    8000131c:	00009497          	auipc	s1,0x9
    80001320:	45448493          	addi	s1,s1,1108 # 8000a770 <proc>
      if(p->state == RUNNABLE) {
    80001324:	490d                	li	s2,3
    80001326:	b77d                	j	800012d4 <scheduler+0x60>

0000000080001328 <sched>:
{
    80001328:	7179                	addi	sp,sp,-48
    8000132a:	f406                	sd	ra,40(sp)
    8000132c:	f022                	sd	s0,32(sp)
    8000132e:	ec26                	sd	s1,24(sp)
    80001330:	e84a                	sd	s2,16(sp)
    80001332:	e44e                	sd	s3,8(sp)
    80001334:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001336:	a6bff0ef          	jal	80000da0 <myproc>
    8000133a:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000133c:	4aa040ef          	jal	800057e6 <holding>
    80001340:	c92d                	beqz	a0,800013b2 <sched+0x8a>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001342:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001344:	2781                	sext.w	a5,a5
    80001346:	079e                	slli	a5,a5,0x7
    80001348:	00009717          	auipc	a4,0x9
    8000134c:	ff870713          	addi	a4,a4,-8 # 8000a340 <pid_lock>
    80001350:	97ba                	add	a5,a5,a4
    80001352:	0a87a703          	lw	a4,168(a5)
    80001356:	4785                	li	a5,1
    80001358:	06f71363          	bne	a4,a5,800013be <sched+0x96>
  if(p->state == RUNNING)
    8000135c:	4c98                	lw	a4,24(s1)
    8000135e:	4791                	li	a5,4
    80001360:	06f70563          	beq	a4,a5,800013ca <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001364:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001368:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000136a:	e7b5                	bnez	a5,800013d6 <sched+0xae>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000136c:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    8000136e:	00009917          	auipc	s2,0x9
    80001372:	fd290913          	addi	s2,s2,-46 # 8000a340 <pid_lock>
    80001376:	2781                	sext.w	a5,a5
    80001378:	079e                	slli	a5,a5,0x7
    8000137a:	97ca                	add	a5,a5,s2
    8000137c:	0ac7a983          	lw	s3,172(a5)
    80001380:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001382:	2781                	sext.w	a5,a5
    80001384:	079e                	slli	a5,a5,0x7
    80001386:	00009597          	auipc	a1,0x9
    8000138a:	ff258593          	addi	a1,a1,-14 # 8000a378 <cpus+0x8>
    8000138e:	95be                	add	a1,a1,a5
    80001390:	06048513          	addi	a0,s1,96
    80001394:	50e000ef          	jal	800018a2 <swtch>
    80001398:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    8000139a:	2781                	sext.w	a5,a5
    8000139c:	079e                	slli	a5,a5,0x7
    8000139e:	993e                	add	s2,s2,a5
    800013a0:	0b392623          	sw	s3,172(s2)
}
    800013a4:	70a2                	ld	ra,40(sp)
    800013a6:	7402                	ld	s0,32(sp)
    800013a8:	64e2                	ld	s1,24(sp)
    800013aa:	6942                	ld	s2,16(sp)
    800013ac:	69a2                	ld	s3,8(sp)
    800013ae:	6145                	addi	sp,sp,48
    800013b0:	8082                	ret
    panic("sched p->lock");
    800013b2:	00006517          	auipc	a0,0x6
    800013b6:	e3650513          	addi	a0,a0,-458 # 800071e8 <etext+0x1e8>
    800013ba:	168040ef          	jal	80005522 <panic>
    panic("sched locks");
    800013be:	00006517          	auipc	a0,0x6
    800013c2:	e3a50513          	addi	a0,a0,-454 # 800071f8 <etext+0x1f8>
    800013c6:	15c040ef          	jal	80005522 <panic>
    panic("sched running");
    800013ca:	00006517          	auipc	a0,0x6
    800013ce:	e3e50513          	addi	a0,a0,-450 # 80007208 <etext+0x208>
    800013d2:	150040ef          	jal	80005522 <panic>
    panic("sched interruptible");
    800013d6:	00006517          	auipc	a0,0x6
    800013da:	e4250513          	addi	a0,a0,-446 # 80007218 <etext+0x218>
    800013de:	144040ef          	jal	80005522 <panic>

00000000800013e2 <yield>:
{
    800013e2:	1101                	addi	sp,sp,-32
    800013e4:	ec06                	sd	ra,24(sp)
    800013e6:	e822                	sd	s0,16(sp)
    800013e8:	e426                	sd	s1,8(sp)
    800013ea:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800013ec:	9b5ff0ef          	jal	80000da0 <myproc>
    800013f0:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800013f2:	45e040ef          	jal	80005850 <acquire>
  p->state = RUNNABLE;
    800013f6:	478d                	li	a5,3
    800013f8:	cc9c                	sw	a5,24(s1)
  sched();
    800013fa:	f2fff0ef          	jal	80001328 <sched>
  release(&p->lock);
    800013fe:	8526                	mv	a0,s1
    80001400:	4e8040ef          	jal	800058e8 <release>
}
    80001404:	60e2                	ld	ra,24(sp)
    80001406:	6442                	ld	s0,16(sp)
    80001408:	64a2                	ld	s1,8(sp)
    8000140a:	6105                	addi	sp,sp,32
    8000140c:	8082                	ret

000000008000140e <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    8000140e:	7179                	addi	sp,sp,-48
    80001410:	f406                	sd	ra,40(sp)
    80001412:	f022                	sd	s0,32(sp)
    80001414:	ec26                	sd	s1,24(sp)
    80001416:	e84a                	sd	s2,16(sp)
    80001418:	e44e                	sd	s3,8(sp)
    8000141a:	1800                	addi	s0,sp,48
    8000141c:	89aa                	mv	s3,a0
    8000141e:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001420:	981ff0ef          	jal	80000da0 <myproc>
    80001424:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001426:	42a040ef          	jal	80005850 <acquire>
  release(lk);
    8000142a:	854a                	mv	a0,s2
    8000142c:	4bc040ef          	jal	800058e8 <release>

  // Go to sleep.
  p->chan = chan;
    80001430:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001434:	4789                	li	a5,2
    80001436:	cc9c                	sw	a5,24(s1)

  sched();
    80001438:	ef1ff0ef          	jal	80001328 <sched>

  // Tidy up.
  p->chan = 0;
    8000143c:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001440:	8526                	mv	a0,s1
    80001442:	4a6040ef          	jal	800058e8 <release>
  acquire(lk);
    80001446:	854a                	mv	a0,s2
    80001448:	408040ef          	jal	80005850 <acquire>
}
    8000144c:	70a2                	ld	ra,40(sp)
    8000144e:	7402                	ld	s0,32(sp)
    80001450:	64e2                	ld	s1,24(sp)
    80001452:	6942                	ld	s2,16(sp)
    80001454:	69a2                	ld	s3,8(sp)
    80001456:	6145                	addi	sp,sp,48
    80001458:	8082                	ret

000000008000145a <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000145a:	7139                	addi	sp,sp,-64
    8000145c:	fc06                	sd	ra,56(sp)
    8000145e:	f822                	sd	s0,48(sp)
    80001460:	f426                	sd	s1,40(sp)
    80001462:	f04a                	sd	s2,32(sp)
    80001464:	ec4e                	sd	s3,24(sp)
    80001466:	e852                	sd	s4,16(sp)
    80001468:	e456                	sd	s5,8(sp)
    8000146a:	0080                	addi	s0,sp,64
    8000146c:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000146e:	00009497          	auipc	s1,0x9
    80001472:	30248493          	addi	s1,s1,770 # 8000a770 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001476:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001478:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000147a:	0000f917          	auipc	s2,0xf
    8000147e:	ef690913          	addi	s2,s2,-266 # 80010370 <tickslock>
    80001482:	a801                	j	80001492 <wakeup+0x38>
      }
      release(&p->lock);
    80001484:	8526                	mv	a0,s1
    80001486:	462040ef          	jal	800058e8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000148a:	17048493          	addi	s1,s1,368
    8000148e:	03248263          	beq	s1,s2,800014b2 <wakeup+0x58>
    if(p != myproc()){
    80001492:	90fff0ef          	jal	80000da0 <myproc>
    80001496:	fea48ae3          	beq	s1,a0,8000148a <wakeup+0x30>
      acquire(&p->lock);
    8000149a:	8526                	mv	a0,s1
    8000149c:	3b4040ef          	jal	80005850 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800014a0:	4c9c                	lw	a5,24(s1)
    800014a2:	ff3791e3          	bne	a5,s3,80001484 <wakeup+0x2a>
    800014a6:	709c                	ld	a5,32(s1)
    800014a8:	fd479ee3          	bne	a5,s4,80001484 <wakeup+0x2a>
        p->state = RUNNABLE;
    800014ac:	0154ac23          	sw	s5,24(s1)
    800014b0:	bfd1                	j	80001484 <wakeup+0x2a>
    }
  }
}
    800014b2:	70e2                	ld	ra,56(sp)
    800014b4:	7442                	ld	s0,48(sp)
    800014b6:	74a2                	ld	s1,40(sp)
    800014b8:	7902                	ld	s2,32(sp)
    800014ba:	69e2                	ld	s3,24(sp)
    800014bc:	6a42                	ld	s4,16(sp)
    800014be:	6aa2                	ld	s5,8(sp)
    800014c0:	6121                	addi	sp,sp,64
    800014c2:	8082                	ret

00000000800014c4 <reparent>:
{
    800014c4:	7179                	addi	sp,sp,-48
    800014c6:	f406                	sd	ra,40(sp)
    800014c8:	f022                	sd	s0,32(sp)
    800014ca:	ec26                	sd	s1,24(sp)
    800014cc:	e84a                	sd	s2,16(sp)
    800014ce:	e44e                	sd	s3,8(sp)
    800014d0:	e052                	sd	s4,0(sp)
    800014d2:	1800                	addi	s0,sp,48
    800014d4:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800014d6:	00009497          	auipc	s1,0x9
    800014da:	29a48493          	addi	s1,s1,666 # 8000a770 <proc>
      pp->parent = initproc;
    800014de:	00009a17          	auipc	s4,0x9
    800014e2:	e22a0a13          	addi	s4,s4,-478 # 8000a300 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800014e6:	0000f997          	auipc	s3,0xf
    800014ea:	e8a98993          	addi	s3,s3,-374 # 80010370 <tickslock>
    800014ee:	a029                	j	800014f8 <reparent+0x34>
    800014f0:	17048493          	addi	s1,s1,368
    800014f4:	01348b63          	beq	s1,s3,8000150a <reparent+0x46>
    if(pp->parent == p){
    800014f8:	7c9c                	ld	a5,56(s1)
    800014fa:	ff279be3          	bne	a5,s2,800014f0 <reparent+0x2c>
      pp->parent = initproc;
    800014fe:	000a3503          	ld	a0,0(s4)
    80001502:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001504:	f57ff0ef          	jal	8000145a <wakeup>
    80001508:	b7e5                	j	800014f0 <reparent+0x2c>
}
    8000150a:	70a2                	ld	ra,40(sp)
    8000150c:	7402                	ld	s0,32(sp)
    8000150e:	64e2                	ld	s1,24(sp)
    80001510:	6942                	ld	s2,16(sp)
    80001512:	69a2                	ld	s3,8(sp)
    80001514:	6a02                	ld	s4,0(sp)
    80001516:	6145                	addi	sp,sp,48
    80001518:	8082                	ret

000000008000151a <exit>:
{
    8000151a:	7179                	addi	sp,sp,-48
    8000151c:	f406                	sd	ra,40(sp)
    8000151e:	f022                	sd	s0,32(sp)
    80001520:	ec26                	sd	s1,24(sp)
    80001522:	e84a                	sd	s2,16(sp)
    80001524:	e44e                	sd	s3,8(sp)
    80001526:	e052                	sd	s4,0(sp)
    80001528:	1800                	addi	s0,sp,48
    8000152a:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000152c:	875ff0ef          	jal	80000da0 <myproc>
    80001530:	89aa                	mv	s3,a0
  if(p == initproc)
    80001532:	00009797          	auipc	a5,0x9
    80001536:	dce7b783          	ld	a5,-562(a5) # 8000a300 <initproc>
    8000153a:	0d050493          	addi	s1,a0,208
    8000153e:	15050913          	addi	s2,a0,336
    80001542:	00a79f63          	bne	a5,a0,80001560 <exit+0x46>
    panic("init exiting");
    80001546:	00006517          	auipc	a0,0x6
    8000154a:	cea50513          	addi	a0,a0,-790 # 80007230 <etext+0x230>
    8000154e:	7d5030ef          	jal	80005522 <panic>
      fileclose(f);
    80001552:	6d3010ef          	jal	80003424 <fileclose>
      p->ofile[fd] = 0;
    80001556:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000155a:	04a1                	addi	s1,s1,8
    8000155c:	01248563          	beq	s1,s2,80001566 <exit+0x4c>
    if(p->ofile[fd]){
    80001560:	6088                	ld	a0,0(s1)
    80001562:	f965                	bnez	a0,80001552 <exit+0x38>
    80001564:	bfdd                	j	8000155a <exit+0x40>
  begin_op();
    80001566:	2a5010ef          	jal	8000300a <begin_op>
  iput(p->cwd);
    8000156a:	1509b503          	ld	a0,336(s3)
    8000156e:	388010ef          	jal	800028f6 <iput>
  end_op();
    80001572:	303010ef          	jal	80003074 <end_op>
  p->cwd = 0;
    80001576:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    8000157a:	00009497          	auipc	s1,0x9
    8000157e:	dde48493          	addi	s1,s1,-546 # 8000a358 <wait_lock>
    80001582:	8526                	mv	a0,s1
    80001584:	2cc040ef          	jal	80005850 <acquire>
  reparent(p);
    80001588:	854e                	mv	a0,s3
    8000158a:	f3bff0ef          	jal	800014c4 <reparent>
  wakeup(p->parent);
    8000158e:	0389b503          	ld	a0,56(s3)
    80001592:	ec9ff0ef          	jal	8000145a <wakeup>
  acquire(&p->lock);
    80001596:	854e                	mv	a0,s3
    80001598:	2b8040ef          	jal	80005850 <acquire>
  p->xstate = status;
    8000159c:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800015a0:	4795                	li	a5,5
    800015a2:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    800015a6:	8526                	mv	a0,s1
    800015a8:	340040ef          	jal	800058e8 <release>
  sched();
    800015ac:	d7dff0ef          	jal	80001328 <sched>
  panic("zombie exit");
    800015b0:	00006517          	auipc	a0,0x6
    800015b4:	c9050513          	addi	a0,a0,-880 # 80007240 <etext+0x240>
    800015b8:	76b030ef          	jal	80005522 <panic>

00000000800015bc <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800015bc:	7179                	addi	sp,sp,-48
    800015be:	f406                	sd	ra,40(sp)
    800015c0:	f022                	sd	s0,32(sp)
    800015c2:	ec26                	sd	s1,24(sp)
    800015c4:	e84a                	sd	s2,16(sp)
    800015c6:	e44e                	sd	s3,8(sp)
    800015c8:	1800                	addi	s0,sp,48
    800015ca:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800015cc:	00009497          	auipc	s1,0x9
    800015d0:	1a448493          	addi	s1,s1,420 # 8000a770 <proc>
    800015d4:	0000f997          	auipc	s3,0xf
    800015d8:	d9c98993          	addi	s3,s3,-612 # 80010370 <tickslock>
    acquire(&p->lock);
    800015dc:	8526                	mv	a0,s1
    800015de:	272040ef          	jal	80005850 <acquire>
    if(p->pid == pid){
    800015e2:	589c                	lw	a5,48(s1)
    800015e4:	01278b63          	beq	a5,s2,800015fa <kill+0x3e>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800015e8:	8526                	mv	a0,s1
    800015ea:	2fe040ef          	jal	800058e8 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800015ee:	17048493          	addi	s1,s1,368
    800015f2:	ff3495e3          	bne	s1,s3,800015dc <kill+0x20>
  }
  return -1;
    800015f6:	557d                	li	a0,-1
    800015f8:	a819                	j	8000160e <kill+0x52>
      p->killed = 1;
    800015fa:	4785                	li	a5,1
    800015fc:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800015fe:	4c98                	lw	a4,24(s1)
    80001600:	4789                	li	a5,2
    80001602:	00f70d63          	beq	a4,a5,8000161c <kill+0x60>
      release(&p->lock);
    80001606:	8526                	mv	a0,s1
    80001608:	2e0040ef          	jal	800058e8 <release>
      return 0;
    8000160c:	4501                	li	a0,0
}
    8000160e:	70a2                	ld	ra,40(sp)
    80001610:	7402                	ld	s0,32(sp)
    80001612:	64e2                	ld	s1,24(sp)
    80001614:	6942                	ld	s2,16(sp)
    80001616:	69a2                	ld	s3,8(sp)
    80001618:	6145                	addi	sp,sp,48
    8000161a:	8082                	ret
        p->state = RUNNABLE;
    8000161c:	478d                	li	a5,3
    8000161e:	cc9c                	sw	a5,24(s1)
    80001620:	b7dd                	j	80001606 <kill+0x4a>

0000000080001622 <setkilled>:

void
setkilled(struct proc *p)
{
    80001622:	1101                	addi	sp,sp,-32
    80001624:	ec06                	sd	ra,24(sp)
    80001626:	e822                	sd	s0,16(sp)
    80001628:	e426                	sd	s1,8(sp)
    8000162a:	1000                	addi	s0,sp,32
    8000162c:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000162e:	222040ef          	jal	80005850 <acquire>
  p->killed = 1;
    80001632:	4785                	li	a5,1
    80001634:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001636:	8526                	mv	a0,s1
    80001638:	2b0040ef          	jal	800058e8 <release>
}
    8000163c:	60e2                	ld	ra,24(sp)
    8000163e:	6442                	ld	s0,16(sp)
    80001640:	64a2                	ld	s1,8(sp)
    80001642:	6105                	addi	sp,sp,32
    80001644:	8082                	ret

0000000080001646 <killed>:

int
killed(struct proc *p)
{
    80001646:	1101                	addi	sp,sp,-32
    80001648:	ec06                	sd	ra,24(sp)
    8000164a:	e822                	sd	s0,16(sp)
    8000164c:	e426                	sd	s1,8(sp)
    8000164e:	e04a                	sd	s2,0(sp)
    80001650:	1000                	addi	s0,sp,32
    80001652:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80001654:	1fc040ef          	jal	80005850 <acquire>
  k = p->killed;
    80001658:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    8000165c:	8526                	mv	a0,s1
    8000165e:	28a040ef          	jal	800058e8 <release>
  return k;
}
    80001662:	854a                	mv	a0,s2
    80001664:	60e2                	ld	ra,24(sp)
    80001666:	6442                	ld	s0,16(sp)
    80001668:	64a2                	ld	s1,8(sp)
    8000166a:	6902                	ld	s2,0(sp)
    8000166c:	6105                	addi	sp,sp,32
    8000166e:	8082                	ret

0000000080001670 <wait>:
{
    80001670:	715d                	addi	sp,sp,-80
    80001672:	e486                	sd	ra,72(sp)
    80001674:	e0a2                	sd	s0,64(sp)
    80001676:	fc26                	sd	s1,56(sp)
    80001678:	f84a                	sd	s2,48(sp)
    8000167a:	f44e                	sd	s3,40(sp)
    8000167c:	f052                	sd	s4,32(sp)
    8000167e:	ec56                	sd	s5,24(sp)
    80001680:	e85a                	sd	s6,16(sp)
    80001682:	e45e                	sd	s7,8(sp)
    80001684:	e062                	sd	s8,0(sp)
    80001686:	0880                	addi	s0,sp,80
    80001688:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    8000168a:	f16ff0ef          	jal	80000da0 <myproc>
    8000168e:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001690:	00009517          	auipc	a0,0x9
    80001694:	cc850513          	addi	a0,a0,-824 # 8000a358 <wait_lock>
    80001698:	1b8040ef          	jal	80005850 <acquire>
    havekids = 0;
    8000169c:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    8000169e:	4a15                	li	s4,5
        havekids = 1;
    800016a0:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800016a2:	0000f997          	auipc	s3,0xf
    800016a6:	cce98993          	addi	s3,s3,-818 # 80010370 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800016aa:	00009c17          	auipc	s8,0x9
    800016ae:	caec0c13          	addi	s8,s8,-850 # 8000a358 <wait_lock>
    800016b2:	a871                	j	8000174e <wait+0xde>
          pid = pp->pid;
    800016b4:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800016b8:	000b0c63          	beqz	s6,800016d0 <wait+0x60>
    800016bc:	4691                	li	a3,4
    800016be:	02c48613          	addi	a2,s1,44
    800016c2:	85da                	mv	a1,s6
    800016c4:	05093503          	ld	a0,80(s2)
    800016c8:	b2aff0ef          	jal	800009f2 <copyout>
    800016cc:	02054b63          	bltz	a0,80001702 <wait+0x92>
          freeproc(pp);
    800016d0:	8526                	mv	a0,s1
    800016d2:	88bff0ef          	jal	80000f5c <freeproc>
          release(&pp->lock);
    800016d6:	8526                	mv	a0,s1
    800016d8:	210040ef          	jal	800058e8 <release>
          release(&wait_lock);
    800016dc:	00009517          	auipc	a0,0x9
    800016e0:	c7c50513          	addi	a0,a0,-900 # 8000a358 <wait_lock>
    800016e4:	204040ef          	jal	800058e8 <release>
}
    800016e8:	854e                	mv	a0,s3
    800016ea:	60a6                	ld	ra,72(sp)
    800016ec:	6406                	ld	s0,64(sp)
    800016ee:	74e2                	ld	s1,56(sp)
    800016f0:	7942                	ld	s2,48(sp)
    800016f2:	79a2                	ld	s3,40(sp)
    800016f4:	7a02                	ld	s4,32(sp)
    800016f6:	6ae2                	ld	s5,24(sp)
    800016f8:	6b42                	ld	s6,16(sp)
    800016fa:	6ba2                	ld	s7,8(sp)
    800016fc:	6c02                	ld	s8,0(sp)
    800016fe:	6161                	addi	sp,sp,80
    80001700:	8082                	ret
            release(&pp->lock);
    80001702:	8526                	mv	a0,s1
    80001704:	1e4040ef          	jal	800058e8 <release>
            release(&wait_lock);
    80001708:	00009517          	auipc	a0,0x9
    8000170c:	c5050513          	addi	a0,a0,-944 # 8000a358 <wait_lock>
    80001710:	1d8040ef          	jal	800058e8 <release>
            return -1;
    80001714:	59fd                	li	s3,-1
    80001716:	bfc9                	j	800016e8 <wait+0x78>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001718:	17048493          	addi	s1,s1,368
    8000171c:	03348063          	beq	s1,s3,8000173c <wait+0xcc>
      if(pp->parent == p){
    80001720:	7c9c                	ld	a5,56(s1)
    80001722:	ff279be3          	bne	a5,s2,80001718 <wait+0xa8>
        acquire(&pp->lock);
    80001726:	8526                	mv	a0,s1
    80001728:	128040ef          	jal	80005850 <acquire>
        if(pp->state == ZOMBIE){
    8000172c:	4c9c                	lw	a5,24(s1)
    8000172e:	f94783e3          	beq	a5,s4,800016b4 <wait+0x44>
        release(&pp->lock);
    80001732:	8526                	mv	a0,s1
    80001734:	1b4040ef          	jal	800058e8 <release>
        havekids = 1;
    80001738:	8756                	mv	a4,s5
    8000173a:	bff9                	j	80001718 <wait+0xa8>
    if(!havekids || killed(p)){
    8000173c:	cf19                	beqz	a4,8000175a <wait+0xea>
    8000173e:	854a                	mv	a0,s2
    80001740:	f07ff0ef          	jal	80001646 <killed>
    80001744:	e919                	bnez	a0,8000175a <wait+0xea>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001746:	85e2                	mv	a1,s8
    80001748:	854a                	mv	a0,s2
    8000174a:	cc5ff0ef          	jal	8000140e <sleep>
    havekids = 0;
    8000174e:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001750:	00009497          	auipc	s1,0x9
    80001754:	02048493          	addi	s1,s1,32 # 8000a770 <proc>
    80001758:	b7e1                	j	80001720 <wait+0xb0>
      release(&wait_lock);
    8000175a:	00009517          	auipc	a0,0x9
    8000175e:	bfe50513          	addi	a0,a0,-1026 # 8000a358 <wait_lock>
    80001762:	186040ef          	jal	800058e8 <release>
      return -1;
    80001766:	59fd                	li	s3,-1
    80001768:	b741                	j	800016e8 <wait+0x78>

000000008000176a <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000176a:	7179                	addi	sp,sp,-48
    8000176c:	f406                	sd	ra,40(sp)
    8000176e:	f022                	sd	s0,32(sp)
    80001770:	ec26                	sd	s1,24(sp)
    80001772:	e84a                	sd	s2,16(sp)
    80001774:	e44e                	sd	s3,8(sp)
    80001776:	e052                	sd	s4,0(sp)
    80001778:	1800                	addi	s0,sp,48
    8000177a:	84aa                	mv	s1,a0
    8000177c:	892e                	mv	s2,a1
    8000177e:	89b2                	mv	s3,a2
    80001780:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001782:	e1eff0ef          	jal	80000da0 <myproc>
  if(user_dst){
    80001786:	cc99                	beqz	s1,800017a4 <either_copyout+0x3a>
    return copyout(p->pagetable, dst, src, len);
    80001788:	86d2                	mv	a3,s4
    8000178a:	864e                	mv	a2,s3
    8000178c:	85ca                	mv	a1,s2
    8000178e:	6928                	ld	a0,80(a0)
    80001790:	a62ff0ef          	jal	800009f2 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001794:	70a2                	ld	ra,40(sp)
    80001796:	7402                	ld	s0,32(sp)
    80001798:	64e2                	ld	s1,24(sp)
    8000179a:	6942                	ld	s2,16(sp)
    8000179c:	69a2                	ld	s3,8(sp)
    8000179e:	6a02                	ld	s4,0(sp)
    800017a0:	6145                	addi	sp,sp,48
    800017a2:	8082                	ret
    memmove((char *)dst, src, len);
    800017a4:	000a061b          	sext.w	a2,s4
    800017a8:	85ce                	mv	a1,s3
    800017aa:	854a                	mv	a0,s2
    800017ac:	9fffe0ef          	jal	800001aa <memmove>
    return 0;
    800017b0:	8526                	mv	a0,s1
    800017b2:	b7cd                	j	80001794 <either_copyout+0x2a>

00000000800017b4 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800017b4:	7179                	addi	sp,sp,-48
    800017b6:	f406                	sd	ra,40(sp)
    800017b8:	f022                	sd	s0,32(sp)
    800017ba:	ec26                	sd	s1,24(sp)
    800017bc:	e84a                	sd	s2,16(sp)
    800017be:	e44e                	sd	s3,8(sp)
    800017c0:	e052                	sd	s4,0(sp)
    800017c2:	1800                	addi	s0,sp,48
    800017c4:	892a                	mv	s2,a0
    800017c6:	84ae                	mv	s1,a1
    800017c8:	89b2                	mv	s3,a2
    800017ca:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800017cc:	dd4ff0ef          	jal	80000da0 <myproc>
  if(user_src){
    800017d0:	cc99                	beqz	s1,800017ee <either_copyin+0x3a>
    return copyin(p->pagetable, dst, src, len);
    800017d2:	86d2                	mv	a3,s4
    800017d4:	864e                	mv	a2,s3
    800017d6:	85ca                	mv	a1,s2
    800017d8:	6928                	ld	a0,80(a0)
    800017da:	af0ff0ef          	jal	80000aca <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800017de:	70a2                	ld	ra,40(sp)
    800017e0:	7402                	ld	s0,32(sp)
    800017e2:	64e2                	ld	s1,24(sp)
    800017e4:	6942                	ld	s2,16(sp)
    800017e6:	69a2                	ld	s3,8(sp)
    800017e8:	6a02                	ld	s4,0(sp)
    800017ea:	6145                	addi	sp,sp,48
    800017ec:	8082                	ret
    memmove(dst, (char*)src, len);
    800017ee:	000a061b          	sext.w	a2,s4
    800017f2:	85ce                	mv	a1,s3
    800017f4:	854a                	mv	a0,s2
    800017f6:	9b5fe0ef          	jal	800001aa <memmove>
    return 0;
    800017fa:	8526                	mv	a0,s1
    800017fc:	b7cd                	j	800017de <either_copyin+0x2a>

00000000800017fe <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800017fe:	715d                	addi	sp,sp,-80
    80001800:	e486                	sd	ra,72(sp)
    80001802:	e0a2                	sd	s0,64(sp)
    80001804:	fc26                	sd	s1,56(sp)
    80001806:	f84a                	sd	s2,48(sp)
    80001808:	f44e                	sd	s3,40(sp)
    8000180a:	f052                	sd	s4,32(sp)
    8000180c:	ec56                	sd	s5,24(sp)
    8000180e:	e85a                	sd	s6,16(sp)
    80001810:	e45e                	sd	s7,8(sp)
    80001812:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001814:	00006517          	auipc	a0,0x6
    80001818:	80450513          	addi	a0,a0,-2044 # 80007018 <etext+0x18>
    8000181c:	235030ef          	jal	80005250 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001820:	00009497          	auipc	s1,0x9
    80001824:	0a848493          	addi	s1,s1,168 # 8000a8c8 <proc+0x158>
    80001828:	0000f917          	auipc	s2,0xf
    8000182c:	ca090913          	addi	s2,s2,-864 # 800104c8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001830:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001832:	00006997          	auipc	s3,0x6
    80001836:	a1e98993          	addi	s3,s3,-1506 # 80007250 <etext+0x250>
    printf("%d %s %s", p->pid, state, p->name);
    8000183a:	00006a97          	auipc	s5,0x6
    8000183e:	a1ea8a93          	addi	s5,s5,-1506 # 80007258 <etext+0x258>
    printf("\n");
    80001842:	00005a17          	auipc	s4,0x5
    80001846:	7d6a0a13          	addi	s4,s4,2006 # 80007018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000184a:	00006b97          	auipc	s7,0x6
    8000184e:	f36b8b93          	addi	s7,s7,-202 # 80007780 <states.0>
    80001852:	a829                	j	8000186c <procdump+0x6e>
    printf("%d %s %s", p->pid, state, p->name);
    80001854:	ed86a583          	lw	a1,-296(a3)
    80001858:	8556                	mv	a0,s5
    8000185a:	1f7030ef          	jal	80005250 <printf>
    printf("\n");
    8000185e:	8552                	mv	a0,s4
    80001860:	1f1030ef          	jal	80005250 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001864:	17048493          	addi	s1,s1,368
    80001868:	03248263          	beq	s1,s2,8000188c <procdump+0x8e>
    if(p->state == UNUSED)
    8000186c:	86a6                	mv	a3,s1
    8000186e:	ec04a783          	lw	a5,-320(s1)
    80001872:	dbed                	beqz	a5,80001864 <procdump+0x66>
      state = "???";
    80001874:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001876:	fcfb6fe3          	bltu	s6,a5,80001854 <procdump+0x56>
    8000187a:	02079713          	slli	a4,a5,0x20
    8000187e:	01d75793          	srli	a5,a4,0x1d
    80001882:	97de                	add	a5,a5,s7
    80001884:	6390                	ld	a2,0(a5)
    80001886:	f679                	bnez	a2,80001854 <procdump+0x56>
      state = "???";
    80001888:	864e                	mv	a2,s3
    8000188a:	b7e9                	j	80001854 <procdump+0x56>
  }
}
    8000188c:	60a6                	ld	ra,72(sp)
    8000188e:	6406                	ld	s0,64(sp)
    80001890:	74e2                	ld	s1,56(sp)
    80001892:	7942                	ld	s2,48(sp)
    80001894:	79a2                	ld	s3,40(sp)
    80001896:	7a02                	ld	s4,32(sp)
    80001898:	6ae2                	ld	s5,24(sp)
    8000189a:	6b42                	ld	s6,16(sp)
    8000189c:	6ba2                	ld	s7,8(sp)
    8000189e:	6161                	addi	sp,sp,80
    800018a0:	8082                	ret

00000000800018a2 <swtch>:
    800018a2:	00153023          	sd	ra,0(a0)
    800018a6:	00253423          	sd	sp,8(a0)
    800018aa:	e900                	sd	s0,16(a0)
    800018ac:	ed04                	sd	s1,24(a0)
    800018ae:	03253023          	sd	s2,32(a0)
    800018b2:	03353423          	sd	s3,40(a0)
    800018b6:	03453823          	sd	s4,48(a0)
    800018ba:	03553c23          	sd	s5,56(a0)
    800018be:	05653023          	sd	s6,64(a0)
    800018c2:	05753423          	sd	s7,72(a0)
    800018c6:	05853823          	sd	s8,80(a0)
    800018ca:	05953c23          	sd	s9,88(a0)
    800018ce:	07a53023          	sd	s10,96(a0)
    800018d2:	07b53423          	sd	s11,104(a0)
    800018d6:	0005b083          	ld	ra,0(a1)
    800018da:	0085b103          	ld	sp,8(a1)
    800018de:	6980                	ld	s0,16(a1)
    800018e0:	6d84                	ld	s1,24(a1)
    800018e2:	0205b903          	ld	s2,32(a1)
    800018e6:	0285b983          	ld	s3,40(a1)
    800018ea:	0305ba03          	ld	s4,48(a1)
    800018ee:	0385ba83          	ld	s5,56(a1)
    800018f2:	0405bb03          	ld	s6,64(a1)
    800018f6:	0485bb83          	ld	s7,72(a1)
    800018fa:	0505bc03          	ld	s8,80(a1)
    800018fe:	0585bc83          	ld	s9,88(a1)
    80001902:	0605bd03          	ld	s10,96(a1)
    80001906:	0685bd83          	ld	s11,104(a1)
    8000190a:	8082                	ret

000000008000190c <trapinit>:

extern int devintr();

void
trapinit(void)
{
    8000190c:	1141                	addi	sp,sp,-16
    8000190e:	e406                	sd	ra,8(sp)
    80001910:	e022                	sd	s0,0(sp)
    80001912:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001914:	00006597          	auipc	a1,0x6
    80001918:	98458593          	addi	a1,a1,-1660 # 80007298 <etext+0x298>
    8000191c:	0000f517          	auipc	a0,0xf
    80001920:	a5450513          	addi	a0,a0,-1452 # 80010370 <tickslock>
    80001924:	6ad030ef          	jal	800057d0 <initlock>
}
    80001928:	60a2                	ld	ra,8(sp)
    8000192a:	6402                	ld	s0,0(sp)
    8000192c:	0141                	addi	sp,sp,16
    8000192e:	8082                	ret

0000000080001930 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001930:	1141                	addi	sp,sp,-16
    80001932:	e422                	sd	s0,8(sp)
    80001934:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001936:	00003797          	auipc	a5,0x3
    8000193a:	e5a78793          	addi	a5,a5,-422 # 80004790 <kernelvec>
    8000193e:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001942:	6422                	ld	s0,8(sp)
    80001944:	0141                	addi	sp,sp,16
    80001946:	8082                	ret

0000000080001948 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001948:	1141                	addi	sp,sp,-16
    8000194a:	e406                	sd	ra,8(sp)
    8000194c:	e022                	sd	s0,0(sp)
    8000194e:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001950:	c50ff0ef          	jal	80000da0 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001954:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001958:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000195a:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    8000195e:	00004697          	auipc	a3,0x4
    80001962:	6a268693          	addi	a3,a3,1698 # 80006000 <_trampoline>
    80001966:	00004717          	auipc	a4,0x4
    8000196a:	69a70713          	addi	a4,a4,1690 # 80006000 <_trampoline>
    8000196e:	8f15                	sub	a4,a4,a3
    80001970:	040007b7          	lui	a5,0x4000
    80001974:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001976:	07b2                	slli	a5,a5,0xc
    80001978:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000197a:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8000197e:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001980:	18002673          	csrr	a2,satp
    80001984:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001986:	6d30                	ld	a2,88(a0)
    80001988:	6138                	ld	a4,64(a0)
    8000198a:	6585                	lui	a1,0x1
    8000198c:	972e                	add	a4,a4,a1
    8000198e:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001990:	6d38                	ld	a4,88(a0)
    80001992:	00000617          	auipc	a2,0x0
    80001996:	11060613          	addi	a2,a2,272 # 80001aa2 <usertrap>
    8000199a:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    8000199c:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    8000199e:	8612                	mv	a2,tp
    800019a0:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800019a2:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800019a6:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800019aa:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800019ae:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800019b2:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800019b4:	6f18                	ld	a4,24(a4)
    800019b6:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    800019ba:	6928                	ld	a0,80(a0)
    800019bc:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    800019be:	00004717          	auipc	a4,0x4
    800019c2:	6de70713          	addi	a4,a4,1758 # 8000609c <userret>
    800019c6:	8f15                	sub	a4,a4,a3
    800019c8:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    800019ca:	577d                	li	a4,-1
    800019cc:	177e                	slli	a4,a4,0x3f
    800019ce:	8d59                	or	a0,a0,a4
    800019d0:	9782                	jalr	a5
}
    800019d2:	60a2                	ld	ra,8(sp)
    800019d4:	6402                	ld	s0,0(sp)
    800019d6:	0141                	addi	sp,sp,16
    800019d8:	8082                	ret

00000000800019da <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800019da:	1101                	addi	sp,sp,-32
    800019dc:	ec06                	sd	ra,24(sp)
    800019de:	e822                	sd	s0,16(sp)
    800019e0:	1000                	addi	s0,sp,32
  if(cpuid() == 0){
    800019e2:	b92ff0ef          	jal	80000d74 <cpuid>
    800019e6:	cd11                	beqz	a0,80001a02 <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    800019e8:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    800019ec:	000f4737          	lui	a4,0xf4
    800019f0:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    800019f4:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    800019f6:	14d79073          	csrw	stimecmp,a5
}
    800019fa:	60e2                	ld	ra,24(sp)
    800019fc:	6442                	ld	s0,16(sp)
    800019fe:	6105                	addi	sp,sp,32
    80001a00:	8082                	ret
    80001a02:	e426                	sd	s1,8(sp)
    acquire(&tickslock);
    80001a04:	0000f497          	auipc	s1,0xf
    80001a08:	96c48493          	addi	s1,s1,-1684 # 80010370 <tickslock>
    80001a0c:	8526                	mv	a0,s1
    80001a0e:	643030ef          	jal	80005850 <acquire>
    ticks++;
    80001a12:	00009517          	auipc	a0,0x9
    80001a16:	8f650513          	addi	a0,a0,-1802 # 8000a308 <ticks>
    80001a1a:	411c                	lw	a5,0(a0)
    80001a1c:	2785                	addiw	a5,a5,1
    80001a1e:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    80001a20:	a3bff0ef          	jal	8000145a <wakeup>
    release(&tickslock);
    80001a24:	8526                	mv	a0,s1
    80001a26:	6c3030ef          	jal	800058e8 <release>
    80001a2a:	64a2                	ld	s1,8(sp)
    80001a2c:	bf75                	j	800019e8 <clockintr+0xe>

0000000080001a2e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001a2e:	1101                	addi	sp,sp,-32
    80001a30:	ec06                	sd	ra,24(sp)
    80001a32:	e822                	sd	s0,16(sp)
    80001a34:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a36:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    80001a3a:	57fd                	li	a5,-1
    80001a3c:	17fe                	slli	a5,a5,0x3f
    80001a3e:	07a5                	addi	a5,a5,9
    80001a40:	00f70c63          	beq	a4,a5,80001a58 <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80001a44:	57fd                	li	a5,-1
    80001a46:	17fe                	slli	a5,a5,0x3f
    80001a48:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    80001a4a:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    80001a4c:	04f70763          	beq	a4,a5,80001a9a <devintr+0x6c>
  }
}
    80001a50:	60e2                	ld	ra,24(sp)
    80001a52:	6442                	ld	s0,16(sp)
    80001a54:	6105                	addi	sp,sp,32
    80001a56:	8082                	ret
    80001a58:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001a5a:	5e3020ef          	jal	8000483c <plic_claim>
    80001a5e:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001a60:	47a9                	li	a5,10
    80001a62:	00f50963          	beq	a0,a5,80001a74 <devintr+0x46>
    } else if(irq == VIRTIO0_IRQ){
    80001a66:	4785                	li	a5,1
    80001a68:	00f50963          	beq	a0,a5,80001a7a <devintr+0x4c>
    return 1;
    80001a6c:	4505                	li	a0,1
    } else if(irq){
    80001a6e:	e889                	bnez	s1,80001a80 <devintr+0x52>
    80001a70:	64a2                	ld	s1,8(sp)
    80001a72:	bff9                	j	80001a50 <devintr+0x22>
      uartintr();
    80001a74:	521030ef          	jal	80005794 <uartintr>
    if(irq)
    80001a78:	a819                	j	80001a8e <devintr+0x60>
      virtio_disk_intr();
    80001a7a:	288030ef          	jal	80004d02 <virtio_disk_intr>
    if(irq)
    80001a7e:	a801                	j	80001a8e <devintr+0x60>
      printf("unexpected interrupt irq=%d\n", irq);
    80001a80:	85a6                	mv	a1,s1
    80001a82:	00006517          	auipc	a0,0x6
    80001a86:	81e50513          	addi	a0,a0,-2018 # 800072a0 <etext+0x2a0>
    80001a8a:	7c6030ef          	jal	80005250 <printf>
      plic_complete(irq);
    80001a8e:	8526                	mv	a0,s1
    80001a90:	5cd020ef          	jal	8000485c <plic_complete>
    return 1;
    80001a94:	4505                	li	a0,1
    80001a96:	64a2                	ld	s1,8(sp)
    80001a98:	bf65                	j	80001a50 <devintr+0x22>
    clockintr();
    80001a9a:	f41ff0ef          	jal	800019da <clockintr>
    return 2;
    80001a9e:	4509                	li	a0,2
    80001aa0:	bf45                	j	80001a50 <devintr+0x22>

0000000080001aa2 <usertrap>:
{
    80001aa2:	1101                	addi	sp,sp,-32
    80001aa4:	ec06                	sd	ra,24(sp)
    80001aa6:	e822                	sd	s0,16(sp)
    80001aa8:	e426                	sd	s1,8(sp)
    80001aaa:	e04a                	sd	s2,0(sp)
    80001aac:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001aae:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001ab2:	1007f793          	andi	a5,a5,256
    80001ab6:	ef85                	bnez	a5,80001aee <usertrap+0x4c>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001ab8:	00003797          	auipc	a5,0x3
    80001abc:	cd878793          	addi	a5,a5,-808 # 80004790 <kernelvec>
    80001ac0:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001ac4:	adcff0ef          	jal	80000da0 <myproc>
    80001ac8:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001aca:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001acc:	14102773          	csrr	a4,sepc
    80001ad0:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ad2:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001ad6:	47a1                	li	a5,8
    80001ad8:	02f70163          	beq	a4,a5,80001afa <usertrap+0x58>
  } else if((which_dev = devintr()) != 0){
    80001adc:	f53ff0ef          	jal	80001a2e <devintr>
    80001ae0:	892a                	mv	s2,a0
    80001ae2:	c135                	beqz	a0,80001b46 <usertrap+0xa4>
  if(killed(p))
    80001ae4:	8526                	mv	a0,s1
    80001ae6:	b61ff0ef          	jal	80001646 <killed>
    80001aea:	cd1d                	beqz	a0,80001b28 <usertrap+0x86>
    80001aec:	a81d                	j	80001b22 <usertrap+0x80>
    panic("usertrap: not from user mode");
    80001aee:	00005517          	auipc	a0,0x5
    80001af2:	7d250513          	addi	a0,a0,2002 # 800072c0 <etext+0x2c0>
    80001af6:	22d030ef          	jal	80005522 <panic>
    if(killed(p))
    80001afa:	b4dff0ef          	jal	80001646 <killed>
    80001afe:	e121                	bnez	a0,80001b3e <usertrap+0x9c>
    p->trapframe->epc += 4;
    80001b00:	6cb8                	ld	a4,88(s1)
    80001b02:	6f1c                	ld	a5,24(a4)
    80001b04:	0791                	addi	a5,a5,4
    80001b06:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b08:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001b0c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b10:	10079073          	csrw	sstatus,a5
    syscall();
    80001b14:	248000ef          	jal	80001d5c <syscall>
  if(killed(p))
    80001b18:	8526                	mv	a0,s1
    80001b1a:	b2dff0ef          	jal	80001646 <killed>
    80001b1e:	c901                	beqz	a0,80001b2e <usertrap+0x8c>
    80001b20:	4901                	li	s2,0
    exit(-1);
    80001b22:	557d                	li	a0,-1
    80001b24:	9f7ff0ef          	jal	8000151a <exit>
  if(which_dev == 2)
    80001b28:	4789                	li	a5,2
    80001b2a:	04f90563          	beq	s2,a5,80001b74 <usertrap+0xd2>
  usertrapret();
    80001b2e:	e1bff0ef          	jal	80001948 <usertrapret>
}
    80001b32:	60e2                	ld	ra,24(sp)
    80001b34:	6442                	ld	s0,16(sp)
    80001b36:	64a2                	ld	s1,8(sp)
    80001b38:	6902                	ld	s2,0(sp)
    80001b3a:	6105                	addi	sp,sp,32
    80001b3c:	8082                	ret
      exit(-1);
    80001b3e:	557d                	li	a0,-1
    80001b40:	9dbff0ef          	jal	8000151a <exit>
    80001b44:	bf75                	j	80001b00 <usertrap+0x5e>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001b46:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80001b4a:	5890                	lw	a2,48(s1)
    80001b4c:	00005517          	auipc	a0,0x5
    80001b50:	79450513          	addi	a0,a0,1940 # 800072e0 <etext+0x2e0>
    80001b54:	6fc030ef          	jal	80005250 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b58:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001b5c:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80001b60:	00005517          	auipc	a0,0x5
    80001b64:	7b050513          	addi	a0,a0,1968 # 80007310 <etext+0x310>
    80001b68:	6e8030ef          	jal	80005250 <printf>
    setkilled(p);
    80001b6c:	8526                	mv	a0,s1
    80001b6e:	ab5ff0ef          	jal	80001622 <setkilled>
    80001b72:	b75d                	j	80001b18 <usertrap+0x76>
    yield();
    80001b74:	86fff0ef          	jal	800013e2 <yield>
    80001b78:	bf5d                	j	80001b2e <usertrap+0x8c>

0000000080001b7a <kerneltrap>:
{
    80001b7a:	7179                	addi	sp,sp,-48
    80001b7c:	f406                	sd	ra,40(sp)
    80001b7e:	f022                	sd	s0,32(sp)
    80001b80:	ec26                	sd	s1,24(sp)
    80001b82:	e84a                	sd	s2,16(sp)
    80001b84:	e44e                	sd	s3,8(sp)
    80001b86:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b88:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b8c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001b90:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001b94:	1004f793          	andi	a5,s1,256
    80001b98:	c795                	beqz	a5,80001bc4 <kerneltrap+0x4a>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b9a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001b9e:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001ba0:	eb85                	bnez	a5,80001bd0 <kerneltrap+0x56>
  if((which_dev = devintr()) == 0){
    80001ba2:	e8dff0ef          	jal	80001a2e <devintr>
    80001ba6:	c91d                	beqz	a0,80001bdc <kerneltrap+0x62>
  if(which_dev == 2 && myproc() != 0)
    80001ba8:	4789                	li	a5,2
    80001baa:	04f50a63          	beq	a0,a5,80001bfe <kerneltrap+0x84>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001bae:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001bb2:	10049073          	csrw	sstatus,s1
}
    80001bb6:	70a2                	ld	ra,40(sp)
    80001bb8:	7402                	ld	s0,32(sp)
    80001bba:	64e2                	ld	s1,24(sp)
    80001bbc:	6942                	ld	s2,16(sp)
    80001bbe:	69a2                	ld	s3,8(sp)
    80001bc0:	6145                	addi	sp,sp,48
    80001bc2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001bc4:	00005517          	auipc	a0,0x5
    80001bc8:	77450513          	addi	a0,a0,1908 # 80007338 <etext+0x338>
    80001bcc:	157030ef          	jal	80005522 <panic>
    panic("kerneltrap: interrupts enabled");
    80001bd0:	00005517          	auipc	a0,0x5
    80001bd4:	79050513          	addi	a0,a0,1936 # 80007360 <etext+0x360>
    80001bd8:	14b030ef          	jal	80005522 <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001bdc:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001be0:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80001be4:	85ce                	mv	a1,s3
    80001be6:	00005517          	auipc	a0,0x5
    80001bea:	79a50513          	addi	a0,a0,1946 # 80007380 <etext+0x380>
    80001bee:	662030ef          	jal	80005250 <printf>
    panic("kerneltrap");
    80001bf2:	00005517          	auipc	a0,0x5
    80001bf6:	7b650513          	addi	a0,a0,1974 # 800073a8 <etext+0x3a8>
    80001bfa:	129030ef          	jal	80005522 <panic>
  if(which_dev == 2 && myproc() != 0)
    80001bfe:	9a2ff0ef          	jal	80000da0 <myproc>
    80001c02:	d555                	beqz	a0,80001bae <kerneltrap+0x34>
    yield();
    80001c04:	fdeff0ef          	jal	800013e2 <yield>
    80001c08:	b75d                	j	80001bae <kerneltrap+0x34>

0000000080001c0a <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001c0a:	1101                	addi	sp,sp,-32
    80001c0c:	ec06                	sd	ra,24(sp)
    80001c0e:	e822                	sd	s0,16(sp)
    80001c10:	e426                	sd	s1,8(sp)
    80001c12:	1000                	addi	s0,sp,32
    80001c14:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001c16:	98aff0ef          	jal	80000da0 <myproc>
  switch (n) {
    80001c1a:	4795                	li	a5,5
    80001c1c:	0497e163          	bltu	a5,s1,80001c5e <argraw+0x54>
    80001c20:	048a                	slli	s1,s1,0x2
    80001c22:	00006717          	auipc	a4,0x6
    80001c26:	b8e70713          	addi	a4,a4,-1138 # 800077b0 <states.0+0x30>
    80001c2a:	94ba                	add	s1,s1,a4
    80001c2c:	409c                	lw	a5,0(s1)
    80001c2e:	97ba                	add	a5,a5,a4
    80001c30:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001c32:	6d3c                	ld	a5,88(a0)
    80001c34:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001c36:	60e2                	ld	ra,24(sp)
    80001c38:	6442                	ld	s0,16(sp)
    80001c3a:	64a2                	ld	s1,8(sp)
    80001c3c:	6105                	addi	sp,sp,32
    80001c3e:	8082                	ret
    return p->trapframe->a1;
    80001c40:	6d3c                	ld	a5,88(a0)
    80001c42:	7fa8                	ld	a0,120(a5)
    80001c44:	bfcd                	j	80001c36 <argraw+0x2c>
    return p->trapframe->a2;
    80001c46:	6d3c                	ld	a5,88(a0)
    80001c48:	63c8                	ld	a0,128(a5)
    80001c4a:	b7f5                	j	80001c36 <argraw+0x2c>
    return p->trapframe->a3;
    80001c4c:	6d3c                	ld	a5,88(a0)
    80001c4e:	67c8                	ld	a0,136(a5)
    80001c50:	b7dd                	j	80001c36 <argraw+0x2c>
    return p->trapframe->a4;
    80001c52:	6d3c                	ld	a5,88(a0)
    80001c54:	6bc8                	ld	a0,144(a5)
    80001c56:	b7c5                	j	80001c36 <argraw+0x2c>
    return p->trapframe->a5;
    80001c58:	6d3c                	ld	a5,88(a0)
    80001c5a:	6fc8                	ld	a0,152(a5)
    80001c5c:	bfe9                	j	80001c36 <argraw+0x2c>
  panic("argraw");
    80001c5e:	00005517          	auipc	a0,0x5
    80001c62:	75a50513          	addi	a0,a0,1882 # 800073b8 <etext+0x3b8>
    80001c66:	0bd030ef          	jal	80005522 <panic>

0000000080001c6a <fetchaddr>:
{
    80001c6a:	1101                	addi	sp,sp,-32
    80001c6c:	ec06                	sd	ra,24(sp)
    80001c6e:	e822                	sd	s0,16(sp)
    80001c70:	e426                	sd	s1,8(sp)
    80001c72:	e04a                	sd	s2,0(sp)
    80001c74:	1000                	addi	s0,sp,32
    80001c76:	84aa                	mv	s1,a0
    80001c78:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001c7a:	926ff0ef          	jal	80000da0 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001c7e:	653c                	ld	a5,72(a0)
    80001c80:	02f4f663          	bgeu	s1,a5,80001cac <fetchaddr+0x42>
    80001c84:	00848713          	addi	a4,s1,8
    80001c88:	02e7e463          	bltu	a5,a4,80001cb0 <fetchaddr+0x46>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001c8c:	46a1                	li	a3,8
    80001c8e:	8626                	mv	a2,s1
    80001c90:	85ca                	mv	a1,s2
    80001c92:	6928                	ld	a0,80(a0)
    80001c94:	e37fe0ef          	jal	80000aca <copyin>
    80001c98:	00a03533          	snez	a0,a0
    80001c9c:	40a00533          	neg	a0,a0
}
    80001ca0:	60e2                	ld	ra,24(sp)
    80001ca2:	6442                	ld	s0,16(sp)
    80001ca4:	64a2                	ld	s1,8(sp)
    80001ca6:	6902                	ld	s2,0(sp)
    80001ca8:	6105                	addi	sp,sp,32
    80001caa:	8082                	ret
    return -1;
    80001cac:	557d                	li	a0,-1
    80001cae:	bfcd                	j	80001ca0 <fetchaddr+0x36>
    80001cb0:	557d                	li	a0,-1
    80001cb2:	b7fd                	j	80001ca0 <fetchaddr+0x36>

0000000080001cb4 <fetchstr>:
{
    80001cb4:	7179                	addi	sp,sp,-48
    80001cb6:	f406                	sd	ra,40(sp)
    80001cb8:	f022                	sd	s0,32(sp)
    80001cba:	ec26                	sd	s1,24(sp)
    80001cbc:	e84a                	sd	s2,16(sp)
    80001cbe:	e44e                	sd	s3,8(sp)
    80001cc0:	1800                	addi	s0,sp,48
    80001cc2:	892a                	mv	s2,a0
    80001cc4:	84ae                	mv	s1,a1
    80001cc6:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001cc8:	8d8ff0ef          	jal	80000da0 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001ccc:	86ce                	mv	a3,s3
    80001cce:	864a                	mv	a2,s2
    80001cd0:	85a6                	mv	a1,s1
    80001cd2:	6928                	ld	a0,80(a0)
    80001cd4:	e7dfe0ef          	jal	80000b50 <copyinstr>
    80001cd8:	00054c63          	bltz	a0,80001cf0 <fetchstr+0x3c>
  return strlen(buf);
    80001cdc:	8526                	mv	a0,s1
    80001cde:	de0fe0ef          	jal	800002be <strlen>
}
    80001ce2:	70a2                	ld	ra,40(sp)
    80001ce4:	7402                	ld	s0,32(sp)
    80001ce6:	64e2                	ld	s1,24(sp)
    80001ce8:	6942                	ld	s2,16(sp)
    80001cea:	69a2                	ld	s3,8(sp)
    80001cec:	6145                	addi	sp,sp,48
    80001cee:	8082                	ret
    return -1;
    80001cf0:	557d                	li	a0,-1
    80001cf2:	bfc5                	j	80001ce2 <fetchstr+0x2e>

0000000080001cf4 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001cf4:	1101                	addi	sp,sp,-32
    80001cf6:	ec06                	sd	ra,24(sp)
    80001cf8:	e822                	sd	s0,16(sp)
    80001cfa:	e426                	sd	s1,8(sp)
    80001cfc:	1000                	addi	s0,sp,32
    80001cfe:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001d00:	f0bff0ef          	jal	80001c0a <argraw>
    80001d04:	c088                	sw	a0,0(s1)
}
    80001d06:	60e2                	ld	ra,24(sp)
    80001d08:	6442                	ld	s0,16(sp)
    80001d0a:	64a2                	ld	s1,8(sp)
    80001d0c:	6105                	addi	sp,sp,32
    80001d0e:	8082                	ret

0000000080001d10 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001d10:	1101                	addi	sp,sp,-32
    80001d12:	ec06                	sd	ra,24(sp)
    80001d14:	e822                	sd	s0,16(sp)
    80001d16:	e426                	sd	s1,8(sp)
    80001d18:	1000                	addi	s0,sp,32
    80001d1a:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001d1c:	eefff0ef          	jal	80001c0a <argraw>
    80001d20:	e088                	sd	a0,0(s1)
}
    80001d22:	60e2                	ld	ra,24(sp)
    80001d24:	6442                	ld	s0,16(sp)
    80001d26:	64a2                	ld	s1,8(sp)
    80001d28:	6105                	addi	sp,sp,32
    80001d2a:	8082                	ret

0000000080001d2c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001d2c:	7179                	addi	sp,sp,-48
    80001d2e:	f406                	sd	ra,40(sp)
    80001d30:	f022                	sd	s0,32(sp)
    80001d32:	ec26                	sd	s1,24(sp)
    80001d34:	e84a                	sd	s2,16(sp)
    80001d36:	1800                	addi	s0,sp,48
    80001d38:	84ae                	mv	s1,a1
    80001d3a:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80001d3c:	fd840593          	addi	a1,s0,-40
    80001d40:	fd1ff0ef          	jal	80001d10 <argaddr>
  return fetchstr(addr, buf, max);
    80001d44:	864a                	mv	a2,s2
    80001d46:	85a6                	mv	a1,s1
    80001d48:	fd843503          	ld	a0,-40(s0)
    80001d4c:	f69ff0ef          	jal	80001cb4 <fetchstr>
}
    80001d50:	70a2                	ld	ra,40(sp)
    80001d52:	7402                	ld	s0,32(sp)
    80001d54:	64e2                	ld	s1,24(sp)
    80001d56:	6942                	ld	s2,16(sp)
    80001d58:	6145                	addi	sp,sp,48
    80001d5a:	8082                	ret

0000000080001d5c <syscall>:



void
syscall(void)
{
    80001d5c:	1101                	addi	sp,sp,-32
    80001d5e:	ec06                	sd	ra,24(sp)
    80001d60:	e822                	sd	s0,16(sp)
    80001d62:	e426                	sd	s1,8(sp)
    80001d64:	e04a                	sd	s2,0(sp)
    80001d66:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001d68:	838ff0ef          	jal	80000da0 <myproc>
    80001d6c:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001d6e:	05853903          	ld	s2,88(a0)
    80001d72:	0a893783          	ld	a5,168(s2)
    80001d76:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001d7a:	37fd                	addiw	a5,a5,-1
    80001d7c:	02100713          	li	a4,33
    80001d80:	00f76f63          	bltu	a4,a5,80001d9e <syscall+0x42>
    80001d84:	00369713          	slli	a4,a3,0x3
    80001d88:	00006797          	auipc	a5,0x6
    80001d8c:	a4078793          	addi	a5,a5,-1472 # 800077c8 <syscalls>
    80001d90:	97ba                	add	a5,a5,a4
    80001d92:	639c                	ld	a5,0(a5)
    80001d94:	c789                	beqz	a5,80001d9e <syscall+0x42>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80001d96:	9782                	jalr	a5
    80001d98:	06a93823          	sd	a0,112(s2)
    80001d9c:	a829                	j	80001db6 <syscall+0x5a>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001d9e:	15848613          	addi	a2,s1,344
    80001da2:	588c                	lw	a1,48(s1)
    80001da4:	00005517          	auipc	a0,0x5
    80001da8:	61c50513          	addi	a0,a0,1564 # 800073c0 <etext+0x3c0>
    80001dac:	4a4030ef          	jal	80005250 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001db0:	6cbc                	ld	a5,88(s1)
    80001db2:	577d                	li	a4,-1
    80001db4:	fbb8                	sd	a4,112(a5)
  }
}
    80001db6:	60e2                	ld	ra,24(sp)
    80001db8:	6442                	ld	s0,16(sp)
    80001dba:	64a2                	ld	s1,8(sp)
    80001dbc:	6902                	ld	s2,0(sp)
    80001dbe:	6105                	addi	sp,sp,32
    80001dc0:	8082                	ret

0000000080001dc2 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80001dc2:	1101                	addi	sp,sp,-32
    80001dc4:	ec06                	sd	ra,24(sp)
    80001dc6:	e822                	sd	s0,16(sp)
    80001dc8:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001dca:	fec40593          	addi	a1,s0,-20
    80001dce:	4501                	li	a0,0
    80001dd0:	f25ff0ef          	jal	80001cf4 <argint>
  exit(n);
    80001dd4:	fec42503          	lw	a0,-20(s0)
    80001dd8:	f42ff0ef          	jal	8000151a <exit>
  return 0;  // not reached
}
    80001ddc:	4501                	li	a0,0
    80001dde:	60e2                	ld	ra,24(sp)
    80001de0:	6442                	ld	s0,16(sp)
    80001de2:	6105                	addi	sp,sp,32
    80001de4:	8082                	ret

0000000080001de6 <sys_getpid>:

uint64
sys_getpid(void)
{
    80001de6:	1141                	addi	sp,sp,-16
    80001de8:	e406                	sd	ra,8(sp)
    80001dea:	e022                	sd	s0,0(sp)
    80001dec:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80001dee:	fb3fe0ef          	jal	80000da0 <myproc>
}
    80001df2:	5908                	lw	a0,48(a0)
    80001df4:	60a2                	ld	ra,8(sp)
    80001df6:	6402                	ld	s0,0(sp)
    80001df8:	0141                	addi	sp,sp,16
    80001dfa:	8082                	ret

0000000080001dfc <sys_fork>:

uint64
sys_fork(void)
{
    80001dfc:	1141                	addi	sp,sp,-16
    80001dfe:	e406                	sd	ra,8(sp)
    80001e00:	e022                	sd	s0,0(sp)
    80001e02:	0800                	addi	s0,sp,16
  return fork();
    80001e04:	b62ff0ef          	jal	80001166 <fork>
}
    80001e08:	60a2                	ld	ra,8(sp)
    80001e0a:	6402                	ld	s0,0(sp)
    80001e0c:	0141                	addi	sp,sp,16
    80001e0e:	8082                	ret

0000000080001e10 <sys_wait>:

uint64
sys_wait(void)
{
    80001e10:	1101                	addi	sp,sp,-32
    80001e12:	ec06                	sd	ra,24(sp)
    80001e14:	e822                	sd	s0,16(sp)
    80001e16:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80001e18:	fe840593          	addi	a1,s0,-24
    80001e1c:	4501                	li	a0,0
    80001e1e:	ef3ff0ef          	jal	80001d10 <argaddr>
  return wait(p);
    80001e22:	fe843503          	ld	a0,-24(s0)
    80001e26:	84bff0ef          	jal	80001670 <wait>
}
    80001e2a:	60e2                	ld	ra,24(sp)
    80001e2c:	6442                	ld	s0,16(sp)
    80001e2e:	6105                	addi	sp,sp,32
    80001e30:	8082                	ret

0000000080001e32 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80001e32:	7179                	addi	sp,sp,-48
    80001e34:	f406                	sd	ra,40(sp)
    80001e36:	f022                	sd	s0,32(sp)
    80001e38:	ec26                	sd	s1,24(sp)
    80001e3a:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80001e3c:	fdc40593          	addi	a1,s0,-36
    80001e40:	4501                	li	a0,0
    80001e42:	eb3ff0ef          	jal	80001cf4 <argint>
  addr = myproc()->sz;
    80001e46:	f5bfe0ef          	jal	80000da0 <myproc>
    80001e4a:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    80001e4c:	fdc42503          	lw	a0,-36(s0)
    80001e50:	ac6ff0ef          	jal	80001116 <growproc>
    80001e54:	00054863          	bltz	a0,80001e64 <sys_sbrk+0x32>
    return -1;
  return addr;
}
    80001e58:	8526                	mv	a0,s1
    80001e5a:	70a2                	ld	ra,40(sp)
    80001e5c:	7402                	ld	s0,32(sp)
    80001e5e:	64e2                	ld	s1,24(sp)
    80001e60:	6145                	addi	sp,sp,48
    80001e62:	8082                	ret
    return -1;
    80001e64:	54fd                	li	s1,-1
    80001e66:	bfcd                	j	80001e58 <sys_sbrk+0x26>

0000000080001e68 <sys_sleep>:

uint64
sys_sleep(void)
{
    80001e68:	7139                	addi	sp,sp,-64
    80001e6a:	fc06                	sd	ra,56(sp)
    80001e6c:	f822                	sd	s0,48(sp)
    80001e6e:	f04a                	sd	s2,32(sp)
    80001e70:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  argint(0, &n);
    80001e72:	fcc40593          	addi	a1,s0,-52
    80001e76:	4501                	li	a0,0
    80001e78:	e7dff0ef          	jal	80001cf4 <argint>
  if(n < 0)
    80001e7c:	fcc42783          	lw	a5,-52(s0)
    80001e80:	0607c763          	bltz	a5,80001eee <sys_sleep+0x86>
    n = 0;
  acquire(&tickslock);
    80001e84:	0000e517          	auipc	a0,0xe
    80001e88:	4ec50513          	addi	a0,a0,1260 # 80010370 <tickslock>
    80001e8c:	1c5030ef          	jal	80005850 <acquire>
  ticks0 = ticks;
    80001e90:	00008917          	auipc	s2,0x8
    80001e94:	47892903          	lw	s2,1144(s2) # 8000a308 <ticks>
  while(ticks - ticks0 < n){
    80001e98:	fcc42783          	lw	a5,-52(s0)
    80001e9c:	cf8d                	beqz	a5,80001ed6 <sys_sleep+0x6e>
    80001e9e:	f426                	sd	s1,40(sp)
    80001ea0:	ec4e                	sd	s3,24(sp)
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80001ea2:	0000e997          	auipc	s3,0xe
    80001ea6:	4ce98993          	addi	s3,s3,1230 # 80010370 <tickslock>
    80001eaa:	00008497          	auipc	s1,0x8
    80001eae:	45e48493          	addi	s1,s1,1118 # 8000a308 <ticks>
    if(killed(myproc())){
    80001eb2:	eeffe0ef          	jal	80000da0 <myproc>
    80001eb6:	f90ff0ef          	jal	80001646 <killed>
    80001eba:	ed0d                	bnez	a0,80001ef4 <sys_sleep+0x8c>
    sleep(&ticks, &tickslock);
    80001ebc:	85ce                	mv	a1,s3
    80001ebe:	8526                	mv	a0,s1
    80001ec0:	d4eff0ef          	jal	8000140e <sleep>
  while(ticks - ticks0 < n){
    80001ec4:	409c                	lw	a5,0(s1)
    80001ec6:	412787bb          	subw	a5,a5,s2
    80001eca:	fcc42703          	lw	a4,-52(s0)
    80001ece:	fee7e2e3          	bltu	a5,a4,80001eb2 <sys_sleep+0x4a>
    80001ed2:	74a2                	ld	s1,40(sp)
    80001ed4:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80001ed6:	0000e517          	auipc	a0,0xe
    80001eda:	49a50513          	addi	a0,a0,1178 # 80010370 <tickslock>
    80001ede:	20b030ef          	jal	800058e8 <release>
  return 0;
    80001ee2:	4501                	li	a0,0
}
    80001ee4:	70e2                	ld	ra,56(sp)
    80001ee6:	7442                	ld	s0,48(sp)
    80001ee8:	7902                	ld	s2,32(sp)
    80001eea:	6121                	addi	sp,sp,64
    80001eec:	8082                	ret
    n = 0;
    80001eee:	fc042623          	sw	zero,-52(s0)
    80001ef2:	bf49                	j	80001e84 <sys_sleep+0x1c>
      release(&tickslock);
    80001ef4:	0000e517          	auipc	a0,0xe
    80001ef8:	47c50513          	addi	a0,a0,1148 # 80010370 <tickslock>
    80001efc:	1ed030ef          	jal	800058e8 <release>
      return -1;
    80001f00:	557d                	li	a0,-1
    80001f02:	74a2                	ld	s1,40(sp)
    80001f04:	69e2                	ld	s3,24(sp)
    80001f06:	bff9                	j	80001ee4 <sys_sleep+0x7c>

0000000080001f08 <sys_pgpte>:


#ifdef LAB_PGTBL
int
sys_pgpte(void)
{
    80001f08:	7179                	addi	sp,sp,-48
    80001f0a:	f406                	sd	ra,40(sp)
    80001f0c:	f022                	sd	s0,32(sp)
    80001f0e:	ec26                	sd	s1,24(sp)
    80001f10:	1800                	addi	s0,sp,48
  uint64 va;
  struct proc *p;  

  p = myproc();
    80001f12:	e8ffe0ef          	jal	80000da0 <myproc>
    80001f16:	84aa                	mv	s1,a0
  argaddr(0, &va);
    80001f18:	fd840593          	addi	a1,s0,-40
    80001f1c:	4501                	li	a0,0
    80001f1e:	df3ff0ef          	jal	80001d10 <argaddr>
  pte_t *pte = pgpte(p->pagetable, va);
    80001f22:	fd843583          	ld	a1,-40(s0)
    80001f26:	68a8                	ld	a0,80(s1)
    80001f28:	cedfe0ef          	jal	80000c14 <pgpte>
    80001f2c:	87aa                	mv	a5,a0
  if(pte != 0) {
      return (uint64) *pte;
  }
  return 0;
    80001f2e:	4501                	li	a0,0
  if(pte != 0) {
    80001f30:	c391                	beqz	a5,80001f34 <sys_pgpte+0x2c>
      return (uint64) *pte;
    80001f32:	4388                	lw	a0,0(a5)
}
    80001f34:	70a2                	ld	ra,40(sp)
    80001f36:	7402                	ld	s0,32(sp)
    80001f38:	64e2                	ld	s1,24(sp)
    80001f3a:	6145                	addi	sp,sp,48
    80001f3c:	8082                	ret

0000000080001f3e <sys_kpgtbl>:
#endif

#ifdef LAB_PGTBL
int
sys_kpgtbl(void)
{
    80001f3e:	1141                	addi	sp,sp,-16
    80001f40:	e406                	sd	ra,8(sp)
    80001f42:	e022                	sd	s0,0(sp)
    80001f44:	0800                	addi	s0,sp,16
  struct proc *p;  

  p = myproc();
    80001f46:	e5bfe0ef          	jal	80000da0 <myproc>
  vmprint(p->pagetable);
    80001f4a:	6928                	ld	a0,80(a0)
    80001f4c:	cbdfe0ef          	jal	80000c08 <vmprint>
  return 0;
}
    80001f50:	4501                	li	a0,0
    80001f52:	60a2                	ld	ra,8(sp)
    80001f54:	6402                	ld	s0,0(sp)
    80001f56:	0141                	addi	sp,sp,16
    80001f58:	8082                	ret

0000000080001f5a <sys_kill>:
#endif


uint64
sys_kill(void)
{
    80001f5a:	1101                	addi	sp,sp,-32
    80001f5c:	ec06                	sd	ra,24(sp)
    80001f5e:	e822                	sd	s0,16(sp)
    80001f60:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80001f62:	fec40593          	addi	a1,s0,-20
    80001f66:	4501                	li	a0,0
    80001f68:	d8dff0ef          	jal	80001cf4 <argint>
  return kill(pid);
    80001f6c:	fec42503          	lw	a0,-20(s0)
    80001f70:	e4cff0ef          	jal	800015bc <kill>
}
    80001f74:	60e2                	ld	ra,24(sp)
    80001f76:	6442                	ld	s0,16(sp)
    80001f78:	6105                	addi	sp,sp,32
    80001f7a:	8082                	ret

0000000080001f7c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80001f7c:	1101                	addi	sp,sp,-32
    80001f7e:	ec06                	sd	ra,24(sp)
    80001f80:	e822                	sd	s0,16(sp)
    80001f82:	e426                	sd	s1,8(sp)
    80001f84:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80001f86:	0000e517          	auipc	a0,0xe
    80001f8a:	3ea50513          	addi	a0,a0,1002 # 80010370 <tickslock>
    80001f8e:	0c3030ef          	jal	80005850 <acquire>
  xticks = ticks;
    80001f92:	00008497          	auipc	s1,0x8
    80001f96:	3764a483          	lw	s1,886(s1) # 8000a308 <ticks>
  release(&tickslock);
    80001f9a:	0000e517          	auipc	a0,0xe
    80001f9e:	3d650513          	addi	a0,a0,982 # 80010370 <tickslock>
    80001fa2:	147030ef          	jal	800058e8 <release>
  return xticks;
}
    80001fa6:	02049513          	slli	a0,s1,0x20
    80001faa:	9101                	srli	a0,a0,0x20
    80001fac:	60e2                	ld	ra,24(sp)
    80001fae:	6442                	ld	s0,16(sp)
    80001fb0:	64a2                	ld	s1,8(sp)
    80001fb2:	6105                	addi	sp,sp,32
    80001fb4:	8082                	ret

0000000080001fb6 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80001fb6:	7179                	addi	sp,sp,-48
    80001fb8:	f406                	sd	ra,40(sp)
    80001fba:	f022                	sd	s0,32(sp)
    80001fbc:	ec26                	sd	s1,24(sp)
    80001fbe:	e84a                	sd	s2,16(sp)
    80001fc0:	e44e                	sd	s3,8(sp)
    80001fc2:	e052                	sd	s4,0(sp)
    80001fc4:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80001fc6:	00005597          	auipc	a1,0x5
    80001fca:	41a58593          	addi	a1,a1,1050 # 800073e0 <etext+0x3e0>
    80001fce:	0000e517          	auipc	a0,0xe
    80001fd2:	3ba50513          	addi	a0,a0,954 # 80010388 <bcache>
    80001fd6:	7fa030ef          	jal	800057d0 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80001fda:	00016797          	auipc	a5,0x16
    80001fde:	3ae78793          	addi	a5,a5,942 # 80018388 <bcache+0x8000>
    80001fe2:	00016717          	auipc	a4,0x16
    80001fe6:	60e70713          	addi	a4,a4,1550 # 800185f0 <bcache+0x8268>
    80001fea:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80001fee:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001ff2:	0000e497          	auipc	s1,0xe
    80001ff6:	3ae48493          	addi	s1,s1,942 # 800103a0 <bcache+0x18>
    b->next = bcache.head.next;
    80001ffa:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80001ffc:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80001ffe:	00005a17          	auipc	s4,0x5
    80002002:	3eaa0a13          	addi	s4,s4,1002 # 800073e8 <etext+0x3e8>
    b->next = bcache.head.next;
    80002006:	2b893783          	ld	a5,696(s2)
    8000200a:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8000200c:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002010:	85d2                	mv	a1,s4
    80002012:	01048513          	addi	a0,s1,16
    80002016:	248010ef          	jal	8000325e <initsleeplock>
    bcache.head.next->prev = b;
    8000201a:	2b893783          	ld	a5,696(s2)
    8000201e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002020:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002024:	45848493          	addi	s1,s1,1112
    80002028:	fd349fe3          	bne	s1,s3,80002006 <binit+0x50>
  }
}
    8000202c:	70a2                	ld	ra,40(sp)
    8000202e:	7402                	ld	s0,32(sp)
    80002030:	64e2                	ld	s1,24(sp)
    80002032:	6942                	ld	s2,16(sp)
    80002034:	69a2                	ld	s3,8(sp)
    80002036:	6a02                	ld	s4,0(sp)
    80002038:	6145                	addi	sp,sp,48
    8000203a:	8082                	ret

000000008000203c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000203c:	7179                	addi	sp,sp,-48
    8000203e:	f406                	sd	ra,40(sp)
    80002040:	f022                	sd	s0,32(sp)
    80002042:	ec26                	sd	s1,24(sp)
    80002044:	e84a                	sd	s2,16(sp)
    80002046:	e44e                	sd	s3,8(sp)
    80002048:	1800                	addi	s0,sp,48
    8000204a:	892a                	mv	s2,a0
    8000204c:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    8000204e:	0000e517          	auipc	a0,0xe
    80002052:	33a50513          	addi	a0,a0,826 # 80010388 <bcache>
    80002056:	7fa030ef          	jal	80005850 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000205a:	00016497          	auipc	s1,0x16
    8000205e:	5e64b483          	ld	s1,1510(s1) # 80018640 <bcache+0x82b8>
    80002062:	00016797          	auipc	a5,0x16
    80002066:	58e78793          	addi	a5,a5,1422 # 800185f0 <bcache+0x8268>
    8000206a:	02f48b63          	beq	s1,a5,800020a0 <bread+0x64>
    8000206e:	873e                	mv	a4,a5
    80002070:	a021                	j	80002078 <bread+0x3c>
    80002072:	68a4                	ld	s1,80(s1)
    80002074:	02e48663          	beq	s1,a4,800020a0 <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    80002078:	449c                	lw	a5,8(s1)
    8000207a:	ff279ce3          	bne	a5,s2,80002072 <bread+0x36>
    8000207e:	44dc                	lw	a5,12(s1)
    80002080:	ff3799e3          	bne	a5,s3,80002072 <bread+0x36>
      b->refcnt++;
    80002084:	40bc                	lw	a5,64(s1)
    80002086:	2785                	addiw	a5,a5,1
    80002088:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000208a:	0000e517          	auipc	a0,0xe
    8000208e:	2fe50513          	addi	a0,a0,766 # 80010388 <bcache>
    80002092:	057030ef          	jal	800058e8 <release>
      acquiresleep(&b->lock);
    80002096:	01048513          	addi	a0,s1,16
    8000209a:	1fa010ef          	jal	80003294 <acquiresleep>
      return b;
    8000209e:	a889                	j	800020f0 <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800020a0:	00016497          	auipc	s1,0x16
    800020a4:	5984b483          	ld	s1,1432(s1) # 80018638 <bcache+0x82b0>
    800020a8:	00016797          	auipc	a5,0x16
    800020ac:	54878793          	addi	a5,a5,1352 # 800185f0 <bcache+0x8268>
    800020b0:	00f48863          	beq	s1,a5,800020c0 <bread+0x84>
    800020b4:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800020b6:	40bc                	lw	a5,64(s1)
    800020b8:	cb91                	beqz	a5,800020cc <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800020ba:	64a4                	ld	s1,72(s1)
    800020bc:	fee49de3          	bne	s1,a4,800020b6 <bread+0x7a>
  panic("bget: no buffers");
    800020c0:	00005517          	auipc	a0,0x5
    800020c4:	33050513          	addi	a0,a0,816 # 800073f0 <etext+0x3f0>
    800020c8:	45a030ef          	jal	80005522 <panic>
      b->dev = dev;
    800020cc:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800020d0:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800020d4:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800020d8:	4785                	li	a5,1
    800020da:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800020dc:	0000e517          	auipc	a0,0xe
    800020e0:	2ac50513          	addi	a0,a0,684 # 80010388 <bcache>
    800020e4:	005030ef          	jal	800058e8 <release>
      acquiresleep(&b->lock);
    800020e8:	01048513          	addi	a0,s1,16
    800020ec:	1a8010ef          	jal	80003294 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800020f0:	409c                	lw	a5,0(s1)
    800020f2:	cb89                	beqz	a5,80002104 <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800020f4:	8526                	mv	a0,s1
    800020f6:	70a2                	ld	ra,40(sp)
    800020f8:	7402                	ld	s0,32(sp)
    800020fa:	64e2                	ld	s1,24(sp)
    800020fc:	6942                	ld	s2,16(sp)
    800020fe:	69a2                	ld	s3,8(sp)
    80002100:	6145                	addi	sp,sp,48
    80002102:	8082                	ret
    virtio_disk_rw(b, 0);
    80002104:	4581                	li	a1,0
    80002106:	8526                	mv	a0,s1
    80002108:	1e9020ef          	jal	80004af0 <virtio_disk_rw>
    b->valid = 1;
    8000210c:	4785                	li	a5,1
    8000210e:	c09c                	sw	a5,0(s1)
  return b;
    80002110:	b7d5                	j	800020f4 <bread+0xb8>

0000000080002112 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002112:	1101                	addi	sp,sp,-32
    80002114:	ec06                	sd	ra,24(sp)
    80002116:	e822                	sd	s0,16(sp)
    80002118:	e426                	sd	s1,8(sp)
    8000211a:	1000                	addi	s0,sp,32
    8000211c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000211e:	0541                	addi	a0,a0,16
    80002120:	1f2010ef          	jal	80003312 <holdingsleep>
    80002124:	c911                	beqz	a0,80002138 <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002126:	4585                	li	a1,1
    80002128:	8526                	mv	a0,s1
    8000212a:	1c7020ef          	jal	80004af0 <virtio_disk_rw>
}
    8000212e:	60e2                	ld	ra,24(sp)
    80002130:	6442                	ld	s0,16(sp)
    80002132:	64a2                	ld	s1,8(sp)
    80002134:	6105                	addi	sp,sp,32
    80002136:	8082                	ret
    panic("bwrite");
    80002138:	00005517          	auipc	a0,0x5
    8000213c:	2d050513          	addi	a0,a0,720 # 80007408 <etext+0x408>
    80002140:	3e2030ef          	jal	80005522 <panic>

0000000080002144 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002144:	1101                	addi	sp,sp,-32
    80002146:	ec06                	sd	ra,24(sp)
    80002148:	e822                	sd	s0,16(sp)
    8000214a:	e426                	sd	s1,8(sp)
    8000214c:	e04a                	sd	s2,0(sp)
    8000214e:	1000                	addi	s0,sp,32
    80002150:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002152:	01050913          	addi	s2,a0,16
    80002156:	854a                	mv	a0,s2
    80002158:	1ba010ef          	jal	80003312 <holdingsleep>
    8000215c:	c135                	beqz	a0,800021c0 <brelse+0x7c>
    panic("brelse");

  releasesleep(&b->lock);
    8000215e:	854a                	mv	a0,s2
    80002160:	17a010ef          	jal	800032da <releasesleep>

  acquire(&bcache.lock);
    80002164:	0000e517          	auipc	a0,0xe
    80002168:	22450513          	addi	a0,a0,548 # 80010388 <bcache>
    8000216c:	6e4030ef          	jal	80005850 <acquire>
  b->refcnt--;
    80002170:	40bc                	lw	a5,64(s1)
    80002172:	37fd                	addiw	a5,a5,-1
    80002174:	0007871b          	sext.w	a4,a5
    80002178:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000217a:	e71d                	bnez	a4,800021a8 <brelse+0x64>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000217c:	68b8                	ld	a4,80(s1)
    8000217e:	64bc                	ld	a5,72(s1)
    80002180:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002182:	68b8                	ld	a4,80(s1)
    80002184:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002186:	00016797          	auipc	a5,0x16
    8000218a:	20278793          	addi	a5,a5,514 # 80018388 <bcache+0x8000>
    8000218e:	2b87b703          	ld	a4,696(a5)
    80002192:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002194:	00016717          	auipc	a4,0x16
    80002198:	45c70713          	addi	a4,a4,1116 # 800185f0 <bcache+0x8268>
    8000219c:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000219e:	2b87b703          	ld	a4,696(a5)
    800021a2:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800021a4:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800021a8:	0000e517          	auipc	a0,0xe
    800021ac:	1e050513          	addi	a0,a0,480 # 80010388 <bcache>
    800021b0:	738030ef          	jal	800058e8 <release>
}
    800021b4:	60e2                	ld	ra,24(sp)
    800021b6:	6442                	ld	s0,16(sp)
    800021b8:	64a2                	ld	s1,8(sp)
    800021ba:	6902                	ld	s2,0(sp)
    800021bc:	6105                	addi	sp,sp,32
    800021be:	8082                	ret
    panic("brelse");
    800021c0:	00005517          	auipc	a0,0x5
    800021c4:	25050513          	addi	a0,a0,592 # 80007410 <etext+0x410>
    800021c8:	35a030ef          	jal	80005522 <panic>

00000000800021cc <bpin>:

void
bpin(struct buf *b) {
    800021cc:	1101                	addi	sp,sp,-32
    800021ce:	ec06                	sd	ra,24(sp)
    800021d0:	e822                	sd	s0,16(sp)
    800021d2:	e426                	sd	s1,8(sp)
    800021d4:	1000                	addi	s0,sp,32
    800021d6:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800021d8:	0000e517          	auipc	a0,0xe
    800021dc:	1b050513          	addi	a0,a0,432 # 80010388 <bcache>
    800021e0:	670030ef          	jal	80005850 <acquire>
  b->refcnt++;
    800021e4:	40bc                	lw	a5,64(s1)
    800021e6:	2785                	addiw	a5,a5,1
    800021e8:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800021ea:	0000e517          	auipc	a0,0xe
    800021ee:	19e50513          	addi	a0,a0,414 # 80010388 <bcache>
    800021f2:	6f6030ef          	jal	800058e8 <release>
}
    800021f6:	60e2                	ld	ra,24(sp)
    800021f8:	6442                	ld	s0,16(sp)
    800021fa:	64a2                	ld	s1,8(sp)
    800021fc:	6105                	addi	sp,sp,32
    800021fe:	8082                	ret

0000000080002200 <bunpin>:

void
bunpin(struct buf *b) {
    80002200:	1101                	addi	sp,sp,-32
    80002202:	ec06                	sd	ra,24(sp)
    80002204:	e822                	sd	s0,16(sp)
    80002206:	e426                	sd	s1,8(sp)
    80002208:	1000                	addi	s0,sp,32
    8000220a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000220c:	0000e517          	auipc	a0,0xe
    80002210:	17c50513          	addi	a0,a0,380 # 80010388 <bcache>
    80002214:	63c030ef          	jal	80005850 <acquire>
  b->refcnt--;
    80002218:	40bc                	lw	a5,64(s1)
    8000221a:	37fd                	addiw	a5,a5,-1
    8000221c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000221e:	0000e517          	auipc	a0,0xe
    80002222:	16a50513          	addi	a0,a0,362 # 80010388 <bcache>
    80002226:	6c2030ef          	jal	800058e8 <release>
}
    8000222a:	60e2                	ld	ra,24(sp)
    8000222c:	6442                	ld	s0,16(sp)
    8000222e:	64a2                	ld	s1,8(sp)
    80002230:	6105                	addi	sp,sp,32
    80002232:	8082                	ret

0000000080002234 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002234:	1101                	addi	sp,sp,-32
    80002236:	ec06                	sd	ra,24(sp)
    80002238:	e822                	sd	s0,16(sp)
    8000223a:	e426                	sd	s1,8(sp)
    8000223c:	e04a                	sd	s2,0(sp)
    8000223e:	1000                	addi	s0,sp,32
    80002240:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002242:	00d5d59b          	srliw	a1,a1,0xd
    80002246:	00017797          	auipc	a5,0x17
    8000224a:	81e7a783          	lw	a5,-2018(a5) # 80018a64 <sb+0x1c>
    8000224e:	9dbd                	addw	a1,a1,a5
    80002250:	dedff0ef          	jal	8000203c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002254:	0074f713          	andi	a4,s1,7
    80002258:	4785                	li	a5,1
    8000225a:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000225e:	14ce                	slli	s1,s1,0x33
    80002260:	90d9                	srli	s1,s1,0x36
    80002262:	00950733          	add	a4,a0,s1
    80002266:	05874703          	lbu	a4,88(a4)
    8000226a:	00e7f6b3          	and	a3,a5,a4
    8000226e:	c29d                	beqz	a3,80002294 <bfree+0x60>
    80002270:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002272:	94aa                	add	s1,s1,a0
    80002274:	fff7c793          	not	a5,a5
    80002278:	8f7d                	and	a4,a4,a5
    8000227a:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    8000227e:	711000ef          	jal	8000318e <log_write>
  brelse(bp);
    80002282:	854a                	mv	a0,s2
    80002284:	ec1ff0ef          	jal	80002144 <brelse>
}
    80002288:	60e2                	ld	ra,24(sp)
    8000228a:	6442                	ld	s0,16(sp)
    8000228c:	64a2                	ld	s1,8(sp)
    8000228e:	6902                	ld	s2,0(sp)
    80002290:	6105                	addi	sp,sp,32
    80002292:	8082                	ret
    panic("freeing free block");
    80002294:	00005517          	auipc	a0,0x5
    80002298:	18450513          	addi	a0,a0,388 # 80007418 <etext+0x418>
    8000229c:	286030ef          	jal	80005522 <panic>

00000000800022a0 <balloc>:
{
    800022a0:	711d                	addi	sp,sp,-96
    800022a2:	ec86                	sd	ra,88(sp)
    800022a4:	e8a2                	sd	s0,80(sp)
    800022a6:	e4a6                	sd	s1,72(sp)
    800022a8:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    800022aa:	00016797          	auipc	a5,0x16
    800022ae:	7a27a783          	lw	a5,1954(a5) # 80018a4c <sb+0x4>
    800022b2:	0e078f63          	beqz	a5,800023b0 <balloc+0x110>
    800022b6:	e0ca                	sd	s2,64(sp)
    800022b8:	fc4e                	sd	s3,56(sp)
    800022ba:	f852                	sd	s4,48(sp)
    800022bc:	f456                	sd	s5,40(sp)
    800022be:	f05a                	sd	s6,32(sp)
    800022c0:	ec5e                	sd	s7,24(sp)
    800022c2:	e862                	sd	s8,16(sp)
    800022c4:	e466                	sd	s9,8(sp)
    800022c6:	8baa                	mv	s7,a0
    800022c8:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800022ca:	00016b17          	auipc	s6,0x16
    800022ce:	77eb0b13          	addi	s6,s6,1918 # 80018a48 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022d2:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    800022d4:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022d6:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800022d8:	6c89                	lui	s9,0x2
    800022da:	a0b5                	j	80002346 <balloc+0xa6>
        bp->data[bi/8] |= m;  // Mark block in use.
    800022dc:	97ca                	add	a5,a5,s2
    800022de:	8e55                	or	a2,a2,a3
    800022e0:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    800022e4:	854a                	mv	a0,s2
    800022e6:	6a9000ef          	jal	8000318e <log_write>
        brelse(bp);
    800022ea:	854a                	mv	a0,s2
    800022ec:	e59ff0ef          	jal	80002144 <brelse>
  bp = bread(dev, bno);
    800022f0:	85a6                	mv	a1,s1
    800022f2:	855e                	mv	a0,s7
    800022f4:	d49ff0ef          	jal	8000203c <bread>
    800022f8:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800022fa:	40000613          	li	a2,1024
    800022fe:	4581                	li	a1,0
    80002300:	05850513          	addi	a0,a0,88
    80002304:	e4bfd0ef          	jal	8000014e <memset>
  log_write(bp);
    80002308:	854a                	mv	a0,s2
    8000230a:	685000ef          	jal	8000318e <log_write>
  brelse(bp);
    8000230e:	854a                	mv	a0,s2
    80002310:	e35ff0ef          	jal	80002144 <brelse>
}
    80002314:	6906                	ld	s2,64(sp)
    80002316:	79e2                	ld	s3,56(sp)
    80002318:	7a42                	ld	s4,48(sp)
    8000231a:	7aa2                	ld	s5,40(sp)
    8000231c:	7b02                	ld	s6,32(sp)
    8000231e:	6be2                	ld	s7,24(sp)
    80002320:	6c42                	ld	s8,16(sp)
    80002322:	6ca2                	ld	s9,8(sp)
}
    80002324:	8526                	mv	a0,s1
    80002326:	60e6                	ld	ra,88(sp)
    80002328:	6446                	ld	s0,80(sp)
    8000232a:	64a6                	ld	s1,72(sp)
    8000232c:	6125                	addi	sp,sp,96
    8000232e:	8082                	ret
    brelse(bp);
    80002330:	854a                	mv	a0,s2
    80002332:	e13ff0ef          	jal	80002144 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002336:	015c87bb          	addw	a5,s9,s5
    8000233a:	00078a9b          	sext.w	s5,a5
    8000233e:	004b2703          	lw	a4,4(s6)
    80002342:	04eaff63          	bgeu	s5,a4,800023a0 <balloc+0x100>
    bp = bread(dev, BBLOCK(b, sb));
    80002346:	41fad79b          	sraiw	a5,s5,0x1f
    8000234a:	0137d79b          	srliw	a5,a5,0x13
    8000234e:	015787bb          	addw	a5,a5,s5
    80002352:	40d7d79b          	sraiw	a5,a5,0xd
    80002356:	01cb2583          	lw	a1,28(s6)
    8000235a:	9dbd                	addw	a1,a1,a5
    8000235c:	855e                	mv	a0,s7
    8000235e:	cdfff0ef          	jal	8000203c <bread>
    80002362:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002364:	004b2503          	lw	a0,4(s6)
    80002368:	000a849b          	sext.w	s1,s5
    8000236c:	8762                	mv	a4,s8
    8000236e:	fca4f1e3          	bgeu	s1,a0,80002330 <balloc+0x90>
      m = 1 << (bi % 8);
    80002372:	00777693          	andi	a3,a4,7
    80002376:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000237a:	41f7579b          	sraiw	a5,a4,0x1f
    8000237e:	01d7d79b          	srliw	a5,a5,0x1d
    80002382:	9fb9                	addw	a5,a5,a4
    80002384:	4037d79b          	sraiw	a5,a5,0x3
    80002388:	00f90633          	add	a2,s2,a5
    8000238c:	05864603          	lbu	a2,88(a2)
    80002390:	00c6f5b3          	and	a1,a3,a2
    80002394:	d5a1                	beqz	a1,800022dc <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002396:	2705                	addiw	a4,a4,1
    80002398:	2485                	addiw	s1,s1,1
    8000239a:	fd471ae3          	bne	a4,s4,8000236e <balloc+0xce>
    8000239e:	bf49                	j	80002330 <balloc+0x90>
    800023a0:	6906                	ld	s2,64(sp)
    800023a2:	79e2                	ld	s3,56(sp)
    800023a4:	7a42                	ld	s4,48(sp)
    800023a6:	7aa2                	ld	s5,40(sp)
    800023a8:	7b02                	ld	s6,32(sp)
    800023aa:	6be2                	ld	s7,24(sp)
    800023ac:	6c42                	ld	s8,16(sp)
    800023ae:	6ca2                	ld	s9,8(sp)
  printf("balloc: out of blocks\n");
    800023b0:	00005517          	auipc	a0,0x5
    800023b4:	08050513          	addi	a0,a0,128 # 80007430 <etext+0x430>
    800023b8:	699020ef          	jal	80005250 <printf>
  return 0;
    800023bc:	4481                	li	s1,0
    800023be:	b79d                	j	80002324 <balloc+0x84>

00000000800023c0 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800023c0:	7179                	addi	sp,sp,-48
    800023c2:	f406                	sd	ra,40(sp)
    800023c4:	f022                	sd	s0,32(sp)
    800023c6:	ec26                	sd	s1,24(sp)
    800023c8:	e84a                	sd	s2,16(sp)
    800023ca:	e44e                	sd	s3,8(sp)
    800023cc:	1800                	addi	s0,sp,48
    800023ce:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800023d0:	47ad                	li	a5,11
    800023d2:	02b7e663          	bltu	a5,a1,800023fe <bmap+0x3e>
    if((addr = ip->addrs[bn]) == 0){
    800023d6:	02059793          	slli	a5,a1,0x20
    800023da:	01e7d593          	srli	a1,a5,0x1e
    800023de:	00b504b3          	add	s1,a0,a1
    800023e2:	0504a903          	lw	s2,80(s1)
    800023e6:	06091a63          	bnez	s2,8000245a <bmap+0x9a>
      addr = balloc(ip->dev);
    800023ea:	4108                	lw	a0,0(a0)
    800023ec:	eb5ff0ef          	jal	800022a0 <balloc>
    800023f0:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800023f4:	06090363          	beqz	s2,8000245a <bmap+0x9a>
        return 0;
      ip->addrs[bn] = addr;
    800023f8:	0524a823          	sw	s2,80(s1)
    800023fc:	a8b9                	j	8000245a <bmap+0x9a>
    }
    return addr;
  }
  bn -= NDIRECT;
    800023fe:	ff45849b          	addiw	s1,a1,-12
    80002402:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80002406:	0ff00793          	li	a5,255
    8000240a:	06e7ee63          	bltu	a5,a4,80002486 <bmap+0xc6>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    8000240e:	08052903          	lw	s2,128(a0)
    80002412:	00091d63          	bnez	s2,8000242c <bmap+0x6c>
      addr = balloc(ip->dev);
    80002416:	4108                	lw	a0,0(a0)
    80002418:	e89ff0ef          	jal	800022a0 <balloc>
    8000241c:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002420:	02090d63          	beqz	s2,8000245a <bmap+0x9a>
    80002424:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002426:	0929a023          	sw	s2,128(s3)
    8000242a:	a011                	j	8000242e <bmap+0x6e>
    8000242c:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    8000242e:	85ca                	mv	a1,s2
    80002430:	0009a503          	lw	a0,0(s3)
    80002434:	c09ff0ef          	jal	8000203c <bread>
    80002438:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    8000243a:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    8000243e:	02049713          	slli	a4,s1,0x20
    80002442:	01e75593          	srli	a1,a4,0x1e
    80002446:	00b784b3          	add	s1,a5,a1
    8000244a:	0004a903          	lw	s2,0(s1)
    8000244e:	00090e63          	beqz	s2,8000246a <bmap+0xaa>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002452:	8552                	mv	a0,s4
    80002454:	cf1ff0ef          	jal	80002144 <brelse>
    return addr;
    80002458:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    8000245a:	854a                	mv	a0,s2
    8000245c:	70a2                	ld	ra,40(sp)
    8000245e:	7402                	ld	s0,32(sp)
    80002460:	64e2                	ld	s1,24(sp)
    80002462:	6942                	ld	s2,16(sp)
    80002464:	69a2                	ld	s3,8(sp)
    80002466:	6145                	addi	sp,sp,48
    80002468:	8082                	ret
      addr = balloc(ip->dev);
    8000246a:	0009a503          	lw	a0,0(s3)
    8000246e:	e33ff0ef          	jal	800022a0 <balloc>
    80002472:	0005091b          	sext.w	s2,a0
      if(addr){
    80002476:	fc090ee3          	beqz	s2,80002452 <bmap+0x92>
        a[bn] = addr;
    8000247a:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    8000247e:	8552                	mv	a0,s4
    80002480:	50f000ef          	jal	8000318e <log_write>
    80002484:	b7f9                	j	80002452 <bmap+0x92>
    80002486:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    80002488:	00005517          	auipc	a0,0x5
    8000248c:	fc050513          	addi	a0,a0,-64 # 80007448 <etext+0x448>
    80002490:	092030ef          	jal	80005522 <panic>

0000000080002494 <iget>:
{
    80002494:	7179                	addi	sp,sp,-48
    80002496:	f406                	sd	ra,40(sp)
    80002498:	f022                	sd	s0,32(sp)
    8000249a:	ec26                	sd	s1,24(sp)
    8000249c:	e84a                	sd	s2,16(sp)
    8000249e:	e44e                	sd	s3,8(sp)
    800024a0:	e052                	sd	s4,0(sp)
    800024a2:	1800                	addi	s0,sp,48
    800024a4:	89aa                	mv	s3,a0
    800024a6:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800024a8:	00016517          	auipc	a0,0x16
    800024ac:	5c050513          	addi	a0,a0,1472 # 80018a68 <itable>
    800024b0:	3a0030ef          	jal	80005850 <acquire>
  empty = 0;
    800024b4:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800024b6:	00016497          	auipc	s1,0x16
    800024ba:	5ca48493          	addi	s1,s1,1482 # 80018a80 <itable+0x18>
    800024be:	00018697          	auipc	a3,0x18
    800024c2:	05268693          	addi	a3,a3,82 # 8001a510 <log>
    800024c6:	a039                	j	800024d4 <iget+0x40>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800024c8:	02090963          	beqz	s2,800024fa <iget+0x66>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800024cc:	08848493          	addi	s1,s1,136
    800024d0:	02d48863          	beq	s1,a3,80002500 <iget+0x6c>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800024d4:	449c                	lw	a5,8(s1)
    800024d6:	fef059e3          	blez	a5,800024c8 <iget+0x34>
    800024da:	4098                	lw	a4,0(s1)
    800024dc:	ff3716e3          	bne	a4,s3,800024c8 <iget+0x34>
    800024e0:	40d8                	lw	a4,4(s1)
    800024e2:	ff4713e3          	bne	a4,s4,800024c8 <iget+0x34>
      ip->ref++;
    800024e6:	2785                	addiw	a5,a5,1
    800024e8:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800024ea:	00016517          	auipc	a0,0x16
    800024ee:	57e50513          	addi	a0,a0,1406 # 80018a68 <itable>
    800024f2:	3f6030ef          	jal	800058e8 <release>
      return ip;
    800024f6:	8926                	mv	s2,s1
    800024f8:	a02d                	j	80002522 <iget+0x8e>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800024fa:	fbe9                	bnez	a5,800024cc <iget+0x38>
      empty = ip;
    800024fc:	8926                	mv	s2,s1
    800024fe:	b7f9                	j	800024cc <iget+0x38>
  if(empty == 0)
    80002500:	02090a63          	beqz	s2,80002534 <iget+0xa0>
  ip->dev = dev;
    80002504:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002508:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000250c:	4785                	li	a5,1
    8000250e:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002512:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002516:	00016517          	auipc	a0,0x16
    8000251a:	55250513          	addi	a0,a0,1362 # 80018a68 <itable>
    8000251e:	3ca030ef          	jal	800058e8 <release>
}
    80002522:	854a                	mv	a0,s2
    80002524:	70a2                	ld	ra,40(sp)
    80002526:	7402                	ld	s0,32(sp)
    80002528:	64e2                	ld	s1,24(sp)
    8000252a:	6942                	ld	s2,16(sp)
    8000252c:	69a2                	ld	s3,8(sp)
    8000252e:	6a02                	ld	s4,0(sp)
    80002530:	6145                	addi	sp,sp,48
    80002532:	8082                	ret
    panic("iget: no inodes");
    80002534:	00005517          	auipc	a0,0x5
    80002538:	f2c50513          	addi	a0,a0,-212 # 80007460 <etext+0x460>
    8000253c:	7e7020ef          	jal	80005522 <panic>

0000000080002540 <fsinit>:
fsinit(int dev) {
    80002540:	7179                	addi	sp,sp,-48
    80002542:	f406                	sd	ra,40(sp)
    80002544:	f022                	sd	s0,32(sp)
    80002546:	ec26                	sd	s1,24(sp)
    80002548:	e84a                	sd	s2,16(sp)
    8000254a:	e44e                	sd	s3,8(sp)
    8000254c:	1800                	addi	s0,sp,48
    8000254e:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002550:	4585                	li	a1,1
    80002552:	aebff0ef          	jal	8000203c <bread>
    80002556:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002558:	00016997          	auipc	s3,0x16
    8000255c:	4f098993          	addi	s3,s3,1264 # 80018a48 <sb>
    80002560:	02000613          	li	a2,32
    80002564:	05850593          	addi	a1,a0,88
    80002568:	854e                	mv	a0,s3
    8000256a:	c41fd0ef          	jal	800001aa <memmove>
  brelse(bp);
    8000256e:	8526                	mv	a0,s1
    80002570:	bd5ff0ef          	jal	80002144 <brelse>
  if(sb.magic != FSMAGIC)
    80002574:	0009a703          	lw	a4,0(s3)
    80002578:	102037b7          	lui	a5,0x10203
    8000257c:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002580:	02f71063          	bne	a4,a5,800025a0 <fsinit+0x60>
  initlog(dev, &sb);
    80002584:	00016597          	auipc	a1,0x16
    80002588:	4c458593          	addi	a1,a1,1220 # 80018a48 <sb>
    8000258c:	854a                	mv	a0,s2
    8000258e:	1f9000ef          	jal	80002f86 <initlog>
}
    80002592:	70a2                	ld	ra,40(sp)
    80002594:	7402                	ld	s0,32(sp)
    80002596:	64e2                	ld	s1,24(sp)
    80002598:	6942                	ld	s2,16(sp)
    8000259a:	69a2                	ld	s3,8(sp)
    8000259c:	6145                	addi	sp,sp,48
    8000259e:	8082                	ret
    panic("invalid file system");
    800025a0:	00005517          	auipc	a0,0x5
    800025a4:	ed050513          	addi	a0,a0,-304 # 80007470 <etext+0x470>
    800025a8:	77b020ef          	jal	80005522 <panic>

00000000800025ac <iinit>:
{
    800025ac:	7179                	addi	sp,sp,-48
    800025ae:	f406                	sd	ra,40(sp)
    800025b0:	f022                	sd	s0,32(sp)
    800025b2:	ec26                	sd	s1,24(sp)
    800025b4:	e84a                	sd	s2,16(sp)
    800025b6:	e44e                	sd	s3,8(sp)
    800025b8:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800025ba:	00005597          	auipc	a1,0x5
    800025be:	ece58593          	addi	a1,a1,-306 # 80007488 <etext+0x488>
    800025c2:	00016517          	auipc	a0,0x16
    800025c6:	4a650513          	addi	a0,a0,1190 # 80018a68 <itable>
    800025ca:	206030ef          	jal	800057d0 <initlock>
  for(i = 0; i < NINODE; i++) {
    800025ce:	00016497          	auipc	s1,0x16
    800025d2:	4c248493          	addi	s1,s1,1218 # 80018a90 <itable+0x28>
    800025d6:	00018997          	auipc	s3,0x18
    800025da:	f4a98993          	addi	s3,s3,-182 # 8001a520 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800025de:	00005917          	auipc	s2,0x5
    800025e2:	eb290913          	addi	s2,s2,-334 # 80007490 <etext+0x490>
    800025e6:	85ca                	mv	a1,s2
    800025e8:	8526                	mv	a0,s1
    800025ea:	475000ef          	jal	8000325e <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800025ee:	08848493          	addi	s1,s1,136
    800025f2:	ff349ae3          	bne	s1,s3,800025e6 <iinit+0x3a>
}
    800025f6:	70a2                	ld	ra,40(sp)
    800025f8:	7402                	ld	s0,32(sp)
    800025fa:	64e2                	ld	s1,24(sp)
    800025fc:	6942                	ld	s2,16(sp)
    800025fe:	69a2                	ld	s3,8(sp)
    80002600:	6145                	addi	sp,sp,48
    80002602:	8082                	ret

0000000080002604 <ialloc>:
{
    80002604:	7139                	addi	sp,sp,-64
    80002606:	fc06                	sd	ra,56(sp)
    80002608:	f822                	sd	s0,48(sp)
    8000260a:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    8000260c:	00016717          	auipc	a4,0x16
    80002610:	44872703          	lw	a4,1096(a4) # 80018a54 <sb+0xc>
    80002614:	4785                	li	a5,1
    80002616:	06e7f063          	bgeu	a5,a4,80002676 <ialloc+0x72>
    8000261a:	f426                	sd	s1,40(sp)
    8000261c:	f04a                	sd	s2,32(sp)
    8000261e:	ec4e                	sd	s3,24(sp)
    80002620:	e852                	sd	s4,16(sp)
    80002622:	e456                	sd	s5,8(sp)
    80002624:	e05a                	sd	s6,0(sp)
    80002626:	8aaa                	mv	s5,a0
    80002628:	8b2e                	mv	s6,a1
    8000262a:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    8000262c:	00016a17          	auipc	s4,0x16
    80002630:	41ca0a13          	addi	s4,s4,1052 # 80018a48 <sb>
    80002634:	00495593          	srli	a1,s2,0x4
    80002638:	018a2783          	lw	a5,24(s4)
    8000263c:	9dbd                	addw	a1,a1,a5
    8000263e:	8556                	mv	a0,s5
    80002640:	9fdff0ef          	jal	8000203c <bread>
    80002644:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002646:	05850993          	addi	s3,a0,88
    8000264a:	00f97793          	andi	a5,s2,15
    8000264e:	079a                	slli	a5,a5,0x6
    80002650:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002652:	00099783          	lh	a5,0(s3)
    80002656:	cb9d                	beqz	a5,8000268c <ialloc+0x88>
    brelse(bp);
    80002658:	aedff0ef          	jal	80002144 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000265c:	0905                	addi	s2,s2,1
    8000265e:	00ca2703          	lw	a4,12(s4)
    80002662:	0009079b          	sext.w	a5,s2
    80002666:	fce7e7e3          	bltu	a5,a4,80002634 <ialloc+0x30>
    8000266a:	74a2                	ld	s1,40(sp)
    8000266c:	7902                	ld	s2,32(sp)
    8000266e:	69e2                	ld	s3,24(sp)
    80002670:	6a42                	ld	s4,16(sp)
    80002672:	6aa2                	ld	s5,8(sp)
    80002674:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    80002676:	00005517          	auipc	a0,0x5
    8000267a:	e2250513          	addi	a0,a0,-478 # 80007498 <etext+0x498>
    8000267e:	3d3020ef          	jal	80005250 <printf>
  return 0;
    80002682:	4501                	li	a0,0
}
    80002684:	70e2                	ld	ra,56(sp)
    80002686:	7442                	ld	s0,48(sp)
    80002688:	6121                	addi	sp,sp,64
    8000268a:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    8000268c:	04000613          	li	a2,64
    80002690:	4581                	li	a1,0
    80002692:	854e                	mv	a0,s3
    80002694:	abbfd0ef          	jal	8000014e <memset>
      dip->type = type;
    80002698:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    8000269c:	8526                	mv	a0,s1
    8000269e:	2f1000ef          	jal	8000318e <log_write>
      brelse(bp);
    800026a2:	8526                	mv	a0,s1
    800026a4:	aa1ff0ef          	jal	80002144 <brelse>
      return iget(dev, inum);
    800026a8:	0009059b          	sext.w	a1,s2
    800026ac:	8556                	mv	a0,s5
    800026ae:	de7ff0ef          	jal	80002494 <iget>
    800026b2:	74a2                	ld	s1,40(sp)
    800026b4:	7902                	ld	s2,32(sp)
    800026b6:	69e2                	ld	s3,24(sp)
    800026b8:	6a42                	ld	s4,16(sp)
    800026ba:	6aa2                	ld	s5,8(sp)
    800026bc:	6b02                	ld	s6,0(sp)
    800026be:	b7d9                	j	80002684 <ialloc+0x80>

00000000800026c0 <iupdate>:
{
    800026c0:	1101                	addi	sp,sp,-32
    800026c2:	ec06                	sd	ra,24(sp)
    800026c4:	e822                	sd	s0,16(sp)
    800026c6:	e426                	sd	s1,8(sp)
    800026c8:	e04a                	sd	s2,0(sp)
    800026ca:	1000                	addi	s0,sp,32
    800026cc:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800026ce:	415c                	lw	a5,4(a0)
    800026d0:	0047d79b          	srliw	a5,a5,0x4
    800026d4:	00016597          	auipc	a1,0x16
    800026d8:	38c5a583          	lw	a1,908(a1) # 80018a60 <sb+0x18>
    800026dc:	9dbd                	addw	a1,a1,a5
    800026de:	4108                	lw	a0,0(a0)
    800026e0:	95dff0ef          	jal	8000203c <bread>
    800026e4:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800026e6:	05850793          	addi	a5,a0,88
    800026ea:	40d8                	lw	a4,4(s1)
    800026ec:	8b3d                	andi	a4,a4,15
    800026ee:	071a                	slli	a4,a4,0x6
    800026f0:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    800026f2:	04449703          	lh	a4,68(s1)
    800026f6:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    800026fa:	04649703          	lh	a4,70(s1)
    800026fe:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002702:	04849703          	lh	a4,72(s1)
    80002706:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    8000270a:	04a49703          	lh	a4,74(s1)
    8000270e:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002712:	44f8                	lw	a4,76(s1)
    80002714:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002716:	03400613          	li	a2,52
    8000271a:	05048593          	addi	a1,s1,80
    8000271e:	00c78513          	addi	a0,a5,12
    80002722:	a89fd0ef          	jal	800001aa <memmove>
  log_write(bp);
    80002726:	854a                	mv	a0,s2
    80002728:	267000ef          	jal	8000318e <log_write>
  brelse(bp);
    8000272c:	854a                	mv	a0,s2
    8000272e:	a17ff0ef          	jal	80002144 <brelse>
}
    80002732:	60e2                	ld	ra,24(sp)
    80002734:	6442                	ld	s0,16(sp)
    80002736:	64a2                	ld	s1,8(sp)
    80002738:	6902                	ld	s2,0(sp)
    8000273a:	6105                	addi	sp,sp,32
    8000273c:	8082                	ret

000000008000273e <idup>:
{
    8000273e:	1101                	addi	sp,sp,-32
    80002740:	ec06                	sd	ra,24(sp)
    80002742:	e822                	sd	s0,16(sp)
    80002744:	e426                	sd	s1,8(sp)
    80002746:	1000                	addi	s0,sp,32
    80002748:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000274a:	00016517          	auipc	a0,0x16
    8000274e:	31e50513          	addi	a0,a0,798 # 80018a68 <itable>
    80002752:	0fe030ef          	jal	80005850 <acquire>
  ip->ref++;
    80002756:	449c                	lw	a5,8(s1)
    80002758:	2785                	addiw	a5,a5,1
    8000275a:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000275c:	00016517          	auipc	a0,0x16
    80002760:	30c50513          	addi	a0,a0,780 # 80018a68 <itable>
    80002764:	184030ef          	jal	800058e8 <release>
}
    80002768:	8526                	mv	a0,s1
    8000276a:	60e2                	ld	ra,24(sp)
    8000276c:	6442                	ld	s0,16(sp)
    8000276e:	64a2                	ld	s1,8(sp)
    80002770:	6105                	addi	sp,sp,32
    80002772:	8082                	ret

0000000080002774 <ilock>:
{
    80002774:	1101                	addi	sp,sp,-32
    80002776:	ec06                	sd	ra,24(sp)
    80002778:	e822                	sd	s0,16(sp)
    8000277a:	e426                	sd	s1,8(sp)
    8000277c:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    8000277e:	cd19                	beqz	a0,8000279c <ilock+0x28>
    80002780:	84aa                	mv	s1,a0
    80002782:	451c                	lw	a5,8(a0)
    80002784:	00f05c63          	blez	a5,8000279c <ilock+0x28>
  acquiresleep(&ip->lock);
    80002788:	0541                	addi	a0,a0,16
    8000278a:	30b000ef          	jal	80003294 <acquiresleep>
  if(ip->valid == 0){
    8000278e:	40bc                	lw	a5,64(s1)
    80002790:	cf89                	beqz	a5,800027aa <ilock+0x36>
}
    80002792:	60e2                	ld	ra,24(sp)
    80002794:	6442                	ld	s0,16(sp)
    80002796:	64a2                	ld	s1,8(sp)
    80002798:	6105                	addi	sp,sp,32
    8000279a:	8082                	ret
    8000279c:	e04a                	sd	s2,0(sp)
    panic("ilock");
    8000279e:	00005517          	auipc	a0,0x5
    800027a2:	d1250513          	addi	a0,a0,-750 # 800074b0 <etext+0x4b0>
    800027a6:	57d020ef          	jal	80005522 <panic>
    800027aa:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800027ac:	40dc                	lw	a5,4(s1)
    800027ae:	0047d79b          	srliw	a5,a5,0x4
    800027b2:	00016597          	auipc	a1,0x16
    800027b6:	2ae5a583          	lw	a1,686(a1) # 80018a60 <sb+0x18>
    800027ba:	9dbd                	addw	a1,a1,a5
    800027bc:	4088                	lw	a0,0(s1)
    800027be:	87fff0ef          	jal	8000203c <bread>
    800027c2:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    800027c4:	05850593          	addi	a1,a0,88
    800027c8:	40dc                	lw	a5,4(s1)
    800027ca:	8bbd                	andi	a5,a5,15
    800027cc:	079a                	slli	a5,a5,0x6
    800027ce:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800027d0:	00059783          	lh	a5,0(a1)
    800027d4:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    800027d8:	00259783          	lh	a5,2(a1)
    800027dc:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    800027e0:	00459783          	lh	a5,4(a1)
    800027e4:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    800027e8:	00659783          	lh	a5,6(a1)
    800027ec:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    800027f0:	459c                	lw	a5,8(a1)
    800027f2:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800027f4:	03400613          	li	a2,52
    800027f8:	05b1                	addi	a1,a1,12
    800027fa:	05048513          	addi	a0,s1,80
    800027fe:	9adfd0ef          	jal	800001aa <memmove>
    brelse(bp);
    80002802:	854a                	mv	a0,s2
    80002804:	941ff0ef          	jal	80002144 <brelse>
    ip->valid = 1;
    80002808:	4785                	li	a5,1
    8000280a:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    8000280c:	04449783          	lh	a5,68(s1)
    80002810:	c399                	beqz	a5,80002816 <ilock+0xa2>
    80002812:	6902                	ld	s2,0(sp)
    80002814:	bfbd                	j	80002792 <ilock+0x1e>
      panic("ilock: no type");
    80002816:	00005517          	auipc	a0,0x5
    8000281a:	ca250513          	addi	a0,a0,-862 # 800074b8 <etext+0x4b8>
    8000281e:	505020ef          	jal	80005522 <panic>

0000000080002822 <iunlock>:
{
    80002822:	1101                	addi	sp,sp,-32
    80002824:	ec06                	sd	ra,24(sp)
    80002826:	e822                	sd	s0,16(sp)
    80002828:	e426                	sd	s1,8(sp)
    8000282a:	e04a                	sd	s2,0(sp)
    8000282c:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    8000282e:	c505                	beqz	a0,80002856 <iunlock+0x34>
    80002830:	84aa                	mv	s1,a0
    80002832:	01050913          	addi	s2,a0,16
    80002836:	854a                	mv	a0,s2
    80002838:	2db000ef          	jal	80003312 <holdingsleep>
    8000283c:	cd09                	beqz	a0,80002856 <iunlock+0x34>
    8000283e:	449c                	lw	a5,8(s1)
    80002840:	00f05b63          	blez	a5,80002856 <iunlock+0x34>
  releasesleep(&ip->lock);
    80002844:	854a                	mv	a0,s2
    80002846:	295000ef          	jal	800032da <releasesleep>
}
    8000284a:	60e2                	ld	ra,24(sp)
    8000284c:	6442                	ld	s0,16(sp)
    8000284e:	64a2                	ld	s1,8(sp)
    80002850:	6902                	ld	s2,0(sp)
    80002852:	6105                	addi	sp,sp,32
    80002854:	8082                	ret
    panic("iunlock");
    80002856:	00005517          	auipc	a0,0x5
    8000285a:	c7250513          	addi	a0,a0,-910 # 800074c8 <etext+0x4c8>
    8000285e:	4c5020ef          	jal	80005522 <panic>

0000000080002862 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002862:	7179                	addi	sp,sp,-48
    80002864:	f406                	sd	ra,40(sp)
    80002866:	f022                	sd	s0,32(sp)
    80002868:	ec26                	sd	s1,24(sp)
    8000286a:	e84a                	sd	s2,16(sp)
    8000286c:	e44e                	sd	s3,8(sp)
    8000286e:	1800                	addi	s0,sp,48
    80002870:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002872:	05050493          	addi	s1,a0,80
    80002876:	08050913          	addi	s2,a0,128
    8000287a:	a021                	j	80002882 <itrunc+0x20>
    8000287c:	0491                	addi	s1,s1,4
    8000287e:	01248b63          	beq	s1,s2,80002894 <itrunc+0x32>
    if(ip->addrs[i]){
    80002882:	408c                	lw	a1,0(s1)
    80002884:	dde5                	beqz	a1,8000287c <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    80002886:	0009a503          	lw	a0,0(s3)
    8000288a:	9abff0ef          	jal	80002234 <bfree>
      ip->addrs[i] = 0;
    8000288e:	0004a023          	sw	zero,0(s1)
    80002892:	b7ed                	j	8000287c <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002894:	0809a583          	lw	a1,128(s3)
    80002898:	ed89                	bnez	a1,800028b2 <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    8000289a:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    8000289e:	854e                	mv	a0,s3
    800028a0:	e21ff0ef          	jal	800026c0 <iupdate>
}
    800028a4:	70a2                	ld	ra,40(sp)
    800028a6:	7402                	ld	s0,32(sp)
    800028a8:	64e2                	ld	s1,24(sp)
    800028aa:	6942                	ld	s2,16(sp)
    800028ac:	69a2                	ld	s3,8(sp)
    800028ae:	6145                	addi	sp,sp,48
    800028b0:	8082                	ret
    800028b2:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800028b4:	0009a503          	lw	a0,0(s3)
    800028b8:	f84ff0ef          	jal	8000203c <bread>
    800028bc:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    800028be:	05850493          	addi	s1,a0,88
    800028c2:	45850913          	addi	s2,a0,1112
    800028c6:	a021                	j	800028ce <itrunc+0x6c>
    800028c8:	0491                	addi	s1,s1,4
    800028ca:	01248963          	beq	s1,s2,800028dc <itrunc+0x7a>
      if(a[j])
    800028ce:	408c                	lw	a1,0(s1)
    800028d0:	dde5                	beqz	a1,800028c8 <itrunc+0x66>
        bfree(ip->dev, a[j]);
    800028d2:	0009a503          	lw	a0,0(s3)
    800028d6:	95fff0ef          	jal	80002234 <bfree>
    800028da:	b7fd                	j	800028c8 <itrunc+0x66>
    brelse(bp);
    800028dc:	8552                	mv	a0,s4
    800028de:	867ff0ef          	jal	80002144 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800028e2:	0809a583          	lw	a1,128(s3)
    800028e6:	0009a503          	lw	a0,0(s3)
    800028ea:	94bff0ef          	jal	80002234 <bfree>
    ip->addrs[NDIRECT] = 0;
    800028ee:	0809a023          	sw	zero,128(s3)
    800028f2:	6a02                	ld	s4,0(sp)
    800028f4:	b75d                	j	8000289a <itrunc+0x38>

00000000800028f6 <iput>:
{
    800028f6:	1101                	addi	sp,sp,-32
    800028f8:	ec06                	sd	ra,24(sp)
    800028fa:	e822                	sd	s0,16(sp)
    800028fc:	e426                	sd	s1,8(sp)
    800028fe:	1000                	addi	s0,sp,32
    80002900:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002902:	00016517          	auipc	a0,0x16
    80002906:	16650513          	addi	a0,a0,358 # 80018a68 <itable>
    8000290a:	747020ef          	jal	80005850 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000290e:	4498                	lw	a4,8(s1)
    80002910:	4785                	li	a5,1
    80002912:	02f70063          	beq	a4,a5,80002932 <iput+0x3c>
  ip->ref--;
    80002916:	449c                	lw	a5,8(s1)
    80002918:	37fd                	addiw	a5,a5,-1
    8000291a:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000291c:	00016517          	auipc	a0,0x16
    80002920:	14c50513          	addi	a0,a0,332 # 80018a68 <itable>
    80002924:	7c5020ef          	jal	800058e8 <release>
}
    80002928:	60e2                	ld	ra,24(sp)
    8000292a:	6442                	ld	s0,16(sp)
    8000292c:	64a2                	ld	s1,8(sp)
    8000292e:	6105                	addi	sp,sp,32
    80002930:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002932:	40bc                	lw	a5,64(s1)
    80002934:	d3ed                	beqz	a5,80002916 <iput+0x20>
    80002936:	04a49783          	lh	a5,74(s1)
    8000293a:	fff1                	bnez	a5,80002916 <iput+0x20>
    8000293c:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    8000293e:	01048913          	addi	s2,s1,16
    80002942:	854a                	mv	a0,s2
    80002944:	151000ef          	jal	80003294 <acquiresleep>
    release(&itable.lock);
    80002948:	00016517          	auipc	a0,0x16
    8000294c:	12050513          	addi	a0,a0,288 # 80018a68 <itable>
    80002950:	799020ef          	jal	800058e8 <release>
    itrunc(ip);
    80002954:	8526                	mv	a0,s1
    80002956:	f0dff0ef          	jal	80002862 <itrunc>
    ip->type = 0;
    8000295a:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    8000295e:	8526                	mv	a0,s1
    80002960:	d61ff0ef          	jal	800026c0 <iupdate>
    ip->valid = 0;
    80002964:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002968:	854a                	mv	a0,s2
    8000296a:	171000ef          	jal	800032da <releasesleep>
    acquire(&itable.lock);
    8000296e:	00016517          	auipc	a0,0x16
    80002972:	0fa50513          	addi	a0,a0,250 # 80018a68 <itable>
    80002976:	6db020ef          	jal	80005850 <acquire>
    8000297a:	6902                	ld	s2,0(sp)
    8000297c:	bf69                	j	80002916 <iput+0x20>

000000008000297e <iunlockput>:
{
    8000297e:	1101                	addi	sp,sp,-32
    80002980:	ec06                	sd	ra,24(sp)
    80002982:	e822                	sd	s0,16(sp)
    80002984:	e426                	sd	s1,8(sp)
    80002986:	1000                	addi	s0,sp,32
    80002988:	84aa                	mv	s1,a0
  iunlock(ip);
    8000298a:	e99ff0ef          	jal	80002822 <iunlock>
  iput(ip);
    8000298e:	8526                	mv	a0,s1
    80002990:	f67ff0ef          	jal	800028f6 <iput>
}
    80002994:	60e2                	ld	ra,24(sp)
    80002996:	6442                	ld	s0,16(sp)
    80002998:	64a2                	ld	s1,8(sp)
    8000299a:	6105                	addi	sp,sp,32
    8000299c:	8082                	ret

000000008000299e <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    8000299e:	1141                	addi	sp,sp,-16
    800029a0:	e422                	sd	s0,8(sp)
    800029a2:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800029a4:	411c                	lw	a5,0(a0)
    800029a6:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800029a8:	415c                	lw	a5,4(a0)
    800029aa:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800029ac:	04451783          	lh	a5,68(a0)
    800029b0:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800029b4:	04a51783          	lh	a5,74(a0)
    800029b8:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800029bc:	04c56783          	lwu	a5,76(a0)
    800029c0:	e99c                	sd	a5,16(a1)
}
    800029c2:	6422                	ld	s0,8(sp)
    800029c4:	0141                	addi	sp,sp,16
    800029c6:	8082                	ret

00000000800029c8 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800029c8:	457c                	lw	a5,76(a0)
    800029ca:	0ed7eb63          	bltu	a5,a3,80002ac0 <readi+0xf8>
{
    800029ce:	7159                	addi	sp,sp,-112
    800029d0:	f486                	sd	ra,104(sp)
    800029d2:	f0a2                	sd	s0,96(sp)
    800029d4:	eca6                	sd	s1,88(sp)
    800029d6:	e0d2                	sd	s4,64(sp)
    800029d8:	fc56                	sd	s5,56(sp)
    800029da:	f85a                	sd	s6,48(sp)
    800029dc:	f45e                	sd	s7,40(sp)
    800029de:	1880                	addi	s0,sp,112
    800029e0:	8b2a                	mv	s6,a0
    800029e2:	8bae                	mv	s7,a1
    800029e4:	8a32                	mv	s4,a2
    800029e6:	84b6                	mv	s1,a3
    800029e8:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    800029ea:	9f35                	addw	a4,a4,a3
    return 0;
    800029ec:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    800029ee:	0cd76063          	bltu	a4,a3,80002aae <readi+0xe6>
    800029f2:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    800029f4:	00e7f463          	bgeu	a5,a4,800029fc <readi+0x34>
    n = ip->size - off;
    800029f8:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800029fc:	080a8f63          	beqz	s5,80002a9a <readi+0xd2>
    80002a00:	e8ca                	sd	s2,80(sp)
    80002a02:	f062                	sd	s8,32(sp)
    80002a04:	ec66                	sd	s9,24(sp)
    80002a06:	e86a                	sd	s10,16(sp)
    80002a08:	e46e                	sd	s11,8(sp)
    80002a0a:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a0c:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002a10:	5c7d                	li	s8,-1
    80002a12:	a80d                	j	80002a44 <readi+0x7c>
    80002a14:	020d1d93          	slli	s11,s10,0x20
    80002a18:	020ddd93          	srli	s11,s11,0x20
    80002a1c:	05890613          	addi	a2,s2,88
    80002a20:	86ee                	mv	a3,s11
    80002a22:	963a                	add	a2,a2,a4
    80002a24:	85d2                	mv	a1,s4
    80002a26:	855e                	mv	a0,s7
    80002a28:	d43fe0ef          	jal	8000176a <either_copyout>
    80002a2c:	05850763          	beq	a0,s8,80002a7a <readi+0xb2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002a30:	854a                	mv	a0,s2
    80002a32:	f12ff0ef          	jal	80002144 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a36:	013d09bb          	addw	s3,s10,s3
    80002a3a:	009d04bb          	addw	s1,s10,s1
    80002a3e:	9a6e                	add	s4,s4,s11
    80002a40:	0559f763          	bgeu	s3,s5,80002a8e <readi+0xc6>
    uint addr = bmap(ip, off/BSIZE);
    80002a44:	00a4d59b          	srliw	a1,s1,0xa
    80002a48:	855a                	mv	a0,s6
    80002a4a:	977ff0ef          	jal	800023c0 <bmap>
    80002a4e:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002a52:	c5b1                	beqz	a1,80002a9e <readi+0xd6>
    bp = bread(ip->dev, addr);
    80002a54:	000b2503          	lw	a0,0(s6)
    80002a58:	de4ff0ef          	jal	8000203c <bread>
    80002a5c:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a5e:	3ff4f713          	andi	a4,s1,1023
    80002a62:	40ec87bb          	subw	a5,s9,a4
    80002a66:	413a86bb          	subw	a3,s5,s3
    80002a6a:	8d3e                	mv	s10,a5
    80002a6c:	2781                	sext.w	a5,a5
    80002a6e:	0006861b          	sext.w	a2,a3
    80002a72:	faf671e3          	bgeu	a2,a5,80002a14 <readi+0x4c>
    80002a76:	8d36                	mv	s10,a3
    80002a78:	bf71                	j	80002a14 <readi+0x4c>
      brelse(bp);
    80002a7a:	854a                	mv	a0,s2
    80002a7c:	ec8ff0ef          	jal	80002144 <brelse>
      tot = -1;
    80002a80:	59fd                	li	s3,-1
      break;
    80002a82:	6946                	ld	s2,80(sp)
    80002a84:	7c02                	ld	s8,32(sp)
    80002a86:	6ce2                	ld	s9,24(sp)
    80002a88:	6d42                	ld	s10,16(sp)
    80002a8a:	6da2                	ld	s11,8(sp)
    80002a8c:	a831                	j	80002aa8 <readi+0xe0>
    80002a8e:	6946                	ld	s2,80(sp)
    80002a90:	7c02                	ld	s8,32(sp)
    80002a92:	6ce2                	ld	s9,24(sp)
    80002a94:	6d42                	ld	s10,16(sp)
    80002a96:	6da2                	ld	s11,8(sp)
    80002a98:	a801                	j	80002aa8 <readi+0xe0>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a9a:	89d6                	mv	s3,s5
    80002a9c:	a031                	j	80002aa8 <readi+0xe0>
    80002a9e:	6946                	ld	s2,80(sp)
    80002aa0:	7c02                	ld	s8,32(sp)
    80002aa2:	6ce2                	ld	s9,24(sp)
    80002aa4:	6d42                	ld	s10,16(sp)
    80002aa6:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002aa8:	0009851b          	sext.w	a0,s3
    80002aac:	69a6                	ld	s3,72(sp)
}
    80002aae:	70a6                	ld	ra,104(sp)
    80002ab0:	7406                	ld	s0,96(sp)
    80002ab2:	64e6                	ld	s1,88(sp)
    80002ab4:	6a06                	ld	s4,64(sp)
    80002ab6:	7ae2                	ld	s5,56(sp)
    80002ab8:	7b42                	ld	s6,48(sp)
    80002aba:	7ba2                	ld	s7,40(sp)
    80002abc:	6165                	addi	sp,sp,112
    80002abe:	8082                	ret
    return 0;
    80002ac0:	4501                	li	a0,0
}
    80002ac2:	8082                	ret

0000000080002ac4 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002ac4:	457c                	lw	a5,76(a0)
    80002ac6:	10d7e063          	bltu	a5,a3,80002bc6 <writei+0x102>
{
    80002aca:	7159                	addi	sp,sp,-112
    80002acc:	f486                	sd	ra,104(sp)
    80002ace:	f0a2                	sd	s0,96(sp)
    80002ad0:	e8ca                	sd	s2,80(sp)
    80002ad2:	e0d2                	sd	s4,64(sp)
    80002ad4:	fc56                	sd	s5,56(sp)
    80002ad6:	f85a                	sd	s6,48(sp)
    80002ad8:	f45e                	sd	s7,40(sp)
    80002ada:	1880                	addi	s0,sp,112
    80002adc:	8aaa                	mv	s5,a0
    80002ade:	8bae                	mv	s7,a1
    80002ae0:	8a32                	mv	s4,a2
    80002ae2:	8936                	mv	s2,a3
    80002ae4:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002ae6:	00e687bb          	addw	a5,a3,a4
    80002aea:	0ed7e063          	bltu	a5,a3,80002bca <writei+0x106>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002aee:	00043737          	lui	a4,0x43
    80002af2:	0cf76e63          	bltu	a4,a5,80002bce <writei+0x10a>
    80002af6:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002af8:	0a0b0f63          	beqz	s6,80002bb6 <writei+0xf2>
    80002afc:	eca6                	sd	s1,88(sp)
    80002afe:	f062                	sd	s8,32(sp)
    80002b00:	ec66                	sd	s9,24(sp)
    80002b02:	e86a                	sd	s10,16(sp)
    80002b04:	e46e                	sd	s11,8(sp)
    80002b06:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002b08:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002b0c:	5c7d                	li	s8,-1
    80002b0e:	a825                	j	80002b46 <writei+0x82>
    80002b10:	020d1d93          	slli	s11,s10,0x20
    80002b14:	020ddd93          	srli	s11,s11,0x20
    80002b18:	05848513          	addi	a0,s1,88
    80002b1c:	86ee                	mv	a3,s11
    80002b1e:	8652                	mv	a2,s4
    80002b20:	85de                	mv	a1,s7
    80002b22:	953a                	add	a0,a0,a4
    80002b24:	c91fe0ef          	jal	800017b4 <either_copyin>
    80002b28:	05850a63          	beq	a0,s8,80002b7c <writei+0xb8>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002b2c:	8526                	mv	a0,s1
    80002b2e:	660000ef          	jal	8000318e <log_write>
    brelse(bp);
    80002b32:	8526                	mv	a0,s1
    80002b34:	e10ff0ef          	jal	80002144 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002b38:	013d09bb          	addw	s3,s10,s3
    80002b3c:	012d093b          	addw	s2,s10,s2
    80002b40:	9a6e                	add	s4,s4,s11
    80002b42:	0569f063          	bgeu	s3,s6,80002b82 <writei+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    80002b46:	00a9559b          	srliw	a1,s2,0xa
    80002b4a:	8556                	mv	a0,s5
    80002b4c:	875ff0ef          	jal	800023c0 <bmap>
    80002b50:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002b54:	c59d                	beqz	a1,80002b82 <writei+0xbe>
    bp = bread(ip->dev, addr);
    80002b56:	000aa503          	lw	a0,0(s5)
    80002b5a:	ce2ff0ef          	jal	8000203c <bread>
    80002b5e:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002b60:	3ff97713          	andi	a4,s2,1023
    80002b64:	40ec87bb          	subw	a5,s9,a4
    80002b68:	413b06bb          	subw	a3,s6,s3
    80002b6c:	8d3e                	mv	s10,a5
    80002b6e:	2781                	sext.w	a5,a5
    80002b70:	0006861b          	sext.w	a2,a3
    80002b74:	f8f67ee3          	bgeu	a2,a5,80002b10 <writei+0x4c>
    80002b78:	8d36                	mv	s10,a3
    80002b7a:	bf59                	j	80002b10 <writei+0x4c>
      brelse(bp);
    80002b7c:	8526                	mv	a0,s1
    80002b7e:	dc6ff0ef          	jal	80002144 <brelse>
  }

  if(off > ip->size)
    80002b82:	04caa783          	lw	a5,76(s5)
    80002b86:	0327fa63          	bgeu	a5,s2,80002bba <writei+0xf6>
    ip->size = off;
    80002b8a:	052aa623          	sw	s2,76(s5)
    80002b8e:	64e6                	ld	s1,88(sp)
    80002b90:	7c02                	ld	s8,32(sp)
    80002b92:	6ce2                	ld	s9,24(sp)
    80002b94:	6d42                	ld	s10,16(sp)
    80002b96:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002b98:	8556                	mv	a0,s5
    80002b9a:	b27ff0ef          	jal	800026c0 <iupdate>

  return tot;
    80002b9e:	0009851b          	sext.w	a0,s3
    80002ba2:	69a6                	ld	s3,72(sp)
}
    80002ba4:	70a6                	ld	ra,104(sp)
    80002ba6:	7406                	ld	s0,96(sp)
    80002ba8:	6946                	ld	s2,80(sp)
    80002baa:	6a06                	ld	s4,64(sp)
    80002bac:	7ae2                	ld	s5,56(sp)
    80002bae:	7b42                	ld	s6,48(sp)
    80002bb0:	7ba2                	ld	s7,40(sp)
    80002bb2:	6165                	addi	sp,sp,112
    80002bb4:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002bb6:	89da                	mv	s3,s6
    80002bb8:	b7c5                	j	80002b98 <writei+0xd4>
    80002bba:	64e6                	ld	s1,88(sp)
    80002bbc:	7c02                	ld	s8,32(sp)
    80002bbe:	6ce2                	ld	s9,24(sp)
    80002bc0:	6d42                	ld	s10,16(sp)
    80002bc2:	6da2                	ld	s11,8(sp)
    80002bc4:	bfd1                	j	80002b98 <writei+0xd4>
    return -1;
    80002bc6:	557d                	li	a0,-1
}
    80002bc8:	8082                	ret
    return -1;
    80002bca:	557d                	li	a0,-1
    80002bcc:	bfe1                	j	80002ba4 <writei+0xe0>
    return -1;
    80002bce:	557d                	li	a0,-1
    80002bd0:	bfd1                	j	80002ba4 <writei+0xe0>

0000000080002bd2 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002bd2:	1141                	addi	sp,sp,-16
    80002bd4:	e406                	sd	ra,8(sp)
    80002bd6:	e022                	sd	s0,0(sp)
    80002bd8:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002bda:	4639                	li	a2,14
    80002bdc:	e3efd0ef          	jal	8000021a <strncmp>
}
    80002be0:	60a2                	ld	ra,8(sp)
    80002be2:	6402                	ld	s0,0(sp)
    80002be4:	0141                	addi	sp,sp,16
    80002be6:	8082                	ret

0000000080002be8 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002be8:	7139                	addi	sp,sp,-64
    80002bea:	fc06                	sd	ra,56(sp)
    80002bec:	f822                	sd	s0,48(sp)
    80002bee:	f426                	sd	s1,40(sp)
    80002bf0:	f04a                	sd	s2,32(sp)
    80002bf2:	ec4e                	sd	s3,24(sp)
    80002bf4:	e852                	sd	s4,16(sp)
    80002bf6:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002bf8:	04451703          	lh	a4,68(a0)
    80002bfc:	4785                	li	a5,1
    80002bfe:	00f71a63          	bne	a4,a5,80002c12 <dirlookup+0x2a>
    80002c02:	892a                	mv	s2,a0
    80002c04:	89ae                	mv	s3,a1
    80002c06:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c08:	457c                	lw	a5,76(a0)
    80002c0a:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002c0c:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c0e:	e39d                	bnez	a5,80002c34 <dirlookup+0x4c>
    80002c10:	a095                	j	80002c74 <dirlookup+0x8c>
    panic("dirlookup not DIR");
    80002c12:	00005517          	auipc	a0,0x5
    80002c16:	8be50513          	addi	a0,a0,-1858 # 800074d0 <etext+0x4d0>
    80002c1a:	109020ef          	jal	80005522 <panic>
      panic("dirlookup read");
    80002c1e:	00005517          	auipc	a0,0x5
    80002c22:	8ca50513          	addi	a0,a0,-1846 # 800074e8 <etext+0x4e8>
    80002c26:	0fd020ef          	jal	80005522 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c2a:	24c1                	addiw	s1,s1,16
    80002c2c:	04c92783          	lw	a5,76(s2)
    80002c30:	04f4f163          	bgeu	s1,a5,80002c72 <dirlookup+0x8a>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002c34:	4741                	li	a4,16
    80002c36:	86a6                	mv	a3,s1
    80002c38:	fc040613          	addi	a2,s0,-64
    80002c3c:	4581                	li	a1,0
    80002c3e:	854a                	mv	a0,s2
    80002c40:	d89ff0ef          	jal	800029c8 <readi>
    80002c44:	47c1                	li	a5,16
    80002c46:	fcf51ce3          	bne	a0,a5,80002c1e <dirlookup+0x36>
    if(de.inum == 0)
    80002c4a:	fc045783          	lhu	a5,-64(s0)
    80002c4e:	dff1                	beqz	a5,80002c2a <dirlookup+0x42>
    if(namecmp(name, de.name) == 0){
    80002c50:	fc240593          	addi	a1,s0,-62
    80002c54:	854e                	mv	a0,s3
    80002c56:	f7dff0ef          	jal	80002bd2 <namecmp>
    80002c5a:	f961                	bnez	a0,80002c2a <dirlookup+0x42>
      if(poff)
    80002c5c:	000a0463          	beqz	s4,80002c64 <dirlookup+0x7c>
        *poff = off;
    80002c60:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80002c64:	fc045583          	lhu	a1,-64(s0)
    80002c68:	00092503          	lw	a0,0(s2)
    80002c6c:	829ff0ef          	jal	80002494 <iget>
    80002c70:	a011                	j	80002c74 <dirlookup+0x8c>
  return 0;
    80002c72:	4501                	li	a0,0
}
    80002c74:	70e2                	ld	ra,56(sp)
    80002c76:	7442                	ld	s0,48(sp)
    80002c78:	74a2                	ld	s1,40(sp)
    80002c7a:	7902                	ld	s2,32(sp)
    80002c7c:	69e2                	ld	s3,24(sp)
    80002c7e:	6a42                	ld	s4,16(sp)
    80002c80:	6121                	addi	sp,sp,64
    80002c82:	8082                	ret

0000000080002c84 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002c84:	711d                	addi	sp,sp,-96
    80002c86:	ec86                	sd	ra,88(sp)
    80002c88:	e8a2                	sd	s0,80(sp)
    80002c8a:	e4a6                	sd	s1,72(sp)
    80002c8c:	e0ca                	sd	s2,64(sp)
    80002c8e:	fc4e                	sd	s3,56(sp)
    80002c90:	f852                	sd	s4,48(sp)
    80002c92:	f456                	sd	s5,40(sp)
    80002c94:	f05a                	sd	s6,32(sp)
    80002c96:	ec5e                	sd	s7,24(sp)
    80002c98:	e862                	sd	s8,16(sp)
    80002c9a:	e466                	sd	s9,8(sp)
    80002c9c:	1080                	addi	s0,sp,96
    80002c9e:	84aa                	mv	s1,a0
    80002ca0:	8b2e                	mv	s6,a1
    80002ca2:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80002ca4:	00054703          	lbu	a4,0(a0)
    80002ca8:	02f00793          	li	a5,47
    80002cac:	00f70e63          	beq	a4,a5,80002cc8 <namex+0x44>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002cb0:	8f0fe0ef          	jal	80000da0 <myproc>
    80002cb4:	15053503          	ld	a0,336(a0)
    80002cb8:	a87ff0ef          	jal	8000273e <idup>
    80002cbc:	8a2a                	mv	s4,a0
  while(*path == '/')
    80002cbe:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80002cc2:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80002cc4:	4b85                	li	s7,1
    80002cc6:	a871                	j	80002d62 <namex+0xde>
    ip = iget(ROOTDEV, ROOTINO);
    80002cc8:	4585                	li	a1,1
    80002cca:	4505                	li	a0,1
    80002ccc:	fc8ff0ef          	jal	80002494 <iget>
    80002cd0:	8a2a                	mv	s4,a0
    80002cd2:	b7f5                	j	80002cbe <namex+0x3a>
      iunlockput(ip);
    80002cd4:	8552                	mv	a0,s4
    80002cd6:	ca9ff0ef          	jal	8000297e <iunlockput>
      return 0;
    80002cda:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80002cdc:	8552                	mv	a0,s4
    80002cde:	60e6                	ld	ra,88(sp)
    80002ce0:	6446                	ld	s0,80(sp)
    80002ce2:	64a6                	ld	s1,72(sp)
    80002ce4:	6906                	ld	s2,64(sp)
    80002ce6:	79e2                	ld	s3,56(sp)
    80002ce8:	7a42                	ld	s4,48(sp)
    80002cea:	7aa2                	ld	s5,40(sp)
    80002cec:	7b02                	ld	s6,32(sp)
    80002cee:	6be2                	ld	s7,24(sp)
    80002cf0:	6c42                	ld	s8,16(sp)
    80002cf2:	6ca2                	ld	s9,8(sp)
    80002cf4:	6125                	addi	sp,sp,96
    80002cf6:	8082                	ret
      iunlock(ip);
    80002cf8:	8552                	mv	a0,s4
    80002cfa:	b29ff0ef          	jal	80002822 <iunlock>
      return ip;
    80002cfe:	bff9                	j	80002cdc <namex+0x58>
      iunlockput(ip);
    80002d00:	8552                	mv	a0,s4
    80002d02:	c7dff0ef          	jal	8000297e <iunlockput>
      return 0;
    80002d06:	8a4e                	mv	s4,s3
    80002d08:	bfd1                	j	80002cdc <namex+0x58>
  len = path - s;
    80002d0a:	40998633          	sub	a2,s3,s1
    80002d0e:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80002d12:	099c5063          	bge	s8,s9,80002d92 <namex+0x10e>
    memmove(name, s, DIRSIZ);
    80002d16:	4639                	li	a2,14
    80002d18:	85a6                	mv	a1,s1
    80002d1a:	8556                	mv	a0,s5
    80002d1c:	c8efd0ef          	jal	800001aa <memmove>
    80002d20:	84ce                	mv	s1,s3
  while(*path == '/')
    80002d22:	0004c783          	lbu	a5,0(s1)
    80002d26:	01279763          	bne	a5,s2,80002d34 <namex+0xb0>
    path++;
    80002d2a:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002d2c:	0004c783          	lbu	a5,0(s1)
    80002d30:	ff278de3          	beq	a5,s2,80002d2a <namex+0xa6>
    ilock(ip);
    80002d34:	8552                	mv	a0,s4
    80002d36:	a3fff0ef          	jal	80002774 <ilock>
    if(ip->type != T_DIR){
    80002d3a:	044a1783          	lh	a5,68(s4)
    80002d3e:	f9779be3          	bne	a5,s7,80002cd4 <namex+0x50>
    if(nameiparent && *path == '\0'){
    80002d42:	000b0563          	beqz	s6,80002d4c <namex+0xc8>
    80002d46:	0004c783          	lbu	a5,0(s1)
    80002d4a:	d7dd                	beqz	a5,80002cf8 <namex+0x74>
    if((next = dirlookup(ip, name, 0)) == 0){
    80002d4c:	4601                	li	a2,0
    80002d4e:	85d6                	mv	a1,s5
    80002d50:	8552                	mv	a0,s4
    80002d52:	e97ff0ef          	jal	80002be8 <dirlookup>
    80002d56:	89aa                	mv	s3,a0
    80002d58:	d545                	beqz	a0,80002d00 <namex+0x7c>
    iunlockput(ip);
    80002d5a:	8552                	mv	a0,s4
    80002d5c:	c23ff0ef          	jal	8000297e <iunlockput>
    ip = next;
    80002d60:	8a4e                	mv	s4,s3
  while(*path == '/')
    80002d62:	0004c783          	lbu	a5,0(s1)
    80002d66:	01279763          	bne	a5,s2,80002d74 <namex+0xf0>
    path++;
    80002d6a:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002d6c:	0004c783          	lbu	a5,0(s1)
    80002d70:	ff278de3          	beq	a5,s2,80002d6a <namex+0xe6>
  if(*path == 0)
    80002d74:	cb8d                	beqz	a5,80002da6 <namex+0x122>
  while(*path != '/' && *path != 0)
    80002d76:	0004c783          	lbu	a5,0(s1)
    80002d7a:	89a6                	mv	s3,s1
  len = path - s;
    80002d7c:	4c81                	li	s9,0
    80002d7e:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    80002d80:	01278963          	beq	a5,s2,80002d92 <namex+0x10e>
    80002d84:	d3d9                	beqz	a5,80002d0a <namex+0x86>
    path++;
    80002d86:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80002d88:	0009c783          	lbu	a5,0(s3)
    80002d8c:	ff279ce3          	bne	a5,s2,80002d84 <namex+0x100>
    80002d90:	bfad                	j	80002d0a <namex+0x86>
    memmove(name, s, len);
    80002d92:	2601                	sext.w	a2,a2
    80002d94:	85a6                	mv	a1,s1
    80002d96:	8556                	mv	a0,s5
    80002d98:	c12fd0ef          	jal	800001aa <memmove>
    name[len] = 0;
    80002d9c:	9cd6                	add	s9,s9,s5
    80002d9e:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80002da2:	84ce                	mv	s1,s3
    80002da4:	bfbd                	j	80002d22 <namex+0x9e>
  if(nameiparent){
    80002da6:	f20b0be3          	beqz	s6,80002cdc <namex+0x58>
    iput(ip);
    80002daa:	8552                	mv	a0,s4
    80002dac:	b4bff0ef          	jal	800028f6 <iput>
    return 0;
    80002db0:	4a01                	li	s4,0
    80002db2:	b72d                	j	80002cdc <namex+0x58>

0000000080002db4 <dirlink>:
{
    80002db4:	7139                	addi	sp,sp,-64
    80002db6:	fc06                	sd	ra,56(sp)
    80002db8:	f822                	sd	s0,48(sp)
    80002dba:	f04a                	sd	s2,32(sp)
    80002dbc:	ec4e                	sd	s3,24(sp)
    80002dbe:	e852                	sd	s4,16(sp)
    80002dc0:	0080                	addi	s0,sp,64
    80002dc2:	892a                	mv	s2,a0
    80002dc4:	8a2e                	mv	s4,a1
    80002dc6:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80002dc8:	4601                	li	a2,0
    80002dca:	e1fff0ef          	jal	80002be8 <dirlookup>
    80002dce:	e535                	bnez	a0,80002e3a <dirlink+0x86>
    80002dd0:	f426                	sd	s1,40(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002dd2:	04c92483          	lw	s1,76(s2)
    80002dd6:	c48d                	beqz	s1,80002e00 <dirlink+0x4c>
    80002dd8:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002dda:	4741                	li	a4,16
    80002ddc:	86a6                	mv	a3,s1
    80002dde:	fc040613          	addi	a2,s0,-64
    80002de2:	4581                	li	a1,0
    80002de4:	854a                	mv	a0,s2
    80002de6:	be3ff0ef          	jal	800029c8 <readi>
    80002dea:	47c1                	li	a5,16
    80002dec:	04f51b63          	bne	a0,a5,80002e42 <dirlink+0x8e>
    if(de.inum == 0)
    80002df0:	fc045783          	lhu	a5,-64(s0)
    80002df4:	c791                	beqz	a5,80002e00 <dirlink+0x4c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002df6:	24c1                	addiw	s1,s1,16
    80002df8:	04c92783          	lw	a5,76(s2)
    80002dfc:	fcf4efe3          	bltu	s1,a5,80002dda <dirlink+0x26>
  strncpy(de.name, name, DIRSIZ);
    80002e00:	4639                	li	a2,14
    80002e02:	85d2                	mv	a1,s4
    80002e04:	fc240513          	addi	a0,s0,-62
    80002e08:	c48fd0ef          	jal	80000250 <strncpy>
  de.inum = inum;
    80002e0c:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002e10:	4741                	li	a4,16
    80002e12:	86a6                	mv	a3,s1
    80002e14:	fc040613          	addi	a2,s0,-64
    80002e18:	4581                	li	a1,0
    80002e1a:	854a                	mv	a0,s2
    80002e1c:	ca9ff0ef          	jal	80002ac4 <writei>
    80002e20:	1541                	addi	a0,a0,-16
    80002e22:	00a03533          	snez	a0,a0
    80002e26:	40a00533          	neg	a0,a0
    80002e2a:	74a2                	ld	s1,40(sp)
}
    80002e2c:	70e2                	ld	ra,56(sp)
    80002e2e:	7442                	ld	s0,48(sp)
    80002e30:	7902                	ld	s2,32(sp)
    80002e32:	69e2                	ld	s3,24(sp)
    80002e34:	6a42                	ld	s4,16(sp)
    80002e36:	6121                	addi	sp,sp,64
    80002e38:	8082                	ret
    iput(ip);
    80002e3a:	abdff0ef          	jal	800028f6 <iput>
    return -1;
    80002e3e:	557d                	li	a0,-1
    80002e40:	b7f5                	j	80002e2c <dirlink+0x78>
      panic("dirlink read");
    80002e42:	00004517          	auipc	a0,0x4
    80002e46:	6b650513          	addi	a0,a0,1718 # 800074f8 <etext+0x4f8>
    80002e4a:	6d8020ef          	jal	80005522 <panic>

0000000080002e4e <namei>:

struct inode*
namei(char *path)
{
    80002e4e:	1101                	addi	sp,sp,-32
    80002e50:	ec06                	sd	ra,24(sp)
    80002e52:	e822                	sd	s0,16(sp)
    80002e54:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80002e56:	fe040613          	addi	a2,s0,-32
    80002e5a:	4581                	li	a1,0
    80002e5c:	e29ff0ef          	jal	80002c84 <namex>
}
    80002e60:	60e2                	ld	ra,24(sp)
    80002e62:	6442                	ld	s0,16(sp)
    80002e64:	6105                	addi	sp,sp,32
    80002e66:	8082                	ret

0000000080002e68 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80002e68:	1141                	addi	sp,sp,-16
    80002e6a:	e406                	sd	ra,8(sp)
    80002e6c:	e022                	sd	s0,0(sp)
    80002e6e:	0800                	addi	s0,sp,16
    80002e70:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80002e72:	4585                	li	a1,1
    80002e74:	e11ff0ef          	jal	80002c84 <namex>
}
    80002e78:	60a2                	ld	ra,8(sp)
    80002e7a:	6402                	ld	s0,0(sp)
    80002e7c:	0141                	addi	sp,sp,16
    80002e7e:	8082                	ret

0000000080002e80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80002e80:	1101                	addi	sp,sp,-32
    80002e82:	ec06                	sd	ra,24(sp)
    80002e84:	e822                	sd	s0,16(sp)
    80002e86:	e426                	sd	s1,8(sp)
    80002e88:	e04a                	sd	s2,0(sp)
    80002e8a:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80002e8c:	00017917          	auipc	s2,0x17
    80002e90:	68490913          	addi	s2,s2,1668 # 8001a510 <log>
    80002e94:	01892583          	lw	a1,24(s2)
    80002e98:	02892503          	lw	a0,40(s2)
    80002e9c:	9a0ff0ef          	jal	8000203c <bread>
    80002ea0:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80002ea2:	02c92603          	lw	a2,44(s2)
    80002ea6:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80002ea8:	00c05f63          	blez	a2,80002ec6 <write_head+0x46>
    80002eac:	00017717          	auipc	a4,0x17
    80002eb0:	69470713          	addi	a4,a4,1684 # 8001a540 <log+0x30>
    80002eb4:	87aa                	mv	a5,a0
    80002eb6:	060a                	slli	a2,a2,0x2
    80002eb8:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80002eba:	4314                	lw	a3,0(a4)
    80002ebc:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80002ebe:	0711                	addi	a4,a4,4
    80002ec0:	0791                	addi	a5,a5,4
    80002ec2:	fec79ce3          	bne	a5,a2,80002eba <write_head+0x3a>
  }
  bwrite(buf);
    80002ec6:	8526                	mv	a0,s1
    80002ec8:	a4aff0ef          	jal	80002112 <bwrite>
  brelse(buf);
    80002ecc:	8526                	mv	a0,s1
    80002ece:	a76ff0ef          	jal	80002144 <brelse>
}
    80002ed2:	60e2                	ld	ra,24(sp)
    80002ed4:	6442                	ld	s0,16(sp)
    80002ed6:	64a2                	ld	s1,8(sp)
    80002ed8:	6902                	ld	s2,0(sp)
    80002eda:	6105                	addi	sp,sp,32
    80002edc:	8082                	ret

0000000080002ede <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80002ede:	00017797          	auipc	a5,0x17
    80002ee2:	65e7a783          	lw	a5,1630(a5) # 8001a53c <log+0x2c>
    80002ee6:	08f05f63          	blez	a5,80002f84 <install_trans+0xa6>
{
    80002eea:	7139                	addi	sp,sp,-64
    80002eec:	fc06                	sd	ra,56(sp)
    80002eee:	f822                	sd	s0,48(sp)
    80002ef0:	f426                	sd	s1,40(sp)
    80002ef2:	f04a                	sd	s2,32(sp)
    80002ef4:	ec4e                	sd	s3,24(sp)
    80002ef6:	e852                	sd	s4,16(sp)
    80002ef8:	e456                	sd	s5,8(sp)
    80002efa:	e05a                	sd	s6,0(sp)
    80002efc:	0080                	addi	s0,sp,64
    80002efe:	8b2a                	mv	s6,a0
    80002f00:	00017a97          	auipc	s5,0x17
    80002f04:	640a8a93          	addi	s5,s5,1600 # 8001a540 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002f08:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002f0a:	00017997          	auipc	s3,0x17
    80002f0e:	60698993          	addi	s3,s3,1542 # 8001a510 <log>
    80002f12:	a829                	j	80002f2c <install_trans+0x4e>
    brelse(lbuf);
    80002f14:	854a                	mv	a0,s2
    80002f16:	a2eff0ef          	jal	80002144 <brelse>
    brelse(dbuf);
    80002f1a:	8526                	mv	a0,s1
    80002f1c:	a28ff0ef          	jal	80002144 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002f20:	2a05                	addiw	s4,s4,1
    80002f22:	0a91                	addi	s5,s5,4
    80002f24:	02c9a783          	lw	a5,44(s3)
    80002f28:	04fa5463          	bge	s4,a5,80002f70 <install_trans+0x92>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002f2c:	0189a583          	lw	a1,24(s3)
    80002f30:	014585bb          	addw	a1,a1,s4
    80002f34:	2585                	addiw	a1,a1,1
    80002f36:	0289a503          	lw	a0,40(s3)
    80002f3a:	902ff0ef          	jal	8000203c <bread>
    80002f3e:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80002f40:	000aa583          	lw	a1,0(s5)
    80002f44:	0289a503          	lw	a0,40(s3)
    80002f48:	8f4ff0ef          	jal	8000203c <bread>
    80002f4c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002f4e:	40000613          	li	a2,1024
    80002f52:	05890593          	addi	a1,s2,88
    80002f56:	05850513          	addi	a0,a0,88
    80002f5a:	a50fd0ef          	jal	800001aa <memmove>
    bwrite(dbuf);  // write dst to disk
    80002f5e:	8526                	mv	a0,s1
    80002f60:	9b2ff0ef          	jal	80002112 <bwrite>
    if(recovering == 0)
    80002f64:	fa0b18e3          	bnez	s6,80002f14 <install_trans+0x36>
      bunpin(dbuf);
    80002f68:	8526                	mv	a0,s1
    80002f6a:	a96ff0ef          	jal	80002200 <bunpin>
    80002f6e:	b75d                	j	80002f14 <install_trans+0x36>
}
    80002f70:	70e2                	ld	ra,56(sp)
    80002f72:	7442                	ld	s0,48(sp)
    80002f74:	74a2                	ld	s1,40(sp)
    80002f76:	7902                	ld	s2,32(sp)
    80002f78:	69e2                	ld	s3,24(sp)
    80002f7a:	6a42                	ld	s4,16(sp)
    80002f7c:	6aa2                	ld	s5,8(sp)
    80002f7e:	6b02                	ld	s6,0(sp)
    80002f80:	6121                	addi	sp,sp,64
    80002f82:	8082                	ret
    80002f84:	8082                	ret

0000000080002f86 <initlog>:
{
    80002f86:	7179                	addi	sp,sp,-48
    80002f88:	f406                	sd	ra,40(sp)
    80002f8a:	f022                	sd	s0,32(sp)
    80002f8c:	ec26                	sd	s1,24(sp)
    80002f8e:	e84a                	sd	s2,16(sp)
    80002f90:	e44e                	sd	s3,8(sp)
    80002f92:	1800                	addi	s0,sp,48
    80002f94:	892a                	mv	s2,a0
    80002f96:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80002f98:	00017497          	auipc	s1,0x17
    80002f9c:	57848493          	addi	s1,s1,1400 # 8001a510 <log>
    80002fa0:	00004597          	auipc	a1,0x4
    80002fa4:	56858593          	addi	a1,a1,1384 # 80007508 <etext+0x508>
    80002fa8:	8526                	mv	a0,s1
    80002faa:	027020ef          	jal	800057d0 <initlock>
  log.start = sb->logstart;
    80002fae:	0149a583          	lw	a1,20(s3)
    80002fb2:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80002fb4:	0109a783          	lw	a5,16(s3)
    80002fb8:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80002fba:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80002fbe:	854a                	mv	a0,s2
    80002fc0:	87cff0ef          	jal	8000203c <bread>
  log.lh.n = lh->n;
    80002fc4:	4d30                	lw	a2,88(a0)
    80002fc6:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80002fc8:	00c05f63          	blez	a2,80002fe6 <initlog+0x60>
    80002fcc:	87aa                	mv	a5,a0
    80002fce:	00017717          	auipc	a4,0x17
    80002fd2:	57270713          	addi	a4,a4,1394 # 8001a540 <log+0x30>
    80002fd6:	060a                	slli	a2,a2,0x2
    80002fd8:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80002fda:	4ff4                	lw	a3,92(a5)
    80002fdc:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80002fde:	0791                	addi	a5,a5,4
    80002fe0:	0711                	addi	a4,a4,4
    80002fe2:	fec79ce3          	bne	a5,a2,80002fda <initlog+0x54>
  brelse(buf);
    80002fe6:	95eff0ef          	jal	80002144 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80002fea:	4505                	li	a0,1
    80002fec:	ef3ff0ef          	jal	80002ede <install_trans>
  log.lh.n = 0;
    80002ff0:	00017797          	auipc	a5,0x17
    80002ff4:	5407a623          	sw	zero,1356(a5) # 8001a53c <log+0x2c>
  write_head(); // clear the log
    80002ff8:	e89ff0ef          	jal	80002e80 <write_head>
}
    80002ffc:	70a2                	ld	ra,40(sp)
    80002ffe:	7402                	ld	s0,32(sp)
    80003000:	64e2                	ld	s1,24(sp)
    80003002:	6942                	ld	s2,16(sp)
    80003004:	69a2                	ld	s3,8(sp)
    80003006:	6145                	addi	sp,sp,48
    80003008:	8082                	ret

000000008000300a <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000300a:	1101                	addi	sp,sp,-32
    8000300c:	ec06                	sd	ra,24(sp)
    8000300e:	e822                	sd	s0,16(sp)
    80003010:	e426                	sd	s1,8(sp)
    80003012:	e04a                	sd	s2,0(sp)
    80003014:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003016:	00017517          	auipc	a0,0x17
    8000301a:	4fa50513          	addi	a0,a0,1274 # 8001a510 <log>
    8000301e:	033020ef          	jal	80005850 <acquire>
  while(1){
    if(log.committing){
    80003022:	00017497          	auipc	s1,0x17
    80003026:	4ee48493          	addi	s1,s1,1262 # 8001a510 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000302a:	4979                	li	s2,30
    8000302c:	a029                	j	80003036 <begin_op+0x2c>
      sleep(&log, &log.lock);
    8000302e:	85a6                	mv	a1,s1
    80003030:	8526                	mv	a0,s1
    80003032:	bdcfe0ef          	jal	8000140e <sleep>
    if(log.committing){
    80003036:	50dc                	lw	a5,36(s1)
    80003038:	fbfd                	bnez	a5,8000302e <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000303a:	5098                	lw	a4,32(s1)
    8000303c:	2705                	addiw	a4,a4,1
    8000303e:	0027179b          	slliw	a5,a4,0x2
    80003042:	9fb9                	addw	a5,a5,a4
    80003044:	0017979b          	slliw	a5,a5,0x1
    80003048:	54d4                	lw	a3,44(s1)
    8000304a:	9fb5                	addw	a5,a5,a3
    8000304c:	00f95763          	bge	s2,a5,8000305a <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003050:	85a6                	mv	a1,s1
    80003052:	8526                	mv	a0,s1
    80003054:	bbafe0ef          	jal	8000140e <sleep>
    80003058:	bff9                	j	80003036 <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    8000305a:	00017517          	auipc	a0,0x17
    8000305e:	4b650513          	addi	a0,a0,1206 # 8001a510 <log>
    80003062:	d118                	sw	a4,32(a0)
      release(&log.lock);
    80003064:	085020ef          	jal	800058e8 <release>
      break;
    }
  }
}
    80003068:	60e2                	ld	ra,24(sp)
    8000306a:	6442                	ld	s0,16(sp)
    8000306c:	64a2                	ld	s1,8(sp)
    8000306e:	6902                	ld	s2,0(sp)
    80003070:	6105                	addi	sp,sp,32
    80003072:	8082                	ret

0000000080003074 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003074:	7139                	addi	sp,sp,-64
    80003076:	fc06                	sd	ra,56(sp)
    80003078:	f822                	sd	s0,48(sp)
    8000307a:	f426                	sd	s1,40(sp)
    8000307c:	f04a                	sd	s2,32(sp)
    8000307e:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003080:	00017497          	auipc	s1,0x17
    80003084:	49048493          	addi	s1,s1,1168 # 8001a510 <log>
    80003088:	8526                	mv	a0,s1
    8000308a:	7c6020ef          	jal	80005850 <acquire>
  log.outstanding -= 1;
    8000308e:	509c                	lw	a5,32(s1)
    80003090:	37fd                	addiw	a5,a5,-1
    80003092:	0007891b          	sext.w	s2,a5
    80003096:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003098:	50dc                	lw	a5,36(s1)
    8000309a:	ef9d                	bnez	a5,800030d8 <end_op+0x64>
    panic("log.committing");
  if(log.outstanding == 0){
    8000309c:	04091763          	bnez	s2,800030ea <end_op+0x76>
    do_commit = 1;
    log.committing = 1;
    800030a0:	00017497          	auipc	s1,0x17
    800030a4:	47048493          	addi	s1,s1,1136 # 8001a510 <log>
    800030a8:	4785                	li	a5,1
    800030aa:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800030ac:	8526                	mv	a0,s1
    800030ae:	03b020ef          	jal	800058e8 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800030b2:	54dc                	lw	a5,44(s1)
    800030b4:	04f04b63          	bgtz	a5,8000310a <end_op+0x96>
    acquire(&log.lock);
    800030b8:	00017497          	auipc	s1,0x17
    800030bc:	45848493          	addi	s1,s1,1112 # 8001a510 <log>
    800030c0:	8526                	mv	a0,s1
    800030c2:	78e020ef          	jal	80005850 <acquire>
    log.committing = 0;
    800030c6:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800030ca:	8526                	mv	a0,s1
    800030cc:	b8efe0ef          	jal	8000145a <wakeup>
    release(&log.lock);
    800030d0:	8526                	mv	a0,s1
    800030d2:	017020ef          	jal	800058e8 <release>
}
    800030d6:	a025                	j	800030fe <end_op+0x8a>
    800030d8:	ec4e                	sd	s3,24(sp)
    800030da:	e852                	sd	s4,16(sp)
    800030dc:	e456                	sd	s5,8(sp)
    panic("log.committing");
    800030de:	00004517          	auipc	a0,0x4
    800030e2:	43250513          	addi	a0,a0,1074 # 80007510 <etext+0x510>
    800030e6:	43c020ef          	jal	80005522 <panic>
    wakeup(&log);
    800030ea:	00017497          	auipc	s1,0x17
    800030ee:	42648493          	addi	s1,s1,1062 # 8001a510 <log>
    800030f2:	8526                	mv	a0,s1
    800030f4:	b66fe0ef          	jal	8000145a <wakeup>
  release(&log.lock);
    800030f8:	8526                	mv	a0,s1
    800030fa:	7ee020ef          	jal	800058e8 <release>
}
    800030fe:	70e2                	ld	ra,56(sp)
    80003100:	7442                	ld	s0,48(sp)
    80003102:	74a2                	ld	s1,40(sp)
    80003104:	7902                	ld	s2,32(sp)
    80003106:	6121                	addi	sp,sp,64
    80003108:	8082                	ret
    8000310a:	ec4e                	sd	s3,24(sp)
    8000310c:	e852                	sd	s4,16(sp)
    8000310e:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    80003110:	00017a97          	auipc	s5,0x17
    80003114:	430a8a93          	addi	s5,s5,1072 # 8001a540 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003118:	00017a17          	auipc	s4,0x17
    8000311c:	3f8a0a13          	addi	s4,s4,1016 # 8001a510 <log>
    80003120:	018a2583          	lw	a1,24(s4)
    80003124:	012585bb          	addw	a1,a1,s2
    80003128:	2585                	addiw	a1,a1,1
    8000312a:	028a2503          	lw	a0,40(s4)
    8000312e:	f0ffe0ef          	jal	8000203c <bread>
    80003132:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003134:	000aa583          	lw	a1,0(s5)
    80003138:	028a2503          	lw	a0,40(s4)
    8000313c:	f01fe0ef          	jal	8000203c <bread>
    80003140:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003142:	40000613          	li	a2,1024
    80003146:	05850593          	addi	a1,a0,88
    8000314a:	05848513          	addi	a0,s1,88
    8000314e:	85cfd0ef          	jal	800001aa <memmove>
    bwrite(to);  // write the log
    80003152:	8526                	mv	a0,s1
    80003154:	fbffe0ef          	jal	80002112 <bwrite>
    brelse(from);
    80003158:	854e                	mv	a0,s3
    8000315a:	febfe0ef          	jal	80002144 <brelse>
    brelse(to);
    8000315e:	8526                	mv	a0,s1
    80003160:	fe5fe0ef          	jal	80002144 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003164:	2905                	addiw	s2,s2,1
    80003166:	0a91                	addi	s5,s5,4
    80003168:	02ca2783          	lw	a5,44(s4)
    8000316c:	faf94ae3          	blt	s2,a5,80003120 <end_op+0xac>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003170:	d11ff0ef          	jal	80002e80 <write_head>
    install_trans(0); // Now install writes to home locations
    80003174:	4501                	li	a0,0
    80003176:	d69ff0ef          	jal	80002ede <install_trans>
    log.lh.n = 0;
    8000317a:	00017797          	auipc	a5,0x17
    8000317e:	3c07a123          	sw	zero,962(a5) # 8001a53c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003182:	cffff0ef          	jal	80002e80 <write_head>
    80003186:	69e2                	ld	s3,24(sp)
    80003188:	6a42                	ld	s4,16(sp)
    8000318a:	6aa2                	ld	s5,8(sp)
    8000318c:	b735                	j	800030b8 <end_op+0x44>

000000008000318e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000318e:	1101                	addi	sp,sp,-32
    80003190:	ec06                	sd	ra,24(sp)
    80003192:	e822                	sd	s0,16(sp)
    80003194:	e426                	sd	s1,8(sp)
    80003196:	e04a                	sd	s2,0(sp)
    80003198:	1000                	addi	s0,sp,32
    8000319a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000319c:	00017917          	auipc	s2,0x17
    800031a0:	37490913          	addi	s2,s2,884 # 8001a510 <log>
    800031a4:	854a                	mv	a0,s2
    800031a6:	6aa020ef          	jal	80005850 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800031aa:	02c92603          	lw	a2,44(s2)
    800031ae:	47f5                	li	a5,29
    800031b0:	06c7c363          	blt	a5,a2,80003216 <log_write+0x88>
    800031b4:	00017797          	auipc	a5,0x17
    800031b8:	3787a783          	lw	a5,888(a5) # 8001a52c <log+0x1c>
    800031bc:	37fd                	addiw	a5,a5,-1
    800031be:	04f65c63          	bge	a2,a5,80003216 <log_write+0x88>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800031c2:	00017797          	auipc	a5,0x17
    800031c6:	36e7a783          	lw	a5,878(a5) # 8001a530 <log+0x20>
    800031ca:	04f05c63          	blez	a5,80003222 <log_write+0x94>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800031ce:	4781                	li	a5,0
    800031d0:	04c05f63          	blez	a2,8000322e <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800031d4:	44cc                	lw	a1,12(s1)
    800031d6:	00017717          	auipc	a4,0x17
    800031da:	36a70713          	addi	a4,a4,874 # 8001a540 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800031de:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800031e0:	4314                	lw	a3,0(a4)
    800031e2:	04b68663          	beq	a3,a1,8000322e <log_write+0xa0>
  for (i = 0; i < log.lh.n; i++) {
    800031e6:	2785                	addiw	a5,a5,1
    800031e8:	0711                	addi	a4,a4,4
    800031ea:	fef61be3          	bne	a2,a5,800031e0 <log_write+0x52>
      break;
  }
  log.lh.block[i] = b->blockno;
    800031ee:	0621                	addi	a2,a2,8
    800031f0:	060a                	slli	a2,a2,0x2
    800031f2:	00017797          	auipc	a5,0x17
    800031f6:	31e78793          	addi	a5,a5,798 # 8001a510 <log>
    800031fa:	97b2                	add	a5,a5,a2
    800031fc:	44d8                	lw	a4,12(s1)
    800031fe:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003200:	8526                	mv	a0,s1
    80003202:	fcbfe0ef          	jal	800021cc <bpin>
    log.lh.n++;
    80003206:	00017717          	auipc	a4,0x17
    8000320a:	30a70713          	addi	a4,a4,778 # 8001a510 <log>
    8000320e:	575c                	lw	a5,44(a4)
    80003210:	2785                	addiw	a5,a5,1
    80003212:	d75c                	sw	a5,44(a4)
    80003214:	a80d                	j	80003246 <log_write+0xb8>
    panic("too big a transaction");
    80003216:	00004517          	auipc	a0,0x4
    8000321a:	30a50513          	addi	a0,a0,778 # 80007520 <etext+0x520>
    8000321e:	304020ef          	jal	80005522 <panic>
    panic("log_write outside of trans");
    80003222:	00004517          	auipc	a0,0x4
    80003226:	31650513          	addi	a0,a0,790 # 80007538 <etext+0x538>
    8000322a:	2f8020ef          	jal	80005522 <panic>
  log.lh.block[i] = b->blockno;
    8000322e:	00878693          	addi	a3,a5,8
    80003232:	068a                	slli	a3,a3,0x2
    80003234:	00017717          	auipc	a4,0x17
    80003238:	2dc70713          	addi	a4,a4,732 # 8001a510 <log>
    8000323c:	9736                	add	a4,a4,a3
    8000323e:	44d4                	lw	a3,12(s1)
    80003240:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003242:	faf60fe3          	beq	a2,a5,80003200 <log_write+0x72>
  }
  release(&log.lock);
    80003246:	00017517          	auipc	a0,0x17
    8000324a:	2ca50513          	addi	a0,a0,714 # 8001a510 <log>
    8000324e:	69a020ef          	jal	800058e8 <release>
}
    80003252:	60e2                	ld	ra,24(sp)
    80003254:	6442                	ld	s0,16(sp)
    80003256:	64a2                	ld	s1,8(sp)
    80003258:	6902                	ld	s2,0(sp)
    8000325a:	6105                	addi	sp,sp,32
    8000325c:	8082                	ret

000000008000325e <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000325e:	1101                	addi	sp,sp,-32
    80003260:	ec06                	sd	ra,24(sp)
    80003262:	e822                	sd	s0,16(sp)
    80003264:	e426                	sd	s1,8(sp)
    80003266:	e04a                	sd	s2,0(sp)
    80003268:	1000                	addi	s0,sp,32
    8000326a:	84aa                	mv	s1,a0
    8000326c:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    8000326e:	00004597          	auipc	a1,0x4
    80003272:	2ea58593          	addi	a1,a1,746 # 80007558 <etext+0x558>
    80003276:	0521                	addi	a0,a0,8
    80003278:	558020ef          	jal	800057d0 <initlock>
  lk->name = name;
    8000327c:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003280:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003284:	0204a423          	sw	zero,40(s1)
}
    80003288:	60e2                	ld	ra,24(sp)
    8000328a:	6442                	ld	s0,16(sp)
    8000328c:	64a2                	ld	s1,8(sp)
    8000328e:	6902                	ld	s2,0(sp)
    80003290:	6105                	addi	sp,sp,32
    80003292:	8082                	ret

0000000080003294 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003294:	1101                	addi	sp,sp,-32
    80003296:	ec06                	sd	ra,24(sp)
    80003298:	e822                	sd	s0,16(sp)
    8000329a:	e426                	sd	s1,8(sp)
    8000329c:	e04a                	sd	s2,0(sp)
    8000329e:	1000                	addi	s0,sp,32
    800032a0:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800032a2:	00850913          	addi	s2,a0,8
    800032a6:	854a                	mv	a0,s2
    800032a8:	5a8020ef          	jal	80005850 <acquire>
  while (lk->locked) {
    800032ac:	409c                	lw	a5,0(s1)
    800032ae:	c799                	beqz	a5,800032bc <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    800032b0:	85ca                	mv	a1,s2
    800032b2:	8526                	mv	a0,s1
    800032b4:	95afe0ef          	jal	8000140e <sleep>
  while (lk->locked) {
    800032b8:	409c                	lw	a5,0(s1)
    800032ba:	fbfd                	bnez	a5,800032b0 <acquiresleep+0x1c>
  }
  lk->locked = 1;
    800032bc:	4785                	li	a5,1
    800032be:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800032c0:	ae1fd0ef          	jal	80000da0 <myproc>
    800032c4:	591c                	lw	a5,48(a0)
    800032c6:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800032c8:	854a                	mv	a0,s2
    800032ca:	61e020ef          	jal	800058e8 <release>
}
    800032ce:	60e2                	ld	ra,24(sp)
    800032d0:	6442                	ld	s0,16(sp)
    800032d2:	64a2                	ld	s1,8(sp)
    800032d4:	6902                	ld	s2,0(sp)
    800032d6:	6105                	addi	sp,sp,32
    800032d8:	8082                	ret

00000000800032da <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800032da:	1101                	addi	sp,sp,-32
    800032dc:	ec06                	sd	ra,24(sp)
    800032de:	e822                	sd	s0,16(sp)
    800032e0:	e426                	sd	s1,8(sp)
    800032e2:	e04a                	sd	s2,0(sp)
    800032e4:	1000                	addi	s0,sp,32
    800032e6:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800032e8:	00850913          	addi	s2,a0,8
    800032ec:	854a                	mv	a0,s2
    800032ee:	562020ef          	jal	80005850 <acquire>
  lk->locked = 0;
    800032f2:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800032f6:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800032fa:	8526                	mv	a0,s1
    800032fc:	95efe0ef          	jal	8000145a <wakeup>
  release(&lk->lk);
    80003300:	854a                	mv	a0,s2
    80003302:	5e6020ef          	jal	800058e8 <release>
}
    80003306:	60e2                	ld	ra,24(sp)
    80003308:	6442                	ld	s0,16(sp)
    8000330a:	64a2                	ld	s1,8(sp)
    8000330c:	6902                	ld	s2,0(sp)
    8000330e:	6105                	addi	sp,sp,32
    80003310:	8082                	ret

0000000080003312 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003312:	7179                	addi	sp,sp,-48
    80003314:	f406                	sd	ra,40(sp)
    80003316:	f022                	sd	s0,32(sp)
    80003318:	ec26                	sd	s1,24(sp)
    8000331a:	e84a                	sd	s2,16(sp)
    8000331c:	1800                	addi	s0,sp,48
    8000331e:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003320:	00850913          	addi	s2,a0,8
    80003324:	854a                	mv	a0,s2
    80003326:	52a020ef          	jal	80005850 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    8000332a:	409c                	lw	a5,0(s1)
    8000332c:	ef81                	bnez	a5,80003344 <holdingsleep+0x32>
    8000332e:	4481                	li	s1,0
  release(&lk->lk);
    80003330:	854a                	mv	a0,s2
    80003332:	5b6020ef          	jal	800058e8 <release>
  return r;
}
    80003336:	8526                	mv	a0,s1
    80003338:	70a2                	ld	ra,40(sp)
    8000333a:	7402                	ld	s0,32(sp)
    8000333c:	64e2                	ld	s1,24(sp)
    8000333e:	6942                	ld	s2,16(sp)
    80003340:	6145                	addi	sp,sp,48
    80003342:	8082                	ret
    80003344:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    80003346:	0284a983          	lw	s3,40(s1)
    8000334a:	a57fd0ef          	jal	80000da0 <myproc>
    8000334e:	5904                	lw	s1,48(a0)
    80003350:	413484b3          	sub	s1,s1,s3
    80003354:	0014b493          	seqz	s1,s1
    80003358:	69a2                	ld	s3,8(sp)
    8000335a:	bfd9                	j	80003330 <holdingsleep+0x1e>

000000008000335c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000335c:	1141                	addi	sp,sp,-16
    8000335e:	e406                	sd	ra,8(sp)
    80003360:	e022                	sd	s0,0(sp)
    80003362:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003364:	00004597          	auipc	a1,0x4
    80003368:	20458593          	addi	a1,a1,516 # 80007568 <etext+0x568>
    8000336c:	00017517          	auipc	a0,0x17
    80003370:	2ec50513          	addi	a0,a0,748 # 8001a658 <ftable>
    80003374:	45c020ef          	jal	800057d0 <initlock>
}
    80003378:	60a2                	ld	ra,8(sp)
    8000337a:	6402                	ld	s0,0(sp)
    8000337c:	0141                	addi	sp,sp,16
    8000337e:	8082                	ret

0000000080003380 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003380:	1101                	addi	sp,sp,-32
    80003382:	ec06                	sd	ra,24(sp)
    80003384:	e822                	sd	s0,16(sp)
    80003386:	e426                	sd	s1,8(sp)
    80003388:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000338a:	00017517          	auipc	a0,0x17
    8000338e:	2ce50513          	addi	a0,a0,718 # 8001a658 <ftable>
    80003392:	4be020ef          	jal	80005850 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003396:	00017497          	auipc	s1,0x17
    8000339a:	2da48493          	addi	s1,s1,730 # 8001a670 <ftable+0x18>
    8000339e:	00018717          	auipc	a4,0x18
    800033a2:	27270713          	addi	a4,a4,626 # 8001b610 <disk>
    if(f->ref == 0){
    800033a6:	40dc                	lw	a5,4(s1)
    800033a8:	cf89                	beqz	a5,800033c2 <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800033aa:	02848493          	addi	s1,s1,40
    800033ae:	fee49ce3          	bne	s1,a4,800033a6 <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800033b2:	00017517          	auipc	a0,0x17
    800033b6:	2a650513          	addi	a0,a0,678 # 8001a658 <ftable>
    800033ba:	52e020ef          	jal	800058e8 <release>
  return 0;
    800033be:	4481                	li	s1,0
    800033c0:	a809                	j	800033d2 <filealloc+0x52>
      f->ref = 1;
    800033c2:	4785                	li	a5,1
    800033c4:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800033c6:	00017517          	auipc	a0,0x17
    800033ca:	29250513          	addi	a0,a0,658 # 8001a658 <ftable>
    800033ce:	51a020ef          	jal	800058e8 <release>
}
    800033d2:	8526                	mv	a0,s1
    800033d4:	60e2                	ld	ra,24(sp)
    800033d6:	6442                	ld	s0,16(sp)
    800033d8:	64a2                	ld	s1,8(sp)
    800033da:	6105                	addi	sp,sp,32
    800033dc:	8082                	ret

00000000800033de <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800033de:	1101                	addi	sp,sp,-32
    800033e0:	ec06                	sd	ra,24(sp)
    800033e2:	e822                	sd	s0,16(sp)
    800033e4:	e426                	sd	s1,8(sp)
    800033e6:	1000                	addi	s0,sp,32
    800033e8:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800033ea:	00017517          	auipc	a0,0x17
    800033ee:	26e50513          	addi	a0,a0,622 # 8001a658 <ftable>
    800033f2:	45e020ef          	jal	80005850 <acquire>
  if(f->ref < 1)
    800033f6:	40dc                	lw	a5,4(s1)
    800033f8:	02f05063          	blez	a5,80003418 <filedup+0x3a>
    panic("filedup");
  f->ref++;
    800033fc:	2785                	addiw	a5,a5,1
    800033fe:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003400:	00017517          	auipc	a0,0x17
    80003404:	25850513          	addi	a0,a0,600 # 8001a658 <ftable>
    80003408:	4e0020ef          	jal	800058e8 <release>
  return f;
}
    8000340c:	8526                	mv	a0,s1
    8000340e:	60e2                	ld	ra,24(sp)
    80003410:	6442                	ld	s0,16(sp)
    80003412:	64a2                	ld	s1,8(sp)
    80003414:	6105                	addi	sp,sp,32
    80003416:	8082                	ret
    panic("filedup");
    80003418:	00004517          	auipc	a0,0x4
    8000341c:	15850513          	addi	a0,a0,344 # 80007570 <etext+0x570>
    80003420:	102020ef          	jal	80005522 <panic>

0000000080003424 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003424:	7139                	addi	sp,sp,-64
    80003426:	fc06                	sd	ra,56(sp)
    80003428:	f822                	sd	s0,48(sp)
    8000342a:	f426                	sd	s1,40(sp)
    8000342c:	0080                	addi	s0,sp,64
    8000342e:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003430:	00017517          	auipc	a0,0x17
    80003434:	22850513          	addi	a0,a0,552 # 8001a658 <ftable>
    80003438:	418020ef          	jal	80005850 <acquire>
  if(f->ref < 1)
    8000343c:	40dc                	lw	a5,4(s1)
    8000343e:	04f05a63          	blez	a5,80003492 <fileclose+0x6e>
    panic("fileclose");
  if(--f->ref > 0){
    80003442:	37fd                	addiw	a5,a5,-1
    80003444:	0007871b          	sext.w	a4,a5
    80003448:	c0dc                	sw	a5,4(s1)
    8000344a:	04e04e63          	bgtz	a4,800034a6 <fileclose+0x82>
    8000344e:	f04a                	sd	s2,32(sp)
    80003450:	ec4e                	sd	s3,24(sp)
    80003452:	e852                	sd	s4,16(sp)
    80003454:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003456:	0004a903          	lw	s2,0(s1)
    8000345a:	0094ca83          	lbu	s5,9(s1)
    8000345e:	0104ba03          	ld	s4,16(s1)
    80003462:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003466:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000346a:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000346e:	00017517          	auipc	a0,0x17
    80003472:	1ea50513          	addi	a0,a0,490 # 8001a658 <ftable>
    80003476:	472020ef          	jal	800058e8 <release>

  if(ff.type == FD_PIPE){
    8000347a:	4785                	li	a5,1
    8000347c:	04f90063          	beq	s2,a5,800034bc <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003480:	3979                	addiw	s2,s2,-2
    80003482:	4785                	li	a5,1
    80003484:	0527f563          	bgeu	a5,s2,800034ce <fileclose+0xaa>
    80003488:	7902                	ld	s2,32(sp)
    8000348a:	69e2                	ld	s3,24(sp)
    8000348c:	6a42                	ld	s4,16(sp)
    8000348e:	6aa2                	ld	s5,8(sp)
    80003490:	a00d                	j	800034b2 <fileclose+0x8e>
    80003492:	f04a                	sd	s2,32(sp)
    80003494:	ec4e                	sd	s3,24(sp)
    80003496:	e852                	sd	s4,16(sp)
    80003498:	e456                	sd	s5,8(sp)
    panic("fileclose");
    8000349a:	00004517          	auipc	a0,0x4
    8000349e:	0de50513          	addi	a0,a0,222 # 80007578 <etext+0x578>
    800034a2:	080020ef          	jal	80005522 <panic>
    release(&ftable.lock);
    800034a6:	00017517          	auipc	a0,0x17
    800034aa:	1b250513          	addi	a0,a0,434 # 8001a658 <ftable>
    800034ae:	43a020ef          	jal	800058e8 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    800034b2:	70e2                	ld	ra,56(sp)
    800034b4:	7442                	ld	s0,48(sp)
    800034b6:	74a2                	ld	s1,40(sp)
    800034b8:	6121                	addi	sp,sp,64
    800034ba:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800034bc:	85d6                	mv	a1,s5
    800034be:	8552                	mv	a0,s4
    800034c0:	336000ef          	jal	800037f6 <pipeclose>
    800034c4:	7902                	ld	s2,32(sp)
    800034c6:	69e2                	ld	s3,24(sp)
    800034c8:	6a42                	ld	s4,16(sp)
    800034ca:	6aa2                	ld	s5,8(sp)
    800034cc:	b7dd                	j	800034b2 <fileclose+0x8e>
    begin_op();
    800034ce:	b3dff0ef          	jal	8000300a <begin_op>
    iput(ff.ip);
    800034d2:	854e                	mv	a0,s3
    800034d4:	c22ff0ef          	jal	800028f6 <iput>
    end_op();
    800034d8:	b9dff0ef          	jal	80003074 <end_op>
    800034dc:	7902                	ld	s2,32(sp)
    800034de:	69e2                	ld	s3,24(sp)
    800034e0:	6a42                	ld	s4,16(sp)
    800034e2:	6aa2                	ld	s5,8(sp)
    800034e4:	b7f9                	j	800034b2 <fileclose+0x8e>

00000000800034e6 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800034e6:	715d                	addi	sp,sp,-80
    800034e8:	e486                	sd	ra,72(sp)
    800034ea:	e0a2                	sd	s0,64(sp)
    800034ec:	fc26                	sd	s1,56(sp)
    800034ee:	f44e                	sd	s3,40(sp)
    800034f0:	0880                	addi	s0,sp,80
    800034f2:	84aa                	mv	s1,a0
    800034f4:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    800034f6:	8abfd0ef          	jal	80000da0 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    800034fa:	409c                	lw	a5,0(s1)
    800034fc:	37f9                	addiw	a5,a5,-2
    800034fe:	4705                	li	a4,1
    80003500:	04f76063          	bltu	a4,a5,80003540 <filestat+0x5a>
    80003504:	f84a                	sd	s2,48(sp)
    80003506:	892a                	mv	s2,a0
    ilock(f->ip);
    80003508:	6c88                	ld	a0,24(s1)
    8000350a:	a6aff0ef          	jal	80002774 <ilock>
    stati(f->ip, &st);
    8000350e:	fb840593          	addi	a1,s0,-72
    80003512:	6c88                	ld	a0,24(s1)
    80003514:	c8aff0ef          	jal	8000299e <stati>
    iunlock(f->ip);
    80003518:	6c88                	ld	a0,24(s1)
    8000351a:	b08ff0ef          	jal	80002822 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    8000351e:	46e1                	li	a3,24
    80003520:	fb840613          	addi	a2,s0,-72
    80003524:	85ce                	mv	a1,s3
    80003526:	05093503          	ld	a0,80(s2)
    8000352a:	cc8fd0ef          	jal	800009f2 <copyout>
    8000352e:	41f5551b          	sraiw	a0,a0,0x1f
    80003532:	7942                	ld	s2,48(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003534:	60a6                	ld	ra,72(sp)
    80003536:	6406                	ld	s0,64(sp)
    80003538:	74e2                	ld	s1,56(sp)
    8000353a:	79a2                	ld	s3,40(sp)
    8000353c:	6161                	addi	sp,sp,80
    8000353e:	8082                	ret
  return -1;
    80003540:	557d                	li	a0,-1
    80003542:	bfcd                	j	80003534 <filestat+0x4e>

0000000080003544 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003544:	7179                	addi	sp,sp,-48
    80003546:	f406                	sd	ra,40(sp)
    80003548:	f022                	sd	s0,32(sp)
    8000354a:	e84a                	sd	s2,16(sp)
    8000354c:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    8000354e:	00854783          	lbu	a5,8(a0)
    80003552:	cfd1                	beqz	a5,800035ee <fileread+0xaa>
    80003554:	ec26                	sd	s1,24(sp)
    80003556:	e44e                	sd	s3,8(sp)
    80003558:	84aa                	mv	s1,a0
    8000355a:	89ae                	mv	s3,a1
    8000355c:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    8000355e:	411c                	lw	a5,0(a0)
    80003560:	4705                	li	a4,1
    80003562:	04e78363          	beq	a5,a4,800035a8 <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003566:	470d                	li	a4,3
    80003568:	04e78763          	beq	a5,a4,800035b6 <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    8000356c:	4709                	li	a4,2
    8000356e:	06e79a63          	bne	a5,a4,800035e2 <fileread+0x9e>
    ilock(f->ip);
    80003572:	6d08                	ld	a0,24(a0)
    80003574:	a00ff0ef          	jal	80002774 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003578:	874a                	mv	a4,s2
    8000357a:	5094                	lw	a3,32(s1)
    8000357c:	864e                	mv	a2,s3
    8000357e:	4585                	li	a1,1
    80003580:	6c88                	ld	a0,24(s1)
    80003582:	c46ff0ef          	jal	800029c8 <readi>
    80003586:	892a                	mv	s2,a0
    80003588:	00a05563          	blez	a0,80003592 <fileread+0x4e>
      f->off += r;
    8000358c:	509c                	lw	a5,32(s1)
    8000358e:	9fa9                	addw	a5,a5,a0
    80003590:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003592:	6c88                	ld	a0,24(s1)
    80003594:	a8eff0ef          	jal	80002822 <iunlock>
    80003598:	64e2                	ld	s1,24(sp)
    8000359a:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    8000359c:	854a                	mv	a0,s2
    8000359e:	70a2                	ld	ra,40(sp)
    800035a0:	7402                	ld	s0,32(sp)
    800035a2:	6942                	ld	s2,16(sp)
    800035a4:	6145                	addi	sp,sp,48
    800035a6:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800035a8:	6908                	ld	a0,16(a0)
    800035aa:	388000ef          	jal	80003932 <piperead>
    800035ae:	892a                	mv	s2,a0
    800035b0:	64e2                	ld	s1,24(sp)
    800035b2:	69a2                	ld	s3,8(sp)
    800035b4:	b7e5                	j	8000359c <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800035b6:	02451783          	lh	a5,36(a0)
    800035ba:	03079693          	slli	a3,a5,0x30
    800035be:	92c1                	srli	a3,a3,0x30
    800035c0:	4725                	li	a4,9
    800035c2:	02d76863          	bltu	a4,a3,800035f2 <fileread+0xae>
    800035c6:	0792                	slli	a5,a5,0x4
    800035c8:	00017717          	auipc	a4,0x17
    800035cc:	ff070713          	addi	a4,a4,-16 # 8001a5b8 <devsw>
    800035d0:	97ba                	add	a5,a5,a4
    800035d2:	639c                	ld	a5,0(a5)
    800035d4:	c39d                	beqz	a5,800035fa <fileread+0xb6>
    r = devsw[f->major].read(1, addr, n);
    800035d6:	4505                	li	a0,1
    800035d8:	9782                	jalr	a5
    800035da:	892a                	mv	s2,a0
    800035dc:	64e2                	ld	s1,24(sp)
    800035de:	69a2                	ld	s3,8(sp)
    800035e0:	bf75                	j	8000359c <fileread+0x58>
    panic("fileread");
    800035e2:	00004517          	auipc	a0,0x4
    800035e6:	fa650513          	addi	a0,a0,-90 # 80007588 <etext+0x588>
    800035ea:	739010ef          	jal	80005522 <panic>
    return -1;
    800035ee:	597d                	li	s2,-1
    800035f0:	b775                	j	8000359c <fileread+0x58>
      return -1;
    800035f2:	597d                	li	s2,-1
    800035f4:	64e2                	ld	s1,24(sp)
    800035f6:	69a2                	ld	s3,8(sp)
    800035f8:	b755                	j	8000359c <fileread+0x58>
    800035fa:	597d                	li	s2,-1
    800035fc:	64e2                	ld	s1,24(sp)
    800035fe:	69a2                	ld	s3,8(sp)
    80003600:	bf71                	j	8000359c <fileread+0x58>

0000000080003602 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003602:	00954783          	lbu	a5,9(a0)
    80003606:	10078b63          	beqz	a5,8000371c <filewrite+0x11a>
{
    8000360a:	715d                	addi	sp,sp,-80
    8000360c:	e486                	sd	ra,72(sp)
    8000360e:	e0a2                	sd	s0,64(sp)
    80003610:	f84a                	sd	s2,48(sp)
    80003612:	f052                	sd	s4,32(sp)
    80003614:	e85a                	sd	s6,16(sp)
    80003616:	0880                	addi	s0,sp,80
    80003618:	892a                	mv	s2,a0
    8000361a:	8b2e                	mv	s6,a1
    8000361c:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    8000361e:	411c                	lw	a5,0(a0)
    80003620:	4705                	li	a4,1
    80003622:	02e78763          	beq	a5,a4,80003650 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003626:	470d                	li	a4,3
    80003628:	02e78863          	beq	a5,a4,80003658 <filewrite+0x56>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    8000362c:	4709                	li	a4,2
    8000362e:	0ce79c63          	bne	a5,a4,80003706 <filewrite+0x104>
    80003632:	f44e                	sd	s3,40(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003634:	0ac05863          	blez	a2,800036e4 <filewrite+0xe2>
    80003638:	fc26                	sd	s1,56(sp)
    8000363a:	ec56                	sd	s5,24(sp)
    8000363c:	e45e                	sd	s7,8(sp)
    8000363e:	e062                	sd	s8,0(sp)
    int i = 0;
    80003640:	4981                	li	s3,0
      int n1 = n - i;
      if(n1 > max)
    80003642:	6b85                	lui	s7,0x1
    80003644:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003648:	6c05                	lui	s8,0x1
    8000364a:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    8000364e:	a8b5                	j	800036ca <filewrite+0xc8>
    ret = pipewrite(f->pipe, addr, n);
    80003650:	6908                	ld	a0,16(a0)
    80003652:	1fc000ef          	jal	8000384e <pipewrite>
    80003656:	a04d                	j	800036f8 <filewrite+0xf6>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003658:	02451783          	lh	a5,36(a0)
    8000365c:	03079693          	slli	a3,a5,0x30
    80003660:	92c1                	srli	a3,a3,0x30
    80003662:	4725                	li	a4,9
    80003664:	0ad76e63          	bltu	a4,a3,80003720 <filewrite+0x11e>
    80003668:	0792                	slli	a5,a5,0x4
    8000366a:	00017717          	auipc	a4,0x17
    8000366e:	f4e70713          	addi	a4,a4,-178 # 8001a5b8 <devsw>
    80003672:	97ba                	add	a5,a5,a4
    80003674:	679c                	ld	a5,8(a5)
    80003676:	c7dd                	beqz	a5,80003724 <filewrite+0x122>
    ret = devsw[f->major].write(1, addr, n);
    80003678:	4505                	li	a0,1
    8000367a:	9782                	jalr	a5
    8000367c:	a8b5                	j	800036f8 <filewrite+0xf6>
      if(n1 > max)
    8000367e:	00048a9b          	sext.w	s5,s1
        n1 = max;

      begin_op();
    80003682:	989ff0ef          	jal	8000300a <begin_op>
      ilock(f->ip);
    80003686:	01893503          	ld	a0,24(s2)
    8000368a:	8eaff0ef          	jal	80002774 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    8000368e:	8756                	mv	a4,s5
    80003690:	02092683          	lw	a3,32(s2)
    80003694:	01698633          	add	a2,s3,s6
    80003698:	4585                	li	a1,1
    8000369a:	01893503          	ld	a0,24(s2)
    8000369e:	c26ff0ef          	jal	80002ac4 <writei>
    800036a2:	84aa                	mv	s1,a0
    800036a4:	00a05763          	blez	a0,800036b2 <filewrite+0xb0>
        f->off += r;
    800036a8:	02092783          	lw	a5,32(s2)
    800036ac:	9fa9                	addw	a5,a5,a0
    800036ae:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    800036b2:	01893503          	ld	a0,24(s2)
    800036b6:	96cff0ef          	jal	80002822 <iunlock>
      end_op();
    800036ba:	9bbff0ef          	jal	80003074 <end_op>

      if(r != n1){
    800036be:	029a9563          	bne	s5,s1,800036e8 <filewrite+0xe6>
        // error from writei
        break;
      }
      i += r;
    800036c2:	013489bb          	addw	s3,s1,s3
    while(i < n){
    800036c6:	0149da63          	bge	s3,s4,800036da <filewrite+0xd8>
      int n1 = n - i;
    800036ca:	413a04bb          	subw	s1,s4,s3
      if(n1 > max)
    800036ce:	0004879b          	sext.w	a5,s1
    800036d2:	fafbd6e3          	bge	s7,a5,8000367e <filewrite+0x7c>
    800036d6:	84e2                	mv	s1,s8
    800036d8:	b75d                	j	8000367e <filewrite+0x7c>
    800036da:	74e2                	ld	s1,56(sp)
    800036dc:	6ae2                	ld	s5,24(sp)
    800036de:	6ba2                	ld	s7,8(sp)
    800036e0:	6c02                	ld	s8,0(sp)
    800036e2:	a039                	j	800036f0 <filewrite+0xee>
    int i = 0;
    800036e4:	4981                	li	s3,0
    800036e6:	a029                	j	800036f0 <filewrite+0xee>
    800036e8:	74e2                	ld	s1,56(sp)
    800036ea:	6ae2                	ld	s5,24(sp)
    800036ec:	6ba2                	ld	s7,8(sp)
    800036ee:	6c02                	ld	s8,0(sp)
    }
    ret = (i == n ? n : -1);
    800036f0:	033a1c63          	bne	s4,s3,80003728 <filewrite+0x126>
    800036f4:	8552                	mv	a0,s4
    800036f6:	79a2                	ld	s3,40(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    800036f8:	60a6                	ld	ra,72(sp)
    800036fa:	6406                	ld	s0,64(sp)
    800036fc:	7942                	ld	s2,48(sp)
    800036fe:	7a02                	ld	s4,32(sp)
    80003700:	6b42                	ld	s6,16(sp)
    80003702:	6161                	addi	sp,sp,80
    80003704:	8082                	ret
    80003706:	fc26                	sd	s1,56(sp)
    80003708:	f44e                	sd	s3,40(sp)
    8000370a:	ec56                	sd	s5,24(sp)
    8000370c:	e45e                	sd	s7,8(sp)
    8000370e:	e062                	sd	s8,0(sp)
    panic("filewrite");
    80003710:	00004517          	auipc	a0,0x4
    80003714:	e8850513          	addi	a0,a0,-376 # 80007598 <etext+0x598>
    80003718:	60b010ef          	jal	80005522 <panic>
    return -1;
    8000371c:	557d                	li	a0,-1
}
    8000371e:	8082                	ret
      return -1;
    80003720:	557d                	li	a0,-1
    80003722:	bfd9                	j	800036f8 <filewrite+0xf6>
    80003724:	557d                	li	a0,-1
    80003726:	bfc9                	j	800036f8 <filewrite+0xf6>
    ret = (i == n ? n : -1);
    80003728:	557d                	li	a0,-1
    8000372a:	79a2                	ld	s3,40(sp)
    8000372c:	b7f1                	j	800036f8 <filewrite+0xf6>

000000008000372e <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000372e:	7179                	addi	sp,sp,-48
    80003730:	f406                	sd	ra,40(sp)
    80003732:	f022                	sd	s0,32(sp)
    80003734:	ec26                	sd	s1,24(sp)
    80003736:	e052                	sd	s4,0(sp)
    80003738:	1800                	addi	s0,sp,48
    8000373a:	84aa                	mv	s1,a0
    8000373c:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    8000373e:	0005b023          	sd	zero,0(a1)
    80003742:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003746:	c3bff0ef          	jal	80003380 <filealloc>
    8000374a:	e088                	sd	a0,0(s1)
    8000374c:	c549                	beqz	a0,800037d6 <pipealloc+0xa8>
    8000374e:	c33ff0ef          	jal	80003380 <filealloc>
    80003752:	00aa3023          	sd	a0,0(s4)
    80003756:	cd25                	beqz	a0,800037ce <pipealloc+0xa0>
    80003758:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    8000375a:	9a5fc0ef          	jal	800000fe <kalloc>
    8000375e:	892a                	mv	s2,a0
    80003760:	c12d                	beqz	a0,800037c2 <pipealloc+0x94>
    80003762:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003764:	4985                	li	s3,1
    80003766:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    8000376a:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    8000376e:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003772:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003776:	00004597          	auipc	a1,0x4
    8000377a:	e3258593          	addi	a1,a1,-462 # 800075a8 <etext+0x5a8>
    8000377e:	052020ef          	jal	800057d0 <initlock>
  (*f0)->type = FD_PIPE;
    80003782:	609c                	ld	a5,0(s1)
    80003784:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003788:	609c                	ld	a5,0(s1)
    8000378a:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    8000378e:	609c                	ld	a5,0(s1)
    80003790:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003794:	609c                	ld	a5,0(s1)
    80003796:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    8000379a:	000a3783          	ld	a5,0(s4)
    8000379e:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    800037a2:	000a3783          	ld	a5,0(s4)
    800037a6:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800037aa:	000a3783          	ld	a5,0(s4)
    800037ae:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    800037b2:	000a3783          	ld	a5,0(s4)
    800037b6:	0127b823          	sd	s2,16(a5)
  return 0;
    800037ba:	4501                	li	a0,0
    800037bc:	6942                	ld	s2,16(sp)
    800037be:	69a2                	ld	s3,8(sp)
    800037c0:	a01d                	j	800037e6 <pipealloc+0xb8>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    800037c2:	6088                	ld	a0,0(s1)
    800037c4:	c119                	beqz	a0,800037ca <pipealloc+0x9c>
    800037c6:	6942                	ld	s2,16(sp)
    800037c8:	a029                	j	800037d2 <pipealloc+0xa4>
    800037ca:	6942                	ld	s2,16(sp)
    800037cc:	a029                	j	800037d6 <pipealloc+0xa8>
    800037ce:	6088                	ld	a0,0(s1)
    800037d0:	c10d                	beqz	a0,800037f2 <pipealloc+0xc4>
    fileclose(*f0);
    800037d2:	c53ff0ef          	jal	80003424 <fileclose>
  if(*f1)
    800037d6:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    800037da:	557d                	li	a0,-1
  if(*f1)
    800037dc:	c789                	beqz	a5,800037e6 <pipealloc+0xb8>
    fileclose(*f1);
    800037de:	853e                	mv	a0,a5
    800037e0:	c45ff0ef          	jal	80003424 <fileclose>
  return -1;
    800037e4:	557d                	li	a0,-1
}
    800037e6:	70a2                	ld	ra,40(sp)
    800037e8:	7402                	ld	s0,32(sp)
    800037ea:	64e2                	ld	s1,24(sp)
    800037ec:	6a02                	ld	s4,0(sp)
    800037ee:	6145                	addi	sp,sp,48
    800037f0:	8082                	ret
  return -1;
    800037f2:	557d                	li	a0,-1
    800037f4:	bfcd                	j	800037e6 <pipealloc+0xb8>

00000000800037f6 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    800037f6:	1101                	addi	sp,sp,-32
    800037f8:	ec06                	sd	ra,24(sp)
    800037fa:	e822                	sd	s0,16(sp)
    800037fc:	e426                	sd	s1,8(sp)
    800037fe:	e04a                	sd	s2,0(sp)
    80003800:	1000                	addi	s0,sp,32
    80003802:	84aa                	mv	s1,a0
    80003804:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003806:	04a020ef          	jal	80005850 <acquire>
  if(writable){
    8000380a:	02090763          	beqz	s2,80003838 <pipeclose+0x42>
    pi->writeopen = 0;
    8000380e:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003812:	21848513          	addi	a0,s1,536
    80003816:	c45fd0ef          	jal	8000145a <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    8000381a:	2204b783          	ld	a5,544(s1)
    8000381e:	e785                	bnez	a5,80003846 <pipeclose+0x50>
    release(&pi->lock);
    80003820:	8526                	mv	a0,s1
    80003822:	0c6020ef          	jal	800058e8 <release>
    kfree((char*)pi);
    80003826:	8526                	mv	a0,s1
    80003828:	ff4fc0ef          	jal	8000001c <kfree>
  } else
    release(&pi->lock);
}
    8000382c:	60e2                	ld	ra,24(sp)
    8000382e:	6442                	ld	s0,16(sp)
    80003830:	64a2                	ld	s1,8(sp)
    80003832:	6902                	ld	s2,0(sp)
    80003834:	6105                	addi	sp,sp,32
    80003836:	8082                	ret
    pi->readopen = 0;
    80003838:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    8000383c:	21c48513          	addi	a0,s1,540
    80003840:	c1bfd0ef          	jal	8000145a <wakeup>
    80003844:	bfd9                	j	8000381a <pipeclose+0x24>
    release(&pi->lock);
    80003846:	8526                	mv	a0,s1
    80003848:	0a0020ef          	jal	800058e8 <release>
}
    8000384c:	b7c5                	j	8000382c <pipeclose+0x36>

000000008000384e <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000384e:	711d                	addi	sp,sp,-96
    80003850:	ec86                	sd	ra,88(sp)
    80003852:	e8a2                	sd	s0,80(sp)
    80003854:	e4a6                	sd	s1,72(sp)
    80003856:	e0ca                	sd	s2,64(sp)
    80003858:	fc4e                	sd	s3,56(sp)
    8000385a:	f852                	sd	s4,48(sp)
    8000385c:	f456                	sd	s5,40(sp)
    8000385e:	1080                	addi	s0,sp,96
    80003860:	84aa                	mv	s1,a0
    80003862:	8aae                	mv	s5,a1
    80003864:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003866:	d3afd0ef          	jal	80000da0 <myproc>
    8000386a:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    8000386c:	8526                	mv	a0,s1
    8000386e:	7e3010ef          	jal	80005850 <acquire>
  while(i < n){
    80003872:	0b405a63          	blez	s4,80003926 <pipewrite+0xd8>
    80003876:	f05a                	sd	s6,32(sp)
    80003878:	ec5e                	sd	s7,24(sp)
    8000387a:	e862                	sd	s8,16(sp)
  int i = 0;
    8000387c:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000387e:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003880:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003884:	21c48b93          	addi	s7,s1,540
    80003888:	a81d                	j	800038be <pipewrite+0x70>
      release(&pi->lock);
    8000388a:	8526                	mv	a0,s1
    8000388c:	05c020ef          	jal	800058e8 <release>
      return -1;
    80003890:	597d                	li	s2,-1
    80003892:	7b02                	ld	s6,32(sp)
    80003894:	6be2                	ld	s7,24(sp)
    80003896:	6c42                	ld	s8,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003898:	854a                	mv	a0,s2
    8000389a:	60e6                	ld	ra,88(sp)
    8000389c:	6446                	ld	s0,80(sp)
    8000389e:	64a6                	ld	s1,72(sp)
    800038a0:	6906                	ld	s2,64(sp)
    800038a2:	79e2                	ld	s3,56(sp)
    800038a4:	7a42                	ld	s4,48(sp)
    800038a6:	7aa2                	ld	s5,40(sp)
    800038a8:	6125                	addi	sp,sp,96
    800038aa:	8082                	ret
      wakeup(&pi->nread);
    800038ac:	8562                	mv	a0,s8
    800038ae:	badfd0ef          	jal	8000145a <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800038b2:	85a6                	mv	a1,s1
    800038b4:	855e                	mv	a0,s7
    800038b6:	b59fd0ef          	jal	8000140e <sleep>
  while(i < n){
    800038ba:	05495b63          	bge	s2,s4,80003910 <pipewrite+0xc2>
    if(pi->readopen == 0 || killed(pr)){
    800038be:	2204a783          	lw	a5,544(s1)
    800038c2:	d7e1                	beqz	a5,8000388a <pipewrite+0x3c>
    800038c4:	854e                	mv	a0,s3
    800038c6:	d81fd0ef          	jal	80001646 <killed>
    800038ca:	f161                	bnez	a0,8000388a <pipewrite+0x3c>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800038cc:	2184a783          	lw	a5,536(s1)
    800038d0:	21c4a703          	lw	a4,540(s1)
    800038d4:	2007879b          	addiw	a5,a5,512
    800038d8:	fcf70ae3          	beq	a4,a5,800038ac <pipewrite+0x5e>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800038dc:	4685                	li	a3,1
    800038de:	01590633          	add	a2,s2,s5
    800038e2:	faf40593          	addi	a1,s0,-81
    800038e6:	0509b503          	ld	a0,80(s3)
    800038ea:	9e0fd0ef          	jal	80000aca <copyin>
    800038ee:	03650e63          	beq	a0,s6,8000392a <pipewrite+0xdc>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800038f2:	21c4a783          	lw	a5,540(s1)
    800038f6:	0017871b          	addiw	a4,a5,1
    800038fa:	20e4ae23          	sw	a4,540(s1)
    800038fe:	1ff7f793          	andi	a5,a5,511
    80003902:	97a6                	add	a5,a5,s1
    80003904:	faf44703          	lbu	a4,-81(s0)
    80003908:	00e78c23          	sb	a4,24(a5)
      i++;
    8000390c:	2905                	addiw	s2,s2,1
    8000390e:	b775                	j	800038ba <pipewrite+0x6c>
    80003910:	7b02                	ld	s6,32(sp)
    80003912:	6be2                	ld	s7,24(sp)
    80003914:	6c42                	ld	s8,16(sp)
  wakeup(&pi->nread);
    80003916:	21848513          	addi	a0,s1,536
    8000391a:	b41fd0ef          	jal	8000145a <wakeup>
  release(&pi->lock);
    8000391e:	8526                	mv	a0,s1
    80003920:	7c9010ef          	jal	800058e8 <release>
  return i;
    80003924:	bf95                	j	80003898 <pipewrite+0x4a>
  int i = 0;
    80003926:	4901                	li	s2,0
    80003928:	b7fd                	j	80003916 <pipewrite+0xc8>
    8000392a:	7b02                	ld	s6,32(sp)
    8000392c:	6be2                	ld	s7,24(sp)
    8000392e:	6c42                	ld	s8,16(sp)
    80003930:	b7dd                	j	80003916 <pipewrite+0xc8>

0000000080003932 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003932:	715d                	addi	sp,sp,-80
    80003934:	e486                	sd	ra,72(sp)
    80003936:	e0a2                	sd	s0,64(sp)
    80003938:	fc26                	sd	s1,56(sp)
    8000393a:	f84a                	sd	s2,48(sp)
    8000393c:	f44e                	sd	s3,40(sp)
    8000393e:	f052                	sd	s4,32(sp)
    80003940:	ec56                	sd	s5,24(sp)
    80003942:	0880                	addi	s0,sp,80
    80003944:	84aa                	mv	s1,a0
    80003946:	892e                	mv	s2,a1
    80003948:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    8000394a:	c56fd0ef          	jal	80000da0 <myproc>
    8000394e:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003950:	8526                	mv	a0,s1
    80003952:	6ff010ef          	jal	80005850 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003956:	2184a703          	lw	a4,536(s1)
    8000395a:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000395e:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003962:	02f71563          	bne	a4,a5,8000398c <piperead+0x5a>
    80003966:	2244a783          	lw	a5,548(s1)
    8000396a:	cb85                	beqz	a5,8000399a <piperead+0x68>
    if(killed(pr)){
    8000396c:	8552                	mv	a0,s4
    8000396e:	cd9fd0ef          	jal	80001646 <killed>
    80003972:	ed19                	bnez	a0,80003990 <piperead+0x5e>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003974:	85a6                	mv	a1,s1
    80003976:	854e                	mv	a0,s3
    80003978:	a97fd0ef          	jal	8000140e <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000397c:	2184a703          	lw	a4,536(s1)
    80003980:	21c4a783          	lw	a5,540(s1)
    80003984:	fef701e3          	beq	a4,a5,80003966 <piperead+0x34>
    80003988:	e85a                	sd	s6,16(sp)
    8000398a:	a809                	j	8000399c <piperead+0x6a>
    8000398c:	e85a                	sd	s6,16(sp)
    8000398e:	a039                	j	8000399c <piperead+0x6a>
      release(&pi->lock);
    80003990:	8526                	mv	a0,s1
    80003992:	757010ef          	jal	800058e8 <release>
      return -1;
    80003996:	59fd                	li	s3,-1
    80003998:	a8b1                	j	800039f4 <piperead+0xc2>
    8000399a:	e85a                	sd	s6,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000399c:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000399e:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800039a0:	05505263          	blez	s5,800039e4 <piperead+0xb2>
    if(pi->nread == pi->nwrite)
    800039a4:	2184a783          	lw	a5,536(s1)
    800039a8:	21c4a703          	lw	a4,540(s1)
    800039ac:	02f70c63          	beq	a4,a5,800039e4 <piperead+0xb2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    800039b0:	0017871b          	addiw	a4,a5,1
    800039b4:	20e4ac23          	sw	a4,536(s1)
    800039b8:	1ff7f793          	andi	a5,a5,511
    800039bc:	97a6                	add	a5,a5,s1
    800039be:	0187c783          	lbu	a5,24(a5)
    800039c2:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800039c6:	4685                	li	a3,1
    800039c8:	fbf40613          	addi	a2,s0,-65
    800039cc:	85ca                	mv	a1,s2
    800039ce:	050a3503          	ld	a0,80(s4)
    800039d2:	820fd0ef          	jal	800009f2 <copyout>
    800039d6:	01650763          	beq	a0,s6,800039e4 <piperead+0xb2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800039da:	2985                	addiw	s3,s3,1
    800039dc:	0905                	addi	s2,s2,1
    800039de:	fd3a93e3          	bne	s5,s3,800039a4 <piperead+0x72>
    800039e2:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800039e4:	21c48513          	addi	a0,s1,540
    800039e8:	a73fd0ef          	jal	8000145a <wakeup>
  release(&pi->lock);
    800039ec:	8526                	mv	a0,s1
    800039ee:	6fb010ef          	jal	800058e8 <release>
    800039f2:	6b42                	ld	s6,16(sp)
  return i;
}
    800039f4:	854e                	mv	a0,s3
    800039f6:	60a6                	ld	ra,72(sp)
    800039f8:	6406                	ld	s0,64(sp)
    800039fa:	74e2                	ld	s1,56(sp)
    800039fc:	7942                	ld	s2,48(sp)
    800039fe:	79a2                	ld	s3,40(sp)
    80003a00:	7a02                	ld	s4,32(sp)
    80003a02:	6ae2                	ld	s5,24(sp)
    80003a04:	6161                	addi	sp,sp,80
    80003a06:	8082                	ret

0000000080003a08 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80003a08:	1141                	addi	sp,sp,-16
    80003a0a:	e422                	sd	s0,8(sp)
    80003a0c:	0800                	addi	s0,sp,16
    80003a0e:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80003a10:	8905                	andi	a0,a0,1
    80003a12:	050e                	slli	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    80003a14:	8b89                	andi	a5,a5,2
    80003a16:	c399                	beqz	a5,80003a1c <flags2perm+0x14>
      perm |= PTE_W;
    80003a18:	00456513          	ori	a0,a0,4
    return perm;
}
    80003a1c:	6422                	ld	s0,8(sp)
    80003a1e:	0141                	addi	sp,sp,16
    80003a20:	8082                	ret

0000000080003a22 <exec>:

int
exec(char *path, char **argv)
{
    80003a22:	df010113          	addi	sp,sp,-528
    80003a26:	20113423          	sd	ra,520(sp)
    80003a2a:	20813023          	sd	s0,512(sp)
    80003a2e:	ffa6                	sd	s1,504(sp)
    80003a30:	fbca                	sd	s2,496(sp)
    80003a32:	0c00                	addi	s0,sp,528
    80003a34:	892a                	mv	s2,a0
    80003a36:	dea43c23          	sd	a0,-520(s0)
    80003a3a:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003a3e:	b62fd0ef          	jal	80000da0 <myproc>
    80003a42:	84aa                	mv	s1,a0

  begin_op();
    80003a44:	dc6ff0ef          	jal	8000300a <begin_op>

  if((ip = namei(path)) == 0){
    80003a48:	854a                	mv	a0,s2
    80003a4a:	c04ff0ef          	jal	80002e4e <namei>
    80003a4e:	c931                	beqz	a0,80003aa2 <exec+0x80>
    80003a50:	f3d2                	sd	s4,480(sp)
    80003a52:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003a54:	d21fe0ef          	jal	80002774 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80003a58:	04000713          	li	a4,64
    80003a5c:	4681                	li	a3,0
    80003a5e:	e5040613          	addi	a2,s0,-432
    80003a62:	4581                	li	a1,0
    80003a64:	8552                	mv	a0,s4
    80003a66:	f63fe0ef          	jal	800029c8 <readi>
    80003a6a:	04000793          	li	a5,64
    80003a6e:	00f51a63          	bne	a0,a5,80003a82 <exec+0x60>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80003a72:	e5042703          	lw	a4,-432(s0)
    80003a76:	464c47b7          	lui	a5,0x464c4
    80003a7a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003a7e:	02f70663          	beq	a4,a5,80003aaa <exec+0x88>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003a82:	8552                	mv	a0,s4
    80003a84:	efbfe0ef          	jal	8000297e <iunlockput>
    end_op();
    80003a88:	decff0ef          	jal	80003074 <end_op>
  }
  return -1;
    80003a8c:	557d                	li	a0,-1
    80003a8e:	7a1e                	ld	s4,480(sp)
}
    80003a90:	20813083          	ld	ra,520(sp)
    80003a94:	20013403          	ld	s0,512(sp)
    80003a98:	74fe                	ld	s1,504(sp)
    80003a9a:	795e                	ld	s2,496(sp)
    80003a9c:	21010113          	addi	sp,sp,528
    80003aa0:	8082                	ret
    end_op();
    80003aa2:	dd2ff0ef          	jal	80003074 <end_op>
    return -1;
    80003aa6:	557d                	li	a0,-1
    80003aa8:	b7e5                	j	80003a90 <exec+0x6e>
    80003aaa:	ebda                	sd	s6,464(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80003aac:	8526                	mv	a0,s1
    80003aae:	b9afd0ef          	jal	80000e48 <proc_pagetable>
    80003ab2:	8b2a                	mv	s6,a0
    80003ab4:	2c050b63          	beqz	a0,80003d8a <exec+0x368>
    80003ab8:	f7ce                	sd	s3,488(sp)
    80003aba:	efd6                	sd	s5,472(sp)
    80003abc:	e7de                	sd	s7,456(sp)
    80003abe:	e3e2                	sd	s8,448(sp)
    80003ac0:	ff66                	sd	s9,440(sp)
    80003ac2:	fb6a                	sd	s10,432(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003ac4:	e7042d03          	lw	s10,-400(s0)
    80003ac8:	e8845783          	lhu	a5,-376(s0)
    80003acc:	12078963          	beqz	a5,80003bfe <exec+0x1dc>
    80003ad0:	f76e                	sd	s11,424(sp)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003ad2:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003ad4:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    80003ad6:	6c85                	lui	s9,0x1
    80003ad8:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80003adc:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80003ae0:	6a85                	lui	s5,0x1
    80003ae2:	a085                	j	80003b42 <exec+0x120>
      panic("loadseg: address should exist");
    80003ae4:	00004517          	auipc	a0,0x4
    80003ae8:	acc50513          	addi	a0,a0,-1332 # 800075b0 <etext+0x5b0>
    80003aec:	237010ef          	jal	80005522 <panic>
    if(sz - i < PGSIZE)
    80003af0:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80003af2:	8726                	mv	a4,s1
    80003af4:	012c06bb          	addw	a3,s8,s2
    80003af8:	4581                	li	a1,0
    80003afa:	8552                	mv	a0,s4
    80003afc:	ecdfe0ef          	jal	800029c8 <readi>
    80003b00:	2501                	sext.w	a0,a0
    80003b02:	24a49a63          	bne	s1,a0,80003d56 <exec+0x334>
  for(i = 0; i < sz; i += PGSIZE){
    80003b06:	012a893b          	addw	s2,s5,s2
    80003b0a:	03397363          	bgeu	s2,s3,80003b30 <exec+0x10e>
    pa = walkaddr(pagetable, va + i);
    80003b0e:	02091593          	slli	a1,s2,0x20
    80003b12:	9181                	srli	a1,a1,0x20
    80003b14:	95de                	add	a1,a1,s7
    80003b16:	855a                	mv	a0,s6
    80003b18:	94ffc0ef          	jal	80000466 <walkaddr>
    80003b1c:	862a                	mv	a2,a0
    if(pa == 0)
    80003b1e:	d179                	beqz	a0,80003ae4 <exec+0xc2>
    if(sz - i < PGSIZE)
    80003b20:	412984bb          	subw	s1,s3,s2
    80003b24:	0004879b          	sext.w	a5,s1
    80003b28:	fcfcf4e3          	bgeu	s9,a5,80003af0 <exec+0xce>
    80003b2c:	84d6                	mv	s1,s5
    80003b2e:	b7c9                	j	80003af0 <exec+0xce>
    sz = sz1;
    80003b30:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b34:	2d85                	addiw	s11,s11,1
    80003b36:	038d0d1b          	addiw	s10,s10,56
    80003b3a:	e8845783          	lhu	a5,-376(s0)
    80003b3e:	08fdd063          	bge	s11,a5,80003bbe <exec+0x19c>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003b42:	2d01                	sext.w	s10,s10
    80003b44:	03800713          	li	a4,56
    80003b48:	86ea                	mv	a3,s10
    80003b4a:	e1840613          	addi	a2,s0,-488
    80003b4e:	4581                	li	a1,0
    80003b50:	8552                	mv	a0,s4
    80003b52:	e77fe0ef          	jal	800029c8 <readi>
    80003b56:	03800793          	li	a5,56
    80003b5a:	1cf51663          	bne	a0,a5,80003d26 <exec+0x304>
    if(ph.type != ELF_PROG_LOAD)
    80003b5e:	e1842783          	lw	a5,-488(s0)
    80003b62:	4705                	li	a4,1
    80003b64:	fce798e3          	bne	a5,a4,80003b34 <exec+0x112>
    if(ph.memsz < ph.filesz)
    80003b68:	e4043483          	ld	s1,-448(s0)
    80003b6c:	e3843783          	ld	a5,-456(s0)
    80003b70:	1af4ef63          	bltu	s1,a5,80003d2e <exec+0x30c>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80003b74:	e2843783          	ld	a5,-472(s0)
    80003b78:	94be                	add	s1,s1,a5
    80003b7a:	1af4ee63          	bltu	s1,a5,80003d36 <exec+0x314>
    if(ph.vaddr % PGSIZE != 0)
    80003b7e:	df043703          	ld	a4,-528(s0)
    80003b82:	8ff9                	and	a5,a5,a4
    80003b84:	1a079d63          	bnez	a5,80003d3e <exec+0x31c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80003b88:	e1c42503          	lw	a0,-484(s0)
    80003b8c:	e7dff0ef          	jal	80003a08 <flags2perm>
    80003b90:	86aa                	mv	a3,a0
    80003b92:	8626                	mv	a2,s1
    80003b94:	85ca                	mv	a1,s2
    80003b96:	855a                	mv	a0,s6
    80003b98:	c47fc0ef          	jal	800007de <uvmalloc>
    80003b9c:	e0a43423          	sd	a0,-504(s0)
    80003ba0:	1a050363          	beqz	a0,80003d46 <exec+0x324>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003ba4:	e2843b83          	ld	s7,-472(s0)
    80003ba8:	e2042c03          	lw	s8,-480(s0)
    80003bac:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003bb0:	00098463          	beqz	s3,80003bb8 <exec+0x196>
    80003bb4:	4901                	li	s2,0
    80003bb6:	bfa1                	j	80003b0e <exec+0xec>
    sz = sz1;
    80003bb8:	e0843903          	ld	s2,-504(s0)
    80003bbc:	bfa5                	j	80003b34 <exec+0x112>
    80003bbe:	7dba                	ld	s11,424(sp)
  iunlockput(ip);
    80003bc0:	8552                	mv	a0,s4
    80003bc2:	dbdfe0ef          	jal	8000297e <iunlockput>
  end_op();
    80003bc6:	caeff0ef          	jal	80003074 <end_op>
  p = myproc();
    80003bca:	9d6fd0ef          	jal	80000da0 <myproc>
    80003bce:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80003bd0:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    80003bd4:	6985                	lui	s3,0x1
    80003bd6:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    80003bd8:	99ca                	add	s3,s3,s2
    80003bda:	77fd                	lui	a5,0xfffff
    80003bdc:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80003be0:	4691                	li	a3,4
    80003be2:	6609                	lui	a2,0x2
    80003be4:	964e                	add	a2,a2,s3
    80003be6:	85ce                	mv	a1,s3
    80003be8:	855a                	mv	a0,s6
    80003bea:	bf5fc0ef          	jal	800007de <uvmalloc>
    80003bee:	892a                	mv	s2,a0
    80003bf0:	e0a43423          	sd	a0,-504(s0)
    80003bf4:	e519                	bnez	a0,80003c02 <exec+0x1e0>
  if(pagetable)
    80003bf6:	e1343423          	sd	s3,-504(s0)
    80003bfa:	4a01                	li	s4,0
    80003bfc:	aab1                	j	80003d58 <exec+0x336>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003bfe:	4901                	li	s2,0
    80003c00:	b7c1                	j	80003bc0 <exec+0x19e>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80003c02:	75f9                	lui	a1,0xffffe
    80003c04:	95aa                	add	a1,a1,a0
    80003c06:	855a                	mv	a0,s6
    80003c08:	dc1fc0ef          	jal	800009c8 <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    80003c0c:	7bfd                	lui	s7,0xfffff
    80003c0e:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    80003c10:	e0043783          	ld	a5,-512(s0)
    80003c14:	6388                	ld	a0,0(a5)
    80003c16:	cd39                	beqz	a0,80003c74 <exec+0x252>
    80003c18:	e9040993          	addi	s3,s0,-368
    80003c1c:	f9040c13          	addi	s8,s0,-112
    80003c20:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80003c22:	e9cfc0ef          	jal	800002be <strlen>
    80003c26:	0015079b          	addiw	a5,a0,1
    80003c2a:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80003c2e:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80003c32:	11796e63          	bltu	s2,s7,80003d4e <exec+0x32c>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80003c36:	e0043d03          	ld	s10,-512(s0)
    80003c3a:	000d3a03          	ld	s4,0(s10)
    80003c3e:	8552                	mv	a0,s4
    80003c40:	e7efc0ef          	jal	800002be <strlen>
    80003c44:	0015069b          	addiw	a3,a0,1
    80003c48:	8652                	mv	a2,s4
    80003c4a:	85ca                	mv	a1,s2
    80003c4c:	855a                	mv	a0,s6
    80003c4e:	da5fc0ef          	jal	800009f2 <copyout>
    80003c52:	10054063          	bltz	a0,80003d52 <exec+0x330>
    ustack[argc] = sp;
    80003c56:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80003c5a:	0485                	addi	s1,s1,1
    80003c5c:	008d0793          	addi	a5,s10,8
    80003c60:	e0f43023          	sd	a5,-512(s0)
    80003c64:	008d3503          	ld	a0,8(s10)
    80003c68:	c909                	beqz	a0,80003c7a <exec+0x258>
    if(argc >= MAXARG)
    80003c6a:	09a1                	addi	s3,s3,8
    80003c6c:	fb899be3          	bne	s3,s8,80003c22 <exec+0x200>
  ip = 0;
    80003c70:	4a01                	li	s4,0
    80003c72:	a0dd                	j	80003d58 <exec+0x336>
  sp = sz;
    80003c74:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    80003c78:	4481                	li	s1,0
  ustack[argc] = 0;
    80003c7a:	00349793          	slli	a5,s1,0x3
    80003c7e:	f9078793          	addi	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffdb740>
    80003c82:	97a2                	add	a5,a5,s0
    80003c84:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80003c88:	00148693          	addi	a3,s1,1
    80003c8c:	068e                	slli	a3,a3,0x3
    80003c8e:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80003c92:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    80003c96:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    80003c9a:	f5796ee3          	bltu	s2,s7,80003bf6 <exec+0x1d4>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80003c9e:	e9040613          	addi	a2,s0,-368
    80003ca2:	85ca                	mv	a1,s2
    80003ca4:	855a                	mv	a0,s6
    80003ca6:	d4dfc0ef          	jal	800009f2 <copyout>
    80003caa:	0e054263          	bltz	a0,80003d8e <exec+0x36c>
  p->trapframe->a1 = sp;
    80003cae:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80003cb2:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80003cb6:	df843783          	ld	a5,-520(s0)
    80003cba:	0007c703          	lbu	a4,0(a5)
    80003cbe:	cf11                	beqz	a4,80003cda <exec+0x2b8>
    80003cc0:	0785                	addi	a5,a5,1
    if(*s == '/')
    80003cc2:	02f00693          	li	a3,47
    80003cc6:	a039                	j	80003cd4 <exec+0x2b2>
      last = s+1;
    80003cc8:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80003ccc:	0785                	addi	a5,a5,1
    80003cce:	fff7c703          	lbu	a4,-1(a5)
    80003cd2:	c701                	beqz	a4,80003cda <exec+0x2b8>
    if(*s == '/')
    80003cd4:	fed71ce3          	bne	a4,a3,80003ccc <exec+0x2aa>
    80003cd8:	bfc5                	j	80003cc8 <exec+0x2a6>
  safestrcpy(p->name, last, sizeof(p->name));
    80003cda:	4641                	li	a2,16
    80003cdc:	df843583          	ld	a1,-520(s0)
    80003ce0:	158a8513          	addi	a0,s5,344
    80003ce4:	da8fc0ef          	jal	8000028c <safestrcpy>
  oldpagetable = p->pagetable;
    80003ce8:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80003cec:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    80003cf0:	e0843783          	ld	a5,-504(s0)
    80003cf4:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80003cf8:	058ab783          	ld	a5,88(s5)
    80003cfc:	e6843703          	ld	a4,-408(s0)
    80003d00:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80003d02:	058ab783          	ld	a5,88(s5)
    80003d06:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80003d0a:	85e6                	mv	a1,s9
    80003d0c:	9f8fd0ef          	jal	80000f04 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80003d10:	0004851b          	sext.w	a0,s1
    80003d14:	79be                	ld	s3,488(sp)
    80003d16:	7a1e                	ld	s4,480(sp)
    80003d18:	6afe                	ld	s5,472(sp)
    80003d1a:	6b5e                	ld	s6,464(sp)
    80003d1c:	6bbe                	ld	s7,456(sp)
    80003d1e:	6c1e                	ld	s8,448(sp)
    80003d20:	7cfa                	ld	s9,440(sp)
    80003d22:	7d5a                	ld	s10,432(sp)
    80003d24:	b3b5                	j	80003a90 <exec+0x6e>
    80003d26:	e1243423          	sd	s2,-504(s0)
    80003d2a:	7dba                	ld	s11,424(sp)
    80003d2c:	a035                	j	80003d58 <exec+0x336>
    80003d2e:	e1243423          	sd	s2,-504(s0)
    80003d32:	7dba                	ld	s11,424(sp)
    80003d34:	a015                	j	80003d58 <exec+0x336>
    80003d36:	e1243423          	sd	s2,-504(s0)
    80003d3a:	7dba                	ld	s11,424(sp)
    80003d3c:	a831                	j	80003d58 <exec+0x336>
    80003d3e:	e1243423          	sd	s2,-504(s0)
    80003d42:	7dba                	ld	s11,424(sp)
    80003d44:	a811                	j	80003d58 <exec+0x336>
    80003d46:	e1243423          	sd	s2,-504(s0)
    80003d4a:	7dba                	ld	s11,424(sp)
    80003d4c:	a031                	j	80003d58 <exec+0x336>
  ip = 0;
    80003d4e:	4a01                	li	s4,0
    80003d50:	a021                	j	80003d58 <exec+0x336>
    80003d52:	4a01                	li	s4,0
  if(pagetable)
    80003d54:	a011                	j	80003d58 <exec+0x336>
    80003d56:	7dba                	ld	s11,424(sp)
    proc_freepagetable(pagetable, sz);
    80003d58:	e0843583          	ld	a1,-504(s0)
    80003d5c:	855a                	mv	a0,s6
    80003d5e:	9a6fd0ef          	jal	80000f04 <proc_freepagetable>
  return -1;
    80003d62:	557d                	li	a0,-1
  if(ip){
    80003d64:	000a1b63          	bnez	s4,80003d7a <exec+0x358>
    80003d68:	79be                	ld	s3,488(sp)
    80003d6a:	7a1e                	ld	s4,480(sp)
    80003d6c:	6afe                	ld	s5,472(sp)
    80003d6e:	6b5e                	ld	s6,464(sp)
    80003d70:	6bbe                	ld	s7,456(sp)
    80003d72:	6c1e                	ld	s8,448(sp)
    80003d74:	7cfa                	ld	s9,440(sp)
    80003d76:	7d5a                	ld	s10,432(sp)
    80003d78:	bb21                	j	80003a90 <exec+0x6e>
    80003d7a:	79be                	ld	s3,488(sp)
    80003d7c:	6afe                	ld	s5,472(sp)
    80003d7e:	6b5e                	ld	s6,464(sp)
    80003d80:	6bbe                	ld	s7,456(sp)
    80003d82:	6c1e                	ld	s8,448(sp)
    80003d84:	7cfa                	ld	s9,440(sp)
    80003d86:	7d5a                	ld	s10,432(sp)
    80003d88:	b9ed                	j	80003a82 <exec+0x60>
    80003d8a:	6b5e                	ld	s6,464(sp)
    80003d8c:	b9dd                	j	80003a82 <exec+0x60>
  sz = sz1;
    80003d8e:	e0843983          	ld	s3,-504(s0)
    80003d92:	b595                	j	80003bf6 <exec+0x1d4>

0000000080003d94 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80003d94:	7179                	addi	sp,sp,-48
    80003d96:	f406                	sd	ra,40(sp)
    80003d98:	f022                	sd	s0,32(sp)
    80003d9a:	ec26                	sd	s1,24(sp)
    80003d9c:	e84a                	sd	s2,16(sp)
    80003d9e:	1800                	addi	s0,sp,48
    80003da0:	892e                	mv	s2,a1
    80003da2:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80003da4:	fdc40593          	addi	a1,s0,-36
    80003da8:	f4dfd0ef          	jal	80001cf4 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80003dac:	fdc42703          	lw	a4,-36(s0)
    80003db0:	47bd                	li	a5,15
    80003db2:	02e7e963          	bltu	a5,a4,80003de4 <argfd+0x50>
    80003db6:	febfc0ef          	jal	80000da0 <myproc>
    80003dba:	fdc42703          	lw	a4,-36(s0)
    80003dbe:	01a70793          	addi	a5,a4,26
    80003dc2:	078e                	slli	a5,a5,0x3
    80003dc4:	953e                	add	a0,a0,a5
    80003dc6:	611c                	ld	a5,0(a0)
    80003dc8:	c385                	beqz	a5,80003de8 <argfd+0x54>
    return -1;
  if(pfd)
    80003dca:	00090463          	beqz	s2,80003dd2 <argfd+0x3e>
    *pfd = fd;
    80003dce:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80003dd2:	4501                	li	a0,0
  if(pf)
    80003dd4:	c091                	beqz	s1,80003dd8 <argfd+0x44>
    *pf = f;
    80003dd6:	e09c                	sd	a5,0(s1)
}
    80003dd8:	70a2                	ld	ra,40(sp)
    80003dda:	7402                	ld	s0,32(sp)
    80003ddc:	64e2                	ld	s1,24(sp)
    80003dde:	6942                	ld	s2,16(sp)
    80003de0:	6145                	addi	sp,sp,48
    80003de2:	8082                	ret
    return -1;
    80003de4:	557d                	li	a0,-1
    80003de6:	bfcd                	j	80003dd8 <argfd+0x44>
    80003de8:	557d                	li	a0,-1
    80003dea:	b7fd                	j	80003dd8 <argfd+0x44>

0000000080003dec <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80003dec:	1101                	addi	sp,sp,-32
    80003dee:	ec06                	sd	ra,24(sp)
    80003df0:	e822                	sd	s0,16(sp)
    80003df2:	e426                	sd	s1,8(sp)
    80003df4:	1000                	addi	s0,sp,32
    80003df6:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80003df8:	fa9fc0ef          	jal	80000da0 <myproc>
    80003dfc:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80003dfe:	0d050793          	addi	a5,a0,208
    80003e02:	4501                	li	a0,0
    80003e04:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80003e06:	6398                	ld	a4,0(a5)
    80003e08:	cb19                	beqz	a4,80003e1e <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    80003e0a:	2505                	addiw	a0,a0,1
    80003e0c:	07a1                	addi	a5,a5,8
    80003e0e:	fed51ce3          	bne	a0,a3,80003e06 <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80003e12:	557d                	li	a0,-1
}
    80003e14:	60e2                	ld	ra,24(sp)
    80003e16:	6442                	ld	s0,16(sp)
    80003e18:	64a2                	ld	s1,8(sp)
    80003e1a:	6105                	addi	sp,sp,32
    80003e1c:	8082                	ret
      p->ofile[fd] = f;
    80003e1e:	01a50793          	addi	a5,a0,26
    80003e22:	078e                	slli	a5,a5,0x3
    80003e24:	963e                	add	a2,a2,a5
    80003e26:	e204                	sd	s1,0(a2)
      return fd;
    80003e28:	b7f5                	j	80003e14 <fdalloc+0x28>

0000000080003e2a <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80003e2a:	715d                	addi	sp,sp,-80
    80003e2c:	e486                	sd	ra,72(sp)
    80003e2e:	e0a2                	sd	s0,64(sp)
    80003e30:	fc26                	sd	s1,56(sp)
    80003e32:	f84a                	sd	s2,48(sp)
    80003e34:	f44e                	sd	s3,40(sp)
    80003e36:	ec56                	sd	s5,24(sp)
    80003e38:	e85a                	sd	s6,16(sp)
    80003e3a:	0880                	addi	s0,sp,80
    80003e3c:	8b2e                	mv	s6,a1
    80003e3e:	89b2                	mv	s3,a2
    80003e40:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80003e42:	fb040593          	addi	a1,s0,-80
    80003e46:	822ff0ef          	jal	80002e68 <nameiparent>
    80003e4a:	84aa                	mv	s1,a0
    80003e4c:	10050a63          	beqz	a0,80003f60 <create+0x136>
    return 0;

  ilock(dp);
    80003e50:	925fe0ef          	jal	80002774 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80003e54:	4601                	li	a2,0
    80003e56:	fb040593          	addi	a1,s0,-80
    80003e5a:	8526                	mv	a0,s1
    80003e5c:	d8dfe0ef          	jal	80002be8 <dirlookup>
    80003e60:	8aaa                	mv	s5,a0
    80003e62:	c129                	beqz	a0,80003ea4 <create+0x7a>
    iunlockput(dp);
    80003e64:	8526                	mv	a0,s1
    80003e66:	b19fe0ef          	jal	8000297e <iunlockput>
    ilock(ip);
    80003e6a:	8556                	mv	a0,s5
    80003e6c:	909fe0ef          	jal	80002774 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80003e70:	4789                	li	a5,2
    80003e72:	02fb1463          	bne	s6,a5,80003e9a <create+0x70>
    80003e76:	044ad783          	lhu	a5,68(s5)
    80003e7a:	37f9                	addiw	a5,a5,-2
    80003e7c:	17c2                	slli	a5,a5,0x30
    80003e7e:	93c1                	srli	a5,a5,0x30
    80003e80:	4705                	li	a4,1
    80003e82:	00f76c63          	bltu	a4,a5,80003e9a <create+0x70>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80003e86:	8556                	mv	a0,s5
    80003e88:	60a6                	ld	ra,72(sp)
    80003e8a:	6406                	ld	s0,64(sp)
    80003e8c:	74e2                	ld	s1,56(sp)
    80003e8e:	7942                	ld	s2,48(sp)
    80003e90:	79a2                	ld	s3,40(sp)
    80003e92:	6ae2                	ld	s5,24(sp)
    80003e94:	6b42                	ld	s6,16(sp)
    80003e96:	6161                	addi	sp,sp,80
    80003e98:	8082                	ret
    iunlockput(ip);
    80003e9a:	8556                	mv	a0,s5
    80003e9c:	ae3fe0ef          	jal	8000297e <iunlockput>
    return 0;
    80003ea0:	4a81                	li	s5,0
    80003ea2:	b7d5                	j	80003e86 <create+0x5c>
    80003ea4:	f052                	sd	s4,32(sp)
  if((ip = ialloc(dp->dev, type)) == 0){
    80003ea6:	85da                	mv	a1,s6
    80003ea8:	4088                	lw	a0,0(s1)
    80003eaa:	f5afe0ef          	jal	80002604 <ialloc>
    80003eae:	8a2a                	mv	s4,a0
    80003eb0:	cd15                	beqz	a0,80003eec <create+0xc2>
  ilock(ip);
    80003eb2:	8c3fe0ef          	jal	80002774 <ilock>
  ip->major = major;
    80003eb6:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80003eba:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    80003ebe:	4905                	li	s2,1
    80003ec0:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80003ec4:	8552                	mv	a0,s4
    80003ec6:	ffafe0ef          	jal	800026c0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80003eca:	032b0763          	beq	s6,s2,80003ef8 <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80003ece:	004a2603          	lw	a2,4(s4)
    80003ed2:	fb040593          	addi	a1,s0,-80
    80003ed6:	8526                	mv	a0,s1
    80003ed8:	eddfe0ef          	jal	80002db4 <dirlink>
    80003edc:	06054563          	bltz	a0,80003f46 <create+0x11c>
  iunlockput(dp);
    80003ee0:	8526                	mv	a0,s1
    80003ee2:	a9dfe0ef          	jal	8000297e <iunlockput>
  return ip;
    80003ee6:	8ad2                	mv	s5,s4
    80003ee8:	7a02                	ld	s4,32(sp)
    80003eea:	bf71                	j	80003e86 <create+0x5c>
    iunlockput(dp);
    80003eec:	8526                	mv	a0,s1
    80003eee:	a91fe0ef          	jal	8000297e <iunlockput>
    return 0;
    80003ef2:	8ad2                	mv	s5,s4
    80003ef4:	7a02                	ld	s4,32(sp)
    80003ef6:	bf41                	j	80003e86 <create+0x5c>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80003ef8:	004a2603          	lw	a2,4(s4)
    80003efc:	00003597          	auipc	a1,0x3
    80003f00:	6d458593          	addi	a1,a1,1748 # 800075d0 <etext+0x5d0>
    80003f04:	8552                	mv	a0,s4
    80003f06:	eaffe0ef          	jal	80002db4 <dirlink>
    80003f0a:	02054e63          	bltz	a0,80003f46 <create+0x11c>
    80003f0e:	40d0                	lw	a2,4(s1)
    80003f10:	00003597          	auipc	a1,0x3
    80003f14:	6c858593          	addi	a1,a1,1736 # 800075d8 <etext+0x5d8>
    80003f18:	8552                	mv	a0,s4
    80003f1a:	e9bfe0ef          	jal	80002db4 <dirlink>
    80003f1e:	02054463          	bltz	a0,80003f46 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    80003f22:	004a2603          	lw	a2,4(s4)
    80003f26:	fb040593          	addi	a1,s0,-80
    80003f2a:	8526                	mv	a0,s1
    80003f2c:	e89fe0ef          	jal	80002db4 <dirlink>
    80003f30:	00054b63          	bltz	a0,80003f46 <create+0x11c>
    dp->nlink++;  // for ".."
    80003f34:	04a4d783          	lhu	a5,74(s1)
    80003f38:	2785                	addiw	a5,a5,1
    80003f3a:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80003f3e:	8526                	mv	a0,s1
    80003f40:	f80fe0ef          	jal	800026c0 <iupdate>
    80003f44:	bf71                	j	80003ee0 <create+0xb6>
  ip->nlink = 0;
    80003f46:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80003f4a:	8552                	mv	a0,s4
    80003f4c:	f74fe0ef          	jal	800026c0 <iupdate>
  iunlockput(ip);
    80003f50:	8552                	mv	a0,s4
    80003f52:	a2dfe0ef          	jal	8000297e <iunlockput>
  iunlockput(dp);
    80003f56:	8526                	mv	a0,s1
    80003f58:	a27fe0ef          	jal	8000297e <iunlockput>
  return 0;
    80003f5c:	7a02                	ld	s4,32(sp)
    80003f5e:	b725                	j	80003e86 <create+0x5c>
    return 0;
    80003f60:	8aaa                	mv	s5,a0
    80003f62:	b715                	j	80003e86 <create+0x5c>

0000000080003f64 <sys_dup>:
{
    80003f64:	7179                	addi	sp,sp,-48
    80003f66:	f406                	sd	ra,40(sp)
    80003f68:	f022                	sd	s0,32(sp)
    80003f6a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80003f6c:	fd840613          	addi	a2,s0,-40
    80003f70:	4581                	li	a1,0
    80003f72:	4501                	li	a0,0
    80003f74:	e21ff0ef          	jal	80003d94 <argfd>
    return -1;
    80003f78:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80003f7a:	02054363          	bltz	a0,80003fa0 <sys_dup+0x3c>
    80003f7e:	ec26                	sd	s1,24(sp)
    80003f80:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80003f82:	fd843903          	ld	s2,-40(s0)
    80003f86:	854a                	mv	a0,s2
    80003f88:	e65ff0ef          	jal	80003dec <fdalloc>
    80003f8c:	84aa                	mv	s1,a0
    return -1;
    80003f8e:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80003f90:	00054d63          	bltz	a0,80003faa <sys_dup+0x46>
  filedup(f);
    80003f94:	854a                	mv	a0,s2
    80003f96:	c48ff0ef          	jal	800033de <filedup>
  return fd;
    80003f9a:	87a6                	mv	a5,s1
    80003f9c:	64e2                	ld	s1,24(sp)
    80003f9e:	6942                	ld	s2,16(sp)
}
    80003fa0:	853e                	mv	a0,a5
    80003fa2:	70a2                	ld	ra,40(sp)
    80003fa4:	7402                	ld	s0,32(sp)
    80003fa6:	6145                	addi	sp,sp,48
    80003fa8:	8082                	ret
    80003faa:	64e2                	ld	s1,24(sp)
    80003fac:	6942                	ld	s2,16(sp)
    80003fae:	bfcd                	j	80003fa0 <sys_dup+0x3c>

0000000080003fb0 <sys_read>:
{
    80003fb0:	7179                	addi	sp,sp,-48
    80003fb2:	f406                	sd	ra,40(sp)
    80003fb4:	f022                	sd	s0,32(sp)
    80003fb6:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80003fb8:	fd840593          	addi	a1,s0,-40
    80003fbc:	4505                	li	a0,1
    80003fbe:	d53fd0ef          	jal	80001d10 <argaddr>
  argint(2, &n);
    80003fc2:	fe440593          	addi	a1,s0,-28
    80003fc6:	4509                	li	a0,2
    80003fc8:	d2dfd0ef          	jal	80001cf4 <argint>
  if(argfd(0, 0, &f) < 0)
    80003fcc:	fe840613          	addi	a2,s0,-24
    80003fd0:	4581                	li	a1,0
    80003fd2:	4501                	li	a0,0
    80003fd4:	dc1ff0ef          	jal	80003d94 <argfd>
    80003fd8:	87aa                	mv	a5,a0
    return -1;
    80003fda:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80003fdc:	0007ca63          	bltz	a5,80003ff0 <sys_read+0x40>
  return fileread(f, p, n);
    80003fe0:	fe442603          	lw	a2,-28(s0)
    80003fe4:	fd843583          	ld	a1,-40(s0)
    80003fe8:	fe843503          	ld	a0,-24(s0)
    80003fec:	d58ff0ef          	jal	80003544 <fileread>
}
    80003ff0:	70a2                	ld	ra,40(sp)
    80003ff2:	7402                	ld	s0,32(sp)
    80003ff4:	6145                	addi	sp,sp,48
    80003ff6:	8082                	ret

0000000080003ff8 <sys_write>:
{
    80003ff8:	7179                	addi	sp,sp,-48
    80003ffa:	f406                	sd	ra,40(sp)
    80003ffc:	f022                	sd	s0,32(sp)
    80003ffe:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004000:	fd840593          	addi	a1,s0,-40
    80004004:	4505                	li	a0,1
    80004006:	d0bfd0ef          	jal	80001d10 <argaddr>
  argint(2, &n);
    8000400a:	fe440593          	addi	a1,s0,-28
    8000400e:	4509                	li	a0,2
    80004010:	ce5fd0ef          	jal	80001cf4 <argint>
  if(argfd(0, 0, &f) < 0)
    80004014:	fe840613          	addi	a2,s0,-24
    80004018:	4581                	li	a1,0
    8000401a:	4501                	li	a0,0
    8000401c:	d79ff0ef          	jal	80003d94 <argfd>
    80004020:	87aa                	mv	a5,a0
    return -1;
    80004022:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004024:	0007ca63          	bltz	a5,80004038 <sys_write+0x40>
  return filewrite(f, p, n);
    80004028:	fe442603          	lw	a2,-28(s0)
    8000402c:	fd843583          	ld	a1,-40(s0)
    80004030:	fe843503          	ld	a0,-24(s0)
    80004034:	dceff0ef          	jal	80003602 <filewrite>
}
    80004038:	70a2                	ld	ra,40(sp)
    8000403a:	7402                	ld	s0,32(sp)
    8000403c:	6145                	addi	sp,sp,48
    8000403e:	8082                	ret

0000000080004040 <sys_close>:
{
    80004040:	1101                	addi	sp,sp,-32
    80004042:	ec06                	sd	ra,24(sp)
    80004044:	e822                	sd	s0,16(sp)
    80004046:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004048:	fe040613          	addi	a2,s0,-32
    8000404c:	fec40593          	addi	a1,s0,-20
    80004050:	4501                	li	a0,0
    80004052:	d43ff0ef          	jal	80003d94 <argfd>
    return -1;
    80004056:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004058:	02054063          	bltz	a0,80004078 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    8000405c:	d45fc0ef          	jal	80000da0 <myproc>
    80004060:	fec42783          	lw	a5,-20(s0)
    80004064:	07e9                	addi	a5,a5,26
    80004066:	078e                	slli	a5,a5,0x3
    80004068:	953e                	add	a0,a0,a5
    8000406a:	00053023          	sd	zero,0(a0)
  fileclose(f);
    8000406e:	fe043503          	ld	a0,-32(s0)
    80004072:	bb2ff0ef          	jal	80003424 <fileclose>
  return 0;
    80004076:	4781                	li	a5,0
}
    80004078:	853e                	mv	a0,a5
    8000407a:	60e2                	ld	ra,24(sp)
    8000407c:	6442                	ld	s0,16(sp)
    8000407e:	6105                	addi	sp,sp,32
    80004080:	8082                	ret

0000000080004082 <sys_fstat>:
{
    80004082:	1101                	addi	sp,sp,-32
    80004084:	ec06                	sd	ra,24(sp)
    80004086:	e822                	sd	s0,16(sp)
    80004088:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    8000408a:	fe040593          	addi	a1,s0,-32
    8000408e:	4505                	li	a0,1
    80004090:	c81fd0ef          	jal	80001d10 <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004094:	fe840613          	addi	a2,s0,-24
    80004098:	4581                	li	a1,0
    8000409a:	4501                	li	a0,0
    8000409c:	cf9ff0ef          	jal	80003d94 <argfd>
    800040a0:	87aa                	mv	a5,a0
    return -1;
    800040a2:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800040a4:	0007c863          	bltz	a5,800040b4 <sys_fstat+0x32>
  return filestat(f, st);
    800040a8:	fe043583          	ld	a1,-32(s0)
    800040ac:	fe843503          	ld	a0,-24(s0)
    800040b0:	c36ff0ef          	jal	800034e6 <filestat>
}
    800040b4:	60e2                	ld	ra,24(sp)
    800040b6:	6442                	ld	s0,16(sp)
    800040b8:	6105                	addi	sp,sp,32
    800040ba:	8082                	ret

00000000800040bc <sys_link>:
{
    800040bc:	7169                	addi	sp,sp,-304
    800040be:	f606                	sd	ra,296(sp)
    800040c0:	f222                	sd	s0,288(sp)
    800040c2:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800040c4:	08000613          	li	a2,128
    800040c8:	ed040593          	addi	a1,s0,-304
    800040cc:	4501                	li	a0,0
    800040ce:	c5ffd0ef          	jal	80001d2c <argstr>
    return -1;
    800040d2:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800040d4:	0c054e63          	bltz	a0,800041b0 <sys_link+0xf4>
    800040d8:	08000613          	li	a2,128
    800040dc:	f5040593          	addi	a1,s0,-176
    800040e0:	4505                	li	a0,1
    800040e2:	c4bfd0ef          	jal	80001d2c <argstr>
    return -1;
    800040e6:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800040e8:	0c054463          	bltz	a0,800041b0 <sys_link+0xf4>
    800040ec:	ee26                	sd	s1,280(sp)
  begin_op();
    800040ee:	f1dfe0ef          	jal	8000300a <begin_op>
  if((ip = namei(old)) == 0){
    800040f2:	ed040513          	addi	a0,s0,-304
    800040f6:	d59fe0ef          	jal	80002e4e <namei>
    800040fa:	84aa                	mv	s1,a0
    800040fc:	c53d                	beqz	a0,8000416a <sys_link+0xae>
  ilock(ip);
    800040fe:	e76fe0ef          	jal	80002774 <ilock>
  if(ip->type == T_DIR){
    80004102:	04449703          	lh	a4,68(s1)
    80004106:	4785                	li	a5,1
    80004108:	06f70663          	beq	a4,a5,80004174 <sys_link+0xb8>
    8000410c:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    8000410e:	04a4d783          	lhu	a5,74(s1)
    80004112:	2785                	addiw	a5,a5,1
    80004114:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004118:	8526                	mv	a0,s1
    8000411a:	da6fe0ef          	jal	800026c0 <iupdate>
  iunlock(ip);
    8000411e:	8526                	mv	a0,s1
    80004120:	f02fe0ef          	jal	80002822 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004124:	fd040593          	addi	a1,s0,-48
    80004128:	f5040513          	addi	a0,s0,-176
    8000412c:	d3dfe0ef          	jal	80002e68 <nameiparent>
    80004130:	892a                	mv	s2,a0
    80004132:	cd21                	beqz	a0,8000418a <sys_link+0xce>
  ilock(dp);
    80004134:	e40fe0ef          	jal	80002774 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004138:	00092703          	lw	a4,0(s2)
    8000413c:	409c                	lw	a5,0(s1)
    8000413e:	04f71363          	bne	a4,a5,80004184 <sys_link+0xc8>
    80004142:	40d0                	lw	a2,4(s1)
    80004144:	fd040593          	addi	a1,s0,-48
    80004148:	854a                	mv	a0,s2
    8000414a:	c6bfe0ef          	jal	80002db4 <dirlink>
    8000414e:	02054b63          	bltz	a0,80004184 <sys_link+0xc8>
  iunlockput(dp);
    80004152:	854a                	mv	a0,s2
    80004154:	82bfe0ef          	jal	8000297e <iunlockput>
  iput(ip);
    80004158:	8526                	mv	a0,s1
    8000415a:	f9cfe0ef          	jal	800028f6 <iput>
  end_op();
    8000415e:	f17fe0ef          	jal	80003074 <end_op>
  return 0;
    80004162:	4781                	li	a5,0
    80004164:	64f2                	ld	s1,280(sp)
    80004166:	6952                	ld	s2,272(sp)
    80004168:	a0a1                	j	800041b0 <sys_link+0xf4>
    end_op();
    8000416a:	f0bfe0ef          	jal	80003074 <end_op>
    return -1;
    8000416e:	57fd                	li	a5,-1
    80004170:	64f2                	ld	s1,280(sp)
    80004172:	a83d                	j	800041b0 <sys_link+0xf4>
    iunlockput(ip);
    80004174:	8526                	mv	a0,s1
    80004176:	809fe0ef          	jal	8000297e <iunlockput>
    end_op();
    8000417a:	efbfe0ef          	jal	80003074 <end_op>
    return -1;
    8000417e:	57fd                	li	a5,-1
    80004180:	64f2                	ld	s1,280(sp)
    80004182:	a03d                	j	800041b0 <sys_link+0xf4>
    iunlockput(dp);
    80004184:	854a                	mv	a0,s2
    80004186:	ff8fe0ef          	jal	8000297e <iunlockput>
  ilock(ip);
    8000418a:	8526                	mv	a0,s1
    8000418c:	de8fe0ef          	jal	80002774 <ilock>
  ip->nlink--;
    80004190:	04a4d783          	lhu	a5,74(s1)
    80004194:	37fd                	addiw	a5,a5,-1
    80004196:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000419a:	8526                	mv	a0,s1
    8000419c:	d24fe0ef          	jal	800026c0 <iupdate>
  iunlockput(ip);
    800041a0:	8526                	mv	a0,s1
    800041a2:	fdcfe0ef          	jal	8000297e <iunlockput>
  end_op();
    800041a6:	ecffe0ef          	jal	80003074 <end_op>
  return -1;
    800041aa:	57fd                	li	a5,-1
    800041ac:	64f2                	ld	s1,280(sp)
    800041ae:	6952                	ld	s2,272(sp)
}
    800041b0:	853e                	mv	a0,a5
    800041b2:	70b2                	ld	ra,296(sp)
    800041b4:	7412                	ld	s0,288(sp)
    800041b6:	6155                	addi	sp,sp,304
    800041b8:	8082                	ret

00000000800041ba <sys_unlink>:
{
    800041ba:	7151                	addi	sp,sp,-240
    800041bc:	f586                	sd	ra,232(sp)
    800041be:	f1a2                	sd	s0,224(sp)
    800041c0:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800041c2:	08000613          	li	a2,128
    800041c6:	f3040593          	addi	a1,s0,-208
    800041ca:	4501                	li	a0,0
    800041cc:	b61fd0ef          	jal	80001d2c <argstr>
    800041d0:	16054063          	bltz	a0,80004330 <sys_unlink+0x176>
    800041d4:	eda6                	sd	s1,216(sp)
  begin_op();
    800041d6:	e35fe0ef          	jal	8000300a <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800041da:	fb040593          	addi	a1,s0,-80
    800041de:	f3040513          	addi	a0,s0,-208
    800041e2:	c87fe0ef          	jal	80002e68 <nameiparent>
    800041e6:	84aa                	mv	s1,a0
    800041e8:	c945                	beqz	a0,80004298 <sys_unlink+0xde>
  ilock(dp);
    800041ea:	d8afe0ef          	jal	80002774 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800041ee:	00003597          	auipc	a1,0x3
    800041f2:	3e258593          	addi	a1,a1,994 # 800075d0 <etext+0x5d0>
    800041f6:	fb040513          	addi	a0,s0,-80
    800041fa:	9d9fe0ef          	jal	80002bd2 <namecmp>
    800041fe:	10050e63          	beqz	a0,8000431a <sys_unlink+0x160>
    80004202:	00003597          	auipc	a1,0x3
    80004206:	3d658593          	addi	a1,a1,982 # 800075d8 <etext+0x5d8>
    8000420a:	fb040513          	addi	a0,s0,-80
    8000420e:	9c5fe0ef          	jal	80002bd2 <namecmp>
    80004212:	10050463          	beqz	a0,8000431a <sys_unlink+0x160>
    80004216:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004218:	f2c40613          	addi	a2,s0,-212
    8000421c:	fb040593          	addi	a1,s0,-80
    80004220:	8526                	mv	a0,s1
    80004222:	9c7fe0ef          	jal	80002be8 <dirlookup>
    80004226:	892a                	mv	s2,a0
    80004228:	0e050863          	beqz	a0,80004318 <sys_unlink+0x15e>
  ilock(ip);
    8000422c:	d48fe0ef          	jal	80002774 <ilock>
  if(ip->nlink < 1)
    80004230:	04a91783          	lh	a5,74(s2)
    80004234:	06f05763          	blez	a5,800042a2 <sys_unlink+0xe8>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004238:	04491703          	lh	a4,68(s2)
    8000423c:	4785                	li	a5,1
    8000423e:	06f70963          	beq	a4,a5,800042b0 <sys_unlink+0xf6>
  memset(&de, 0, sizeof(de));
    80004242:	4641                	li	a2,16
    80004244:	4581                	li	a1,0
    80004246:	fc040513          	addi	a0,s0,-64
    8000424a:	f05fb0ef          	jal	8000014e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000424e:	4741                	li	a4,16
    80004250:	f2c42683          	lw	a3,-212(s0)
    80004254:	fc040613          	addi	a2,s0,-64
    80004258:	4581                	li	a1,0
    8000425a:	8526                	mv	a0,s1
    8000425c:	869fe0ef          	jal	80002ac4 <writei>
    80004260:	47c1                	li	a5,16
    80004262:	08f51b63          	bne	a0,a5,800042f8 <sys_unlink+0x13e>
  if(ip->type == T_DIR){
    80004266:	04491703          	lh	a4,68(s2)
    8000426a:	4785                	li	a5,1
    8000426c:	08f70d63          	beq	a4,a5,80004306 <sys_unlink+0x14c>
  iunlockput(dp);
    80004270:	8526                	mv	a0,s1
    80004272:	f0cfe0ef          	jal	8000297e <iunlockput>
  ip->nlink--;
    80004276:	04a95783          	lhu	a5,74(s2)
    8000427a:	37fd                	addiw	a5,a5,-1
    8000427c:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004280:	854a                	mv	a0,s2
    80004282:	c3efe0ef          	jal	800026c0 <iupdate>
  iunlockput(ip);
    80004286:	854a                	mv	a0,s2
    80004288:	ef6fe0ef          	jal	8000297e <iunlockput>
  end_op();
    8000428c:	de9fe0ef          	jal	80003074 <end_op>
  return 0;
    80004290:	4501                	li	a0,0
    80004292:	64ee                	ld	s1,216(sp)
    80004294:	694e                	ld	s2,208(sp)
    80004296:	a849                	j	80004328 <sys_unlink+0x16e>
    end_op();
    80004298:	dddfe0ef          	jal	80003074 <end_op>
    return -1;
    8000429c:	557d                	li	a0,-1
    8000429e:	64ee                	ld	s1,216(sp)
    800042a0:	a061                	j	80004328 <sys_unlink+0x16e>
    800042a2:	e5ce                	sd	s3,200(sp)
    panic("unlink: nlink < 1");
    800042a4:	00003517          	auipc	a0,0x3
    800042a8:	33c50513          	addi	a0,a0,828 # 800075e0 <etext+0x5e0>
    800042ac:	276010ef          	jal	80005522 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800042b0:	04c92703          	lw	a4,76(s2)
    800042b4:	02000793          	li	a5,32
    800042b8:	f8e7f5e3          	bgeu	a5,a4,80004242 <sys_unlink+0x88>
    800042bc:	e5ce                	sd	s3,200(sp)
    800042be:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800042c2:	4741                	li	a4,16
    800042c4:	86ce                	mv	a3,s3
    800042c6:	f1840613          	addi	a2,s0,-232
    800042ca:	4581                	li	a1,0
    800042cc:	854a                	mv	a0,s2
    800042ce:	efafe0ef          	jal	800029c8 <readi>
    800042d2:	47c1                	li	a5,16
    800042d4:	00f51c63          	bne	a0,a5,800042ec <sys_unlink+0x132>
    if(de.inum != 0)
    800042d8:	f1845783          	lhu	a5,-232(s0)
    800042dc:	efa1                	bnez	a5,80004334 <sys_unlink+0x17a>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800042de:	29c1                	addiw	s3,s3,16
    800042e0:	04c92783          	lw	a5,76(s2)
    800042e4:	fcf9efe3          	bltu	s3,a5,800042c2 <sys_unlink+0x108>
    800042e8:	69ae                	ld	s3,200(sp)
    800042ea:	bfa1                	j	80004242 <sys_unlink+0x88>
      panic("isdirempty: readi");
    800042ec:	00003517          	auipc	a0,0x3
    800042f0:	30c50513          	addi	a0,a0,780 # 800075f8 <etext+0x5f8>
    800042f4:	22e010ef          	jal	80005522 <panic>
    800042f8:	e5ce                	sd	s3,200(sp)
    panic("unlink: writei");
    800042fa:	00003517          	auipc	a0,0x3
    800042fe:	31650513          	addi	a0,a0,790 # 80007610 <etext+0x610>
    80004302:	220010ef          	jal	80005522 <panic>
    dp->nlink--;
    80004306:	04a4d783          	lhu	a5,74(s1)
    8000430a:	37fd                	addiw	a5,a5,-1
    8000430c:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004310:	8526                	mv	a0,s1
    80004312:	baefe0ef          	jal	800026c0 <iupdate>
    80004316:	bfa9                	j	80004270 <sys_unlink+0xb6>
    80004318:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    8000431a:	8526                	mv	a0,s1
    8000431c:	e62fe0ef          	jal	8000297e <iunlockput>
  end_op();
    80004320:	d55fe0ef          	jal	80003074 <end_op>
  return -1;
    80004324:	557d                	li	a0,-1
    80004326:	64ee                	ld	s1,216(sp)
}
    80004328:	70ae                	ld	ra,232(sp)
    8000432a:	740e                	ld	s0,224(sp)
    8000432c:	616d                	addi	sp,sp,240
    8000432e:	8082                	ret
    return -1;
    80004330:	557d                	li	a0,-1
    80004332:	bfdd                	j	80004328 <sys_unlink+0x16e>
    iunlockput(ip);
    80004334:	854a                	mv	a0,s2
    80004336:	e48fe0ef          	jal	8000297e <iunlockput>
    goto bad;
    8000433a:	694e                	ld	s2,208(sp)
    8000433c:	69ae                	ld	s3,200(sp)
    8000433e:	bff1                	j	8000431a <sys_unlink+0x160>

0000000080004340 <sys_open>:

uint64
sys_open(void)
{
    80004340:	7131                	addi	sp,sp,-192
    80004342:	fd06                	sd	ra,184(sp)
    80004344:	f922                	sd	s0,176(sp)
    80004346:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004348:	f4c40593          	addi	a1,s0,-180
    8000434c:	4505                	li	a0,1
    8000434e:	9a7fd0ef          	jal	80001cf4 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004352:	08000613          	li	a2,128
    80004356:	f5040593          	addi	a1,s0,-176
    8000435a:	4501                	li	a0,0
    8000435c:	9d1fd0ef          	jal	80001d2c <argstr>
    80004360:	87aa                	mv	a5,a0
    return -1;
    80004362:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004364:	0a07c263          	bltz	a5,80004408 <sys_open+0xc8>
    80004368:	f526                	sd	s1,168(sp)

  begin_op();
    8000436a:	ca1fe0ef          	jal	8000300a <begin_op>

  if(omode & O_CREATE){
    8000436e:	f4c42783          	lw	a5,-180(s0)
    80004372:	2007f793          	andi	a5,a5,512
    80004376:	c3d5                	beqz	a5,8000441a <sys_open+0xda>
    ip = create(path, T_FILE, 0, 0);
    80004378:	4681                	li	a3,0
    8000437a:	4601                	li	a2,0
    8000437c:	4589                	li	a1,2
    8000437e:	f5040513          	addi	a0,s0,-176
    80004382:	aa9ff0ef          	jal	80003e2a <create>
    80004386:	84aa                	mv	s1,a0
    if(ip == 0){
    80004388:	c541                	beqz	a0,80004410 <sys_open+0xd0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000438a:	04449703          	lh	a4,68(s1)
    8000438e:	478d                	li	a5,3
    80004390:	00f71763          	bne	a4,a5,8000439e <sys_open+0x5e>
    80004394:	0464d703          	lhu	a4,70(s1)
    80004398:	47a5                	li	a5,9
    8000439a:	0ae7ed63          	bltu	a5,a4,80004454 <sys_open+0x114>
    8000439e:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800043a0:	fe1fe0ef          	jal	80003380 <filealloc>
    800043a4:	892a                	mv	s2,a0
    800043a6:	c179                	beqz	a0,8000446c <sys_open+0x12c>
    800043a8:	ed4e                	sd	s3,152(sp)
    800043aa:	a43ff0ef          	jal	80003dec <fdalloc>
    800043ae:	89aa                	mv	s3,a0
    800043b0:	0a054a63          	bltz	a0,80004464 <sys_open+0x124>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    800043b4:	04449703          	lh	a4,68(s1)
    800043b8:	478d                	li	a5,3
    800043ba:	0cf70263          	beq	a4,a5,8000447e <sys_open+0x13e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    800043be:	4789                	li	a5,2
    800043c0:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    800043c4:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    800043c8:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    800043cc:	f4c42783          	lw	a5,-180(s0)
    800043d0:	0017c713          	xori	a4,a5,1
    800043d4:	8b05                	andi	a4,a4,1
    800043d6:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    800043da:	0037f713          	andi	a4,a5,3
    800043de:	00e03733          	snez	a4,a4
    800043e2:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    800043e6:	4007f793          	andi	a5,a5,1024
    800043ea:	c791                	beqz	a5,800043f6 <sys_open+0xb6>
    800043ec:	04449703          	lh	a4,68(s1)
    800043f0:	4789                	li	a5,2
    800043f2:	08f70d63          	beq	a4,a5,8000448c <sys_open+0x14c>
    itrunc(ip);
  }

  iunlock(ip);
    800043f6:	8526                	mv	a0,s1
    800043f8:	c2afe0ef          	jal	80002822 <iunlock>
  end_op();
    800043fc:	c79fe0ef          	jal	80003074 <end_op>

  return fd;
    80004400:	854e                	mv	a0,s3
    80004402:	74aa                	ld	s1,168(sp)
    80004404:	790a                	ld	s2,160(sp)
    80004406:	69ea                	ld	s3,152(sp)
}
    80004408:	70ea                	ld	ra,184(sp)
    8000440a:	744a                	ld	s0,176(sp)
    8000440c:	6129                	addi	sp,sp,192
    8000440e:	8082                	ret
      end_op();
    80004410:	c65fe0ef          	jal	80003074 <end_op>
      return -1;
    80004414:	557d                	li	a0,-1
    80004416:	74aa                	ld	s1,168(sp)
    80004418:	bfc5                	j	80004408 <sys_open+0xc8>
    if((ip = namei(path)) == 0){
    8000441a:	f5040513          	addi	a0,s0,-176
    8000441e:	a31fe0ef          	jal	80002e4e <namei>
    80004422:	84aa                	mv	s1,a0
    80004424:	c11d                	beqz	a0,8000444a <sys_open+0x10a>
    ilock(ip);
    80004426:	b4efe0ef          	jal	80002774 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000442a:	04449703          	lh	a4,68(s1)
    8000442e:	4785                	li	a5,1
    80004430:	f4f71de3          	bne	a4,a5,8000438a <sys_open+0x4a>
    80004434:	f4c42783          	lw	a5,-180(s0)
    80004438:	d3bd                	beqz	a5,8000439e <sys_open+0x5e>
      iunlockput(ip);
    8000443a:	8526                	mv	a0,s1
    8000443c:	d42fe0ef          	jal	8000297e <iunlockput>
      end_op();
    80004440:	c35fe0ef          	jal	80003074 <end_op>
      return -1;
    80004444:	557d                	li	a0,-1
    80004446:	74aa                	ld	s1,168(sp)
    80004448:	b7c1                	j	80004408 <sys_open+0xc8>
      end_op();
    8000444a:	c2bfe0ef          	jal	80003074 <end_op>
      return -1;
    8000444e:	557d                	li	a0,-1
    80004450:	74aa                	ld	s1,168(sp)
    80004452:	bf5d                	j	80004408 <sys_open+0xc8>
    iunlockput(ip);
    80004454:	8526                	mv	a0,s1
    80004456:	d28fe0ef          	jal	8000297e <iunlockput>
    end_op();
    8000445a:	c1bfe0ef          	jal	80003074 <end_op>
    return -1;
    8000445e:	557d                	li	a0,-1
    80004460:	74aa                	ld	s1,168(sp)
    80004462:	b75d                	j	80004408 <sys_open+0xc8>
      fileclose(f);
    80004464:	854a                	mv	a0,s2
    80004466:	fbffe0ef          	jal	80003424 <fileclose>
    8000446a:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    8000446c:	8526                	mv	a0,s1
    8000446e:	d10fe0ef          	jal	8000297e <iunlockput>
    end_op();
    80004472:	c03fe0ef          	jal	80003074 <end_op>
    return -1;
    80004476:	557d                	li	a0,-1
    80004478:	74aa                	ld	s1,168(sp)
    8000447a:	790a                	ld	s2,160(sp)
    8000447c:	b771                	j	80004408 <sys_open+0xc8>
    f->type = FD_DEVICE;
    8000447e:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    80004482:	04649783          	lh	a5,70(s1)
    80004486:	02f91223          	sh	a5,36(s2)
    8000448a:	bf3d                	j	800043c8 <sys_open+0x88>
    itrunc(ip);
    8000448c:	8526                	mv	a0,s1
    8000448e:	bd4fe0ef          	jal	80002862 <itrunc>
    80004492:	b795                	j	800043f6 <sys_open+0xb6>

0000000080004494 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004494:	7175                	addi	sp,sp,-144
    80004496:	e506                	sd	ra,136(sp)
    80004498:	e122                	sd	s0,128(sp)
    8000449a:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    8000449c:	b6ffe0ef          	jal	8000300a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800044a0:	08000613          	li	a2,128
    800044a4:	f7040593          	addi	a1,s0,-144
    800044a8:	4501                	li	a0,0
    800044aa:	883fd0ef          	jal	80001d2c <argstr>
    800044ae:	02054363          	bltz	a0,800044d4 <sys_mkdir+0x40>
    800044b2:	4681                	li	a3,0
    800044b4:	4601                	li	a2,0
    800044b6:	4585                	li	a1,1
    800044b8:	f7040513          	addi	a0,s0,-144
    800044bc:	96fff0ef          	jal	80003e2a <create>
    800044c0:	c911                	beqz	a0,800044d4 <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800044c2:	cbcfe0ef          	jal	8000297e <iunlockput>
  end_op();
    800044c6:	baffe0ef          	jal	80003074 <end_op>
  return 0;
    800044ca:	4501                	li	a0,0
}
    800044cc:	60aa                	ld	ra,136(sp)
    800044ce:	640a                	ld	s0,128(sp)
    800044d0:	6149                	addi	sp,sp,144
    800044d2:	8082                	ret
    end_op();
    800044d4:	ba1fe0ef          	jal	80003074 <end_op>
    return -1;
    800044d8:	557d                	li	a0,-1
    800044da:	bfcd                	j	800044cc <sys_mkdir+0x38>

00000000800044dc <sys_mknod>:

uint64
sys_mknod(void)
{
    800044dc:	7135                	addi	sp,sp,-160
    800044de:	ed06                	sd	ra,152(sp)
    800044e0:	e922                	sd	s0,144(sp)
    800044e2:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    800044e4:	b27fe0ef          	jal	8000300a <begin_op>
  argint(1, &major);
    800044e8:	f6c40593          	addi	a1,s0,-148
    800044ec:	4505                	li	a0,1
    800044ee:	807fd0ef          	jal	80001cf4 <argint>
  argint(2, &minor);
    800044f2:	f6840593          	addi	a1,s0,-152
    800044f6:	4509                	li	a0,2
    800044f8:	ffcfd0ef          	jal	80001cf4 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800044fc:	08000613          	li	a2,128
    80004500:	f7040593          	addi	a1,s0,-144
    80004504:	4501                	li	a0,0
    80004506:	827fd0ef          	jal	80001d2c <argstr>
    8000450a:	02054563          	bltz	a0,80004534 <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    8000450e:	f6841683          	lh	a3,-152(s0)
    80004512:	f6c41603          	lh	a2,-148(s0)
    80004516:	458d                	li	a1,3
    80004518:	f7040513          	addi	a0,s0,-144
    8000451c:	90fff0ef          	jal	80003e2a <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004520:	c911                	beqz	a0,80004534 <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004522:	c5cfe0ef          	jal	8000297e <iunlockput>
  end_op();
    80004526:	b4ffe0ef          	jal	80003074 <end_op>
  return 0;
    8000452a:	4501                	li	a0,0
}
    8000452c:	60ea                	ld	ra,152(sp)
    8000452e:	644a                	ld	s0,144(sp)
    80004530:	610d                	addi	sp,sp,160
    80004532:	8082                	ret
    end_op();
    80004534:	b41fe0ef          	jal	80003074 <end_op>
    return -1;
    80004538:	557d                	li	a0,-1
    8000453a:	bfcd                	j	8000452c <sys_mknod+0x50>

000000008000453c <sys_chdir>:

uint64
sys_chdir(void)
{
    8000453c:	7135                	addi	sp,sp,-160
    8000453e:	ed06                	sd	ra,152(sp)
    80004540:	e922                	sd	s0,144(sp)
    80004542:	e14a                	sd	s2,128(sp)
    80004544:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004546:	85bfc0ef          	jal	80000da0 <myproc>
    8000454a:	892a                	mv	s2,a0
  
  begin_op();
    8000454c:	abffe0ef          	jal	8000300a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004550:	08000613          	li	a2,128
    80004554:	f6040593          	addi	a1,s0,-160
    80004558:	4501                	li	a0,0
    8000455a:	fd2fd0ef          	jal	80001d2c <argstr>
    8000455e:	04054363          	bltz	a0,800045a4 <sys_chdir+0x68>
    80004562:	e526                	sd	s1,136(sp)
    80004564:	f6040513          	addi	a0,s0,-160
    80004568:	8e7fe0ef          	jal	80002e4e <namei>
    8000456c:	84aa                	mv	s1,a0
    8000456e:	c915                	beqz	a0,800045a2 <sys_chdir+0x66>
    end_op();
    return -1;
  }
  ilock(ip);
    80004570:	a04fe0ef          	jal	80002774 <ilock>
  if(ip->type != T_DIR){
    80004574:	04449703          	lh	a4,68(s1)
    80004578:	4785                	li	a5,1
    8000457a:	02f71963          	bne	a4,a5,800045ac <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    8000457e:	8526                	mv	a0,s1
    80004580:	aa2fe0ef          	jal	80002822 <iunlock>
  iput(p->cwd);
    80004584:	15093503          	ld	a0,336(s2)
    80004588:	b6efe0ef          	jal	800028f6 <iput>
  end_op();
    8000458c:	ae9fe0ef          	jal	80003074 <end_op>
  p->cwd = ip;
    80004590:	14993823          	sd	s1,336(s2)
  return 0;
    80004594:	4501                	li	a0,0
    80004596:	64aa                	ld	s1,136(sp)
}
    80004598:	60ea                	ld	ra,152(sp)
    8000459a:	644a                	ld	s0,144(sp)
    8000459c:	690a                	ld	s2,128(sp)
    8000459e:	610d                	addi	sp,sp,160
    800045a0:	8082                	ret
    800045a2:	64aa                	ld	s1,136(sp)
    end_op();
    800045a4:	ad1fe0ef          	jal	80003074 <end_op>
    return -1;
    800045a8:	557d                	li	a0,-1
    800045aa:	b7fd                	j	80004598 <sys_chdir+0x5c>
    iunlockput(ip);
    800045ac:	8526                	mv	a0,s1
    800045ae:	bd0fe0ef          	jal	8000297e <iunlockput>
    end_op();
    800045b2:	ac3fe0ef          	jal	80003074 <end_op>
    return -1;
    800045b6:	557d                	li	a0,-1
    800045b8:	64aa                	ld	s1,136(sp)
    800045ba:	bff9                	j	80004598 <sys_chdir+0x5c>

00000000800045bc <sys_exec>:

uint64
sys_exec(void)
{
    800045bc:	7121                	addi	sp,sp,-448
    800045be:	ff06                	sd	ra,440(sp)
    800045c0:	fb22                	sd	s0,432(sp)
    800045c2:	0380                	addi	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    800045c4:	e4840593          	addi	a1,s0,-440
    800045c8:	4505                	li	a0,1
    800045ca:	f46fd0ef          	jal	80001d10 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    800045ce:	08000613          	li	a2,128
    800045d2:	f5040593          	addi	a1,s0,-176
    800045d6:	4501                	li	a0,0
    800045d8:	f54fd0ef          	jal	80001d2c <argstr>
    800045dc:	87aa                	mv	a5,a0
    return -1;
    800045de:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    800045e0:	0c07c463          	bltz	a5,800046a8 <sys_exec+0xec>
    800045e4:	f726                	sd	s1,424(sp)
    800045e6:	f34a                	sd	s2,416(sp)
    800045e8:	ef4e                	sd	s3,408(sp)
    800045ea:	eb52                	sd	s4,400(sp)
  }
  memset(argv, 0, sizeof(argv));
    800045ec:	10000613          	li	a2,256
    800045f0:	4581                	li	a1,0
    800045f2:	e5040513          	addi	a0,s0,-432
    800045f6:	b59fb0ef          	jal	8000014e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800045fa:	e5040493          	addi	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    800045fe:	89a6                	mv	s3,s1
    80004600:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004602:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004606:	00391513          	slli	a0,s2,0x3
    8000460a:	e4040593          	addi	a1,s0,-448
    8000460e:	e4843783          	ld	a5,-440(s0)
    80004612:	953e                	add	a0,a0,a5
    80004614:	e56fd0ef          	jal	80001c6a <fetchaddr>
    80004618:	02054663          	bltz	a0,80004644 <sys_exec+0x88>
      goto bad;
    }
    if(uarg == 0){
    8000461c:	e4043783          	ld	a5,-448(s0)
    80004620:	c3a9                	beqz	a5,80004662 <sys_exec+0xa6>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004622:	addfb0ef          	jal	800000fe <kalloc>
    80004626:	85aa                	mv	a1,a0
    80004628:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    8000462c:	cd01                	beqz	a0,80004644 <sys_exec+0x88>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000462e:	6605                	lui	a2,0x1
    80004630:	e4043503          	ld	a0,-448(s0)
    80004634:	e80fd0ef          	jal	80001cb4 <fetchstr>
    80004638:	00054663          	bltz	a0,80004644 <sys_exec+0x88>
    if(i >= NELEM(argv)){
    8000463c:	0905                	addi	s2,s2,1
    8000463e:	09a1                	addi	s3,s3,8
    80004640:	fd4913e3          	bne	s2,s4,80004606 <sys_exec+0x4a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004644:	f5040913          	addi	s2,s0,-176
    80004648:	6088                	ld	a0,0(s1)
    8000464a:	c931                	beqz	a0,8000469e <sys_exec+0xe2>
    kfree(argv[i]);
    8000464c:	9d1fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004650:	04a1                	addi	s1,s1,8
    80004652:	ff249be3          	bne	s1,s2,80004648 <sys_exec+0x8c>
  return -1;
    80004656:	557d                	li	a0,-1
    80004658:	74ba                	ld	s1,424(sp)
    8000465a:	791a                	ld	s2,416(sp)
    8000465c:	69fa                	ld	s3,408(sp)
    8000465e:	6a5a                	ld	s4,400(sp)
    80004660:	a0a1                	j	800046a8 <sys_exec+0xec>
      argv[i] = 0;
    80004662:	0009079b          	sext.w	a5,s2
    80004666:	078e                	slli	a5,a5,0x3
    80004668:	fd078793          	addi	a5,a5,-48
    8000466c:	97a2                	add	a5,a5,s0
    8000466e:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    80004672:	e5040593          	addi	a1,s0,-432
    80004676:	f5040513          	addi	a0,s0,-176
    8000467a:	ba8ff0ef          	jal	80003a22 <exec>
    8000467e:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004680:	f5040993          	addi	s3,s0,-176
    80004684:	6088                	ld	a0,0(s1)
    80004686:	c511                	beqz	a0,80004692 <sys_exec+0xd6>
    kfree(argv[i]);
    80004688:	995fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000468c:	04a1                	addi	s1,s1,8
    8000468e:	ff349be3          	bne	s1,s3,80004684 <sys_exec+0xc8>
  return ret;
    80004692:	854a                	mv	a0,s2
    80004694:	74ba                	ld	s1,424(sp)
    80004696:	791a                	ld	s2,416(sp)
    80004698:	69fa                	ld	s3,408(sp)
    8000469a:	6a5a                	ld	s4,400(sp)
    8000469c:	a031                	j	800046a8 <sys_exec+0xec>
  return -1;
    8000469e:	557d                	li	a0,-1
    800046a0:	74ba                	ld	s1,424(sp)
    800046a2:	791a                	ld	s2,416(sp)
    800046a4:	69fa                	ld	s3,408(sp)
    800046a6:	6a5a                	ld	s4,400(sp)
}
    800046a8:	70fa                	ld	ra,440(sp)
    800046aa:	745a                	ld	s0,432(sp)
    800046ac:	6139                	addi	sp,sp,448
    800046ae:	8082                	ret

00000000800046b0 <sys_pipe>:

uint64
sys_pipe(void)
{
    800046b0:	7139                	addi	sp,sp,-64
    800046b2:	fc06                	sd	ra,56(sp)
    800046b4:	f822                	sd	s0,48(sp)
    800046b6:	f426                	sd	s1,40(sp)
    800046b8:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800046ba:	ee6fc0ef          	jal	80000da0 <myproc>
    800046be:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    800046c0:	fd840593          	addi	a1,s0,-40
    800046c4:	4501                	li	a0,0
    800046c6:	e4afd0ef          	jal	80001d10 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    800046ca:	fc840593          	addi	a1,s0,-56
    800046ce:	fd040513          	addi	a0,s0,-48
    800046d2:	85cff0ef          	jal	8000372e <pipealloc>
    return -1;
    800046d6:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800046d8:	0a054463          	bltz	a0,80004780 <sys_pipe+0xd0>
  fd0 = -1;
    800046dc:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800046e0:	fd043503          	ld	a0,-48(s0)
    800046e4:	f08ff0ef          	jal	80003dec <fdalloc>
    800046e8:	fca42223          	sw	a0,-60(s0)
    800046ec:	08054163          	bltz	a0,8000476e <sys_pipe+0xbe>
    800046f0:	fc843503          	ld	a0,-56(s0)
    800046f4:	ef8ff0ef          	jal	80003dec <fdalloc>
    800046f8:	fca42023          	sw	a0,-64(s0)
    800046fc:	06054063          	bltz	a0,8000475c <sys_pipe+0xac>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004700:	4691                	li	a3,4
    80004702:	fc440613          	addi	a2,s0,-60
    80004706:	fd843583          	ld	a1,-40(s0)
    8000470a:	68a8                	ld	a0,80(s1)
    8000470c:	ae6fc0ef          	jal	800009f2 <copyout>
    80004710:	00054e63          	bltz	a0,8000472c <sys_pipe+0x7c>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80004714:	4691                	li	a3,4
    80004716:	fc040613          	addi	a2,s0,-64
    8000471a:	fd843583          	ld	a1,-40(s0)
    8000471e:	0591                	addi	a1,a1,4
    80004720:	68a8                	ld	a0,80(s1)
    80004722:	ad0fc0ef          	jal	800009f2 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80004726:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004728:	04055c63          	bgez	a0,80004780 <sys_pipe+0xd0>
    p->ofile[fd0] = 0;
    8000472c:	fc442783          	lw	a5,-60(s0)
    80004730:	07e9                	addi	a5,a5,26
    80004732:	078e                	slli	a5,a5,0x3
    80004734:	97a6                	add	a5,a5,s1
    80004736:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8000473a:	fc042783          	lw	a5,-64(s0)
    8000473e:	07e9                	addi	a5,a5,26
    80004740:	078e                	slli	a5,a5,0x3
    80004742:	94be                	add	s1,s1,a5
    80004744:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80004748:	fd043503          	ld	a0,-48(s0)
    8000474c:	cd9fe0ef          	jal	80003424 <fileclose>
    fileclose(wf);
    80004750:	fc843503          	ld	a0,-56(s0)
    80004754:	cd1fe0ef          	jal	80003424 <fileclose>
    return -1;
    80004758:	57fd                	li	a5,-1
    8000475a:	a01d                	j	80004780 <sys_pipe+0xd0>
    if(fd0 >= 0)
    8000475c:	fc442783          	lw	a5,-60(s0)
    80004760:	0007c763          	bltz	a5,8000476e <sys_pipe+0xbe>
      p->ofile[fd0] = 0;
    80004764:	07e9                	addi	a5,a5,26
    80004766:	078e                	slli	a5,a5,0x3
    80004768:	97a6                	add	a5,a5,s1
    8000476a:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    8000476e:	fd043503          	ld	a0,-48(s0)
    80004772:	cb3fe0ef          	jal	80003424 <fileclose>
    fileclose(wf);
    80004776:	fc843503          	ld	a0,-56(s0)
    8000477a:	cabfe0ef          	jal	80003424 <fileclose>
    return -1;
    8000477e:	57fd                	li	a5,-1
}
    80004780:	853e                	mv	a0,a5
    80004782:	70e2                	ld	ra,56(sp)
    80004784:	7442                	ld	s0,48(sp)
    80004786:	74a2                	ld	s1,40(sp)
    80004788:	6121                	addi	sp,sp,64
    8000478a:	8082                	ret
    8000478c:	0000                	unimp
	...

0000000080004790 <kernelvec>:
    80004790:	7111                	addi	sp,sp,-256
    80004792:	e006                	sd	ra,0(sp)
    80004794:	e40a                	sd	sp,8(sp)
    80004796:	e80e                	sd	gp,16(sp)
    80004798:	ec12                	sd	tp,24(sp)
    8000479a:	f016                	sd	t0,32(sp)
    8000479c:	f41a                	sd	t1,40(sp)
    8000479e:	f81e                	sd	t2,48(sp)
    800047a0:	e4aa                	sd	a0,72(sp)
    800047a2:	e8ae                	sd	a1,80(sp)
    800047a4:	ecb2                	sd	a2,88(sp)
    800047a6:	f0b6                	sd	a3,96(sp)
    800047a8:	f4ba                	sd	a4,104(sp)
    800047aa:	f8be                	sd	a5,112(sp)
    800047ac:	fcc2                	sd	a6,120(sp)
    800047ae:	e146                	sd	a7,128(sp)
    800047b0:	edf2                	sd	t3,216(sp)
    800047b2:	f1f6                	sd	t4,224(sp)
    800047b4:	f5fa                	sd	t5,232(sp)
    800047b6:	f9fe                	sd	t6,240(sp)
    800047b8:	bc2fd0ef          	jal	80001b7a <kerneltrap>
    800047bc:	6082                	ld	ra,0(sp)
    800047be:	6122                	ld	sp,8(sp)
    800047c0:	61c2                	ld	gp,16(sp)
    800047c2:	7282                	ld	t0,32(sp)
    800047c4:	7322                	ld	t1,40(sp)
    800047c6:	73c2                	ld	t2,48(sp)
    800047c8:	6526                	ld	a0,72(sp)
    800047ca:	65c6                	ld	a1,80(sp)
    800047cc:	6666                	ld	a2,88(sp)
    800047ce:	7686                	ld	a3,96(sp)
    800047d0:	7726                	ld	a4,104(sp)
    800047d2:	77c6                	ld	a5,112(sp)
    800047d4:	7866                	ld	a6,120(sp)
    800047d6:	688a                	ld	a7,128(sp)
    800047d8:	6e6e                	ld	t3,216(sp)
    800047da:	7e8e                	ld	t4,224(sp)
    800047dc:	7f2e                	ld	t5,232(sp)
    800047de:	7fce                	ld	t6,240(sp)
    800047e0:	6111                	addi	sp,sp,256
    800047e2:	10200073          	sret
	...

00000000800047ee <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800047ee:	1141                	addi	sp,sp,-16
    800047f0:	e422                	sd	s0,8(sp)
    800047f2:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800047f4:	0c0007b7          	lui	a5,0xc000
    800047f8:	4705                	li	a4,1
    800047fa:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800047fc:	0c0007b7          	lui	a5,0xc000
    80004800:	c3d8                	sw	a4,4(a5)
}
    80004802:	6422                	ld	s0,8(sp)
    80004804:	0141                	addi	sp,sp,16
    80004806:	8082                	ret

0000000080004808 <plicinithart>:

void
plicinithart(void)
{
    80004808:	1141                	addi	sp,sp,-16
    8000480a:	e406                	sd	ra,8(sp)
    8000480c:	e022                	sd	s0,0(sp)
    8000480e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80004810:	d64fc0ef          	jal	80000d74 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80004814:	0085171b          	slliw	a4,a0,0x8
    80004818:	0c0027b7          	lui	a5,0xc002
    8000481c:	97ba                	add	a5,a5,a4
    8000481e:	40200713          	li	a4,1026
    80004822:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80004826:	00d5151b          	slliw	a0,a0,0xd
    8000482a:	0c2017b7          	lui	a5,0xc201
    8000482e:	97aa                	add	a5,a5,a0
    80004830:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80004834:	60a2                	ld	ra,8(sp)
    80004836:	6402                	ld	s0,0(sp)
    80004838:	0141                	addi	sp,sp,16
    8000483a:	8082                	ret

000000008000483c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    8000483c:	1141                	addi	sp,sp,-16
    8000483e:	e406                	sd	ra,8(sp)
    80004840:	e022                	sd	s0,0(sp)
    80004842:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80004844:	d30fc0ef          	jal	80000d74 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80004848:	00d5151b          	slliw	a0,a0,0xd
    8000484c:	0c2017b7          	lui	a5,0xc201
    80004850:	97aa                	add	a5,a5,a0
  return irq;
}
    80004852:	43c8                	lw	a0,4(a5)
    80004854:	60a2                	ld	ra,8(sp)
    80004856:	6402                	ld	s0,0(sp)
    80004858:	0141                	addi	sp,sp,16
    8000485a:	8082                	ret

000000008000485c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000485c:	1101                	addi	sp,sp,-32
    8000485e:	ec06                	sd	ra,24(sp)
    80004860:	e822                	sd	s0,16(sp)
    80004862:	e426                	sd	s1,8(sp)
    80004864:	1000                	addi	s0,sp,32
    80004866:	84aa                	mv	s1,a0
  int hart = cpuid();
    80004868:	d0cfc0ef          	jal	80000d74 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000486c:	00d5151b          	slliw	a0,a0,0xd
    80004870:	0c2017b7          	lui	a5,0xc201
    80004874:	97aa                	add	a5,a5,a0
    80004876:	c3c4                	sw	s1,4(a5)
}
    80004878:	60e2                	ld	ra,24(sp)
    8000487a:	6442                	ld	s0,16(sp)
    8000487c:	64a2                	ld	s1,8(sp)
    8000487e:	6105                	addi	sp,sp,32
    80004880:	8082                	ret

0000000080004882 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80004882:	1141                	addi	sp,sp,-16
    80004884:	e406                	sd	ra,8(sp)
    80004886:	e022                	sd	s0,0(sp)
    80004888:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000488a:	479d                	li	a5,7
    8000488c:	04a7ca63          	blt	a5,a0,800048e0 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    80004890:	00017797          	auipc	a5,0x17
    80004894:	d8078793          	addi	a5,a5,-640 # 8001b610 <disk>
    80004898:	97aa                	add	a5,a5,a0
    8000489a:	0187c783          	lbu	a5,24(a5)
    8000489e:	e7b9                	bnez	a5,800048ec <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800048a0:	00451693          	slli	a3,a0,0x4
    800048a4:	00017797          	auipc	a5,0x17
    800048a8:	d6c78793          	addi	a5,a5,-660 # 8001b610 <disk>
    800048ac:	6398                	ld	a4,0(a5)
    800048ae:	9736                	add	a4,a4,a3
    800048b0:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    800048b4:	6398                	ld	a4,0(a5)
    800048b6:	9736                	add	a4,a4,a3
    800048b8:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    800048bc:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800048c0:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800048c4:	97aa                	add	a5,a5,a0
    800048c6:	4705                	li	a4,1
    800048c8:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800048cc:	00017517          	auipc	a0,0x17
    800048d0:	d5c50513          	addi	a0,a0,-676 # 8001b628 <disk+0x18>
    800048d4:	b87fc0ef          	jal	8000145a <wakeup>
}
    800048d8:	60a2                	ld	ra,8(sp)
    800048da:	6402                	ld	s0,0(sp)
    800048dc:	0141                	addi	sp,sp,16
    800048de:	8082                	ret
    panic("free_desc 1");
    800048e0:	00003517          	auipc	a0,0x3
    800048e4:	d4050513          	addi	a0,a0,-704 # 80007620 <etext+0x620>
    800048e8:	43b000ef          	jal	80005522 <panic>
    panic("free_desc 2");
    800048ec:	00003517          	auipc	a0,0x3
    800048f0:	d4450513          	addi	a0,a0,-700 # 80007630 <etext+0x630>
    800048f4:	42f000ef          	jal	80005522 <panic>

00000000800048f8 <virtio_disk_init>:
{
    800048f8:	1101                	addi	sp,sp,-32
    800048fa:	ec06                	sd	ra,24(sp)
    800048fc:	e822                	sd	s0,16(sp)
    800048fe:	e426                	sd	s1,8(sp)
    80004900:	e04a                	sd	s2,0(sp)
    80004902:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80004904:	00003597          	auipc	a1,0x3
    80004908:	d3c58593          	addi	a1,a1,-708 # 80007640 <etext+0x640>
    8000490c:	00017517          	auipc	a0,0x17
    80004910:	e2c50513          	addi	a0,a0,-468 # 8001b738 <disk+0x128>
    80004914:	6bd000ef          	jal	800057d0 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80004918:	100017b7          	lui	a5,0x10001
    8000491c:	4398                	lw	a4,0(a5)
    8000491e:	2701                	sext.w	a4,a4
    80004920:	747277b7          	lui	a5,0x74727
    80004924:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80004928:	18f71063          	bne	a4,a5,80004aa8 <virtio_disk_init+0x1b0>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    8000492c:	100017b7          	lui	a5,0x10001
    80004930:	0791                	addi	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    80004932:	439c                	lw	a5,0(a5)
    80004934:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80004936:	4709                	li	a4,2
    80004938:	16e79863          	bne	a5,a4,80004aa8 <virtio_disk_init+0x1b0>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000493c:	100017b7          	lui	a5,0x10001
    80004940:	07a1                	addi	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    80004942:	439c                	lw	a5,0(a5)
    80004944:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80004946:	16e79163          	bne	a5,a4,80004aa8 <virtio_disk_init+0x1b0>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000494a:	100017b7          	lui	a5,0x10001
    8000494e:	47d8                	lw	a4,12(a5)
    80004950:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80004952:	554d47b7          	lui	a5,0x554d4
    80004956:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000495a:	14f71763          	bne	a4,a5,80004aa8 <virtio_disk_init+0x1b0>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000495e:	100017b7          	lui	a5,0x10001
    80004962:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80004966:	4705                	li	a4,1
    80004968:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000496a:	470d                	li	a4,3
    8000496c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000496e:	10001737          	lui	a4,0x10001
    80004972:	4b14                	lw	a3,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80004974:	c7ffe737          	lui	a4,0xc7ffe
    80004978:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdaf0f>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    8000497c:	8ef9                	and	a3,a3,a4
    8000497e:	10001737          	lui	a4,0x10001
    80004982:	d314                	sw	a3,32(a4)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004984:	472d                	li	a4,11
    80004986:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004988:	07078793          	addi	a5,a5,112
  status = *R(VIRTIO_MMIO_STATUS);
    8000498c:	439c                	lw	a5,0(a5)
    8000498e:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80004992:	8ba1                	andi	a5,a5,8
    80004994:	12078063          	beqz	a5,80004ab4 <virtio_disk_init+0x1bc>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80004998:	100017b7          	lui	a5,0x10001
    8000499c:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    800049a0:	100017b7          	lui	a5,0x10001
    800049a4:	04478793          	addi	a5,a5,68 # 10001044 <_entry-0x6fffefbc>
    800049a8:	439c                	lw	a5,0(a5)
    800049aa:	2781                	sext.w	a5,a5
    800049ac:	10079a63          	bnez	a5,80004ac0 <virtio_disk_init+0x1c8>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800049b0:	100017b7          	lui	a5,0x10001
    800049b4:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    800049b8:	439c                	lw	a5,0(a5)
    800049ba:	2781                	sext.w	a5,a5
  if(max == 0)
    800049bc:	10078863          	beqz	a5,80004acc <virtio_disk_init+0x1d4>
  if(max < NUM)
    800049c0:	471d                	li	a4,7
    800049c2:	10f77b63          	bgeu	a4,a5,80004ad8 <virtio_disk_init+0x1e0>
  disk.desc = kalloc();
    800049c6:	f38fb0ef          	jal	800000fe <kalloc>
    800049ca:	00017497          	auipc	s1,0x17
    800049ce:	c4648493          	addi	s1,s1,-954 # 8001b610 <disk>
    800049d2:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800049d4:	f2afb0ef          	jal	800000fe <kalloc>
    800049d8:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800049da:	f24fb0ef          	jal	800000fe <kalloc>
    800049de:	87aa                	mv	a5,a0
    800049e0:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    800049e2:	6088                	ld	a0,0(s1)
    800049e4:	10050063          	beqz	a0,80004ae4 <virtio_disk_init+0x1ec>
    800049e8:	00017717          	auipc	a4,0x17
    800049ec:	c3073703          	ld	a4,-976(a4) # 8001b618 <disk+0x8>
    800049f0:	0e070a63          	beqz	a4,80004ae4 <virtio_disk_init+0x1ec>
    800049f4:	0e078863          	beqz	a5,80004ae4 <virtio_disk_init+0x1ec>
  memset(disk.desc, 0, PGSIZE);
    800049f8:	6605                	lui	a2,0x1
    800049fa:	4581                	li	a1,0
    800049fc:	f52fb0ef          	jal	8000014e <memset>
  memset(disk.avail, 0, PGSIZE);
    80004a00:	00017497          	auipc	s1,0x17
    80004a04:	c1048493          	addi	s1,s1,-1008 # 8001b610 <disk>
    80004a08:	6605                	lui	a2,0x1
    80004a0a:	4581                	li	a1,0
    80004a0c:	6488                	ld	a0,8(s1)
    80004a0e:	f40fb0ef          	jal	8000014e <memset>
  memset(disk.used, 0, PGSIZE);
    80004a12:	6605                	lui	a2,0x1
    80004a14:	4581                	li	a1,0
    80004a16:	6888                	ld	a0,16(s1)
    80004a18:	f36fb0ef          	jal	8000014e <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80004a1c:	100017b7          	lui	a5,0x10001
    80004a20:	4721                	li	a4,8
    80004a22:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80004a24:	4098                	lw	a4,0(s1)
    80004a26:	100017b7          	lui	a5,0x10001
    80004a2a:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80004a2e:	40d8                	lw	a4,4(s1)
    80004a30:	100017b7          	lui	a5,0x10001
    80004a34:	08e7a223          	sw	a4,132(a5) # 10001084 <_entry-0x6fffef7c>
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80004a38:	649c                	ld	a5,8(s1)
    80004a3a:	0007869b          	sext.w	a3,a5
    80004a3e:	10001737          	lui	a4,0x10001
    80004a42:	08d72823          	sw	a3,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80004a46:	9781                	srai	a5,a5,0x20
    80004a48:	10001737          	lui	a4,0x10001
    80004a4c:	08f72a23          	sw	a5,148(a4) # 10001094 <_entry-0x6fffef6c>
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80004a50:	689c                	ld	a5,16(s1)
    80004a52:	0007869b          	sext.w	a3,a5
    80004a56:	10001737          	lui	a4,0x10001
    80004a5a:	0ad72023          	sw	a3,160(a4) # 100010a0 <_entry-0x6fffef60>
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80004a5e:	9781                	srai	a5,a5,0x20
    80004a60:	10001737          	lui	a4,0x10001
    80004a64:	0af72223          	sw	a5,164(a4) # 100010a4 <_entry-0x6fffef5c>
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80004a68:	10001737          	lui	a4,0x10001
    80004a6c:	4785                	li	a5,1
    80004a6e:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80004a70:	00f48c23          	sb	a5,24(s1)
    80004a74:	00f48ca3          	sb	a5,25(s1)
    80004a78:	00f48d23          	sb	a5,26(s1)
    80004a7c:	00f48da3          	sb	a5,27(s1)
    80004a80:	00f48e23          	sb	a5,28(s1)
    80004a84:	00f48ea3          	sb	a5,29(s1)
    80004a88:	00f48f23          	sb	a5,30(s1)
    80004a8c:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80004a90:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a94:	100017b7          	lui	a5,0x10001
    80004a98:	0727a823          	sw	s2,112(a5) # 10001070 <_entry-0x6fffef90>
}
    80004a9c:	60e2                	ld	ra,24(sp)
    80004a9e:	6442                	ld	s0,16(sp)
    80004aa0:	64a2                	ld	s1,8(sp)
    80004aa2:	6902                	ld	s2,0(sp)
    80004aa4:	6105                	addi	sp,sp,32
    80004aa6:	8082                	ret
    panic("could not find virtio disk");
    80004aa8:	00003517          	auipc	a0,0x3
    80004aac:	ba850513          	addi	a0,a0,-1112 # 80007650 <etext+0x650>
    80004ab0:	273000ef          	jal	80005522 <panic>
    panic("virtio disk FEATURES_OK unset");
    80004ab4:	00003517          	auipc	a0,0x3
    80004ab8:	bbc50513          	addi	a0,a0,-1092 # 80007670 <etext+0x670>
    80004abc:	267000ef          	jal	80005522 <panic>
    panic("virtio disk should not be ready");
    80004ac0:	00003517          	auipc	a0,0x3
    80004ac4:	bd050513          	addi	a0,a0,-1072 # 80007690 <etext+0x690>
    80004ac8:	25b000ef          	jal	80005522 <panic>
    panic("virtio disk has no queue 0");
    80004acc:	00003517          	auipc	a0,0x3
    80004ad0:	be450513          	addi	a0,a0,-1052 # 800076b0 <etext+0x6b0>
    80004ad4:	24f000ef          	jal	80005522 <panic>
    panic("virtio disk max queue too short");
    80004ad8:	00003517          	auipc	a0,0x3
    80004adc:	bf850513          	addi	a0,a0,-1032 # 800076d0 <etext+0x6d0>
    80004ae0:	243000ef          	jal	80005522 <panic>
    panic("virtio disk kalloc");
    80004ae4:	00003517          	auipc	a0,0x3
    80004ae8:	c0c50513          	addi	a0,a0,-1012 # 800076f0 <etext+0x6f0>
    80004aec:	237000ef          	jal	80005522 <panic>

0000000080004af0 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80004af0:	7159                	addi	sp,sp,-112
    80004af2:	f486                	sd	ra,104(sp)
    80004af4:	f0a2                	sd	s0,96(sp)
    80004af6:	eca6                	sd	s1,88(sp)
    80004af8:	e8ca                	sd	s2,80(sp)
    80004afa:	e4ce                	sd	s3,72(sp)
    80004afc:	e0d2                	sd	s4,64(sp)
    80004afe:	fc56                	sd	s5,56(sp)
    80004b00:	f85a                	sd	s6,48(sp)
    80004b02:	f45e                	sd	s7,40(sp)
    80004b04:	f062                	sd	s8,32(sp)
    80004b06:	ec66                	sd	s9,24(sp)
    80004b08:	1880                	addi	s0,sp,112
    80004b0a:	8a2a                	mv	s4,a0
    80004b0c:	8bae                	mv	s7,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80004b0e:	00c52c83          	lw	s9,12(a0)
    80004b12:	001c9c9b          	slliw	s9,s9,0x1
    80004b16:	1c82                	slli	s9,s9,0x20
    80004b18:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80004b1c:	00017517          	auipc	a0,0x17
    80004b20:	c1c50513          	addi	a0,a0,-996 # 8001b738 <disk+0x128>
    80004b24:	52d000ef          	jal	80005850 <acquire>
  for(int i = 0; i < 3; i++){
    80004b28:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80004b2a:	44a1                	li	s1,8
      disk.free[i] = 0;
    80004b2c:	00017b17          	auipc	s6,0x17
    80004b30:	ae4b0b13          	addi	s6,s6,-1308 # 8001b610 <disk>
  for(int i = 0; i < 3; i++){
    80004b34:	4a8d                	li	s5,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004b36:	00017c17          	auipc	s8,0x17
    80004b3a:	c02c0c13          	addi	s8,s8,-1022 # 8001b738 <disk+0x128>
    80004b3e:	a8b9                	j	80004b9c <virtio_disk_rw+0xac>
      disk.free[i] = 0;
    80004b40:	00fb0733          	add	a4,s6,a5
    80004b44:	00070c23          	sb	zero,24(a4) # 10001018 <_entry-0x6fffefe8>
    idx[i] = alloc_desc();
    80004b48:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80004b4a:	0207c563          	bltz	a5,80004b74 <virtio_disk_rw+0x84>
  for(int i = 0; i < 3; i++){
    80004b4e:	2905                	addiw	s2,s2,1
    80004b50:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80004b52:	05590963          	beq	s2,s5,80004ba4 <virtio_disk_rw+0xb4>
    idx[i] = alloc_desc();
    80004b56:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80004b58:	00017717          	auipc	a4,0x17
    80004b5c:	ab870713          	addi	a4,a4,-1352 # 8001b610 <disk>
    80004b60:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80004b62:	01874683          	lbu	a3,24(a4)
    80004b66:	fee9                	bnez	a3,80004b40 <virtio_disk_rw+0x50>
  for(int i = 0; i < NUM; i++){
    80004b68:	2785                	addiw	a5,a5,1
    80004b6a:	0705                	addi	a4,a4,1
    80004b6c:	fe979be3          	bne	a5,s1,80004b62 <virtio_disk_rw+0x72>
    idx[i] = alloc_desc();
    80004b70:	57fd                	li	a5,-1
    80004b72:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80004b74:	01205d63          	blez	s2,80004b8e <virtio_disk_rw+0x9e>
        free_desc(idx[j]);
    80004b78:	f9042503          	lw	a0,-112(s0)
    80004b7c:	d07ff0ef          	jal	80004882 <free_desc>
      for(int j = 0; j < i; j++)
    80004b80:	4785                	li	a5,1
    80004b82:	0127d663          	bge	a5,s2,80004b8e <virtio_disk_rw+0x9e>
        free_desc(idx[j]);
    80004b86:	f9442503          	lw	a0,-108(s0)
    80004b8a:	cf9ff0ef          	jal	80004882 <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004b8e:	85e2                	mv	a1,s8
    80004b90:	00017517          	auipc	a0,0x17
    80004b94:	a9850513          	addi	a0,a0,-1384 # 8001b628 <disk+0x18>
    80004b98:	877fc0ef          	jal	8000140e <sleep>
  for(int i = 0; i < 3; i++){
    80004b9c:	f9040613          	addi	a2,s0,-112
    80004ba0:	894e                	mv	s2,s3
    80004ba2:	bf55                	j	80004b56 <virtio_disk_rw+0x66>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004ba4:	f9042503          	lw	a0,-112(s0)
    80004ba8:	00451693          	slli	a3,a0,0x4

  if(write)
    80004bac:	00017797          	auipc	a5,0x17
    80004bb0:	a6478793          	addi	a5,a5,-1436 # 8001b610 <disk>
    80004bb4:	00a50713          	addi	a4,a0,10
    80004bb8:	0712                	slli	a4,a4,0x4
    80004bba:	973e                	add	a4,a4,a5
    80004bbc:	01703633          	snez	a2,s7
    80004bc0:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80004bc2:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80004bc6:	01973823          	sd	s9,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80004bca:	6398                	ld	a4,0(a5)
    80004bcc:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004bce:	0a868613          	addi	a2,a3,168
    80004bd2:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80004bd4:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80004bd6:	6390                	ld	a2,0(a5)
    80004bd8:	00d605b3          	add	a1,a2,a3
    80004bdc:	4741                	li	a4,16
    80004bde:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80004be0:	4805                	li	a6,1
    80004be2:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    80004be6:	f9442703          	lw	a4,-108(s0)
    80004bea:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80004bee:	0712                	slli	a4,a4,0x4
    80004bf0:	963a                	add	a2,a2,a4
    80004bf2:	058a0593          	addi	a1,s4,88
    80004bf6:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80004bf8:	0007b883          	ld	a7,0(a5)
    80004bfc:	9746                	add	a4,a4,a7
    80004bfe:	40000613          	li	a2,1024
    80004c02:	c710                	sw	a2,8(a4)
  if(write)
    80004c04:	001bb613          	seqz	a2,s7
    80004c08:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80004c0c:	00166613          	ori	a2,a2,1
    80004c10:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80004c14:	f9842583          	lw	a1,-104(s0)
    80004c18:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80004c1c:	00250613          	addi	a2,a0,2
    80004c20:	0612                	slli	a2,a2,0x4
    80004c22:	963e                	add	a2,a2,a5
    80004c24:	577d                	li	a4,-1
    80004c26:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80004c2a:	0592                	slli	a1,a1,0x4
    80004c2c:	98ae                	add	a7,a7,a1
    80004c2e:	03068713          	addi	a4,a3,48
    80004c32:	973e                	add	a4,a4,a5
    80004c34:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80004c38:	6398                	ld	a4,0(a5)
    80004c3a:	972e                	add	a4,a4,a1
    80004c3c:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80004c40:	4689                	li	a3,2
    80004c42:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    80004c46:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80004c4a:	010a2223          	sw	a6,4(s4)
  disk.info[idx[0]].b = b;
    80004c4e:	01463423          	sd	s4,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80004c52:	6794                	ld	a3,8(a5)
    80004c54:	0026d703          	lhu	a4,2(a3)
    80004c58:	8b1d                	andi	a4,a4,7
    80004c5a:	0706                	slli	a4,a4,0x1
    80004c5c:	96ba                	add	a3,a3,a4
    80004c5e:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80004c62:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80004c66:	6798                	ld	a4,8(a5)
    80004c68:	00275783          	lhu	a5,2(a4)
    80004c6c:	2785                	addiw	a5,a5,1
    80004c6e:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80004c72:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80004c76:	100017b7          	lui	a5,0x10001
    80004c7a:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80004c7e:	004a2783          	lw	a5,4(s4)
    sleep(b, &disk.vdisk_lock);
    80004c82:	00017917          	auipc	s2,0x17
    80004c86:	ab690913          	addi	s2,s2,-1354 # 8001b738 <disk+0x128>
  while(b->disk == 1) {
    80004c8a:	4485                	li	s1,1
    80004c8c:	01079a63          	bne	a5,a6,80004ca0 <virtio_disk_rw+0x1b0>
    sleep(b, &disk.vdisk_lock);
    80004c90:	85ca                	mv	a1,s2
    80004c92:	8552                	mv	a0,s4
    80004c94:	f7afc0ef          	jal	8000140e <sleep>
  while(b->disk == 1) {
    80004c98:	004a2783          	lw	a5,4(s4)
    80004c9c:	fe978ae3          	beq	a5,s1,80004c90 <virtio_disk_rw+0x1a0>
  }

  disk.info[idx[0]].b = 0;
    80004ca0:	f9042903          	lw	s2,-112(s0)
    80004ca4:	00290713          	addi	a4,s2,2
    80004ca8:	0712                	slli	a4,a4,0x4
    80004caa:	00017797          	auipc	a5,0x17
    80004cae:	96678793          	addi	a5,a5,-1690 # 8001b610 <disk>
    80004cb2:	97ba                	add	a5,a5,a4
    80004cb4:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80004cb8:	00017997          	auipc	s3,0x17
    80004cbc:	95898993          	addi	s3,s3,-1704 # 8001b610 <disk>
    80004cc0:	00491713          	slli	a4,s2,0x4
    80004cc4:	0009b783          	ld	a5,0(s3)
    80004cc8:	97ba                	add	a5,a5,a4
    80004cca:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80004cce:	854a                	mv	a0,s2
    80004cd0:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80004cd4:	bafff0ef          	jal	80004882 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80004cd8:	8885                	andi	s1,s1,1
    80004cda:	f0fd                	bnez	s1,80004cc0 <virtio_disk_rw+0x1d0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80004cdc:	00017517          	auipc	a0,0x17
    80004ce0:	a5c50513          	addi	a0,a0,-1444 # 8001b738 <disk+0x128>
    80004ce4:	405000ef          	jal	800058e8 <release>
}
    80004ce8:	70a6                	ld	ra,104(sp)
    80004cea:	7406                	ld	s0,96(sp)
    80004cec:	64e6                	ld	s1,88(sp)
    80004cee:	6946                	ld	s2,80(sp)
    80004cf0:	69a6                	ld	s3,72(sp)
    80004cf2:	6a06                	ld	s4,64(sp)
    80004cf4:	7ae2                	ld	s5,56(sp)
    80004cf6:	7b42                	ld	s6,48(sp)
    80004cf8:	7ba2                	ld	s7,40(sp)
    80004cfa:	7c02                	ld	s8,32(sp)
    80004cfc:	6ce2                	ld	s9,24(sp)
    80004cfe:	6165                	addi	sp,sp,112
    80004d00:	8082                	ret

0000000080004d02 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80004d02:	1101                	addi	sp,sp,-32
    80004d04:	ec06                	sd	ra,24(sp)
    80004d06:	e822                	sd	s0,16(sp)
    80004d08:	e426                	sd	s1,8(sp)
    80004d0a:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80004d0c:	00017497          	auipc	s1,0x17
    80004d10:	90448493          	addi	s1,s1,-1788 # 8001b610 <disk>
    80004d14:	00017517          	auipc	a0,0x17
    80004d18:	a2450513          	addi	a0,a0,-1500 # 8001b738 <disk+0x128>
    80004d1c:	335000ef          	jal	80005850 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80004d20:	100017b7          	lui	a5,0x10001
    80004d24:	53b8                	lw	a4,96(a5)
    80004d26:	8b0d                	andi	a4,a4,3
    80004d28:	100017b7          	lui	a5,0x10001
    80004d2c:	d3f8                	sw	a4,100(a5)

  __sync_synchronize();
    80004d2e:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80004d32:	689c                	ld	a5,16(s1)
    80004d34:	0204d703          	lhu	a4,32(s1)
    80004d38:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80004d3c:	04f70663          	beq	a4,a5,80004d88 <virtio_disk_intr+0x86>
    __sync_synchronize();
    80004d40:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80004d44:	6898                	ld	a4,16(s1)
    80004d46:	0204d783          	lhu	a5,32(s1)
    80004d4a:	8b9d                	andi	a5,a5,7
    80004d4c:	078e                	slli	a5,a5,0x3
    80004d4e:	97ba                	add	a5,a5,a4
    80004d50:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80004d52:	00278713          	addi	a4,a5,2
    80004d56:	0712                	slli	a4,a4,0x4
    80004d58:	9726                	add	a4,a4,s1
    80004d5a:	01074703          	lbu	a4,16(a4)
    80004d5e:	e321                	bnez	a4,80004d9e <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80004d60:	0789                	addi	a5,a5,2
    80004d62:	0792                	slli	a5,a5,0x4
    80004d64:	97a6                	add	a5,a5,s1
    80004d66:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80004d68:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80004d6c:	eeefc0ef          	jal	8000145a <wakeup>

    disk.used_idx += 1;
    80004d70:	0204d783          	lhu	a5,32(s1)
    80004d74:	2785                	addiw	a5,a5,1
    80004d76:	17c2                	slli	a5,a5,0x30
    80004d78:	93c1                	srli	a5,a5,0x30
    80004d7a:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80004d7e:	6898                	ld	a4,16(s1)
    80004d80:	00275703          	lhu	a4,2(a4)
    80004d84:	faf71ee3          	bne	a4,a5,80004d40 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80004d88:	00017517          	auipc	a0,0x17
    80004d8c:	9b050513          	addi	a0,a0,-1616 # 8001b738 <disk+0x128>
    80004d90:	359000ef          	jal	800058e8 <release>
}
    80004d94:	60e2                	ld	ra,24(sp)
    80004d96:	6442                	ld	s0,16(sp)
    80004d98:	64a2                	ld	s1,8(sp)
    80004d9a:	6105                	addi	sp,sp,32
    80004d9c:	8082                	ret
      panic("virtio_disk_intr status");
    80004d9e:	00003517          	auipc	a0,0x3
    80004da2:	96a50513          	addi	a0,a0,-1686 # 80007708 <etext+0x708>
    80004da6:	77c000ef          	jal	80005522 <panic>

0000000080004daa <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80004daa:	1141                	addi	sp,sp,-16
    80004dac:	e422                	sd	s0,8(sp)
    80004dae:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mie" : "=r" (x) );
    80004db0:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80004db4:	0207e793          	ori	a5,a5,32
  asm volatile("csrw mie, %0" : : "r" (x));
    80004db8:	30479073          	csrw	mie,a5
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80004dbc:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80004dc0:	577d                	li	a4,-1
    80004dc2:	177e                	slli	a4,a4,0x3f
    80004dc4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80004dc6:	30a79073          	csrw	0x30a,a5
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80004dca:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80004dce:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80004dd2:	30679073          	csrw	mcounteren,a5
  asm volatile("csrr %0, time" : "=r" (x) );
    80004dd6:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80004dda:	000f4737          	lui	a4,0xf4
    80004dde:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80004de2:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80004de4:	14d79073          	csrw	stimecmp,a5
}
    80004de8:	6422                	ld	s0,8(sp)
    80004dea:	0141                	addi	sp,sp,16
    80004dec:	8082                	ret

0000000080004dee <start>:
{
    80004dee:	1141                	addi	sp,sp,-16
    80004df0:	e406                	sd	ra,8(sp)
    80004df2:	e022                	sd	s0,0(sp)
    80004df4:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80004df6:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80004dfa:	7779                	lui	a4,0xffffe
    80004dfc:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdafaf>
    80004e00:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80004e02:	6705                	lui	a4,0x1
    80004e04:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004e08:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80004e0a:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80004e0e:	ffffb797          	auipc	a5,0xffffb
    80004e12:	4da78793          	addi	a5,a5,1242 # 800002e8 <main>
    80004e16:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80004e1a:	4781                	li	a5,0
    80004e1c:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80004e20:	67c1                	lui	a5,0x10
    80004e22:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004e24:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80004e28:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80004e2c:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80004e30:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80004e34:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80004e38:	57fd                	li	a5,-1
    80004e3a:	83a9                	srli	a5,a5,0xa
    80004e3c:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80004e40:	47bd                	li	a5,15
    80004e42:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80004e46:	f65ff0ef          	jal	80004daa <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80004e4a:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80004e4e:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80004e50:	823e                	mv	tp,a5
  asm volatile("mret");
    80004e52:	30200073          	mret
}
    80004e56:	60a2                	ld	ra,8(sp)
    80004e58:	6402                	ld	s0,0(sp)
    80004e5a:	0141                	addi	sp,sp,16
    80004e5c:	8082                	ret

0000000080004e5e <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80004e5e:	715d                	addi	sp,sp,-80
    80004e60:	e486                	sd	ra,72(sp)
    80004e62:	e0a2                	sd	s0,64(sp)
    80004e64:	f84a                	sd	s2,48(sp)
    80004e66:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80004e68:	04c05263          	blez	a2,80004eac <consolewrite+0x4e>
    80004e6c:	fc26                	sd	s1,56(sp)
    80004e6e:	f44e                	sd	s3,40(sp)
    80004e70:	f052                	sd	s4,32(sp)
    80004e72:	ec56                	sd	s5,24(sp)
    80004e74:	8a2a                	mv	s4,a0
    80004e76:	84ae                	mv	s1,a1
    80004e78:	89b2                	mv	s3,a2
    80004e7a:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80004e7c:	5afd                	li	s5,-1
    80004e7e:	4685                	li	a3,1
    80004e80:	8626                	mv	a2,s1
    80004e82:	85d2                	mv	a1,s4
    80004e84:	fbf40513          	addi	a0,s0,-65
    80004e88:	92dfc0ef          	jal	800017b4 <either_copyin>
    80004e8c:	03550263          	beq	a0,s5,80004eb0 <consolewrite+0x52>
      break;
    uartputc(c);
    80004e90:	fbf44503          	lbu	a0,-65(s0)
    80004e94:	035000ef          	jal	800056c8 <uartputc>
  for(i = 0; i < n; i++){
    80004e98:	2905                	addiw	s2,s2,1
    80004e9a:	0485                	addi	s1,s1,1
    80004e9c:	ff2991e3          	bne	s3,s2,80004e7e <consolewrite+0x20>
    80004ea0:	894e                	mv	s2,s3
    80004ea2:	74e2                	ld	s1,56(sp)
    80004ea4:	79a2                	ld	s3,40(sp)
    80004ea6:	7a02                	ld	s4,32(sp)
    80004ea8:	6ae2                	ld	s5,24(sp)
    80004eaa:	a039                	j	80004eb8 <consolewrite+0x5a>
    80004eac:	4901                	li	s2,0
    80004eae:	a029                	j	80004eb8 <consolewrite+0x5a>
    80004eb0:	74e2                	ld	s1,56(sp)
    80004eb2:	79a2                	ld	s3,40(sp)
    80004eb4:	7a02                	ld	s4,32(sp)
    80004eb6:	6ae2                	ld	s5,24(sp)
  }

  return i;
}
    80004eb8:	854a                	mv	a0,s2
    80004eba:	60a6                	ld	ra,72(sp)
    80004ebc:	6406                	ld	s0,64(sp)
    80004ebe:	7942                	ld	s2,48(sp)
    80004ec0:	6161                	addi	sp,sp,80
    80004ec2:	8082                	ret

0000000080004ec4 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80004ec4:	711d                	addi	sp,sp,-96
    80004ec6:	ec86                	sd	ra,88(sp)
    80004ec8:	e8a2                	sd	s0,80(sp)
    80004eca:	e4a6                	sd	s1,72(sp)
    80004ecc:	e0ca                	sd	s2,64(sp)
    80004ece:	fc4e                	sd	s3,56(sp)
    80004ed0:	f852                	sd	s4,48(sp)
    80004ed2:	f456                	sd	s5,40(sp)
    80004ed4:	f05a                	sd	s6,32(sp)
    80004ed6:	1080                	addi	s0,sp,96
    80004ed8:	8aaa                	mv	s5,a0
    80004eda:	8a2e                	mv	s4,a1
    80004edc:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80004ede:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80004ee2:	0001f517          	auipc	a0,0x1f
    80004ee6:	86e50513          	addi	a0,a0,-1938 # 80023750 <cons>
    80004eea:	167000ef          	jal	80005850 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80004eee:	0001f497          	auipc	s1,0x1f
    80004ef2:	86248493          	addi	s1,s1,-1950 # 80023750 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80004ef6:	0001f917          	auipc	s2,0x1f
    80004efa:	8f290913          	addi	s2,s2,-1806 # 800237e8 <cons+0x98>
  while(n > 0){
    80004efe:	0b305d63          	blez	s3,80004fb8 <consoleread+0xf4>
    while(cons.r == cons.w){
    80004f02:	0984a783          	lw	a5,152(s1)
    80004f06:	09c4a703          	lw	a4,156(s1)
    80004f0a:	0af71263          	bne	a4,a5,80004fae <consoleread+0xea>
      if(killed(myproc())){
    80004f0e:	e93fb0ef          	jal	80000da0 <myproc>
    80004f12:	f34fc0ef          	jal	80001646 <killed>
    80004f16:	e12d                	bnez	a0,80004f78 <consoleread+0xb4>
      sleep(&cons.r, &cons.lock);
    80004f18:	85a6                	mv	a1,s1
    80004f1a:	854a                	mv	a0,s2
    80004f1c:	cf2fc0ef          	jal	8000140e <sleep>
    while(cons.r == cons.w){
    80004f20:	0984a783          	lw	a5,152(s1)
    80004f24:	09c4a703          	lw	a4,156(s1)
    80004f28:	fef703e3          	beq	a4,a5,80004f0e <consoleread+0x4a>
    80004f2c:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80004f2e:	0001f717          	auipc	a4,0x1f
    80004f32:	82270713          	addi	a4,a4,-2014 # 80023750 <cons>
    80004f36:	0017869b          	addiw	a3,a5,1
    80004f3a:	08d72c23          	sw	a3,152(a4)
    80004f3e:	07f7f693          	andi	a3,a5,127
    80004f42:	9736                	add	a4,a4,a3
    80004f44:	01874703          	lbu	a4,24(a4)
    80004f48:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    80004f4c:	4691                	li	a3,4
    80004f4e:	04db8663          	beq	s7,a3,80004f9a <consoleread+0xd6>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80004f52:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80004f56:	4685                	li	a3,1
    80004f58:	faf40613          	addi	a2,s0,-81
    80004f5c:	85d2                	mv	a1,s4
    80004f5e:	8556                	mv	a0,s5
    80004f60:	80bfc0ef          	jal	8000176a <either_copyout>
    80004f64:	57fd                	li	a5,-1
    80004f66:	04f50863          	beq	a0,a5,80004fb6 <consoleread+0xf2>
      break;

    dst++;
    80004f6a:	0a05                	addi	s4,s4,1
    --n;
    80004f6c:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80004f6e:	47a9                	li	a5,10
    80004f70:	04fb8d63          	beq	s7,a5,80004fca <consoleread+0x106>
    80004f74:	6be2                	ld	s7,24(sp)
    80004f76:	b761                	j	80004efe <consoleread+0x3a>
        release(&cons.lock);
    80004f78:	0001e517          	auipc	a0,0x1e
    80004f7c:	7d850513          	addi	a0,a0,2008 # 80023750 <cons>
    80004f80:	169000ef          	jal	800058e8 <release>
        return -1;
    80004f84:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80004f86:	60e6                	ld	ra,88(sp)
    80004f88:	6446                	ld	s0,80(sp)
    80004f8a:	64a6                	ld	s1,72(sp)
    80004f8c:	6906                	ld	s2,64(sp)
    80004f8e:	79e2                	ld	s3,56(sp)
    80004f90:	7a42                	ld	s4,48(sp)
    80004f92:	7aa2                	ld	s5,40(sp)
    80004f94:	7b02                	ld	s6,32(sp)
    80004f96:	6125                	addi	sp,sp,96
    80004f98:	8082                	ret
      if(n < target){
    80004f9a:	0009871b          	sext.w	a4,s3
    80004f9e:	01677a63          	bgeu	a4,s6,80004fb2 <consoleread+0xee>
        cons.r--;
    80004fa2:	0001f717          	auipc	a4,0x1f
    80004fa6:	84f72323          	sw	a5,-1978(a4) # 800237e8 <cons+0x98>
    80004faa:	6be2                	ld	s7,24(sp)
    80004fac:	a031                	j	80004fb8 <consoleread+0xf4>
    80004fae:	ec5e                	sd	s7,24(sp)
    80004fb0:	bfbd                	j	80004f2e <consoleread+0x6a>
    80004fb2:	6be2                	ld	s7,24(sp)
    80004fb4:	a011                	j	80004fb8 <consoleread+0xf4>
    80004fb6:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    80004fb8:	0001e517          	auipc	a0,0x1e
    80004fbc:	79850513          	addi	a0,a0,1944 # 80023750 <cons>
    80004fc0:	129000ef          	jal	800058e8 <release>
  return target - n;
    80004fc4:	413b053b          	subw	a0,s6,s3
    80004fc8:	bf7d                	j	80004f86 <consoleread+0xc2>
    80004fca:	6be2                	ld	s7,24(sp)
    80004fcc:	b7f5                	j	80004fb8 <consoleread+0xf4>

0000000080004fce <consputc>:
{
    80004fce:	1141                	addi	sp,sp,-16
    80004fd0:	e406                	sd	ra,8(sp)
    80004fd2:	e022                	sd	s0,0(sp)
    80004fd4:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80004fd6:	10000793          	li	a5,256
    80004fda:	00f50863          	beq	a0,a5,80004fea <consputc+0x1c>
    uartputc_sync(c);
    80004fde:	604000ef          	jal	800055e2 <uartputc_sync>
}
    80004fe2:	60a2                	ld	ra,8(sp)
    80004fe4:	6402                	ld	s0,0(sp)
    80004fe6:	0141                	addi	sp,sp,16
    80004fe8:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80004fea:	4521                	li	a0,8
    80004fec:	5f6000ef          	jal	800055e2 <uartputc_sync>
    80004ff0:	02000513          	li	a0,32
    80004ff4:	5ee000ef          	jal	800055e2 <uartputc_sync>
    80004ff8:	4521                	li	a0,8
    80004ffa:	5e8000ef          	jal	800055e2 <uartputc_sync>
    80004ffe:	b7d5                	j	80004fe2 <consputc+0x14>

0000000080005000 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005000:	1101                	addi	sp,sp,-32
    80005002:	ec06                	sd	ra,24(sp)
    80005004:	e822                	sd	s0,16(sp)
    80005006:	e426                	sd	s1,8(sp)
    80005008:	1000                	addi	s0,sp,32
    8000500a:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    8000500c:	0001e517          	auipc	a0,0x1e
    80005010:	74450513          	addi	a0,a0,1860 # 80023750 <cons>
    80005014:	03d000ef          	jal	80005850 <acquire>

  switch(c){
    80005018:	47d5                	li	a5,21
    8000501a:	08f48f63          	beq	s1,a5,800050b8 <consoleintr+0xb8>
    8000501e:	0297c563          	blt	a5,s1,80005048 <consoleintr+0x48>
    80005022:	47a1                	li	a5,8
    80005024:	0ef48463          	beq	s1,a5,8000510c <consoleintr+0x10c>
    80005028:	47c1                	li	a5,16
    8000502a:	10f49563          	bne	s1,a5,80005134 <consoleintr+0x134>
  case C('P'):  // Print process list.
    procdump();
    8000502e:	fd0fc0ef          	jal	800017fe <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005032:	0001e517          	auipc	a0,0x1e
    80005036:	71e50513          	addi	a0,a0,1822 # 80023750 <cons>
    8000503a:	0af000ef          	jal	800058e8 <release>
}
    8000503e:	60e2                	ld	ra,24(sp)
    80005040:	6442                	ld	s0,16(sp)
    80005042:	64a2                	ld	s1,8(sp)
    80005044:	6105                	addi	sp,sp,32
    80005046:	8082                	ret
  switch(c){
    80005048:	07f00793          	li	a5,127
    8000504c:	0cf48063          	beq	s1,a5,8000510c <consoleintr+0x10c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005050:	0001e717          	auipc	a4,0x1e
    80005054:	70070713          	addi	a4,a4,1792 # 80023750 <cons>
    80005058:	0a072783          	lw	a5,160(a4)
    8000505c:	09872703          	lw	a4,152(a4)
    80005060:	9f99                	subw	a5,a5,a4
    80005062:	07f00713          	li	a4,127
    80005066:	fcf766e3          	bltu	a4,a5,80005032 <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    8000506a:	47b5                	li	a5,13
    8000506c:	0cf48763          	beq	s1,a5,8000513a <consoleintr+0x13a>
      consputc(c);
    80005070:	8526                	mv	a0,s1
    80005072:	f5dff0ef          	jal	80004fce <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005076:	0001e797          	auipc	a5,0x1e
    8000507a:	6da78793          	addi	a5,a5,1754 # 80023750 <cons>
    8000507e:	0a07a683          	lw	a3,160(a5)
    80005082:	0016871b          	addiw	a4,a3,1
    80005086:	0007061b          	sext.w	a2,a4
    8000508a:	0ae7a023          	sw	a4,160(a5)
    8000508e:	07f6f693          	andi	a3,a3,127
    80005092:	97b6                	add	a5,a5,a3
    80005094:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005098:	47a9                	li	a5,10
    8000509a:	0cf48563          	beq	s1,a5,80005164 <consoleintr+0x164>
    8000509e:	4791                	li	a5,4
    800050a0:	0cf48263          	beq	s1,a5,80005164 <consoleintr+0x164>
    800050a4:	0001e797          	auipc	a5,0x1e
    800050a8:	7447a783          	lw	a5,1860(a5) # 800237e8 <cons+0x98>
    800050ac:	9f1d                	subw	a4,a4,a5
    800050ae:	08000793          	li	a5,128
    800050b2:	f8f710e3          	bne	a4,a5,80005032 <consoleintr+0x32>
    800050b6:	a07d                	j	80005164 <consoleintr+0x164>
    800050b8:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    800050ba:	0001e717          	auipc	a4,0x1e
    800050be:	69670713          	addi	a4,a4,1686 # 80023750 <cons>
    800050c2:	0a072783          	lw	a5,160(a4)
    800050c6:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800050ca:	0001e497          	auipc	s1,0x1e
    800050ce:	68648493          	addi	s1,s1,1670 # 80023750 <cons>
    while(cons.e != cons.w &&
    800050d2:	4929                	li	s2,10
    800050d4:	02f70863          	beq	a4,a5,80005104 <consoleintr+0x104>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800050d8:	37fd                	addiw	a5,a5,-1
    800050da:	07f7f713          	andi	a4,a5,127
    800050de:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800050e0:	01874703          	lbu	a4,24(a4)
    800050e4:	03270263          	beq	a4,s2,80005108 <consoleintr+0x108>
      cons.e--;
    800050e8:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800050ec:	10000513          	li	a0,256
    800050f0:	edfff0ef          	jal	80004fce <consputc>
    while(cons.e != cons.w &&
    800050f4:	0a04a783          	lw	a5,160(s1)
    800050f8:	09c4a703          	lw	a4,156(s1)
    800050fc:	fcf71ee3          	bne	a4,a5,800050d8 <consoleintr+0xd8>
    80005100:	6902                	ld	s2,0(sp)
    80005102:	bf05                	j	80005032 <consoleintr+0x32>
    80005104:	6902                	ld	s2,0(sp)
    80005106:	b735                	j	80005032 <consoleintr+0x32>
    80005108:	6902                	ld	s2,0(sp)
    8000510a:	b725                	j	80005032 <consoleintr+0x32>
    if(cons.e != cons.w){
    8000510c:	0001e717          	auipc	a4,0x1e
    80005110:	64470713          	addi	a4,a4,1604 # 80023750 <cons>
    80005114:	0a072783          	lw	a5,160(a4)
    80005118:	09c72703          	lw	a4,156(a4)
    8000511c:	f0f70be3          	beq	a4,a5,80005032 <consoleintr+0x32>
      cons.e--;
    80005120:	37fd                	addiw	a5,a5,-1
    80005122:	0001e717          	auipc	a4,0x1e
    80005126:	6cf72723          	sw	a5,1742(a4) # 800237f0 <cons+0xa0>
      consputc(BACKSPACE);
    8000512a:	10000513          	li	a0,256
    8000512e:	ea1ff0ef          	jal	80004fce <consputc>
    80005132:	b701                	j	80005032 <consoleintr+0x32>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005134:	ee048fe3          	beqz	s1,80005032 <consoleintr+0x32>
    80005138:	bf21                	j	80005050 <consoleintr+0x50>
      consputc(c);
    8000513a:	4529                	li	a0,10
    8000513c:	e93ff0ef          	jal	80004fce <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005140:	0001e797          	auipc	a5,0x1e
    80005144:	61078793          	addi	a5,a5,1552 # 80023750 <cons>
    80005148:	0a07a703          	lw	a4,160(a5)
    8000514c:	0017069b          	addiw	a3,a4,1
    80005150:	0006861b          	sext.w	a2,a3
    80005154:	0ad7a023          	sw	a3,160(a5)
    80005158:	07f77713          	andi	a4,a4,127
    8000515c:	97ba                	add	a5,a5,a4
    8000515e:	4729                	li	a4,10
    80005160:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005164:	0001e797          	auipc	a5,0x1e
    80005168:	68c7a423          	sw	a2,1672(a5) # 800237ec <cons+0x9c>
        wakeup(&cons.r);
    8000516c:	0001e517          	auipc	a0,0x1e
    80005170:	67c50513          	addi	a0,a0,1660 # 800237e8 <cons+0x98>
    80005174:	ae6fc0ef          	jal	8000145a <wakeup>
    80005178:	bd6d                	j	80005032 <consoleintr+0x32>

000000008000517a <consoleinit>:

void
consoleinit(void)
{
    8000517a:	1141                	addi	sp,sp,-16
    8000517c:	e406                	sd	ra,8(sp)
    8000517e:	e022                	sd	s0,0(sp)
    80005180:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005182:	00002597          	auipc	a1,0x2
    80005186:	59e58593          	addi	a1,a1,1438 # 80007720 <etext+0x720>
    8000518a:	0001e517          	auipc	a0,0x1e
    8000518e:	5c650513          	addi	a0,a0,1478 # 80023750 <cons>
    80005192:	63e000ef          	jal	800057d0 <initlock>

  uartinit();
    80005196:	3f4000ef          	jal	8000558a <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000519a:	00015797          	auipc	a5,0x15
    8000519e:	41e78793          	addi	a5,a5,1054 # 8001a5b8 <devsw>
    800051a2:	00000717          	auipc	a4,0x0
    800051a6:	d2270713          	addi	a4,a4,-734 # 80004ec4 <consoleread>
    800051aa:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    800051ac:	00000717          	auipc	a4,0x0
    800051b0:	cb270713          	addi	a4,a4,-846 # 80004e5e <consolewrite>
    800051b4:	ef98                	sd	a4,24(a5)
}
    800051b6:	60a2                	ld	ra,8(sp)
    800051b8:	6402                	ld	s0,0(sp)
    800051ba:	0141                	addi	sp,sp,16
    800051bc:	8082                	ret

00000000800051be <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    800051be:	7179                	addi	sp,sp,-48
    800051c0:	f406                	sd	ra,40(sp)
    800051c2:	f022                	sd	s0,32(sp)
    800051c4:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    800051c6:	c219                	beqz	a2,800051cc <printint+0xe>
    800051c8:	08054063          	bltz	a0,80005248 <printint+0x8a>
    x = -xx;
  else
    x = xx;
    800051cc:	4881                	li	a7,0
    800051ce:	fd040693          	addi	a3,s0,-48

  i = 0;
    800051d2:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    800051d4:	00002617          	auipc	a2,0x2
    800051d8:	70c60613          	addi	a2,a2,1804 # 800078e0 <digits>
    800051dc:	883e                	mv	a6,a5
    800051de:	2785                	addiw	a5,a5,1
    800051e0:	02b57733          	remu	a4,a0,a1
    800051e4:	9732                	add	a4,a4,a2
    800051e6:	00074703          	lbu	a4,0(a4)
    800051ea:	00e68023          	sb	a4,0(a3)
  } while((x /= base) != 0);
    800051ee:	872a                	mv	a4,a0
    800051f0:	02b55533          	divu	a0,a0,a1
    800051f4:	0685                	addi	a3,a3,1
    800051f6:	feb773e3          	bgeu	a4,a1,800051dc <printint+0x1e>

  if(sign)
    800051fa:	00088a63          	beqz	a7,8000520e <printint+0x50>
    buf[i++] = '-';
    800051fe:	1781                	addi	a5,a5,-32
    80005200:	97a2                	add	a5,a5,s0
    80005202:	02d00713          	li	a4,45
    80005206:	fee78823          	sb	a4,-16(a5)
    8000520a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
    8000520e:	02f05963          	blez	a5,80005240 <printint+0x82>
    80005212:	ec26                	sd	s1,24(sp)
    80005214:	e84a                	sd	s2,16(sp)
    80005216:	fd040713          	addi	a4,s0,-48
    8000521a:	00f704b3          	add	s1,a4,a5
    8000521e:	fff70913          	addi	s2,a4,-1
    80005222:	993e                	add	s2,s2,a5
    80005224:	37fd                	addiw	a5,a5,-1
    80005226:	1782                	slli	a5,a5,0x20
    80005228:	9381                	srli	a5,a5,0x20
    8000522a:	40f90933          	sub	s2,s2,a5
    consputc(buf[i]);
    8000522e:	fff4c503          	lbu	a0,-1(s1)
    80005232:	d9dff0ef          	jal	80004fce <consputc>
  while(--i >= 0)
    80005236:	14fd                	addi	s1,s1,-1
    80005238:	ff249be3          	bne	s1,s2,8000522e <printint+0x70>
    8000523c:	64e2                	ld	s1,24(sp)
    8000523e:	6942                	ld	s2,16(sp)
}
    80005240:	70a2                	ld	ra,40(sp)
    80005242:	7402                	ld	s0,32(sp)
    80005244:	6145                	addi	sp,sp,48
    80005246:	8082                	ret
    x = -xx;
    80005248:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    8000524c:	4885                	li	a7,1
    x = -xx;
    8000524e:	b741                	j	800051ce <printint+0x10>

0000000080005250 <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    80005250:	7155                	addi	sp,sp,-208
    80005252:	e506                	sd	ra,136(sp)
    80005254:	e122                	sd	s0,128(sp)
    80005256:	f0d2                	sd	s4,96(sp)
    80005258:	0900                	addi	s0,sp,144
    8000525a:	8a2a                	mv	s4,a0
    8000525c:	e40c                	sd	a1,8(s0)
    8000525e:	e810                	sd	a2,16(s0)
    80005260:	ec14                	sd	a3,24(s0)
    80005262:	f018                	sd	a4,32(s0)
    80005264:	f41c                	sd	a5,40(s0)
    80005266:	03043823          	sd	a6,48(s0)
    8000526a:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2, locking;
  char *s;

  locking = pr.locking;
    8000526e:	0001e797          	auipc	a5,0x1e
    80005272:	5a27a783          	lw	a5,1442(a5) # 80023810 <pr+0x18>
    80005276:	f6f43c23          	sd	a5,-136(s0)
  if(locking)
    8000527a:	e3a1                	bnez	a5,800052ba <printf+0x6a>
    acquire(&pr.lock);

  va_start(ap, fmt);
    8000527c:	00840793          	addi	a5,s0,8
    80005280:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005284:	00054503          	lbu	a0,0(a0)
    80005288:	26050763          	beqz	a0,800054f6 <printf+0x2a6>
    8000528c:	fca6                	sd	s1,120(sp)
    8000528e:	f8ca                	sd	s2,112(sp)
    80005290:	f4ce                	sd	s3,104(sp)
    80005292:	ecd6                	sd	s5,88(sp)
    80005294:	e8da                	sd	s6,80(sp)
    80005296:	e0e2                	sd	s8,64(sp)
    80005298:	fc66                	sd	s9,56(sp)
    8000529a:	f86a                	sd	s10,48(sp)
    8000529c:	f46e                	sd	s11,40(sp)
    8000529e:	4981                	li	s3,0
    if(cx != '%'){
    800052a0:	02500a93          	li	s5,37
    i++;
    c0 = fmt[i+0] & 0xff;
    c1 = c2 = 0;
    if(c0) c1 = fmt[i+1] & 0xff;
    if(c1) c2 = fmt[i+2] & 0xff;
    if(c0 == 'd'){
    800052a4:	06400b13          	li	s6,100
      printint(va_arg(ap, int), 10, 1);
    } else if(c0 == 'l' && c1 == 'd'){
    800052a8:	06c00c13          	li	s8,108
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    800052ac:	07500c93          	li	s9,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    800052b0:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if(c0 == 'p'){
    800052b4:	07000d93          	li	s11,112
    800052b8:	a815                	j	800052ec <printf+0x9c>
    acquire(&pr.lock);
    800052ba:	0001e517          	auipc	a0,0x1e
    800052be:	53e50513          	addi	a0,a0,1342 # 800237f8 <pr>
    800052c2:	58e000ef          	jal	80005850 <acquire>
  va_start(ap, fmt);
    800052c6:	00840793          	addi	a5,s0,8
    800052ca:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    800052ce:	000a4503          	lbu	a0,0(s4)
    800052d2:	fd4d                	bnez	a0,8000528c <printf+0x3c>
    800052d4:	a481                	j	80005514 <printf+0x2c4>
      consputc(cx);
    800052d6:	cf9ff0ef          	jal	80004fce <consputc>
      continue;
    800052da:	84ce                	mv	s1,s3
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    800052dc:	0014899b          	addiw	s3,s1,1
    800052e0:	013a07b3          	add	a5,s4,s3
    800052e4:	0007c503          	lbu	a0,0(a5)
    800052e8:	1e050b63          	beqz	a0,800054de <printf+0x28e>
    if(cx != '%'){
    800052ec:	ff5515e3          	bne	a0,s5,800052d6 <printf+0x86>
    i++;
    800052f0:	0019849b          	addiw	s1,s3,1
    c0 = fmt[i+0] & 0xff;
    800052f4:	009a07b3          	add	a5,s4,s1
    800052f8:	0007c903          	lbu	s2,0(a5)
    if(c0) c1 = fmt[i+1] & 0xff;
    800052fc:	1e090163          	beqz	s2,800054de <printf+0x28e>
    80005300:	0017c783          	lbu	a5,1(a5)
    c1 = c2 = 0;
    80005304:	86be                	mv	a3,a5
    if(c1) c2 = fmt[i+2] & 0xff;
    80005306:	c789                	beqz	a5,80005310 <printf+0xc0>
    80005308:	009a0733          	add	a4,s4,s1
    8000530c:	00274683          	lbu	a3,2(a4)
    if(c0 == 'd'){
    80005310:	03690763          	beq	s2,s6,8000533e <printf+0xee>
    } else if(c0 == 'l' && c1 == 'd'){
    80005314:	05890163          	beq	s2,s8,80005356 <printf+0x106>
    } else if(c0 == 'u'){
    80005318:	0d990b63          	beq	s2,s9,800053ee <printf+0x19e>
    } else if(c0 == 'x'){
    8000531c:	13a90163          	beq	s2,s10,8000543e <printf+0x1ee>
    } else if(c0 == 'p'){
    80005320:	13b90b63          	beq	s2,s11,80005456 <printf+0x206>
      printptr(va_arg(ap, uint64));
    } else if(c0 == 's'){
    80005324:	07300793          	li	a5,115
    80005328:	16f90a63          	beq	s2,a5,8000549c <printf+0x24c>
      if((s = va_arg(ap, char*)) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
    } else if(c0 == '%'){
    8000532c:	1b590463          	beq	s2,s5,800054d4 <printf+0x284>
      consputc('%');
    } else if(c0 == 0){
      break;
    } else {
      // Print unknown % sequence to draw attention.
      consputc('%');
    80005330:	8556                	mv	a0,s5
    80005332:	c9dff0ef          	jal	80004fce <consputc>
      consputc(c0);
    80005336:	854a                	mv	a0,s2
    80005338:	c97ff0ef          	jal	80004fce <consputc>
    8000533c:	b745                	j	800052dc <printf+0x8c>
      printint(va_arg(ap, int), 10, 1);
    8000533e:	f8843783          	ld	a5,-120(s0)
    80005342:	00878713          	addi	a4,a5,8
    80005346:	f8e43423          	sd	a4,-120(s0)
    8000534a:	4605                	li	a2,1
    8000534c:	45a9                	li	a1,10
    8000534e:	4388                	lw	a0,0(a5)
    80005350:	e6fff0ef          	jal	800051be <printint>
    80005354:	b761                	j	800052dc <printf+0x8c>
    } else if(c0 == 'l' && c1 == 'd'){
    80005356:	03678663          	beq	a5,s6,80005382 <printf+0x132>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000535a:	05878263          	beq	a5,s8,8000539e <printf+0x14e>
    } else if(c0 == 'l' && c1 == 'u'){
    8000535e:	0b978463          	beq	a5,s9,80005406 <printf+0x1b6>
    } else if(c0 == 'l' && c1 == 'x'){
    80005362:	fda797e3          	bne	a5,s10,80005330 <printf+0xe0>
      printint(va_arg(ap, uint64), 16, 0);
    80005366:	f8843783          	ld	a5,-120(s0)
    8000536a:	00878713          	addi	a4,a5,8
    8000536e:	f8e43423          	sd	a4,-120(s0)
    80005372:	4601                	li	a2,0
    80005374:	45c1                	li	a1,16
    80005376:	6388                	ld	a0,0(a5)
    80005378:	e47ff0ef          	jal	800051be <printint>
      i += 1;
    8000537c:	0029849b          	addiw	s1,s3,2
    80005380:	bfb1                	j	800052dc <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 1);
    80005382:	f8843783          	ld	a5,-120(s0)
    80005386:	00878713          	addi	a4,a5,8
    8000538a:	f8e43423          	sd	a4,-120(s0)
    8000538e:	4605                	li	a2,1
    80005390:	45a9                	li	a1,10
    80005392:	6388                	ld	a0,0(a5)
    80005394:	e2bff0ef          	jal	800051be <printint>
      i += 1;
    80005398:	0029849b          	addiw	s1,s3,2
    8000539c:	b781                	j	800052dc <printf+0x8c>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000539e:	06400793          	li	a5,100
    800053a2:	02f68863          	beq	a3,a5,800053d2 <printf+0x182>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    800053a6:	07500793          	li	a5,117
    800053aa:	06f68c63          	beq	a3,a5,80005422 <printf+0x1d2>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    800053ae:	07800793          	li	a5,120
    800053b2:	f6f69fe3          	bne	a3,a5,80005330 <printf+0xe0>
      printint(va_arg(ap, uint64), 16, 0);
    800053b6:	f8843783          	ld	a5,-120(s0)
    800053ba:	00878713          	addi	a4,a5,8
    800053be:	f8e43423          	sd	a4,-120(s0)
    800053c2:	4601                	li	a2,0
    800053c4:	45c1                	li	a1,16
    800053c6:	6388                	ld	a0,0(a5)
    800053c8:	df7ff0ef          	jal	800051be <printint>
      i += 2;
    800053cc:	0039849b          	addiw	s1,s3,3
    800053d0:	b731                	j	800052dc <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 1);
    800053d2:	f8843783          	ld	a5,-120(s0)
    800053d6:	00878713          	addi	a4,a5,8
    800053da:	f8e43423          	sd	a4,-120(s0)
    800053de:	4605                	li	a2,1
    800053e0:	45a9                	li	a1,10
    800053e2:	6388                	ld	a0,0(a5)
    800053e4:	ddbff0ef          	jal	800051be <printint>
      i += 2;
    800053e8:	0039849b          	addiw	s1,s3,3
    800053ec:	bdc5                	j	800052dc <printf+0x8c>
      printint(va_arg(ap, int), 10, 0);
    800053ee:	f8843783          	ld	a5,-120(s0)
    800053f2:	00878713          	addi	a4,a5,8
    800053f6:	f8e43423          	sd	a4,-120(s0)
    800053fa:	4601                	li	a2,0
    800053fc:	45a9                	li	a1,10
    800053fe:	4388                	lw	a0,0(a5)
    80005400:	dbfff0ef          	jal	800051be <printint>
    80005404:	bde1                	j	800052dc <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 0);
    80005406:	f8843783          	ld	a5,-120(s0)
    8000540a:	00878713          	addi	a4,a5,8
    8000540e:	f8e43423          	sd	a4,-120(s0)
    80005412:	4601                	li	a2,0
    80005414:	45a9                	li	a1,10
    80005416:	6388                	ld	a0,0(a5)
    80005418:	da7ff0ef          	jal	800051be <printint>
      i += 1;
    8000541c:	0029849b          	addiw	s1,s3,2
    80005420:	bd75                	j	800052dc <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 0);
    80005422:	f8843783          	ld	a5,-120(s0)
    80005426:	00878713          	addi	a4,a5,8
    8000542a:	f8e43423          	sd	a4,-120(s0)
    8000542e:	4601                	li	a2,0
    80005430:	45a9                	li	a1,10
    80005432:	6388                	ld	a0,0(a5)
    80005434:	d8bff0ef          	jal	800051be <printint>
      i += 2;
    80005438:	0039849b          	addiw	s1,s3,3
    8000543c:	b545                	j	800052dc <printf+0x8c>
      printint(va_arg(ap, int), 16, 0);
    8000543e:	f8843783          	ld	a5,-120(s0)
    80005442:	00878713          	addi	a4,a5,8
    80005446:	f8e43423          	sd	a4,-120(s0)
    8000544a:	4601                	li	a2,0
    8000544c:	45c1                	li	a1,16
    8000544e:	4388                	lw	a0,0(a5)
    80005450:	d6fff0ef          	jal	800051be <printint>
    80005454:	b561                	j	800052dc <printf+0x8c>
    80005456:	e4de                	sd	s7,72(sp)
      printptr(va_arg(ap, uint64));
    80005458:	f8843783          	ld	a5,-120(s0)
    8000545c:	00878713          	addi	a4,a5,8
    80005460:	f8e43423          	sd	a4,-120(s0)
    80005464:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80005468:	03000513          	li	a0,48
    8000546c:	b63ff0ef          	jal	80004fce <consputc>
  consputc('x');
    80005470:	07800513          	li	a0,120
    80005474:	b5bff0ef          	jal	80004fce <consputc>
    80005478:	4941                	li	s2,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000547a:	00002b97          	auipc	s7,0x2
    8000547e:	466b8b93          	addi	s7,s7,1126 # 800078e0 <digits>
    80005482:	03c9d793          	srli	a5,s3,0x3c
    80005486:	97de                	add	a5,a5,s7
    80005488:	0007c503          	lbu	a0,0(a5)
    8000548c:	b43ff0ef          	jal	80004fce <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005490:	0992                	slli	s3,s3,0x4
    80005492:	397d                	addiw	s2,s2,-1
    80005494:	fe0917e3          	bnez	s2,80005482 <printf+0x232>
    80005498:	6ba6                	ld	s7,72(sp)
    8000549a:	b589                	j	800052dc <printf+0x8c>
      if((s = va_arg(ap, char*)) == 0)
    8000549c:	f8843783          	ld	a5,-120(s0)
    800054a0:	00878713          	addi	a4,a5,8
    800054a4:	f8e43423          	sd	a4,-120(s0)
    800054a8:	0007b903          	ld	s2,0(a5)
    800054ac:	00090d63          	beqz	s2,800054c6 <printf+0x276>
      for(; *s; s++)
    800054b0:	00094503          	lbu	a0,0(s2)
    800054b4:	e20504e3          	beqz	a0,800052dc <printf+0x8c>
        consputc(*s);
    800054b8:	b17ff0ef          	jal	80004fce <consputc>
      for(; *s; s++)
    800054bc:	0905                	addi	s2,s2,1
    800054be:	00094503          	lbu	a0,0(s2)
    800054c2:	f97d                	bnez	a0,800054b8 <printf+0x268>
    800054c4:	bd21                	j	800052dc <printf+0x8c>
        s = "(null)";
    800054c6:	00002917          	auipc	s2,0x2
    800054ca:	26290913          	addi	s2,s2,610 # 80007728 <etext+0x728>
      for(; *s; s++)
    800054ce:	02800513          	li	a0,40
    800054d2:	b7dd                	j	800054b8 <printf+0x268>
      consputc('%');
    800054d4:	02500513          	li	a0,37
    800054d8:	af7ff0ef          	jal	80004fce <consputc>
    800054dc:	b501                	j	800052dc <printf+0x8c>
    }
#endif
  }
  va_end(ap);

  if(locking)
    800054de:	f7843783          	ld	a5,-136(s0)
    800054e2:	e385                	bnez	a5,80005502 <printf+0x2b2>
    800054e4:	74e6                	ld	s1,120(sp)
    800054e6:	7946                	ld	s2,112(sp)
    800054e8:	79a6                	ld	s3,104(sp)
    800054ea:	6ae6                	ld	s5,88(sp)
    800054ec:	6b46                	ld	s6,80(sp)
    800054ee:	6c06                	ld	s8,64(sp)
    800054f0:	7ce2                	ld	s9,56(sp)
    800054f2:	7d42                	ld	s10,48(sp)
    800054f4:	7da2                	ld	s11,40(sp)
    release(&pr.lock);

  return 0;
}
    800054f6:	4501                	li	a0,0
    800054f8:	60aa                	ld	ra,136(sp)
    800054fa:	640a                	ld	s0,128(sp)
    800054fc:	7a06                	ld	s4,96(sp)
    800054fe:	6169                	addi	sp,sp,208
    80005500:	8082                	ret
    80005502:	74e6                	ld	s1,120(sp)
    80005504:	7946                	ld	s2,112(sp)
    80005506:	79a6                	ld	s3,104(sp)
    80005508:	6ae6                	ld	s5,88(sp)
    8000550a:	6b46                	ld	s6,80(sp)
    8000550c:	6c06                	ld	s8,64(sp)
    8000550e:	7ce2                	ld	s9,56(sp)
    80005510:	7d42                	ld	s10,48(sp)
    80005512:	7da2                	ld	s11,40(sp)
    release(&pr.lock);
    80005514:	0001e517          	auipc	a0,0x1e
    80005518:	2e450513          	addi	a0,a0,740 # 800237f8 <pr>
    8000551c:	3cc000ef          	jal	800058e8 <release>
    80005520:	bfd9                	j	800054f6 <printf+0x2a6>

0000000080005522 <panic>:

void
panic(char *s)
{
    80005522:	1101                	addi	sp,sp,-32
    80005524:	ec06                	sd	ra,24(sp)
    80005526:	e822                	sd	s0,16(sp)
    80005528:	e426                	sd	s1,8(sp)
    8000552a:	1000                	addi	s0,sp,32
    8000552c:	84aa                	mv	s1,a0
  pr.locking = 0;
    8000552e:	0001e797          	auipc	a5,0x1e
    80005532:	2e07a123          	sw	zero,738(a5) # 80023810 <pr+0x18>
  printf("panic: ");
    80005536:	00002517          	auipc	a0,0x2
    8000553a:	1fa50513          	addi	a0,a0,506 # 80007730 <etext+0x730>
    8000553e:	d13ff0ef          	jal	80005250 <printf>
  printf("%s\n", s);
    80005542:	85a6                	mv	a1,s1
    80005544:	00002517          	auipc	a0,0x2
    80005548:	1f450513          	addi	a0,a0,500 # 80007738 <etext+0x738>
    8000554c:	d05ff0ef          	jal	80005250 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005550:	4785                	li	a5,1
    80005552:	00005717          	auipc	a4,0x5
    80005556:	daf72d23          	sw	a5,-582(a4) # 8000a30c <panicked>
  for(;;)
    8000555a:	a001                	j	8000555a <panic+0x38>

000000008000555c <printfinit>:
    ;
}

void
printfinit(void)
{
    8000555c:	1101                	addi	sp,sp,-32
    8000555e:	ec06                	sd	ra,24(sp)
    80005560:	e822                	sd	s0,16(sp)
    80005562:	e426                	sd	s1,8(sp)
    80005564:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80005566:	0001e497          	auipc	s1,0x1e
    8000556a:	29248493          	addi	s1,s1,658 # 800237f8 <pr>
    8000556e:	00002597          	auipc	a1,0x2
    80005572:	1d258593          	addi	a1,a1,466 # 80007740 <etext+0x740>
    80005576:	8526                	mv	a0,s1
    80005578:	258000ef          	jal	800057d0 <initlock>
  pr.locking = 1;
    8000557c:	4785                	li	a5,1
    8000557e:	cc9c                	sw	a5,24(s1)
}
    80005580:	60e2                	ld	ra,24(sp)
    80005582:	6442                	ld	s0,16(sp)
    80005584:	64a2                	ld	s1,8(sp)
    80005586:	6105                	addi	sp,sp,32
    80005588:	8082                	ret

000000008000558a <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000558a:	1141                	addi	sp,sp,-16
    8000558c:	e406                	sd	ra,8(sp)
    8000558e:	e022                	sd	s0,0(sp)
    80005590:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005592:	100007b7          	lui	a5,0x10000
    80005596:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    8000559a:	10000737          	lui	a4,0x10000
    8000559e:	f8000693          	li	a3,-128
    800055a2:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800055a6:	468d                	li	a3,3
    800055a8:	10000637          	lui	a2,0x10000
    800055ac:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800055b0:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800055b4:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800055b8:	10000737          	lui	a4,0x10000
    800055bc:	461d                	li	a2,7
    800055be:	00c70123          	sb	a2,2(a4) # 10000002 <_entry-0x6ffffffe>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800055c2:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    800055c6:	00002597          	auipc	a1,0x2
    800055ca:	18258593          	addi	a1,a1,386 # 80007748 <etext+0x748>
    800055ce:	0001e517          	auipc	a0,0x1e
    800055d2:	24a50513          	addi	a0,a0,586 # 80023818 <uart_tx_lock>
    800055d6:	1fa000ef          	jal	800057d0 <initlock>
}
    800055da:	60a2                	ld	ra,8(sp)
    800055dc:	6402                	ld	s0,0(sp)
    800055de:	0141                	addi	sp,sp,16
    800055e0:	8082                	ret

00000000800055e2 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800055e2:	1101                	addi	sp,sp,-32
    800055e4:	ec06                	sd	ra,24(sp)
    800055e6:	e822                	sd	s0,16(sp)
    800055e8:	e426                	sd	s1,8(sp)
    800055ea:	1000                	addi	s0,sp,32
    800055ec:	84aa                	mv	s1,a0
  push_off();
    800055ee:	222000ef          	jal	80005810 <push_off>

  if(panicked){
    800055f2:	00005797          	auipc	a5,0x5
    800055f6:	d1a7a783          	lw	a5,-742(a5) # 8000a30c <panicked>
    800055fa:	e795                	bnez	a5,80005626 <uartputc_sync+0x44>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800055fc:	10000737          	lui	a4,0x10000
    80005600:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80005602:	00074783          	lbu	a5,0(a4)
    80005606:	0207f793          	andi	a5,a5,32
    8000560a:	dfe5                	beqz	a5,80005602 <uartputc_sync+0x20>
    ;
  WriteReg(THR, c);
    8000560c:	0ff4f513          	zext.b	a0,s1
    80005610:	100007b7          	lui	a5,0x10000
    80005614:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80005618:	27c000ef          	jal	80005894 <pop_off>
}
    8000561c:	60e2                	ld	ra,24(sp)
    8000561e:	6442                	ld	s0,16(sp)
    80005620:	64a2                	ld	s1,8(sp)
    80005622:	6105                	addi	sp,sp,32
    80005624:	8082                	ret
    for(;;)
    80005626:	a001                	j	80005626 <uartputc_sync+0x44>

0000000080005628 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80005628:	00005797          	auipc	a5,0x5
    8000562c:	ce87b783          	ld	a5,-792(a5) # 8000a310 <uart_tx_r>
    80005630:	00005717          	auipc	a4,0x5
    80005634:	ce873703          	ld	a4,-792(a4) # 8000a318 <uart_tx_w>
    80005638:	08f70263          	beq	a4,a5,800056bc <uartstart+0x94>
{
    8000563c:	7139                	addi	sp,sp,-64
    8000563e:	fc06                	sd	ra,56(sp)
    80005640:	f822                	sd	s0,48(sp)
    80005642:	f426                	sd	s1,40(sp)
    80005644:	f04a                	sd	s2,32(sp)
    80005646:	ec4e                	sd	s3,24(sp)
    80005648:	e852                	sd	s4,16(sp)
    8000564a:	e456                	sd	s5,8(sp)
    8000564c:	e05a                	sd	s6,0(sp)
    8000564e:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      ReadReg(ISR);
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005650:	10000937          	lui	s2,0x10000
    80005654:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005656:	0001ea97          	auipc	s5,0x1e
    8000565a:	1c2a8a93          	addi	s5,s5,450 # 80023818 <uart_tx_lock>
    uart_tx_r += 1;
    8000565e:	00005497          	auipc	s1,0x5
    80005662:	cb248493          	addi	s1,s1,-846 # 8000a310 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    80005666:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    8000566a:	00005997          	auipc	s3,0x5
    8000566e:	cae98993          	addi	s3,s3,-850 # 8000a318 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005672:	00094703          	lbu	a4,0(s2)
    80005676:	02077713          	andi	a4,a4,32
    8000567a:	c71d                	beqz	a4,800056a8 <uartstart+0x80>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000567c:	01f7f713          	andi	a4,a5,31
    80005680:	9756                	add	a4,a4,s5
    80005682:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    80005686:	0785                	addi	a5,a5,1
    80005688:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    8000568a:	8526                	mv	a0,s1
    8000568c:	dcffb0ef          	jal	8000145a <wakeup>
    WriteReg(THR, c);
    80005690:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    80005694:	609c                	ld	a5,0(s1)
    80005696:	0009b703          	ld	a4,0(s3)
    8000569a:	fcf71ce3          	bne	a4,a5,80005672 <uartstart+0x4a>
      ReadReg(ISR);
    8000569e:	100007b7          	lui	a5,0x10000
    800056a2:	0789                	addi	a5,a5,2 # 10000002 <_entry-0x6ffffffe>
    800056a4:	0007c783          	lbu	a5,0(a5)
  }
}
    800056a8:	70e2                	ld	ra,56(sp)
    800056aa:	7442                	ld	s0,48(sp)
    800056ac:	74a2                	ld	s1,40(sp)
    800056ae:	7902                	ld	s2,32(sp)
    800056b0:	69e2                	ld	s3,24(sp)
    800056b2:	6a42                	ld	s4,16(sp)
    800056b4:	6aa2                	ld	s5,8(sp)
    800056b6:	6b02                	ld	s6,0(sp)
    800056b8:	6121                	addi	sp,sp,64
    800056ba:	8082                	ret
      ReadReg(ISR);
    800056bc:	100007b7          	lui	a5,0x10000
    800056c0:	0789                	addi	a5,a5,2 # 10000002 <_entry-0x6ffffffe>
    800056c2:	0007c783          	lbu	a5,0(a5)
      return;
    800056c6:	8082                	ret

00000000800056c8 <uartputc>:
{
    800056c8:	7179                	addi	sp,sp,-48
    800056ca:	f406                	sd	ra,40(sp)
    800056cc:	f022                	sd	s0,32(sp)
    800056ce:	ec26                	sd	s1,24(sp)
    800056d0:	e84a                	sd	s2,16(sp)
    800056d2:	e44e                	sd	s3,8(sp)
    800056d4:	e052                	sd	s4,0(sp)
    800056d6:	1800                	addi	s0,sp,48
    800056d8:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800056da:	0001e517          	auipc	a0,0x1e
    800056de:	13e50513          	addi	a0,a0,318 # 80023818 <uart_tx_lock>
    800056e2:	16e000ef          	jal	80005850 <acquire>
  if(panicked){
    800056e6:	00005797          	auipc	a5,0x5
    800056ea:	c267a783          	lw	a5,-986(a5) # 8000a30c <panicked>
    800056ee:	efbd                	bnez	a5,8000576c <uartputc+0xa4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800056f0:	00005717          	auipc	a4,0x5
    800056f4:	c2873703          	ld	a4,-984(a4) # 8000a318 <uart_tx_w>
    800056f8:	00005797          	auipc	a5,0x5
    800056fc:	c187b783          	ld	a5,-1000(a5) # 8000a310 <uart_tx_r>
    80005700:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    80005704:	0001e997          	auipc	s3,0x1e
    80005708:	11498993          	addi	s3,s3,276 # 80023818 <uart_tx_lock>
    8000570c:	00005497          	auipc	s1,0x5
    80005710:	c0448493          	addi	s1,s1,-1020 # 8000a310 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005714:	00005917          	auipc	s2,0x5
    80005718:	c0490913          	addi	s2,s2,-1020 # 8000a318 <uart_tx_w>
    8000571c:	00e79d63          	bne	a5,a4,80005736 <uartputc+0x6e>
    sleep(&uart_tx_r, &uart_tx_lock);
    80005720:	85ce                	mv	a1,s3
    80005722:	8526                	mv	a0,s1
    80005724:	cebfb0ef          	jal	8000140e <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005728:	00093703          	ld	a4,0(s2)
    8000572c:	609c                	ld	a5,0(s1)
    8000572e:	02078793          	addi	a5,a5,32
    80005732:	fee787e3          	beq	a5,a4,80005720 <uartputc+0x58>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80005736:	0001e497          	auipc	s1,0x1e
    8000573a:	0e248493          	addi	s1,s1,226 # 80023818 <uart_tx_lock>
    8000573e:	01f77793          	andi	a5,a4,31
    80005742:	97a6                	add	a5,a5,s1
    80005744:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80005748:	0705                	addi	a4,a4,1
    8000574a:	00005797          	auipc	a5,0x5
    8000574e:	bce7b723          	sd	a4,-1074(a5) # 8000a318 <uart_tx_w>
  uartstart();
    80005752:	ed7ff0ef          	jal	80005628 <uartstart>
  release(&uart_tx_lock);
    80005756:	8526                	mv	a0,s1
    80005758:	190000ef          	jal	800058e8 <release>
}
    8000575c:	70a2                	ld	ra,40(sp)
    8000575e:	7402                	ld	s0,32(sp)
    80005760:	64e2                	ld	s1,24(sp)
    80005762:	6942                	ld	s2,16(sp)
    80005764:	69a2                	ld	s3,8(sp)
    80005766:	6a02                	ld	s4,0(sp)
    80005768:	6145                	addi	sp,sp,48
    8000576a:	8082                	ret
    for(;;)
    8000576c:	a001                	j	8000576c <uartputc+0xa4>

000000008000576e <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000576e:	1141                	addi	sp,sp,-16
    80005770:	e422                	sd	s0,8(sp)
    80005772:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80005774:	100007b7          	lui	a5,0x10000
    80005778:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    8000577a:	0007c783          	lbu	a5,0(a5)
    8000577e:	8b85                	andi	a5,a5,1
    80005780:	cb81                	beqz	a5,80005790 <uartgetc+0x22>
    // input data is ready.
    return ReadReg(RHR);
    80005782:	100007b7          	lui	a5,0x10000
    80005786:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    8000578a:	6422                	ld	s0,8(sp)
    8000578c:	0141                	addi	sp,sp,16
    8000578e:	8082                	ret
    return -1;
    80005790:	557d                	li	a0,-1
    80005792:	bfe5                	j	8000578a <uartgetc+0x1c>

0000000080005794 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80005794:	1101                	addi	sp,sp,-32
    80005796:	ec06                	sd	ra,24(sp)
    80005798:	e822                	sd	s0,16(sp)
    8000579a:	e426                	sd	s1,8(sp)
    8000579c:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000579e:	54fd                	li	s1,-1
    800057a0:	a019                	j	800057a6 <uartintr+0x12>
      break;
    consoleintr(c);
    800057a2:	85fff0ef          	jal	80005000 <consoleintr>
    int c = uartgetc();
    800057a6:	fc9ff0ef          	jal	8000576e <uartgetc>
    if(c == -1)
    800057aa:	fe951ce3          	bne	a0,s1,800057a2 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800057ae:	0001e497          	auipc	s1,0x1e
    800057b2:	06a48493          	addi	s1,s1,106 # 80023818 <uart_tx_lock>
    800057b6:	8526                	mv	a0,s1
    800057b8:	098000ef          	jal	80005850 <acquire>
  uartstart();
    800057bc:	e6dff0ef          	jal	80005628 <uartstart>
  release(&uart_tx_lock);
    800057c0:	8526                	mv	a0,s1
    800057c2:	126000ef          	jal	800058e8 <release>
}
    800057c6:	60e2                	ld	ra,24(sp)
    800057c8:	6442                	ld	s0,16(sp)
    800057ca:	64a2                	ld	s1,8(sp)
    800057cc:	6105                	addi	sp,sp,32
    800057ce:	8082                	ret

00000000800057d0 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800057d0:	1141                	addi	sp,sp,-16
    800057d2:	e422                	sd	s0,8(sp)
    800057d4:	0800                	addi	s0,sp,16
  lk->name = name;
    800057d6:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800057d8:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800057dc:	00053823          	sd	zero,16(a0)
}
    800057e0:	6422                	ld	s0,8(sp)
    800057e2:	0141                	addi	sp,sp,16
    800057e4:	8082                	ret

00000000800057e6 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800057e6:	411c                	lw	a5,0(a0)
    800057e8:	e399                	bnez	a5,800057ee <holding+0x8>
    800057ea:	4501                	li	a0,0
  return r;
}
    800057ec:	8082                	ret
{
    800057ee:	1101                	addi	sp,sp,-32
    800057f0:	ec06                	sd	ra,24(sp)
    800057f2:	e822                	sd	s0,16(sp)
    800057f4:	e426                	sd	s1,8(sp)
    800057f6:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800057f8:	6904                	ld	s1,16(a0)
    800057fa:	d8afb0ef          	jal	80000d84 <mycpu>
    800057fe:	40a48533          	sub	a0,s1,a0
    80005802:	00153513          	seqz	a0,a0
}
    80005806:	60e2                	ld	ra,24(sp)
    80005808:	6442                	ld	s0,16(sp)
    8000580a:	64a2                	ld	s1,8(sp)
    8000580c:	6105                	addi	sp,sp,32
    8000580e:	8082                	ret

0000000080005810 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80005810:	1101                	addi	sp,sp,-32
    80005812:	ec06                	sd	ra,24(sp)
    80005814:	e822                	sd	s0,16(sp)
    80005816:	e426                	sd	s1,8(sp)
    80005818:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000581a:	100024f3          	csrr	s1,sstatus
    8000581e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80005822:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80005824:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80005828:	d5cfb0ef          	jal	80000d84 <mycpu>
    8000582c:	5d3c                	lw	a5,120(a0)
    8000582e:	cb99                	beqz	a5,80005844 <push_off+0x34>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80005830:	d54fb0ef          	jal	80000d84 <mycpu>
    80005834:	5d3c                	lw	a5,120(a0)
    80005836:	2785                	addiw	a5,a5,1
    80005838:	dd3c                	sw	a5,120(a0)
}
    8000583a:	60e2                	ld	ra,24(sp)
    8000583c:	6442                	ld	s0,16(sp)
    8000583e:	64a2                	ld	s1,8(sp)
    80005840:	6105                	addi	sp,sp,32
    80005842:	8082                	ret
    mycpu()->intena = old;
    80005844:	d40fb0ef          	jal	80000d84 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80005848:	8085                	srli	s1,s1,0x1
    8000584a:	8885                	andi	s1,s1,1
    8000584c:	dd64                	sw	s1,124(a0)
    8000584e:	b7cd                	j	80005830 <push_off+0x20>

0000000080005850 <acquire>:
{
    80005850:	1101                	addi	sp,sp,-32
    80005852:	ec06                	sd	ra,24(sp)
    80005854:	e822                	sd	s0,16(sp)
    80005856:	e426                	sd	s1,8(sp)
    80005858:	1000                	addi	s0,sp,32
    8000585a:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000585c:	fb5ff0ef          	jal	80005810 <push_off>
  if(holding(lk))
    80005860:	8526                	mv	a0,s1
    80005862:	f85ff0ef          	jal	800057e6 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80005866:	4705                	li	a4,1
  if(holding(lk))
    80005868:	e105                	bnez	a0,80005888 <acquire+0x38>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000586a:	87ba                	mv	a5,a4
    8000586c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005870:	2781                	sext.w	a5,a5
    80005872:	ffe5                	bnez	a5,8000586a <acquire+0x1a>
  __sync_synchronize();
    80005874:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    80005878:	d0cfb0ef          	jal	80000d84 <mycpu>
    8000587c:	e888                	sd	a0,16(s1)
}
    8000587e:	60e2                	ld	ra,24(sp)
    80005880:	6442                	ld	s0,16(sp)
    80005882:	64a2                	ld	s1,8(sp)
    80005884:	6105                	addi	sp,sp,32
    80005886:	8082                	ret
    panic("acquire");
    80005888:	00002517          	auipc	a0,0x2
    8000588c:	ec850513          	addi	a0,a0,-312 # 80007750 <etext+0x750>
    80005890:	c93ff0ef          	jal	80005522 <panic>

0000000080005894 <pop_off>:

void
pop_off(void)
{
    80005894:	1141                	addi	sp,sp,-16
    80005896:	e406                	sd	ra,8(sp)
    80005898:	e022                	sd	s0,0(sp)
    8000589a:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    8000589c:	ce8fb0ef          	jal	80000d84 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800058a0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800058a4:	8b89                	andi	a5,a5,2
  if(intr_get())
    800058a6:	e78d                	bnez	a5,800058d0 <pop_off+0x3c>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800058a8:	5d3c                	lw	a5,120(a0)
    800058aa:	02f05963          	blez	a5,800058dc <pop_off+0x48>
    panic("pop_off");
  c->noff -= 1;
    800058ae:	37fd                	addiw	a5,a5,-1
    800058b0:	0007871b          	sext.w	a4,a5
    800058b4:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800058b6:	eb09                	bnez	a4,800058c8 <pop_off+0x34>
    800058b8:	5d7c                	lw	a5,124(a0)
    800058ba:	c799                	beqz	a5,800058c8 <pop_off+0x34>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800058bc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800058c0:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800058c4:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800058c8:	60a2                	ld	ra,8(sp)
    800058ca:	6402                	ld	s0,0(sp)
    800058cc:	0141                	addi	sp,sp,16
    800058ce:	8082                	ret
    panic("pop_off - interruptible");
    800058d0:	00002517          	auipc	a0,0x2
    800058d4:	e8850513          	addi	a0,a0,-376 # 80007758 <etext+0x758>
    800058d8:	c4bff0ef          	jal	80005522 <panic>
    panic("pop_off");
    800058dc:	00002517          	auipc	a0,0x2
    800058e0:	e9450513          	addi	a0,a0,-364 # 80007770 <etext+0x770>
    800058e4:	c3fff0ef          	jal	80005522 <panic>

00000000800058e8 <release>:
{
    800058e8:	1101                	addi	sp,sp,-32
    800058ea:	ec06                	sd	ra,24(sp)
    800058ec:	e822                	sd	s0,16(sp)
    800058ee:	e426                	sd	s1,8(sp)
    800058f0:	1000                	addi	s0,sp,32
    800058f2:	84aa                	mv	s1,a0
  if(!holding(lk))
    800058f4:	ef3ff0ef          	jal	800057e6 <holding>
    800058f8:	c105                	beqz	a0,80005918 <release+0x30>
  lk->cpu = 0;
    800058fa:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800058fe:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    80005902:	0310000f          	fence	rw,w
    80005906:	0004a023          	sw	zero,0(s1)
  pop_off();
    8000590a:	f8bff0ef          	jal	80005894 <pop_off>
}
    8000590e:	60e2                	ld	ra,24(sp)
    80005910:	6442                	ld	s0,16(sp)
    80005912:	64a2                	ld	s1,8(sp)
    80005914:	6105                	addi	sp,sp,32
    80005916:	8082                	ret
    panic("release");
    80005918:	00002517          	auipc	a0,0x2
    8000591c:	e6050513          	addi	a0,a0,-416 # 80007778 <etext+0x778>
    80005920:	c03ff0ef          	jal	80005522 <panic>
	...

0000000080006000 <_trampoline>:
    80006000:	14051073          	csrw	sscratch,a0
    80006004:	02000537          	lui	a0,0x2000
    80006008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000600a:	0536                	slli	a0,a0,0xd
    8000600c:	02153423          	sd	ra,40(a0)
    80006010:	02253823          	sd	sp,48(a0)
    80006014:	02353c23          	sd	gp,56(a0)
    80006018:	04453023          	sd	tp,64(a0)
    8000601c:	04553423          	sd	t0,72(a0)
    80006020:	04653823          	sd	t1,80(a0)
    80006024:	04753c23          	sd	t2,88(a0)
    80006028:	f120                	sd	s0,96(a0)
    8000602a:	f524                	sd	s1,104(a0)
    8000602c:	fd2c                	sd	a1,120(a0)
    8000602e:	e150                	sd	a2,128(a0)
    80006030:	e554                	sd	a3,136(a0)
    80006032:	e958                	sd	a4,144(a0)
    80006034:	ed5c                	sd	a5,152(a0)
    80006036:	0b053023          	sd	a6,160(a0)
    8000603a:	0b153423          	sd	a7,168(a0)
    8000603e:	0b253823          	sd	s2,176(a0)
    80006042:	0b353c23          	sd	s3,184(a0)
    80006046:	0d453023          	sd	s4,192(a0)
    8000604a:	0d553423          	sd	s5,200(a0)
    8000604e:	0d653823          	sd	s6,208(a0)
    80006052:	0d753c23          	sd	s7,216(a0)
    80006056:	0f853023          	sd	s8,224(a0)
    8000605a:	0f953423          	sd	s9,232(a0)
    8000605e:	0fa53823          	sd	s10,240(a0)
    80006062:	0fb53c23          	sd	s11,248(a0)
    80006066:	11c53023          	sd	t3,256(a0)
    8000606a:	11d53423          	sd	t4,264(a0)
    8000606e:	11e53823          	sd	t5,272(a0)
    80006072:	11f53c23          	sd	t6,280(a0)
    80006076:	140022f3          	csrr	t0,sscratch
    8000607a:	06553823          	sd	t0,112(a0)
    8000607e:	00853103          	ld	sp,8(a0)
    80006082:	02053203          	ld	tp,32(a0)
    80006086:	01053283          	ld	t0,16(a0)
    8000608a:	00053303          	ld	t1,0(a0)
    8000608e:	12000073          	sfence.vma
    80006092:	18031073          	csrw	satp,t1
    80006096:	12000073          	sfence.vma
    8000609a:	8282                	jr	t0

000000008000609c <userret>:
    8000609c:	12000073          	sfence.vma
    800060a0:	18051073          	csrw	satp,a0
    800060a4:	12000073          	sfence.vma
    800060a8:	02000537          	lui	a0,0x2000
    800060ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800060ae:	0536                	slli	a0,a0,0xd
    800060b0:	02853083          	ld	ra,40(a0)
    800060b4:	03053103          	ld	sp,48(a0)
    800060b8:	03853183          	ld	gp,56(a0)
    800060bc:	04053203          	ld	tp,64(a0)
    800060c0:	04853283          	ld	t0,72(a0)
    800060c4:	05053303          	ld	t1,80(a0)
    800060c8:	05853383          	ld	t2,88(a0)
    800060cc:	7120                	ld	s0,96(a0)
    800060ce:	7524                	ld	s1,104(a0)
    800060d0:	7d2c                	ld	a1,120(a0)
    800060d2:	6150                	ld	a2,128(a0)
    800060d4:	6554                	ld	a3,136(a0)
    800060d6:	6958                	ld	a4,144(a0)
    800060d8:	6d5c                	ld	a5,152(a0)
    800060da:	0a053803          	ld	a6,160(a0)
    800060de:	0a853883          	ld	a7,168(a0)
    800060e2:	0b053903          	ld	s2,176(a0)
    800060e6:	0b853983          	ld	s3,184(a0)
    800060ea:	0c053a03          	ld	s4,192(a0)
    800060ee:	0c853a83          	ld	s5,200(a0)
    800060f2:	0d053b03          	ld	s6,208(a0)
    800060f6:	0d853b83          	ld	s7,216(a0)
    800060fa:	0e053c03          	ld	s8,224(a0)
    800060fe:	0e853c83          	ld	s9,232(a0)
    80006102:	0f053d03          	ld	s10,240(a0)
    80006106:	0f853d83          	ld	s11,248(a0)
    8000610a:	10053e03          	ld	t3,256(a0)
    8000610e:	10853e83          	ld	t4,264(a0)
    80006112:	11053f03          	ld	t5,272(a0)
    80006116:	11853f83          	ld	t6,280(a0)
    8000611a:	7928                	ld	a0,112(a0)
    8000611c:	10200073          	sret
	...
