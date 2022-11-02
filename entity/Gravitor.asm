; Gravitor (0C) data and subroutines

GravitorPullDelay = $02
GravitorY = $30 ; gravitor has a constant y position
GravitorChargeSpeed = $02
GravitorResetSpeed = $01
GravitorStopY = $E0
DropPigSpeed = $04

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

SpawnGravitor:
    ldx #$01
    ldy #$35
    lda #$01
    sta TempValue+2
    jsr RenderRow
    rts

GravitorTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    ldy #$00
    lda (TempPointer), y
    cmp #GravitorY
    bne @Charge
    ldx BananaPullTimer
    cpx #GravitorPullDelay
    beq @DoneDelayCheck
    inc BananaPullTimer
    jmp @Finish
@DoneDelayCheck:
    lda #$00
    sta BananaPullTimer
    ldy #$03
    lda (TempPointer), y
    cmp $020F
    bcc @MoveRight
    beq @ChkBelow
    ldy #$01
    lda TempPointer
    tax
    lda #$02
    jsr MoveSpriteGroup
    jmp @Finish
@MoveRight:
    ldy #$01
    lda TempPointer
    tax
    lda #$03
    jsr MoveSpriteGroup
@Finish:
    lda TempIndex+1
    clc
    adc #$04
    sta TempIndex+1
    rts

@ChkBelow:
    ldy #$00
    lda (TempPointer), y
    cmp $020C
    bcs @Finish

@Charge:
    ldy #$00
    lda (TempPointer), y
    clc
    adc #GravitorChargeSpeed
    sta (TempPointer), y
    cmp $020C
    bcc @Finish
    ldy #$03
    lda (TempPointer), y
    clc
    adc #$0C
    cmp $020F
    bcc @Finish
    sec
    sbc #$18
    cmp $020F
    bcs @Finish
    lda GameStatus
    ora #%00001000
    sta GameStatus
    jsr @DropPig
    ldy #$00
    lda (TempPointer), y
    cmp #$EE
    bcc @Finish
    lda TempIndex+1
    clc
    adc #$04
    sta TempIndex+1
    jmp PlayerDeath

@DropPig:
    ldx #$00
@DropPigLoop:
    lda $0200, x
    clc
    adc #DropPigSpeed
    sta $0200, x
    txa
    clc
    adc #$04
    tax
    cpx #$20
    bne @DropPigLoop
    rts 