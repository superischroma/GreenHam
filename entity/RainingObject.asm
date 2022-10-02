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

SpawnIceShards:
    ldy #$1D
    bne SpawnRainingObj

SpawnMeteor:
    ldy #$1E

SpawnRainingObj:
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

; a - offset
RainingObjTick:
    rts