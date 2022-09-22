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

MoveChopUp:
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
    rts

MoveChopDown:
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
    rts

MoveChopLeft:
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
    beq @Skip
    lda #$05
    sta $020D
    lda #$06
    sta $0211
    lda #%00000001
    ora GameStatus
    sta GameStatus
@Skip:
    rts

MoveChopRight:
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
    beq @Skip
    lda #$03
    sta $020D
    lda #$04
    sta $0211
    lda #%00000001
    eor GameStatus
    sta GameStatus
@Skip:
    rts