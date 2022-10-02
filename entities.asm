; Entity IDs
; 00 - Chop (player)
; 01 - Bead
; 02 - Super Cheese
; 03 - Banana
; 04 - Anti-Chop
; 05 - Black Hole
; 06 - Speedster
; 07 - Ice Shards
; 08 - Meteor
; 09 - Sandzilla
; 0A - Quicksand
; 0B - Spikes
; 0C - Gravitor
; 0D - Thundercloud
; 0E - Lightning
; 0F - Ewitch
; 10 - Party Popper
; 11 - Negative Spell
; 12 - Fish
; 13 - Chomper
; 14 - Bubble Generator
; 15 - Whirlpool
; 16 - Needle
; 17 - Sewing Kit

Chop_ID = $00
Bead_ID = $01
SuperCheese_ID = $02
Banana_ID = $03
AntiChop_ID = $04
BlackHole_ID = $05
Speedster_ID = $06
IceShards_ID = $07
Meteor_ID = $08
Sandzilla_ID = $09
Quicksand_ID = $0A
Spikes_ID = $0B
Gravitor_ID = $0C
Thundercloud_ID = $0D
Lightning_ID = $0E
Ewitch_ID = $0F
PartyPopper_ID = $10
NegativeSpell_ID = $11
Fish_ID = $12
Chomper_ID = $13
BubbleGenerator_ID = $14
Whirlpool_ID = $15
Needle_ID = $16
SewingKit_ID = $17

; y - count
; x - offset
; a - direction (0 - up, 1 - down, 2 - left, 3 - right)
MoveSpriteGroup:
    cmp #$03
    beq @Right
    cmp #$02
    beq @Left
    cmp #$01
    beq @Down
    dec $0200, x
@Loop:
    inc $0203, x
    dey
    pha
    txa
    clc
    adc #$04
    tax
    pla
    cpy #$00
    bne MoveSpriteGroup
    rts

@Right:
    inc $0203, x
    jmp @Loop

@Left:
    dec $0203, x
    jmp @Loop

@Down:
    inc $0200, x 
    jmp @Loop

AddPalette:
    lda PPUSTATUS
    lda #$3F
    sta PPUADDR
    lda PalettePointer
    sta PPUADDR
    ldy #$00
@Loop:
    lda (TempPointer), y
    sta PPUDATA
    inc PalettePointer
    iny
    cpy #$04
    bne @Loop
    lda PalettePointer
    sec
    sbc #$10
    clc
    lsr a
    clc
    lsr a
    sec
    sbc #$01
    rts

IsEntityDead:
    ldy #$01
    lda (TempPointer), y
    cmp #$FE
    rts

ChkCollison2x2:
    lda #$10
    sta TempValue
    sta TempValue+1

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

; dist x and y in temp value
ChkCollison:
    ldy #$03
    lda (TempPointer), y
    cmp $020F
    bcs @Not
    clc
    adc TempValue
    cmp $020F
    bcc @Not
    ldy #$00
    lda (TempPointer), y
    cmp $020C
    bcs @Not
    clc
    adc TempValue+1
    cmp $020C
    bcc @Not
    lda #$01
    rts
@Not:
    lda #$00
    rts