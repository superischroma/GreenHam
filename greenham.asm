; ----------------------------------------------------------
; -                        Green Ham                       -
; -                 Written by superischroma               -
; -                      MAIN CONTROLLER                   -
; ----------------------------------------------------------

    .include "constants.asm"

    .segment "ZEROPAGE"

; Lives count - starts at 3, goes to 99
PlayerLives:
    .byte $00, $00

; Bead count - starts at 0, goes to 80
PlayerBeads:
    .byte $00, $00

; Current stage of the player
; 00 - Title screen
; 01 - Space stage
; 02-08 - TBD
PlayerStage:
    .byte $00

; Direction player is facing
; 00 - right
; 01 - left
PlayerFacing:
    .byte $00

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

    .include "loader.asm"
    .include "player.asm"

WaitForVBlank:
    bit PPUSTATUS
    bpl WaitForVBlank
    rts

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

    jsr WaitForVBlank

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

    jsr WaitForVBlank

InitializeData:
    ; Initialize lives
    lda #$03
    ldx #$01
    sta PlayerLives, x

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

    jsr ClearBackground

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
;    and #%00000001
;    beq SkipA
;SkipA:

ReadB:
    lda $4016
;    and #%00000001
;    beq SkipB
;SkipB:

ReadSelect:
    lda $4016
;    and #%00000001
;    beq SkipSelect
;SkipSelect:

ReadStart:
    lda $4016
;    and #%00000001
;    beq SkipStart
;SkipStart:

; Up movement code
ReadUp:
    lda $4016
    and #%00000001
    beq SkipUp
    ldx #$00
@Loop:
    lda $0200, x
    sec
    sbc #PLAYERSPEED
    sta $0200, x
    clc
    inx
    inx
    inx 
    inx
    cpx #$20
    bne @Loop
SkipUp:

; Down movement code
ReadDown:
    lda $4016
    and #%00000001
    beq SkipDown
    ldx #$00
@Loop:
    lda $0200, x
    clc
    adc #PLAYERSPEED
    sta $0200, x
    clc
    inx
    inx
    inx 
    inx
    cpx #$20
    bne @Loop
SkipDown:

; Left movement code
ReadLeft:
    lda $4016
    and #%00000001
    beq SkipLeft
    ldx #$03
@Loop:
    lda $0200, x
    sec
    sbc #PLAYERSPEED
    sta $0200, x
    clc
    inx
    inx
    inx 
    inx
    cpx #$23
    bne @Loop

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
    ldx #$03
@Loop:
    lda $0200, x
    clc
    adc #PLAYERSPEED
    sta $0200, x
    clc
    inx
    inx
    inx 
    inx
    cpx #$23
    bne @Loop

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

NametableValues:

InformationBar:
    ; PIG
    .byte $20, $43, $19
    .byte $20, $44, $12
    .byte $20, $45, $10

    ; x
    .byte $20, $63, $44

    ; BEADS
    .byte $20, $4D, $0B
    .byte $20, $4E, $0E
    .byte $20, $4F, $0A
    .byte $20, $50, $0D
    .byte $20, $51, $1C

    ; x
    .byte $20, $6D, $44

    ; STAGE
    .byte $20, $58, $1C
    .byte $20, $59, $1D
    .byte $20, $5A, $0A
    .byte $20, $5B, $10
    .byte $20, $5C, $0E

SpaceBackground:
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

Version:
    .byte $0A, $15, $19, $11, $0A

AttributeTable:
    .byte %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101
    .byte %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101, %01010101

    .segment "VECTORS"

    .word NMI
    .word Reset
    .word 0

    .segment "CHARS"

    .incbin "graphics.chr"