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
    cpx #45
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
    jsr LoadStage
    rts

LoadLives:
    ldx #$00
@LivesLoop:
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    txa
    clc
    adc #$64
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
    adc #$6E
    sta PPUADDR
    lda PlayerBeads, x
    sta PPUDATA
    inx
    cpx #$02
    bne @BeadsLoop
    rts

LoadStage:
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$7A
    sta PPUADDR
    lda PlayerStage
    sta PPUDATA
    rts

LoadVersion:
    ldx #$00
    lda PPUSTATUS
    lda #$20
    sta PPUADDR
    lda #$41
    sta PPUADDR
@Loop:
    lda Version, x
    sta PPUDATA
    inx
    cpx #$05
    bne @Loop
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

    jsr LoadVersion
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

LoadSpacePalette:
    lda PPUSTATUS
    lda #$3F
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ldx #$00
@Loop:
    lda SpacePalette, x
    sta PPUDATA
    inx
    cpx #$04
    bne @Loop
    rts

LoadRoom:
    ldy #$00
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
    bne @SkipLayerCheck
    pla
    inc TempValue
    lda TempValue
    cmp #$04
    bne @Loop
    ldy #45
    ldx #$00
@EnemyLoop:
    lda (PlayerRoom), y
    cmp #$FF
    beq @AfterEnemyLoop
    sta $0230, x
    inx
    iny
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
    lda #%00000000
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
    cmp #$02
    bcs @LR
    tay
    jsr SetPlayerY
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

UnloadBead:
    ldx #$20
    lda #$FE
@Loop:
    sta $0200, x
    inx
    cpx #$30
    bne @Loop
    rts

;UnloadInformationBar:
;    ldx #$00
;    lda PPUSTATUS
;    lda #$20
;    sta PPUADDR
;    lda #$00
;    sta PPUADDR
;@Loop:
;    lda #$24
;    sta PPUDATA
;    inx
;    cpx #$80
;    bne @Loop
;    rts

;LoadPauseScreen:
;    jsr DisableScreen
;    jsr UnloadInformationBar
;    ldx #$00
;    lda PPUSTATUS
;    lda #$20
;    sta PPUADDR
;    lda #$50
;    sta PPUADDR
;@Loop:
;    lda PauseDisplay, x
;    sta PPUDATA
;    inx
;    cpx #$0B
;    bne @Loop
;    jsr EnableScreen
;    rts