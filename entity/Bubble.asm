; Bubble (18; temporary object)

BubblePalette:
    .byte $02, $30, $12, $2D

SpawnBubble:
    lda #<BubblePalette
    sta TempPointer
    lda #>BubblePalette
    sta TempPointer+1
    jsr AddPalette
    sta TempValue+2
    ldx #$02
    ldy #$46
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$48
    jsr RenderRow
    rts