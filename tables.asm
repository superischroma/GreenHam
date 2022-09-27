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
    .word 0, 0, SpawnSuperCheese, SpawnBanana, 0, 0, SpawnSpeedster