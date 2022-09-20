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
; 01 - SSF
; 02-08 - TBD
; 09 - Options
PlayerStage:
    .byte $00

; Direction player is facing
; 00 - right
; 01 - left
PlayerFacing:
    .byte $00

;             --- paused (0 - no, 1 - yes)
;             | -- player facing direction (0 - right, 1 - left)
;             | |
; 0 0 0 0 0 0 0 0
GameStatus:
    .byte %00000000

; button press states (A, B, Select, Start, Up, Down, Left, Right)
Buttons:
    .byte %00000000

; prevents certain buttons from being held
ButtonTapChecker:
    .byte %00000000

; Memory address of current room
PlayerRoom:
    .byte $00, $00

; Tracks whether beads have been collected in stage
BeadStates:
    .byte %00000000

TempPointer:
    .byte $00, $00

CurrentBGKeyframeSet:
    .word 0

CurrentBGKeyframe:
    .byte $00

BGKeyframeCounter:
    .byte $00

TempValue:
    .byte $00, $00

SelectedOption:
    .byte $00

TitleCardTimer:
    .byte $00

BananaPullTimer:
    .byte $00

OverflowCounter: ; counting overflows for loops which exceed 256 iterations
    .byte 0

    .segment "HEADER"

    .byte "NES", $1A ; iNES Header
    .byte 2 ; PRG data size (16kb)
    .byte 1 ; CHR data size (8kb)
    .byte $01, $00 ; Mapper

    .segment "STARTUP"

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
    sta $0000, x
    sta $0100, x
    sta $0300, x
    sta $0400, x
    sta $0500, x
    sta $0600, x
    sta $0700, x
    lda #$FE
    sta $0200, x
    inx 
    bne ClearMemory

    jsr WaitForVBlank

    ; data initialization section

    lda #$03
    ldx #$01
    sta PlayerLives, x ; set lives to 3

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

    ; startup loads
    jsr ClearBackground
    jsr LoadTitleScreen

    ; enable rendering
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

    lda TitleCardTimer
    cmp #$00
    beq LatchController
    jsr TitleCardEvent
    jmp CleanNMI

LatchController:
    lda #$00
    sta Buttons
    lda #$01
    sta $4016
    lda #$00
    sta $4016
    ldx #$08
@Loop:
    lda $4016
    lsr a
    rol Buttons
    dex
    bne @Loop

    ; Start button
    lda Buttons
    and #%00010000
    beq SkipStart
    ldx PlayerStage
    cpx #$00
;    bne @PauseOption
    bne SkipStart
    ldx SelectedOption
    cpx #$00
    beq @TitleStartOption
    ;cpx #$01
    ;beq @TitleOptionsOption
    jmp SkipStart
@TitleStartOption:
    jsr DisableScreen
    lda #<SSFBGKeyframes
    sta CurrentBGKeyframeSet
    lda #>SSFBGKeyframes
    sta CurrentBGKeyframeSet+1
    lda #$01
    jsr SetStageValue
    jsr ClearBackground
    lda #<SSFPalette
    sta TempPointer
    lda #>SSFPalette
    sta TempPointer+1
    jsr LoadLevelPalette
    jsr EnableScreen
    lda #<SSFTitleCard
    sta TempPointer
    lda #>SSFTitleCard
    sta TempPointer+1
    jsr RunTitleCard
    jmp CleanNMI
;    jmp SkipStart
;@PauseOption:
;    lda GameStatus
;    and #%00000010
;    cmp #$02 ; is paused?
;    bne @EnablePause
;    jmp SkipStart
;@EnablePause:
;    jsr LoadPauseScreen
;    lda #%00000010
;    ora GameStatus
;    sta GameStatus
SkipStart:

;    lda GameStatus
;    and #%00000010
;    cmp #$02 ; is paused?
;    bne ReadA
;    jmp CleanNMI

; Up movement code
    lda Buttons
    and #%00001000
    beq SkipUp
    lda $0200
    cmp #$07
    bcs @SkipRoomCheck
    ldx #$00
    ldy #$02
    jsr CheckNeighbor
    jmp SkipUp
@SkipRoomCheck:
    ldx #$00
@Loop:
    lda $0200, x
    sec
    sbc #PlayerSpeed
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
    lda Buttons
    and #%00000100
    beq SkipDown
    lda $0200
    cmp #$CC
    bcc @SkipRoomCheck
    ldx #$01
    ldy #$04
    jsr CheckNeighbor
    jmp SkipDown
