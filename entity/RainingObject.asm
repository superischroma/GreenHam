; Data and subroutines for Ice Shards (07) and Meteors (08)

RainingObjSpeed = $02
ROTriggerRange = 1
ROTriggerPxRange = ROTriggerRange * 8
ROTriggerFarDelta = ROTriggerPxRange + 7

FHFMeteorPalette:
    .byte $22, $07, $27, $38

ROStartVector:
    .byte $ED, $06
    .byte $F5, $06
    .byte $ED, $0E
    .byte $F5, $0E

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

; $ED, $06

; x - tile
; a - offset
RainingObjTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    lda #$00
    cmp RainingObjTrigger
    bne @Rain ; is trigger location saved? if so, branch
    ldy #$03
    lda (TempPointer), y ; load x-pos of trigger sprite
    sec
    sbc #ROTriggerPxRange
    cmp $020F
    bcs @End ; is player x-pos less than trigger x-pos? if so, branch
    lda (TempPointer), y ; load x-pos of trigger sprite
    clc
    adc #ROTriggerFarDelta
    cmp $020F
    bcc @End ; is player x-pos greater than trigger x-pos? if so, branch
    ldy #$00
    lda (TempPointer), y
    sec
    sbc #ROTriggerPxRange
    cmp $020C
    bcs @End
    lda (TempPointer), y
    clc
    adc #ROTriggerFarDelta
    cmp $020C
    bcc @End
    stx TempValue
    ldx #$00
    stx TempValue+1
@Loop:
    lda TempValue+1
    clc
    adc #$03
    tay
    lda ROStartVector, x
    sta (TempPointer), y
    inx
    ldy TempValue+1
    lda ROStartVector, x
    sta (TempPointer), y
    inx
    iny
    lda TempValue ; load tile index
    cmp #$1E
    bcs @Meteor ; is tile a meteor? if so, branch
    lda #$1D
    sta (TempPointer), y
    jmp @FinishLoop
@Meteor:
    txa
    lsr a ; divide by 2
    clc
    adc #$1E
    sta (TempPointer), y
@FinishLoop:
    lda TempValue+1
    clc
    adc #$04
    sta TempValue+1
    cpx #$08
    bne @Loop
    rts
@Rain:
    ldy #$04
    ldx TempPointer
    lda #$01
    jsr MoveSpriteGroup
    ldy #$04
    ldx TempPointer
    lda #$02
    jsr MoveSpriteGroup
    rts
@End:
    rts