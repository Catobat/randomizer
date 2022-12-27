.equ showMap, always+4
.thumb
@vanilla check
add	r1,r0
ldrb	r0,[r1,#3]
cmp	r0,#0
@vanilla behavior for gold fusions
beq	return

@check if we always skip
ldr	r3,always
cmp	r3,#0
bne	noCutscene

@check if a skip button is being held
ldr	r3,=#0x3000FF0
ldrh	r3,[r3]
mov	r2,#0x0B
and	r3,r2
cmp	r3,#0
beq	cutscene

noCutscene:
ldr	r3,showMap
cmp	r3,#0
beq	fullSkip

@go straight to map screen
mov	r0,#0x0A

cutscene:
ldr	r3,=#0x80A35ED
bx	r3

fullSkip:
@get the fusion id into place
ldrb	r0,[r1,#3]
ldrb	r1,[r1,#4]
ldr	r2,=#0x2032EC0
strb	r0,[r2,#2]
strb	r1,[r2,#3]
strb	r0,[r2,#4]
strb	r1,[r2,#5]
@prepare the fusion cutscene
push	{r4}
ldr	r4,=#0x2032EC0
ldrb	r1,[r4,#3]
lsl	r0,r1,#2
add	r0,r1
lsl	r0,#2
ldr	r1,=#0x8054460
ldr	r1,[r1]
add	r0,r1
ldr	r2,=#0x2000080
ldrb	r1,[r0]
mov	r3,#0
strb	r1,[r2]
ldrb	r1,[r0,#1]
strb	r1,[r2,#3]
ldrb	r1,[r4,#3]
strb	r1,[r2,#4]
str	r0,[r2,#0xC]
ldrb	r0,[r2,#5]
add	r0,#1
strb	r0,[r2,#5]
strb	r3,[r2,#6]
mov	r0,#0x96
lsl	r0,#1
strh	r0,[r2,#8]
pop	{r4}

return:
ldr	r3,=#0x80A3601
bx	r3

.align
.ltorg
always:
