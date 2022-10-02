; Data and subroutines for Ice Shards (07) and Meteors (08)

RainingObjSpeed = $02
ROTriggerRange = 1
ROTriggerPxRange = ROTriggerRange * 8
ROTriggerFarDelta = ROTriggerPxRange + 7

ROStartingX = $F0
ROStartingY = $00

FHFMeteorPalette:
    .byte $22, $07, $27, $38

SpawnIceShards:
    ldy #$1D
    bne SpawnRainingObj

SpawnMeteor:
    ldy #$1E

SpawnRainingObj:
    ldx EntityCount
    dex
    txa
    asl a
    tax
    lda TempValue
    sta EntityData, x
    lda TempValue+1
    sta EntityData+1, x
    lda #ROStartingX
    sta TempValue
    lda #ROStartingY
    sta TempValue+1
    lda #$01
    cpy #$1E
    bne @NotFHFMeteor
    ldy PlayerStage
    cpy #FHF_ID 
    bne @NotFHFMeteor ; is player in FHF? if not, branch
    lda #<FHFMeteorPalette
    sta TempPointer
    lda #>FHFMeteorPalette
    sta TempPointer+1
    jsr AddPalette ; add FHF meteor palette
@NotFHFMeteor:
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
    rts

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

; x - index
; a - offset
RainingObjTick:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    lda #$00
    sta $00FE
    ldy #$01
    lda (TempPointer), y
    cmp #$FE
    bne @Run
    lda ActiveEntities, x
    clc
    adc #$16
    sta TempValue
    txa
    asl a
    tax
    lda EntityData, x ; get x-pos of trigger point
    cmp $020F
    bcs @End
    inc $00FE
    clc
    adc #$10
    cmp $020F
    bcc @End
    inc $00FE
    lda EntityData+1, x ; get y-pos of trigger point
    cmp $020C
    bcs @End
    inc $00FE
    clc
    adc #$10
    cmp $020C
    bcc @End
    inc $00FE
    ; init for run
    ldy #$01
@InitLoop:
    lda TempValue
    sta (TempPointer), y
    cmp #$1D
    beq @SkipInc
    inc TempValue
@SkipInc:
    tya
    clc
    adc #$04
    tay
    cpy #$11
    bne @InitLoop
@End:
    rts
@Run:
    ldy #$00
@MoveLoop:
    lda (TempPointer), y
    clc
    adc #$02
    sta (TempPointer), y
    tya
    clc
    adc #$03
    tay
    lda (TempPointer), y
    sec
    sbc #$02
    sta (TempPointer), y
    iny
    cpy #$10
    bne @MoveLoop
    ldy #$00
    lda (TempPointer), y
    cmp #$E4
    bcc @End
    ldy #$00
    lda #ROStartingX
    sta TempValue
    lda #ROStartingY
    sta TempValue+1
@ResetLoop:
    lda TempValue+1
    sta (TempPointer), y
    lda TempValue
    cmp #ROStartingX
    beq @SkipYInc
    lda TempValue+1
    clc
    adc #$08
    sta TempValue+1
@SkipYInc:
    iny
    lda #$FE
    sta (TempPointer), y
    iny
    iny
    lda TempValue
    sta (TempPointer), y
    cmp #ROStartingX
    bne @SubX
    clc
    adc #$08
    bne @AfterSubX
@SubX:
    sec
    sbc #$08
@AfterSubX:
    sta TempValue
    iny
    cpy #$10
    bne @ResetLoop
    rts

; $0C, $E4