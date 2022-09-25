; Bead (01) data and subroutines

UnloadCurrentBead:
    ldx #$20
    lda #$FE
@Loop:
    sta $0200, x
    inx
    cpx #$30
    bne @Loop
    rts

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
    jsr UnloadCurrentBead
    lda BeadStates
    ldy #44
    ora (PlayerRoom), y
    sta BeadStates
@End:
    rts