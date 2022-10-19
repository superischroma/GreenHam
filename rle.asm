;;;;;;;;;;;;;;;;;;;;;;;;; WORKING ON BETTER DRAWING

; y - length, TempPointer - sequence, a - hi byte, TempValue - lo byte
AddSequenceRLEBuffer:
    ldx BufferPointer
    sta $0300, x
    inx
    lda TempValue
    sta $0300, x
    inx
    tya
    sta $0300, x
    inx
@Loop:
    rts