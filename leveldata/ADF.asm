; Palette, BG keyframes, rooms for Aquatic Depths Field

ADFPalette:
    .byte $02, $1A, $04, $24

ADFBGKeyframes:
    .byte $30, $20, $10, $00, $10, $20, $FF ; flashing white

ADFTitleCard: ; AQUATIC DEPTHS
    .byte $21, $85
    .byte 14
    .byte $0A, $1A, $1E, $0A, $1D, $12, $0C, $24, $0D, $0E, $19, $1D, $11, $1C
    .byte $5C, $5D, $60, $61, $5C, $5D, $60, $61, $5E, $5F, $62, $63, $5E, $5F, $62, $63

ADFRoomA:
    .word BGPatternC
    .word 0, 0, 0, 0
    
    .byte $5C, $5D, $5C, $5D, $5C, $5D, $5E, $5F
    .byte $5C, $5D, $5C, $5D, $5C, $5D, $5E, $5F
    .byte $5C, $5D, $5E, $5F
    .byte $60, $61, $62, $63
    .byte $5C, $5D, $5E, $5F
    .byte $60, $61, $62, $63

    .byte $00, $00, %00000000

    .byte $14, $70, $70
    
    .byte $FF