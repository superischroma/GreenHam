; Lookup tables for levels

TitleCardTable:
    .word FHFTitleCard, SPFTitleCard, MSFTitleCard, ADFTitleCard, SSFTitleCard, 0, 0, 0

LevelPaletteTable:
    .word FHFPalette, SPFPalette, MSFPalette, ADFPalette, SSFPalette, 0, 0, 0

InitialRoomTable:
    .word FHFRoomStart, SPFRoomA, MSFRoomA, ADFRoomA, SSFRoomA, 0, 0, 0

BGKeyframeSetTable:
    .word FHFBGKeyframes, SPFBGKeyframes, MSFBGKeyframes, 0, SSFBGKeyframes, 0, 0, 0

TickTable:
    .word 0, 0, 0, BananaTick
    .word BananaTick, BlackHoleTick, SpeedsterTick, RainingObjTick
    .word RainingObjTick, BananaTick, BlackHoleTick, RainingObjTick
    .word GravitorTick, ThundercloudTick, 0, 0
    .word 0, 0, 0, 0
    .word BubbleGeneratorTick, 0, NeedleTick, SewingKitTick

SpawnTable:
    .word 0, 0, SpawnSuperCheese, SpawnBanana
    .word SpawnAntiChop, SpawnBlackHole, SpawnSpeedster, SpawnIceShards
    .word SpawnMeteor, SpawnSandzilla, SpawnQuicksand, SpawnSpikes
    .word SpawnGravitor, SpawnThundercloud, 0, 0
    .word SpawnPartyPopper, SpawnNegativeSpell, 0, 0
    .word SpawnBubbleGenerator, 0, SpawnNeedle, SpawnSewingKit