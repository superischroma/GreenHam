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

FHFRoomStart:
    .word BGPatternA
    .word 0, 0, 0, FHFRoomSplit

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

    .byte $70, $70, %00000001

    .byte $FF

FHFRoomSplit:
    .word BGPatternA
    .word FHFRoomU1, FHFRoomD1, FHFRoomStart, 0

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

    .byte $03, $70, $70

    .byte $FF

FHFRoomU1:
    .word BGPatternA
    .word 0, FHFRoomSplit, 0, FHFRoomU2

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

    .byte $FF

FHFRoomU2:
    .word BGPatternA
    .word 0, 0, FHFRoomU1, FHFRoomU3

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

    .byte Gravitor_ID, $80, GravitorY

    .byte $FF

FHFRoomU3:
    .word BGPatternA
    .word 0, 0, FHFRoomU2, FHFRoomU4

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

    .byte AntiChop_ID, $A0, $40

    .byte $FF

FHFRoomU4:
    .word BGPatternA
    .word FHFRoomUU, FHFRoomNeedle, FHFRoomU3, 0

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

    .byte $70, $70, %00000010

    .byte Meteor_ID, $70, $70

    .byte $FF

FHFRoomUU:
    .word BGPatternA
    .word 0, FHFRoomU4, 0, 0

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

    .byte $D0, $30, %00000100

    .byte Meteor_ID, $D0, $30

    .byte $FF

FHFRoomD1:
    .word BGPatternA
    .word FHFRoomSplit, 0, 0, FHFRoomD2

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

    .byte $FF

FHFRoomD2:
    .word BGPatternA
    .word 0, FHFRoomDD, FHFRoomD1, FHFRoomD3

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

    .byte Gravitor_ID, $80, GravitorY
    .byte Meteor_ID, $70, $70

    .byte $FF

FHFRoomDD:
    .word BGPatternA
    .word FHFRoomD2, FHFRoomDDD, 0, 0

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

    .byte $70, $30, %00010000

    .byte $FF

FHFRoomDDD:
    .word BGPatternA
    .word FHFRoomDD, 0, 0, 0

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

    .byte $C0, $C0, %00100000

    .byte $FF

FHFRoomD3:
    .word BGPatternA
    .word 0, 0, FHFRoomD2, FHFRoomD4

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

    .byte Banana_ID, $40, $40

    .byte $FF

FHFRoomD4:
    .word BGPatternA
    .word FHFRoomNeedle, FHFRoomSewing, FHFRoomD3, 0

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

    .byte $70, $70, %00001000

    .byte $FF

FHFRoomSewing:
    .word BGPatternA
    .word FHFRoomD4, 0, 0, 0

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

    .byte $70, $70, %00000000

    .byte SewingKit_ID, $30, $B0

    .byte $FF

FHFRoomNeedle:
    .word BGPatternA
    .word FHFRoomU4, FHFRoomD4, 0, FHFRoomR1

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

    .byte Needle_ID, $80, $A0

    .byte $FF

FHFRoomR1:
    .word BGPatternA
    .word 0, 0, FHFRoomNeedle, FHFRoomR2

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

    .byte $FF

FHFRoomR2:
    .word BGPatternA
    .word 0, FHFRoomR3, FHFRoomR1, FHFRoomEnd

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

    .byte $70, $30, %01000000

    .byte $FF

FHFRoomR3:
    .word BGPatternA
    .word FHFRoomR2, FHFRoomR4, 0, 0

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

    .byte $FF

FHFRoomR4:
    .word BGPatternA
    .word FHFRoomR3, 0, 0, FHFRoomR5

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

    .byte Banana_ID, $70, $40
    .byte Meteor_ID, $70, $A0

    .byte $FF

FHFRoomR5:
    .word BGPatternA
    .word 0, 0, FHFRoomR4, 0

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

    .byte $70, $70, %10000000

    .byte $FF