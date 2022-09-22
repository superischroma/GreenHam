BananaPullDelay = $01

; a - offset
BananaTick:
    ldx BananaPullTimer
    cpx #BananaPullDelay
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