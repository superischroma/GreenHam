; Palette, BG keyframes, rooms for space stage

SpacePalette:
    .byte $0F, $02, $11, $30 ; black, dark blue, light blue, white

SpaceBGKeyframes:
    .byte $30, $20, $10, $00, $10, $20, $FF ; flashing white

SpaceRoomA:
    .word BGPatternA
    .word 0, 0, 0, SpaceRoomB

    .byte $2A
    .byte $2B, $2C
    .byte $2B, $2C
    .byte $25, $26, $27, $28
    .byte $29, $2A, $2B, $2C
    .byte $29, $2A, $2B, $2C
    .byte $29, $2A
    .byte $29
    .byte $2B, $2C
    .byte $25, $26, $27, $28
    .byte $2A
    .byte $29, $2A, $2B, $2C
    .byte $2A

    .byte $00, $00, %00000000

    .byte $FF

SpaceRoomB:
    .word BGPatternB
    .word 0, 0, SpaceRoomA, 0

    .byte $2B, $2C
    .byte $2A
    .byte $29, $2A, $2B, $2C
    .byte $29
    .byte $29, $2A, $2B, $2C
    .byte $2A
    .byte $29, $2A
    .byte $25, $26, $27, $28
    .byte $2B, $2C
    .byte $2B, $2C
    .byte $29
    .byte $2A
    .byte $29, $2A
    .byte $2A
    .byte $29, $2A, $2B, $2C

    .byte $AE, $7C, %00000001

    .byte $2D, $0E, %00000001, $C1
    .byte $2D, $0F, %00000001, $C9
    .byte $35, $10, %00000001, $C1
    .byte $35, $11, %00000001, $C9
    .byte $3D, $12, %00000001, $C1
    .byte $3D, $13, %00000001, $C9
    
    .byte $FF