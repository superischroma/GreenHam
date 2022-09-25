; Chop (00) data and subroutines

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
    jsr ChkInGame
    beq @End
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
@End:
    rts

MoveChopDown:
    jsr ChkInGame
    beq @End
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
@End:
    rts

MoveChopLeft:
    jsr ChkInGame
    beq @End
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
@End:
    rts

MoveChopRight:
    jsr ChkInGame
    beq @End
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
@End:
    rts

FaceChopLeft:
    lda GameStatus
    and #%00000001
    bne @Skip ; is player facing left? if so, branch
    lda #$05
    sta $020D
    lda #$06
    sta $0211
    lda #%00000001
    ora GameStatus
    sta GameStatus
@Skip:
    rts

FaceChopRight:
    lda GameStatus
    and #%00000001
    beq @Skip ; is player facing right? if so, branch
    lda #$03
    sta $020D
    lda #$04
    sta $0211
    lda #%00000001
    eor GameStatus
    sta GameStatus
@Skip:
    rts

ChkInGame:
    lda PlayerStage
    cmp #$01
    bcc @Not
    cmp #$09
    bcs @Not
    lda #$01
    rts
@Not:
    lda #$00
    rts