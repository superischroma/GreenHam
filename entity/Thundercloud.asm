; Thundercloud (0D) data and subroutines

ThundercloudPullDelay = $04

SpawnThundercloud:
    ldx #$03
    ldy #$31
    lda #$01
    sta TempValue+2
    jsr RenderRow
    rts

; pig sprite 4 x: $020F
; pig sprite 4 y: $020C

ThundercloudTick:
    ldx ThundercloudPullTimer
    cpx #ThundercloudPullDelay
    beq @DoneDelayCheck
    inc ThundercloudPullTimer
    jmp @Finish
@DoneDelayCheck:
    sta TempPointer
    lda #$02
    sta TempPointer+1
    lda #$00
    sta ThundercloudPullTimer
    ldy #$07
    lda (TempPointer), y
    cmp $020F
    bcc @MoveRight
    beq @Finish
    ldy #$03
    lda TempPointer
    tax
    lda #$02
    jsr MoveSpriteGroup
    jmp @Finish
@MoveRight:
    ldy #$03
    lda TempPointer
    tax
    lda #$03
    jsr MoveSpriteGroup
@Finish:
    lda TempIndex+1
    clc
    adc #$0C
    sta TempIndex+1
    rts