@SkipRoomCheck:
    ldx #$00
@Loop:
    lda $0200, x
    clc
    adc #PlayerSpeed
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
    lda Buttons
    and #%00000010
    beq SkipLeft
    lda $0203
    cmp #$08
    bcs @SkipRoomCheck
    ldx #$02
    ldy #$06
    jsr CheckNeighbor
    jmp SkipLeft
@SkipRoomCheck:
    ldx #$03
@Loop:
    lda $0200, x
    sec
    sbc #PlayerSpeed
    sta $0200, x
    clc
    inx
    inx
    inx 
    inx
    cpx #$23
    bne @Loop

    lda GameStatus
    and #%00000001
    cmp #%00000001 ; is player facing left?
    beq SkipFlipPlayerLeft
    lda #$05
    sta $020D
    lda #$06
    sta $0211
    lda #%00000001
    ora GameStatus
    sta GameStatus

SkipFlipPlayerLeft:
SkipLeft:

; Right movement code
    lda Buttons
    and #%00000001
    beq SkipRight
    lda $0203
    cmp #$ED
    bcc @SkipRoomCheck
    ldx #$03
    ldy #$08
    jsr CheckNeighbor
    jmp SkipRight
@SkipRoomCheck:
    ldx #$03
@Loop:
    lda $0200, x
    clc
    adc #PlayerSpeed
    sta $0200, x
    clc
    inx
    inx
    inx 
    inx
    cpx #$23
    bne @Loop

    lda GameStatus
    and #%00000001
    cmp #%00000000 ; is player facing right?
    beq SkipFlipPlayerRight
    lda #$03
    sta $020D
    lda #$04
    sta $0211
    lda #%00000001
    eor GameStatus
    sta GameStatus

SkipFlipPlayerRight:
SkipRight:

    lda #$30
    jsr PullBanana

    jsr CheckBeadCollect

RunKeyframeChange:
    lda CurrentBGKeyframeSet+1
    cmp #$00
    beq @Skip
    lda BGKeyframeCounter
    cmp #12
    bne @IncrementCounter
    lda #$00
    sta BGKeyframeCounter
    lda PPUSTATUS
    lda #$3F
    sta PPUADDR
    lda #$03
    sta PPUADDR
    ldy CurrentBGKeyframe
    lda (CurrentBGKeyframeSet), y
    sta PPUDATA
    iny
    sty CurrentBGKeyframe
    lda (CurrentBGKeyframeSet), y
    cmp #$FF
    bne @IncrementCounter
    lda #$00
    sta CurrentBGKeyframe
@IncrementCounter:
    inc BGKeyframeCounter
@Skip:

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
    .byte $0F, $3A, $29, $09 ; stage palette
    .byte $0F, $3A, $29, $09 ; generic/text palette: black, pale green, green, dark green
    .byte $0F, $0F, $0F, $0F
    .byte $0F, $0F, $0F, $0F

    ; Sprite palettes
    .byte $0F, $09, $39, $2A ; Green and black
    .byte $0F, $38, $39, $0F ; Yellow and black
    .byte $0F, $07, $17, $16
    .byte $0F, $0F, $0F, $0F

PigSprite:
    .byte $74, $00, %00000000, $0F
    .byte $74, $01, %00000000, $17
    .byte $7C, $02, %00000000, $09
    .byte $7C, $03, %00000000, $11
    .byte $7C, $04, %00000000, $19 
    .byte $84, $07, %00000000, $0C
    .byte $84, $08, %00000000, $14
    .byte $84, $09, %00000000, $1C

PigSpawnPositions:
    .byte $1E ; top
    .byte $C4 ; down
    .byte $E0 ; left
    .byte $0F ; right

NametableValues:

