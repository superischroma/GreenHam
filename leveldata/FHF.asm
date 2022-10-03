; Palette, BG keyframes, rooms for the Fluttering Heights Field

FHFPalette:
    .byte $22, $0F, $1A, $30

FHFBGKeyframes:
    .byte $30, $20, $FF ; flashing white

FHFTitleCard: ; FLUTTERING HEIGHTS
    .byte $21, $85
    .byte 18
    .byte $0F, $15, $1E, $1D, $1D, $0E, $1B, $12, $17, $10, $24, $11, $0E, $12, $10, $11, $1D, $1C
    .byte $50, $51, $4C, $4D, $50, $51, $4C, $4D, $52, $53, $4E, $4F, $52, $53, $4E, $4F

FHFRoomA:
    .word BGPatternA
    .word 0, 0, 0, 0

    .byte $4E
    .byte $4C, $4D
    .byte $4E, $4F
    .byte $50, $51, $52, $53
    .byte $4C, $4D, $4E, $4F
    .byte $50, $51, $52, $53
    .byte $4C, $4D
    .byte $4F
    .byte $4E, $4F
    .byte $4C, $4D, $4E, $4F
    .byte $4E
    .byte $50, $51, $52, $53
    .byte $4F

    .byte $00, $00, %00000000

    .byte $08, $70, $70
    .byte $0D, $70, $20

    .byte $FF