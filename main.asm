    .include "constants.inc"

    .segment "ZEROPAGE"

PlayerBeads:
    .byte 0

PlayerFacing:
    .byte 0 ; right - 0, left - 1

OverflowCounter: ; counting overflows for loops which exceed 256 iterations
    .byte 0

    .segment "HEADER"

    .byte "NES", $1A ; iNES Header
    .byte 2 ; PRG data size (16kb)
    .byte 1 ; CHR data size (8kb)
    .byte $01, $00 ; Mapper

    .segment "STARTUP"

; Unused segment

    .segment "CODE"

Reset:
    sei 
    cld 
    ldx #$40
    stx $4017
    ldx #$FF
    txs 
    inx 
    stx PPUCTRL
    stx PPUMASK
    stx $4010

VBlankWaitPre:
    bit PPUSTATUS
    bpl VBlankWaitPre

ClearMemory:
    lda #$00
	sta	$0000, x
	sta	$0100, x
	sta	$0300, x
	sta	$0400, x
	sta	$0500, x
	sta	$0600, x
	sta	$0700, x
    lda #$FE
    sta $0200, x
    inx 
    bne ClearMemory

VBlankWaitPost:
    bit PPUSTATUS
    bpl VBlankWaitPost

LoadPalettes:
    lda PPUSTATUS
    lda #$3F
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ldx #$00
@Loop:
    lda Palettes, x
    sta PPUDATA
    inx 
    cpx #$20
    bne @Loop

LoadSprites:
    ldx #$00
@Loop:
    lda Sprites, x
    sta $0200, x
    inx 
    cpx #$20
    bne @Loop

ClearBackground:
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ldx #$00
    lda #$00
    sta OverflowCounter
@Loop:
    lda #$24
    sta PPUDATA
    cpx #$FF
    bne @AfterOverflowCheck
    lda OverflowCounter
    clc
    adc #$01
    sta OverflowCounter
@AfterOverflowCheck:
    inx
    cpx #$C0
    bne @Loop
    lda OverflowCounter
    cmp #$03
    bne @Loop

LoadBackgroundFeatures:
    ldx #$00
@Loop:
    lda PPUSTATUS
    lda BackgroundFeatures, x
    sta PPUADDR
    inx
    lda BackgroundFeatures, x
    sta PPUADDR
    inx
    lda BackgroundFeatures, x
    sta PPUDATA
    inx
    cpx #72
    bne @Loop

LoadAttributes:
    lda PPUSTATUS
    lda #$23
    sta PPUADDR
    lda #$C0
    sta PPUADDR
    ldx #$00
@Loop:
    lda AttributeTable, x
    sta PPUDATA
    inx
    cpx #$08
    bne @Loop

EnableRendering:    
    lda #%10010000
    sta PPUCTRL

    lda #%00011110
    sta PPUMASK

Infinite:
    jmp Infinite

NMI:
    lda #$00
    sta OAMADDR
    lda #$02
    sta OAMDMA

LatchController:
    lda #$01
    sta $4016
    lda #$00
    sta $4016

ReadA:
    lda $4016
    and #%00000001
    beq SkipA
SkipA:

ReadB:
    lda $4016
    and #%00000001
    beq SkipB
SkipB:

ReadSelect:
    lda $4016
    and #%00000001
    beq SkipSelect
SkipSelect:

ReadStart:
    lda $4016
    and #%00000001
    beq SkipStart
SkipStart:

; Up movement code
ReadUp:
    lda $4016
    and #%00000001
    beq SkipUp

    lda $0200
    sec
    sbc #PLAYERSPEED
    sta $0200

    lda $0204
    sec
    sbc #PLAYERSPEED
    sta $0204

    lda $0208
    sec
    sbc #PLAYERSPEED
    sta $0208

    lda $020C
    sec
    sbc #PLAYERSPEED
    sta $020C

    lda $0210
    sec
    sbc #PLAYERSPEED
    sta $0210

    lda $0214
    sec
    sbc #PLAYERSPEED
    sta $0214

    lda $0218
    sec
    sbc #PLAYERSPEED
    sta $0218

    lda $021C
    sec
    sbc #PLAYERSPEED
    sta $021C
SkipUp:

; Down movement code
ReadDown:
    lda $4016
    and #%00000001
    beq SkipDown

    lda $0200
    clc
    adc #PLAYERSPEED
    sta $0200

    lda $0204
    clc
    adc #PLAYERSPEED
    sta $0204

    lda $0208
    clc
    adc #PLAYERSPEED
    sta $0208

    lda $020C
    clc
    adc #PLAYERSPEED
    sta $020C

    lda $0210
    clc
    adc #PLAYERSPEED
    sta $0210

    lda $0214
    clc
    adc #PLAYERSPEED
    sta $0214

    lda $0218
    clc
    adc #PLAYERSPEED
    sta $0218

    lda $021C
    clc
    adc #PLAYERSPEED
    sta $021C
