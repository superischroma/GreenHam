UnloadCurrentBead:
    ldx #$20
    lda #$FE
@Loop:
    sta $0200, x
    inx
    cpx #$30
    bne @Loop
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
    jsr UnloadCurrentBead
    lda BeadStates
    ldy #44
    ora (PlayerRoom), y
    sta BeadStates
@End:
    rts