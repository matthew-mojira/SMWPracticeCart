;========================
; SMW Practice Cart
; Version 3.1.0
; Created by Dotsarecool
;========================

; set to $000000 to compile for SlowROM
; set to $800000 to compile for FastROM
; must patch to a FastROM version of SMW
!_F = $800000

cleartable

ORG !_F+$00B888
  REP #$10
  LDY.W #$8000
  STY $8A
  LDA.B #$1C

; internal rom name
ORG !_F+$00FFC0
        db "SMW PRACTICE CART    "
; uses S-RTC chip
ORG !_F+$00FFD6
        db $55
; give the cartridge more SRAM
ORG !_F+$00FFD8
        db $05

; nintendo presents sound
ORG !_F+$0093C1
        db $15

; include everything because I want to be organized this time

incsrc "src/defines.asm"            ; internal
incsrc "src/hijacks.asm"            ; internal
incsrc "src/hex_edits.asm"          ; internal
incsrc "src/relocations.asm"        ; internal
incsrc "src/statusbar.asm"          ; internal
incsrc "src/level_mario_appear.asm" ; $108000
incsrc "src/overworld_load.asm"     ; $118000
incsrc "src/level_load.asm"         ; $128000
incsrc "src/level_finish.asm"       ; $138000
incsrc "src/overworld_tick.asm"     ; $148000
incsrc "src/level_tick.asm"         ; $158000
incsrc "src/nmi.asm"                ; $168000
incsrc "src/every_frame.asm"        ; $178000
incsrc "src/overworld_menu.asm"     ; $188000 - $198000
incsrc "src/l_r_reset.asm"          ; $1A8000
incsrc "src/movies.asm"             ; $1B8000 - $1C8000

; incbin "bin/spc_engine.bin"       ; $1F8000 (see relocations.asm)

ORG !_F+$1C8000
incbin "src/bin/GFX32_33_compressed.bin"

; Luigi palette
ORG !_F+$00B2C8
  db $3F, $4F, $1D, $58, $40, $11, $E0, $3F, $07, $3C, $AE, $7C, $B3, $7D, $00, $2F
  db $5F, $16, $FF, $03
ORG !_F+$00B2F0
  db $1F, $3B, $1D, $58, $29, $25, $FF, $7F, $40, $11, $E0, $01, $E0, $02, $7B, $57
  db $DF, $0D, $FF, $03
ORG !_F+$00B598
  db $FF, $7F, $00, $00, $80, $02, $E0, $03, $08, $6D, $1A, $26, $3B, $57

; LUIGI START
ORG !_F+$0091DB
  db $D0


; fix S in Start
ORG !_F+$00913F
  db $34
ORG !_F+$009170
  db $F4

; make sure the ROM is expanded to the full 1MBit
ORG !_F+$1FFFFF
        db $EA