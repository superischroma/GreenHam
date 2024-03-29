; Green Ham - Subroutines for loading stages/features/details

LoadInformationBar:
    ldx #$00
@TileLoop:
    lda PPUSTATUS
    lda InformationBar, x
    sta PPUADDR
    inx
    lda InformationBar, x
    sta PPUADDR
    inx
    lda InformationBar, x
    sta PPUDATA
    inx
    cpx #12
    bne @TileLoop

    lda PPUSTATUS
    lda #$23
    sta PPUADDR
    lda #$C0
    sta PPUADDR
    ldx #$00
@AttrLoop:
    lda #%01010101
    sta PPUDATA
    inx
    cpx #$08
    bne @AttrLoop

    jsr LoadLives
    jsr LoadBeads
    jsr LoadNeedleStatus
    rts

LoadLives:
    ldx #$00
@LivesLoop:
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    txa
    clc
    adc #$4B
    sta PPUADDR
    lda PlayerLives, x
    sta PPUDATA
    inx
    cpx #$02
    bne @LivesLoop
    rts

LoadBeads:
    ldx #$00
@BeadsLoop:
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    txa
    clc
    adc #$55
    sta PPUADDR
    lda PlayerBeads, x
    sta PPUDATA
    inx
    cpx #$02
    bne @BeadsLoop
    rts

LoadNeedleStatus:
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$42
    sta PPUADDR
    lda GameStatus
    and #%00000100
    cmp #$00
    beq @Off
    lda #$68
    sta PPUDATA
    rts
@Off:
    lda #$24
    sta PPUDATA
    rts

LoadTitleScreen:
    lda #$00
    sta SelectedOption
    ldx #$00
@Loop:
    lda PPUSTATUS
    lda TitleScreen, x
    sta PPUADDR
    inx
    lda TitleScreen, x
    sta PPUADDR
    inx
    lda TitleScreen, x
    sta PPUDATA
    inx
    cpx #171
    bne @Loop
    rts

LoadPigSprite:
    ldx #$00
@Loop:
    lda PigSprite, x
    sta $0200, x
    inx 
    cpx #$20
    bne @Loop
    rts

ClearBackground:
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ldx #$00
    lda #$00
    sta OverflowCounter
@Loop:
    lda #$24
    sta PPUDATA
    cpx #$FF
    bne @AfterOverflowCheck
    inc OverflowCounter
@AfterOverflowCheck:
    inx
    cpx #$C0
    bne @Loop
    lda OverflowCounter
    cmp #$03
    bne @Loop
    lda #$00
    sta OverflowCounter
    rts

EnableScreen:
    lda #%00011110
    sta PPUMASK
    rts

DisableScreen:
    lda #%00000000
    sta PPUMASK
    rts

LoadLevelPalette:
    lda PPUSTATUS
    lda #$3F
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ldy #$00
@Loop1:
    lda (TempPointer), y
    sta PPUDATA
    iny
    cpy #$04
    bne @Loop1
    lda PPUSTATUS
    lda #$3F
    sta PPUADDR
    lda #$14
    sta PPUADDR
    ldy #$00
@Loop2:
    lda (TempPointer), y
    sta PPUDATA
    iny
    cpy #$04
    bne @Loop2
    rts

LoadRoom:
    lda #$30
    sta SpritePointer
    lda #$18
    sta PalettePointer
    ldy #$00
    sty EntityCount
    lda (PlayerRoom), y
    sta TempPointer
    iny
    lda (PlayerRoom), y
    sta TempPointer+1
    lda #$00
    sta TempValue
    ldy #$0A
@Loop:
    lda (PlayerRoom), y
    pha ; a - tile
    tya
    clc
    adc TempValue
    sec
    sbc #$0A
    tay
    lda (TempPointer), y
    tax ; x - board location
    tya
    clc
    adc #$0A
    sec
    sbc TempValue
    tay
    cpx #$00
    beq @ContLayerCheck
    jmp @SkipLayerCheck
@ContLayerCheck:
    pla
    inc TempValue
    lda TempValue
    cmp #$04
    bne @Loop
    ldy #45
@EnemyLoop:
    lda (PlayerRoom), y
    cmp #$FF
    beq @AfterEnemyLoop
    ldx EntityCount
    sta ActiveEntities, x
    inc EntityCount
    pha
    iny
    lda (PlayerRoom), y
    sta TempValue
    iny
    lda (PlayerRoom), y
    sta TempValue+1 
    iny
    pla
    asl a
    tax
    lda SpawnTable, x
    sta IndirectJmpPointer
    lda SpawnTable+1, x
    sta IndirectJmpPointer+1
    tya
    pha
    jsr CallPtrSubroutine
    pla
    tay
    jmp @EnemyLoop
