; Lookup tables for levels

TitleCardTable:
    .word FHFTitleCard, SPFTitleCard, MSFTitleCard, 0, SSFTitleCard, 0, 0, 0

LevelPaletteTable:
    .word FHFPalette, SPFPalette, MSFPalette, ADFPalette, SSFPalette, 0, 0, 0

InitialRoomTable:
    .word FHFRoomA, SPFRoomA, MSFRoomA, 0, SSFRoomA, 0, 0, 0

BGKeyframeSetTable:
    .word FHFBGKeyframes, SPFBGKeyframes, MSFBGKeyframes, 0, SSFBGKeyframes, 0, 0, 0

TickTable:
    .word 0, 0, 0, BananaTick, 0, BlackHoleTick, SpeedsterTick, 0, 0, 0, BlackHoleTick, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NeedleTick, 0

SpawnTable:
    .word 0, 0, SpawnSuperCheese, SpawnBanana, 0, SpawnBlackHole, SpawnSpeedster, SpawnIceShards, SpawnMeteor, 0, SpawnQuicksand, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, SpawnNeedle, 0