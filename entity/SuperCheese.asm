; Super Cheese (02) data and subroutines

; x and y of sprite in index registers
SpawnSuperCheese:
    ldx #$02
    ldy #$24
    lda #$00
    sta TempValue+2
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$26
    lda #$00
    sta TempValue+2
    jsr RenderRow
    rts