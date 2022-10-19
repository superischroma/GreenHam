; Lookup tables for levels

TitleCardTable:
    .word FHFTitleCard, SPFTitleCard, MSFTitleCard, ADFTitleCard, SSFTitleCard, 0, 0, 0

LevelPaletteTable:
    .word FHFPalette, SPFPalette, MSFPalette, ADFPalette, SSFPalette, 0, 0, 0

InitialRoomTable:
    .word FHFRoomA, SPFRoomA, MSFRoomA, ADFRoomA, SSFRoomA, 0, 0, 0

BGKeyframeSetTable:
    .word FHFBGKeyframes, SPFBGKeyframes, MSFBGKeyframes, 0, SSFBGKeyframes, 0, 0, 0

TickTable:
    .word 0, 0, 0, BananaTick, 0, BlackHoleTick, SpeedsterTick, RainingObjTick, RainingObjTick, BananaTick, BlackHoleTick, RainingObjTick, GravitorTick, ThundercloudTick, 0, 0, 0, 0, 0, 0, 0, 0, NeedleTick, 0

SpawnTable:
    .word 0, 0, SpawnSuperCheese, SpawnBanana, 0, SpawnBlackHole, SpawnSpeedster, SpawnIceShards, SpawnMeteor, SpawnSandzilla, SpawnQuicksand, SpawnSpikes, SpawnGravitor, SpawnThundercloud, 0, 0, 0, SpawnNegativeSpell, 0, 0, SpawnBubbleGenerator, 0, SpawnNeedle, 0