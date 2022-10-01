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
    rts