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