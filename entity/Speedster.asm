; Speedster subroutines
SpeedsterDelay = $A0
SpeedsterVSpeed = $01
SpeedsterHSpeed = $04

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

; a - offset
SpeedsterTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    lda SpeedsterDestination
    bne @Continue
    lda SpeedsterTimer
    cmp #SpeedsterDelay
    beq @Start
    inc SpeedsterTimer
    rts
@Start:
    lda $020F
    sta SpeedsterDestination
    lda $020C
    sta SpeedsterDestination+1
    ldy #$01
    lda #$1B
    sta (TempPointer), y
    dey
    lda (TempPointer), y ; load y-pos
    ldy #$02
    cmp SpeedsterDestination+1
    bcc @FaceUp
    lda #%00000001
    sta (TempPointer), y
    jmp @Continue
@FaceUp:
    lda #%10000001
    sta (TempPointer), y
@Continue:
    ldy #$00
    lda (TempPointer), y ; load y-pos
    cmp SpeedsterDestination+1
    bcc @MoveDown
    beq @MoveHorizontal
    sec
    sbc #SpeedsterVSpeed
    sta (TempPointer), y
    rts
@MoveDown:
    clc
    adc #SpeedsterVSpeed
    sta (TempPointer), y
    rts
@MoveHorizontal:
    ldy #$03
    lda (TempPointer), y
    cmp SpeedsterDestination
    bcc @MoveRight
    pha
    ldy #$01
    lda #$1C
    sta (TempPointer), y
    iny
    lda #%01000001
    sta (TempPointer), y
    pla
    ldy #$03
    sec
    sbc #SpeedsterHSpeed
    sta (TempPointer), y
    cmp SpeedsterDestination
    bcc @Restore
    beq @Restore
    rts
@MoveRight:
    pha
    ldy #$01
    lda #$1C
    sta (TempPointer), y
    iny
    lda #%00000001
    sta (TempPointer), y
    pla
    ldy #$03
    clc
    adc #SpeedsterHSpeed
    sta (TempPointer), y
    cmp SpeedsterDestination
    bcs @Restore
    rts
@Restore:
    lda #$00
    sta SpeedsterDestination
    sta SpeedsterDestination+1
    sta SpeedsterTimer
    rts