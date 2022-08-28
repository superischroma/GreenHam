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