TitleScreen:
    .byte $21, $2B, $36
    .byte $21, $4B, $37 ; G

    .byte $21, $2C, $38
    .byte $21, $4C, $39 ; R

    .byte $21, $2D, $3A
    .byte $21, $4D, $3B ; E

    .byte $21, $2E, $3A
    .byte $21, $4E, $3B ; E

    .byte $21, $2F, $3C
    .byte $21, $4F, $3D ; N

    .byte $21, $30, $35
    .byte $21, $50, $35 ; Space

    .byte $21, $31, $3E
    .byte $21, $51, $3F ; H

    .byte $21, $32, $40
    .byte $21, $52, $3F ; A

    .byte $21, $33, $41
    .byte $21, $53, $42 ; M

    .byte $21, $0A, $2D ; top-left corner

    .byte $21, $0B, $2E
    .byte $21, $0C, $2E
    .byte $21, $0D, $2E
    .byte $21, $0E, $2E
    .byte $21, $0F, $2E
    .byte $21, $10, $2E ; top straight
    .byte $21, $11, $2E
    .byte $21, $12, $2E
    .byte $21, $13, $2E

    .byte $21, $14, $2F ; top-right corner

    .byte $21, $34, $34
    .byte $21, $54, $34 ; right straight

    .byte $21, $74, $32 ; bottom-right corner

    .byte $21, $73, $31 ; bottom straight
    .byte $21, $72, $31
    .byte $21, $71, $31
    .byte $21, $70, $31
    .byte $21, $6F, $31
    .byte $21, $6E, $31
    .byte $21, $6D, $31
    .byte $21, $6C, $31
    .byte $21, $6B, $31

    .byte $21, $6A, $30 ; bottom-left corner

    .byte $21, $4A, $33 ; left straight
    .byte $21, $2A, $33

    .byte $29, $EB, $44 ; > (default selection)

    ; START
    .byte $29, $ED, $1C
    .byte $29, $EE, $1D
    .byte $29, $EF, $0A
    .byte $29, $F0, $1B
    .byte $29, $F1, $1D

    ; OPTIONS
    .byte $2A, $4C, $18
    .byte $2A, $4D, $19
    .byte $2A, $4E, $1D
    .byte $2A, $4F, $12
    .byte $2A, $50, $18
    .byte $2A, $51, $17
    .byte $2A, $52, $1C

InformationBar:
    ; pig icon
    .byte $20, $49, $64

    ; x
    .byte $20, $4A, $43

    ; bead icon
    .byte $20, $53, $65

    ; x
    .byte $20, $54, $43

Version:
    .byte $0A, $15, $19, $11, $0A ; ALPHA

TitleCardField:
    .byte $0F, $12, $0E, $15, $0D ; FIELD

;PauseDisplay:
;    .byte $10, $0A, $16, $0E ; GAME
;    .byte $24 ; (space)
;    .byte $19, $0A, $1E, $1C, $0E, $0D ; PAUSED

; Room storage format:
; Background pattern (1 word) - memory address of pattern
; Neighboring rooms (4 words) - memory addresses to the rooms which can be entered by approaching the sides of the screen (up, down, left, right; 0 for no room)
; Background (32 bytes) - Tiles for filling the background pattern
; Enemies (4 bytes per, terminated by null byte) - Entities which spawn on the screen and will attack the player

BGPatternA:
    .byte $C2, $D6, $D7 ; 1, 2
    .byte $00
    .byte $1C, $1D, $24, $25, $44, $45, $8F, $90, $AF, $B0, $DA, $DB, $FA, $FB, $E9, $EA ; 2, 4, 4, 4, 2
    .byte $00
    .byte $25, $75, $76, $ED, $EE ; 1, 2, 4 (half)
    .byte $00
    .byte $0D, $0E, $21, $46, $47, $66, $67, $7B ; 4 (half), 1, 4, 1
    .byte $00

BGPatternB:
    .byte $CB, $CC, $F8 ; 2, 1
    .byte $00
    .byte $46, $47, $66, $67, $52, $B9, $BA, $D9, $DA, $CF ; 4, 1, 4, 1
    .byte $00
    .byte $02, $03, $2A, $2B, $4A, $4B, $5C, $5D, $90, $91, $C3, $D8, $EE, $EF ; 2, 4, 2, 2, 1, 1, 2
    .byte $00
    .byte $27, $59, $5A, $79, $7A ; 1, 4
    .byte $00

TitleCards:
    .word SSFTitleCard, 0, 0, 0, 0, 0, 0, 0

LevelPalettes:
    .word SSFPalette, SPFPalette, FHFPalette, MSFPalette, ADFPalette, 0, 0, 0

    .include "leveldata/SSF.asm"
    .include "leveldata/SPF.asm"
    .include "leveldata/FHF.asm"
    .include "leveldata/MSF.asm"
    .include "leveldata/ADF.asm"

    .segment "VECTORS"

    .word NMI
    .word Reset
    .word 0

    .segment "CHARS"

    .incbin "graphics.chr"