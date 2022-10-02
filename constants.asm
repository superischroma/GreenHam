; PPU IO ports
PPUCTRL = $2000
PPUMASK = $2001
PPUSTATUS = $2002
OAMADDR = $2003
OAMDATA = $2004
PPUSCROLL = $2005
PPUADDR = $2006
PPUDATA = $2007
OAMDMA = $4014
; APU IO ports
APUFLAGS = $4015
SQ1_ENV = $4000
SQ1_SWEEP = $4001
SQ1_LO = $4002
SQ1_HI = $4003
SQ2_ENV = $4004
SQ2_SWEEP = $4005
SQ2_LO = $4006
SQ2_HI = $4007
TRI_ENV = $4008
TRI_LO = $400A
TRI_HI = $400B
; Stage IDs
; 00 - Title screen
; 01 - Fluttering Heights Field
; 02 - Sandy Pyramid Field
; 03 - Magical Spell Field
; 04 - Aquatic Depths Field
; 05 - Starry Sights Field
; 06 - Flashing Casino Field
; 07 - Planetary Debris Field
; 08 - Flowing Fire Field
; 09 - Options
; 0A - Field Select
TitleScreen_ID = $00
FHF_ID = $01
SPF_ID = $02
MSF_ID = $03
ADF_ID = $04
SSF_ID = $05
FCF_ID = $06
PDF_ID = $07
FFF_ID = $08
DF_ID = $09
Options_ID = $0A
FieldSelect_ID = $0B
; Constant game settings
Debug = 1
PlayerSpeed = $01