SkipDown:

; Left movement code
ReadLeft:
    lda $4016
    and #%00000001
    beq SkipLeft

    lda $0203
    sec
    sbc #PLAYERSPEED
    sta $0203

    lda $0207
    sec
    sbc #PLAYERSPEED
    sta $0207

    lda $020B
    sec
    sbc #PLAYERSPEED
    sta $020B

    lda $020F
    sec
    sbc #PLAYERSPEED
    sta $020F

    lda $0213
    sec
    sbc #PLAYERSPEED
    sta $0213

    lda $0217
    sec
    sbc #PLAYERSPEED
    sta $0217

    lda $021B
    sec
    sbc #PLAYERSPEED
    sta $021B

    lda $021F
    sec
    sbc #PLAYERSPEED
    sta $021F

    lda PlayerFacing
    cmp #$01 ; is player facing left?
    beq SkipFlipPlayerLeft

    lda #$05
    sta $020D

    lda #$06
    sta $0211

    lda #$01
    sta PlayerFacing

SkipFlipPlayerLeft:
SkipLeft:

; Right movement code
ReadRight:
    lda $4016
    and #%00000001
    beq SkipRight

    lda $0203
    clc
    adc #PLAYERSPEED
    sta $0203

    lda $0207
    clc
    adc #PLAYERSPEED
    sta $0207

    lda $020B
    clc
    adc #PLAYERSPEED
    sta $020B

    lda $020F
    clc
    adc #PLAYERSPEED
    sta $020F

    lda $0213
    clc
    adc #PLAYERSPEED
    sta $0213

    lda $0217
    clc
    adc #PLAYERSPEED
    sta $0217

    lda $021B
    clc
    adc #PLAYERSPEED
    sta $021B

    lda $021F
    clc
    adc #PLAYERSPEED
    sta $021F

    lda PlayerFacing
    cmp #$00 ; is player facing right?
    beq SkipFlipPlayerRight

    lda #$03
    sta $020D

    lda #$04
    sta $0211

    lda #$00
    sta PlayerFacing

SkipFlipPlayerRight:
SkipRight:

CleanNMI:
    lda #%10010000
    sta PPUCTRL

    lda #%00011110
    sta PPUMASK

    lda #$00
    sta PPUSCROLL
    sta PPUSCROLL
    rti 

Palettes:
    ; Background palettes
    .byte $0F, $02, $11, $30
	.byte $0F, $3A, $29, $09
	.byte $0F, $39, $3A, $3B
	.byte $0F, $3D, $3E, $0F

    ; Sprite palettes
	.byte $0F, $09, $39, $2A ; Green and black
	.byte $0F, $38, $39, $0F
	.byte $0F, $1C, $15, $14
	.byte $0F, $02, $38, $3C

Sprites:
    .byte $C8, $00, %00000000, $0F
    .byte $C8, $01, %00000000, $17
    .byte $D0, $02, %00000000, $09
    .byte $D0, $03, %00000000, $11 ; tiles will change to 5 and 6 if turned left 0x20D
    .byte $D0, $04, %00000000, $19 ; 0x211
    .byte $D8, $07, %00000000, $0C
    .byte $D8, $08, %00000000, $14
    .byte $D8, $09, %00000000, $1C

BackgroundFeatures:
    .byte $20, $43, $19
    .byte $20, $44, $12
    .byte $20, $45, $10

    .byte $20, $63, $44
    .byte $20, $64, $03

    .byte $20, $4B, $0B
    .byte $20, $4C, $0E
    .byte $20, $4D, $0A
    .byte $20, $4E, $0D
    .byte $20, $4F, $1C

    .byte $20, $6B, $44
    .byte $20, $6C, $00
    .byte $20, $6D, $00

    ; star cluster
    .byte $21, $78, $29
    .byte $21, $79, $2A
    .byte $21, $98, $2B
    .byte $21, $99, $2C

    ; bottom half star cluster
    .byte $20, $C8, $2B
    .byte $20, $C9, $2C

    .byte $22, $03, $29

    .byte $23, $19, $25
    .byte $23, $1A, $26
    .byte $23, $39, $27
    .byte $23, $3A, $28

AttributeTable:
    .byte %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101
    .byte %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101

    .segment "VECTORS"

    .word NMI
    .word Reset
    .word 0

    .segment "CHARS"

    .incbin "graphics.chr"