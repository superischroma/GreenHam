; Palette, BG keyframes, rooms for the Magical Spell Field

MSFPalette:
    .byte $34, $24, $16, $30

MSFBGKeyframes:
    .byte $30, $20, $10, $00, $10, $20, $FF ; flashing white

MSFTitleCard: ; MAGICAL SPELL
    .byte $21, $87
    .byte 13
    .byte $16, $0A, $10, $12, $0C, $0A, $15, $24, $1C, $19, $0E, $15, $15
    .byte $54, $55, $58, $59, $54, $55, $58, $59, $56, $57, $5A, $5B, $56, $57, $5A, $5B

MSFRoomA:
    .word BGPatternA
    .word 0, 0, 0, 0

    .byte $59
    .byte $5A, $5B
    .byte $58, $59
    .byte $54, $55, $56, $57
    .byte $58, $59, $5A, $5B
    .byte $54, $55, $56, $57
    .byte $5A, $5B
    .byte $5A
    .byte $59, $5A
    .byte $58, $59, $5A, $5B
    .byte $58
    .byte $58, $59, $5A, $5B
    .byte $5B

    .byte $00, $00, %00000000

    .byte $11, $70, $70

    .byte $FF