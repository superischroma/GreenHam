; Bubble Generator (14) data and subroutines

BubbleLikePalette:
    .byte $02, $30, $12, $2D

BubbleFloatDelay = $02

SpawnBubbleGenerator:
    lda #<BubbleLikePalette
    sta TempPointer
    lda #>BubbleLikePalette
    sta TempPointer+1
    jsr AddPalette
    sta TempValue+2
    ldx #$02
    ldy #$FE
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
    ldx #$02
    ldy #$FE
    jsr RenderRow
    lda TempValue+1
    clc
    adc #$02
    sta TempValue+1
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

BubbleGeneratorTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    lda BubbleFloatTimer
    cmp BubbleFloatDelay+1
    bne @SkipFloat
    ldy #$04
    ldx TempPointer
    lda #$00
    jsr MoveSpriteGroup
    lda #$00
    sta BubbleFloatTimer
@SkipFloat:
    inc BubbleFloatTimer
    ldy #$00
    lda (TempPointer), y
    sta TempValue
    ldy #$10
    lda (TempPointer), y
    sec
    sbc #$0B
    cmp TempValue
    beq @EnableBubble
    ldy #$00
    lda (TempPointer), y
    cmp #$FF
    beq @DisableBubble
    jsr ChkCollison2x2
    beq @Ret
    jmp @DisableBubble
@EnableBubble:
    ldx #$46
    ldy #$01
@ELoop:
    txa
    sta (TempPointer), y
    inx
    tya
    clc
    adc #$04
    tay
    cpx #$4A
    bne @ELoop
@Ret:
    lda TempIndex+1
    clc
    adc #$20
    sta TempIndex+1
    rts
@DisableBubble:
    ldy #$01
@DLoop:
    lda #$FE
    sta (TempPointer), y
    tya
    clc
    adc #$04
    tay
    cpy #$11
    bne @DLoop
    jmp @Ret