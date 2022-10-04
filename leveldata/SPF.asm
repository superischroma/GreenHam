; Palette, BG keyframes, rooms for the Sandy Pyramid Field

SPFPalette:
    .byte $27, $0F, $28, $38

SPFBGKeyframes:
    .byte $38, $36, $27, $18, $27, $36, $FF ; flashing red

SPFTitleCard: ; SANDY PYRAMID
    .byte $21, $88
    .byte 13
    .byte $1C, $0A, $17, $0D, $22, $24, $19, $22, $1B, $0A, $16, $12, $0D
    .byte $45, $46, $49, $4A, $45, $46, $49, $4A, $47, $48, $4B, $4B, $47, $48, $4B, $4B

SPFRoomA:
    .word BGPatternA
    .word 0, 0, 0, 0

    .byte $66
    .byte $47, $48
    .byte $45, $46
    .byte $49, $4A, $4B, $4B
    .byte $45, $46, $47, $48
    .byte $49, $4A, $4B, $4B
    .byte $45, $46
    .byte $66
    .byte $47, $48
    .byte $45, $46, $47, $48
    .byte $66
    .byte $49, $4A, $4B, $4B
    .byte $66

    .byte $00, $00, %00000000

    .byte $0A, $40, $40
    .byte $09, $90, $90
    .byte $0B, $70, $70

    .byte $FF