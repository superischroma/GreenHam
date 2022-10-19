; Bubble Generator (14) data and subroutines

BubbleLikePalette:
    .byte $02, $30, $12, $2D

SpawnBubbleGenerator:
    lda #<BubbleLikePalette
    sta TempPointer
    lda #>BubbleLikePalette
    sta TempPointer+1
    jsr AddPalette
    sta TempValue+2
    ldx #$02
    ldy #$4A
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$4C
    jsr RenderRow
    rts