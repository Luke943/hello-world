; Print 'Hello, World!'
; Based on Intel 4004 architecture
; For console emulator - https://github.com/CodeAbbey/intel4004-emu/wiki
; Also command reference at bottom

jun start                       ; jump to 'start'

string:
    db 'Hello, World!' 13 10 0  ; string, carriage return, linefeed, null

start:
    fim r0 string               ; r0:r1 points to 'string' in code

next_char:
    fin r2                     ; read char pointed to into r2:r3
    ld r3                       ; jump to 'finish' when null loaded (start)
    jcn an not_end  
    ld r2
    jcn az finish               ; (end)

no_end:                         ; routine performed for non-null characters
    jms $3e0                    ; print char in r2:r3 to console
    ld r1                       ; move pointer to next char in 'string' (start)
    iac
    xch r1
    tcc
    add r0
    xch r0                      ; (end)
    jun next_char               ; go back to 'next_char' routine

finish:
    nop                         ; no operation, all done :)


; Key:

; acc - accumulator
; r0 to r15 - registers
; cy - carry flag

; ldm 5 - load to acc value 5
; xch r2 - exchange values of acc and r2
; ld r3 - load acc with copy of value in r3
; clc - clear cy
; stc - set cy to 1
; clb - clear cy and acc
; fim r4 $57 - loads 0x57 into r4:r5

; cmc - complement cy
; cma - complememnt acc
; add r2 - adds value of r2 to acc
; sub r3 - subtracts value of r2 from acc
; iac - incremement acc
; dac - decrement acc
; inc r12 - increment r12
; ral - rotate acc left
; rar - rotate acc right
; tcc - transfer cy to acc, clear cy

; jun - jump unconditionally
; jcn c0 - jump if cy==0
; jcn c1 - jump if cy==1
; jcn az - jump if acc==0
; jcn an - jump if acc!=0
; jms - add subroutine to stack
; bbl - branch, back, load (pops address from stack and jumps)

; src r2 - set data pointer to value of r2:r3
; wrm - write from acc to memory
; rdm - read from memory to acc
; adm - add memory to acc
; sbm - subtract memory from acc

; fin - load byte specified by r0:r1 from code memory
; db - store bytes in code (not compiled instructions)

; daa - decimal adjustment to acc (-10 and set cy)
; tcs - transfer, carry, subtract (load acc with 10 if cy set, clear cy)

; jms $3fe - print all memory
; jms $3fd - print first 64 cells of memory
; jms $3ff - print all registers, acc, cy
; jms $3e0 - print char from r2:r3 to console
; jms $3f0 - read char from console to r2:r3
