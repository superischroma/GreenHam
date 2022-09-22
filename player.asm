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

; Store the stage value in accumulator register before invoking
SetStageValue:
    sta PlayerStage
    rts