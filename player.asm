; Green Ham - Subroutines for managing the player

IncrementBeads:
    ldx #$01
    inc PlayerBeads, x
    lda PlayerBeads, x
    cmp #10
    bne @SkipTensChange
    lda #$00
    sta PlayerBeads, x
    inc PlayerBeads
@SkipTensChange:
    jsr LoadBeads
    rts

IncrementLives:
    ldx #$01
    inc PlayerLives, x
    lda PlayerLives, x
    cmp #10
    bne @SkipTensChange
    lda #$00
    sta PlayerLives, x
    inc PlayerLives
@SkipTensChange:
    jsr LoadLives
    rts

DecrementLives:
    ldx #$01
    dec PlayerLives, x
    lda PlayerLives, x
    cmp #$FF
    bne @SkipTensChange
    lda #$09
    sta PlayerLives, x
    dec PlayerLives
@SkipTensChange:
    jsr LoadLives
    rts

SetPlayerY:
    tya
    sta $0200
    sta $0204
    clc
    adc #$08
    sta $0208
    sta $020C
    sta $0210
    clc
    adc #$08
    sta $0214
    sta $0218
    sta $021C
    rts

SetPlayerX:
    txa
    sta $0203
    clc
    adc #$08
    sta $0207
    sec
    sbc #$0E
    sta $020B
    clc
    adc #$08
    sta $020F
    clc
    adc #$08
    sta $0213
    sec
    sbc #$0D
    sta $0217
    clc
    adc #$08
    sta $021B
    clc
    adc #$08
    sta $021F
    rts

; Store the stage value in accumulator register before invoking
SetStageValue:
    sta PlayerStage
    jsr LoadStage
    rts

; a - offset
PullBanana:
    ldx BananaPullTimer
    cpx #BANANAPULLDELAY
    beq @DoneDelayCheck
    inc BananaPullTimer
    rts

@DoneDelayCheck:
    sta TempPointer
    lda #$02
    sta TempPointer+1

    ; check if banana must move right
    ldy #$07
    lda (TempPointer), y ; load top-right sprite x-pos of banana
    cmp $020B ; left-most sprite x-pos of pig
    bcs @DoneLeftCheck
    ldx #$00
    ldy #$03
    jsr @PullBananaLoop
@DoneLeftCheck:
    ; check if banana must move left
    ldy #$03
    lda (TempPointer), y ; load top-left sprite x-pos of banana
    sec
    sbc #$08
    cmp $0213 ; right-most sprite x-pos of pig
    bcc @DoneRightCheck
    ldx #$01
    ldy #$03
    jsr @PullBananaLoop
@DoneRightCheck:
    ; check if banana must move down
    ldy #$10
    lda (TempPointer), y ; bottom-most sprite y-pos of banana
    cmp $0200 ; top-most sprite y-pos of pig
    bcs @DoneUpCheck
    ldx #$00
    ldy #$00
    jsr @PullBananaLoop
@DoneUpCheck:
    ; check if banana must move up
    ldy #$00
    lda (TempPointer), y ; top-most sprite y-pos of banana
    sec
    sbc #$08
    cmp $0214 ; bottom-most sprite y-pos of pig
    bcc @DoneDownCheck
    ldx #$01
    ldy #$00
    jsr @PullBananaLoop
@DoneDownCheck:
    lda #$00
    sta BananaPullTimer
    rts

; a: attribute update; x: 0 - add, 1 - subtract
@PullBananaLoop:
    tya
    clc
    adc #24
    sta TempValue
@LoopSeg:
    lda (TempPointer), y
    cpx #$01
    beq @SubSpeed
    clc
    adc #$01
    jmp @AfterSubSpeed
@SubSpeed:
    sec
    sbc #$01
@AfterSubSpeed:
    sta (TempPointer), y
    tya
    clc
    adc #$04
    tay
    cpy TempValue
    bne @LoopSeg
    rts

; bead sprite 1 x: $0223
; bead sprite 1 y: $0220
; bead sprite 2 x: $0227
; bead sprite 2 y: $0224
; bead sprite 3 x: $022B
; bead sprite 3 y: $0228
; bead sprite 4 x: $022F
; bead sprite 4 y: $022C

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

; pig sprite 4 x >= bead sprite 1 x && pig sprite 4 x <= bead sprite 2 x && pig sprite 4 y <= bead sprite 3 y && pig sprite 4 y >= bead sprite 1 y
CheckBeadCollect:
    lda $0220
    cmp #$FE
    bne @Continue
    rts
@Continue:
    lda $020F
    cmp $0223
    bcc @End
    cmp $0227
    bcs @End
    lda $020C
    cmp $0228
    bcs @End
    cmp $0220
    bcc @End
    jsr IncrementBeads
    jsr UnloadBead
@End:
    rts