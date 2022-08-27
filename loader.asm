; Green Ham - Subroutines for loading stages/features/details

LoadInformationBar:
    ldx #$00
@Loop:
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
    bne @Loop

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

ClearBackground:
    lda PPUSTATUS
    ldy #$00
    lda #$20
ClearSecondBackground:
    cpy #$01
    bne SkipSecondBackground
    lda #$24
SkipSecondBackground:
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
    lda OverflowCounter
    clc
    adc #$01
    sta OverflowCounter
@AfterOverflowCheck:
    inx
    cpx #$C0
    bne @Loop
    lda OverflowCounter
    cmp #$03
    bne @Loop
    iny
    cpy #$02
    bne ClearSecondBackground
    rts