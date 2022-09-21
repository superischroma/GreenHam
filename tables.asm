; Pointer tables for levels

TitleCardTable:
    .word SSFTitleCard, SPFTitleCard, 0, 0, 0, 0, 0, 0

LevelPaletteTable:
    .word SSFPalette, SPFPalette, FHFPalette, MSFPalette, ADFPalette, 0, 0, 0

InitialRoomTable:
    .word SSFRoomA, SPFRoomA, 0, 0, 0, 0, 0, 0

BGKeyframeSetTable:
    .word SSFBGKeyframes, SPFBGKeyframes, 0, 0, 0, 0, 0, 0