@AfterEnemyLoop:
    ldy #44
    lda (PlayerRoom), y
    cmp #%00000000
    beq @AfterBeadLoop
    and BeadStates
    cmp #$00
    bne @AfterBeadLoop
    ldx #$20
    lda #$00
    sta TempValue
    lda #$16
    sta TempValue+1
@BeadLoop:
    ldy #43
    lda (PlayerRoom), y ; load y-pos
    cpx #$28
    bcc @SkipYMod
    clc 
    adc #$08
@SkipYMod:
    sta $0200, x
    inx
    lda TempValue+1
    sta $0200, x
    inc TempValue+1
    inx
    lda #%00000001
    sta $0200, x
    inx
    ldy #42
    lda (PlayerRoom), y
    ldy TempValue
    cpy #$08
    bne @SetXMod
    clc
    adc #$08
    ldy #$00
    sty TempValue
    jmp @SkipXMod
@SetXMod:
    ldy #$08
    sty TempValue
@SkipXMod:
    sta $0200, x
    inx
    cpx #$30
    bne @BeadLoop
@AfterBeadLoop:
    rts
@SkipLayerCheck:
    lda PPUSTATUS
    lda #$20
    clc
    adc TempValue
    sta PPUADDR
    stx PPUADDR
    pla
    sta PPUDATA
    iny
    jmp @Loop

CheckNeighbor:
    lda (PlayerRoom), y
    sta TempPointer
    iny
    lda (PlayerRoom), y
    sta TempPointer+1
    lda TempPointer
    cmp #$00
    bne @Continue
    rts
@Continue:
    sta PlayerRoom
    lda TempPointer+1
    sta PlayerRoom+1
    jsr DisableScreen
    lda PigSpawnPositions, x
    cpx #$02
    bcs @LR
    tay
    jsr SetPlayerY
    jmp @AfterLR
@LR:
    tax
    jsr SetPlayerX
@AfterLR:
    jsr UnloadEnemies
    jsr ClearBackground
    jsr LoadInformationBar
    jsr LoadRoom
    jsr EnableScreen
    rts

UnloadEnemies:
    ldx #$20
    lda #$FE
@Loop:
    sta $0200, x
    inx
    cpx #$00
    bne @Loop
    rts

RunTitleCard: ; start title card timer
    lda #$00
    sta TempValue
    lda #$01
    sta TitleCardTimer
    rts

TitleCardEvent: ; title card frame tick
    .if Debug = 1
    jmp @Exit
    .else
    lda TitleCardTimer
    cmp #$30
    beq @Next
    inc TitleCardTimer
    rts
@Next:
    lda #$01
    sta TitleCardTimer
    lda TempValue
    cmp #$04
    beq @Exit
    cmp #$01
    bcs @Wait
    ; load title card
    jsr DisableScreen
    lda PPUSTATUS
    ldy #$00
    lda (TempPointer), y
    sta PPUADDR
    iny
    lda (TempPointer), y
    sta PPUADDR
    iny
    lda (TempPointer), y
    tax
    iny
@MainCardLoop:
    lda (TempPointer), y
    sta PPUDATA
    dex
    iny
    cpx #$00
    bne @MainCardLoop
    lda #$24
    sta PPUDATA
    ldx #$00
@FieldCardLoop:
    lda TitleCardField, x
    sta PPUDATA
    inx
    cpx #$05
    bne @FieldCardLoop
    lda PPUSTATUS
    lda #$21
    sta PPUADDR
    lda #$CC
    sta PPUADDR
    ldx #$00
    jsr @GraphicLoop
    lda PPUSTATUS
    lda #$21
    sta PPUADDR
    lda #$EC
    sta PPUADDR
    ldx #$00
    jsr @GraphicLoop
    ldx #%00000101
    jsr @SetFieldAttrLine
    jsr EnableScreen
@Wait:
    inc TempValue
    rts
    .endif
@Exit:
    lda #$00
    sta TitleCardTimer
    jsr DisableScreen
    ldx #%00000000
    jsr @SetFieldAttrLine
    jsr ClearBackground
    jsr LoadInformationBar
    jsr LoadPigSprite
    ldx PlayerStage
    dex
    txa
    asl a
    tax
    lda InitialRoomTable, x
    sta PlayerRoom
    lda InitialRoomTable+1, x
    sta PlayerRoom+1
    jsr LoadRoom
    jsr EnableScreen
    rts

@GraphicLoop:
    lda (TempPointer), y
    sta PPUDATA
    inx
    iny
    cpx #$08
    bne @GraphicLoop
    rts

