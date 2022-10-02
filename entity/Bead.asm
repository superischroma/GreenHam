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
    lda #$20
    sta TempPointer
    lda #$02
    sta TempPointer+1
    jsr ChkCollison2x2
    beq @End ; is player colliding with bead? if not, branch
    jsr IncrementBeads
    jsr UnloadCurrentBead
    lda BeadStates
    ldy #44
    ora (PlayerRoom), y
    sta BeadStates
@End:
    rts