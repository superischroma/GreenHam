; Lookup tables for levels

TitleCardTable:
    .word SSFTitleCard, SPFTitleCard, FHFTitleCard, MSFTitleCard, 0, 0, 0, 0

LevelPaletteTable:
    .word SSFPalette, SPFPalette, FHFPalette, MSFPalette, ADFPalette, 0, 0, 0

InitialRoomTable:
    .word SSFRoomA, SPFRoomA, FHFRoomA, MSFRoomA, 0, 0, 0, 0

BGKeyframeSetTable:
    .word SSFBGKeyframes, SPFBGKeyframes, FHFBGKeyframes, MSFBGKeyframes, 0, 0, 0, 0

TickTable:
    .word 0, 0, 0, BananaTick, 0, BlackHoleTick, SpeedsterTick

SpawnTable:
    .word 0, 0, SpawnSuperCheese

EntityInitSpriteTable:
    .byte $00, $00, $24, $0E, $00, $1A, $1B, $1D, $1E, $2B, $2A, $28, $35, $31, $34

EntityWidthTable:
    .byte $00, $00, $02, $02, $03, $02, $01, $02, $02, $02, $02, $01, $01, $03, $01

EntitySpriteCtTable:
    .byte $00, $00, $04, $06, $08, $04, $01, $04, $04, $06, $04, $02, $01, $03, $03