@SetFieldAttrLine:
    ldy #$00
    lda PPUSTATUS
    lda #$23
    sta PPUADDR
    lda #$D8
    sta PPUADDR
@SFALLoop:
    txa
    sta PPUDATA
    iny
    cpy #$08
    bne @SFALLoop
    rts

LoadFieldSelect:
    ldx #$00
    lda PPUSTATUS
    lda #$21
    sta PPUADDR
    lda #$AA
    sta PPUADDR
@TextLoop:
    lda FieldSelect, x
    sta PPUDATA
    inx
    cpx #12
    bne @TextLoop
    lda PPUSTATUS
    lda #$21
    sta PPUADDR
    lda #$ED
    sta PPUADDR
@SelectorLoop:
    lda FieldSelect, x
    sta PPUDATA
    inx
    cpx #17
    bne @SelectorLoop
    rts

LoadStage:
    stx TempValue
    jsr DisableScreen
    dex
    txa
    asl a ; multiply by 2
    tax
    lda BGKeyframeSetTable, x
    sta CurrentBGKeyframeSet
    lda BGKeyframeSetTable+1, x
    sta CurrentBGKeyframeSet+1
    lda TempValue
    jsr SetStageValue
    stx TempValue+1
    jsr ClearBackground
    ldx TempValue+1
    lda LevelPaletteTable, x
    sta TempPointer
    lda LevelPaletteTable+1, x
    sta TempPointer+1
    stx TempValue+1
    jsr LoadLevelPalette
    jsr EnableScreen
    ldx TempValue+1
    lda TitleCardTable, x
    sta TempPointer
    lda TitleCardTable+1, x
    sta TempPointer+1
    jsr RunTitleCard
    rts

DisplayValue:
    sta TempValue
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$83
    sta PPUADDR
    ldx #$00
@Loop:
    lda TempValue
    and #%10000000
    beq @Zero
    lda #$01
    sta PPUDATA
    jmp @Restore
@Zero:
    lda #$00
    sta PPUDATA
@Restore:
    inx
    asl TempValue
    cpx #$08
    bne @Loop
    rts

UnloadInformationBar:
    ldx #$00
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR
@Loop:
    lda #$24
    sta PPUDATA
    inx
    cpx #$80
    bne @Loop
    rts

LoadPauseScreen:
    jsr DisableScreen
    jsr UnloadInformationBar
    ldx #$00
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$4B
    sta PPUADDR
@Loop:
    lda PauseDisplay, x
    sta PPUDATA
    inx
    cpx #$0B
    bne @Loop
    jsr EnableScreen
    rts

EnableAudio:
    lda #$0F
    sta $4015
    rts

; index x - count
; index y - tile
; x-pos, y-pos, and attr in TempValue
RenderRow:
    lda TempValue+1
    pha
    lda TempValue
    pha
    lda TempValue+1
    pha
    sty TempValue+1
    lda #$00
    sta TempPointer
    lda #$02
    sta TempPointer+1
    ldy SpritePointer
@Loop:
    pla
    sta (TempPointer), y
    pha
    iny
    lda TempValue+1
    sta (TempPointer), y
    cmp #$FE
    beq @SkipInc ; skip increment if the tile is blank (0xFE)
    inc TempValue+1
@SkipInc:
    iny
    lda TempValue+2
    sta (TempPointer), y
    iny
    lda TempValue
    sta (TempPointer), y
    clc
    adc #$08
    sta TempValue
    iny
    dex
    bne @Loop
    sty SpritePointer
    pla
    pla
    sta TempValue
    pla
    sta TempValue+1
    rts

; index y - tile
; x-pos, y-pos, and attr in TempValue
RenderCircularRow:
    ldx #$02
    lda TempValue+1
    pha
    lda TempValue
    pha
    lda TempValue+1
    pha
    sty TempValue+1
    lda #$00
    sta TempPointer
    lda #$02
    sta TempPointer+1
    ldy SpritePointer
@Loop:
    pla
    sta (TempPointer), y
    pha
    iny
    lda TempValue+1
    sta (TempPointer), y
    iny
    lda TempValue+2
    cpx #$01
    bne @SkipFlip
    ora #%01000000
@SkipFlip:
    sta (TempPointer), y
    iny
    lda TempValue
    sta (TempPointer), y
    clc
    adc #$08
    sta TempValue
    iny
    dex
    bne @Loop
    sty SpritePointer
    lda TempValue+2
    eor #%01000000
    sta TempValue+2
    pla
    pla
    sta TempValue
    pla
    sta TempValue+1
    rts

UnloadSprite:
    ldx TempPointer
    lda #$FE
@Loop:
    sta $0200, x
    inx
    dey
    bne @Loop
    rts