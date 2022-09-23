; Palette, BG keyframes, rooms for the Starry Sights Field

SSFPalette:
    .byte $0F, $02, $11, $30 ; black, dark blue, light blue, white

SSFBGKeyframes:
    .byte $30, $20, $10, $00, $10, $20, $FF ; flashing white

SSFTitleCard: ; STARRY SIGHTS
    .byte $21, $87
    .byte 13
    .byte $1C, $1D, $0A, $1B, $1B, $22, $24, $1C, $12, $10, $11, $1D, $1C
    .byte $29, $2A, $25, $26, $29, $2A, $25, $26, $2B, $2C, $27, $28, $2B, $2C, $27, $28

SSFRoomA:
    .word BGPatternA
    .word 0, 0, 0, SSFRoomB

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

SSFRoomB:
    .word BGPatternB
    .word 0, 0, SSFRoomA, 0

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

    .byte $2D, $0E, %00000010, $C1
    .byte $2D, $0F, %00000010, $C9
    .byte $35, $10, %00000010, $C1
    .byte $35, $11, %00000010, $C9
    .byte $3D, $12, %00000010, $C1
    .byte $3D, $13, %00000010, $C9

    .byte $70, $1A, %00000001, $70
    .byte $70, $1A, %01000001, $78
    .byte $78, $1A, %10000001, $70
    .byte $78, $1A, %11000001, $78

    .byte $50, $1B, %00000001, $50
    
    .byte $FF