let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 2D_Regions_2.725/Manual/Data/0
badd +28 2D_Regions_2.725/Manual/plot.plt
badd +53 2D_Regions_2.725/Manual/Data/0/config.ant
badd +14 2D_Regions_2.725/Manual/result_fm
badd +30 2D_Period_2.7/config.json
badd +9 Cob_2.69_B/config.json
badd +7 2D_Period_2.69/config.json
badd +48 model.cpp
badd +31 2D_Period_2.675/config.json
badd +67 Cob_2.675_B/Manual/plot.plt
badd +10 Cob_2.675_B/Manual/configB1.ant
badd +1 Cob_2.675_B/config.json
badd +35 Cob_2.675_B/Manual/configB2.ant
badd +16 Cob_2.675_B/Manual/periodic_symbolic_sequenceB1.tna
badd +41 Cob_2.675_B/Manual/basins/config.ant
badd +5 Cob_2.675_B/Manual/basins/1.tna
badd +25 Cob_2.675_B/Manual/result_fm
badd +8 2D_Regions_2.675/config.json
badd +57 2D_Regions_2.675/Manual/Data/0/config.ant
badd +10 2D_Regions_2.675/Manual/Data/1/config.ant
badd +10 2D_Regions_2.675/Manual/Data/2/config.ant
badd +10 2D_Regions_2.675/Manual/Data/3/config.ant
badd +43 2D_Regions_2.675/Manual/plot.plt
badd +18 2D_Regions_2.675/Manual/result_fm
badd +1 ~/Projects/Uni/Masterarbeit/Simulation/Models/60_MinimalRepr/2D_Period_Whole_Lotta_Points/extras.plt
badd +10 Cob_2.675_A/config.json
badd +1 Cob_2.675_A/Manual/configB1.ant
badd +37 Cob_2.675_A/Manual/configA1.ant
badd +15 Cob_2.675_A/Manual/configA2.ant
badd +34 Cob_2.675_A/Manual/basins/config.ant
badd +68 Cob_2.675_A/Manual/plot.plt
badd +67 ~/Projects/Uni/Masterarbeit/Simulation/Models/60_MinimalRepr/Cobweb_M/Manual/plot.plt
badd +24 ~/Projects/Uni/Masterarbeit/Simulation/Models/60_MinimalRepr/Cobweb_M/Manual/result_fm
badd +9611 Cob_2.675_A/Manual/basins/1.tna
badd +1 Cob_2.675_A/Manual/basins/period.tna
badd +26 Cob_2.675_A/Manual/result_fm
badd +3 Cob_2.675_A/result_fm
badd +31 2D_Regions_2.8_add/config.json
badd +56 2D_Regions_2.8_add/Manual/Data/0/config.ant
badd +17 2D_Regions_2.8_add/Manual/plot.plt
badd +7 2D_Regions_2.8_add/Manual/result_fm
badd +57 2D_Regions_2.8_add/Manual/Data/1/config.ant
badd +57 2D_Regions_2.8_add/Manual/Data/2/config.ant
badd +56 2D_Regions_2.8_add/Manual/Data/3/config.ant
badd +1 2D_Regions_2.8_add_hor/config.json
badd +57 2D_Regions_2.8_add_hor/Manual/Data/0/config.ant
badd +48 2D_Regions_2.8_add_hor/Manual/Data/1/config.ant
badd +57 2D_Regions_2.8_add_hor/Manual/Data/2/config.ant
badd +57 2D_Regions_2.8_add_hor/Manual/Data/3/config.ant
badd +2 2D_Regions_2.8_add_hor/Manual/plot.plt
badd +17 2D_Regions_2.8_add_hor/Manual/result_fm
badd +8 Cob_2.8_add_hor_A/config.json
badd +1 2D_Regions_2.8_add_hor/extras.plt
badd +6 Cob_2.8_add_hor_A/Manual/configB1.ant
badd +6 Cob_2.8_add_hor_A/Manual/configB2.ant
badd +27 Cob_2.8_add_hor_A/Manual/basins/config.ant
badd +67 Cob_2.8_add_hor_A/Manual/plot.plt
badd +40 1D_Bif_2.8_add_hor_AU/config.json
badd +23 1D_Bif_2.8_add_hor_AU/Autogen/plot.plt
badd +1 Cob_2.8_add_hor_A
badd +11 1D_Bif_2.8_add_hor_AU/Manual/Data/0/config.ant
badd +882 1D_Bif_2.8_add_hor_AU/Manual/Data/0/period.tna
badd +200 1D_Bif_2.8_add_hor_AU/Manual/work.plt
badd +51 1D_Bif_2.8_add_hor_AU/Manual/Data/2/config.ant
badd +882 1D_Bif_2.8_add_hor_AU/Manual/Data/2/period.tna
badd +37 1D_Bif_2.8_add_hor_AU/Manual/Data/1/config.ant
badd +32 1D_Bif_2.8_add_hor_AU/Manual/result_fm
badd +1 2D_Period_2.8_add_hor/config.json
badd +8 2D_Regions_2.65_add_hor/config.json
badd +1 1D_Bif_2.8_add_hor_AU/result_fm
badd +30 2D_Regions_2.65_add_vert/config.json
badd +6 2D_Regions_2.65_add_vert/Manual/Data/0/config.ant
badd +28 2D_Regions_2.65_add_vert/Manual/plot.plt
badd +57 2D_Regions_2.65_add_vert/Manual/Data/1/config.ant
badd +49 2D_Regions_2.65_add_vert/Manual/Data/2/config.ant
badd +48 2D_Regions_2.65_add_vert/Manual/Data/3/config.ant
badd +14 2D_Regions_2.65_add_vert/Manual/result_fm
badd +1 ~/Projects/Uni/Masterarbeit/Simulation/Models/60_MinimalRepr/2D_Period_Whole_Lotta_Points/result_fm
badd +10 Cob_2.65_add_vert_B/config.json
badd +6 Cob_2.65_add_vert_B/Manual/configB1.ant
badd +31 Cob_2.65_add_vert_B/Manual/configB2.ant
badd +30 Cob_2.65_add_vert_B/Manual/basins/config.ant
badd +278 Cob_2.65_add_vert_B/Manual/plot.plt
badd +25 Cob_2.65_add_vert_B/Manual/result_fm
badd +11 Cob_2.65_add_vert_B/Manual/run.sh
badd +51 2D_Regions_2.8_add_vert/Manual/plot.plt
badd +16 2D_Regions_2.8_add_vert/Manual/result_fm
badd +10 Cob_2.8_add_vert_A/config.json
badd +23 Cob_2.8_add_vert_A/Manual/configA1.ant
badd +35 Cob_2.8_add_vert_A/Manual/configA2.ant
badd +25 Cob_2.8_add_vert_A/Manual/basins/config.ant
badd +11 Cob_2.8_add_vert_A/Manual/run.sh
badd +68 Cob_2.8_add_vert_A/Manual/plot.plt
badd +24 Cob_2.8_add_vert_A/Manual/result_fm
badd +75019 Cob_2.65_add_vert_B/Manual/basins/1.tna
badd +1 2D_Regions_2.65_add_vert/extras.plt
badd +1 2D_Regions_2.65/Manual/plot.plt
badd +1 2D_Regions_2.675/Manual/Makefile
badd +1 2D_Regions_2.8/Manual/plot.plt
badd +1 2D_Regions_2.65_add_vert/Manual/result.eps
badd +40 1D_Bif_2.65_add_vert_BR/config.json
badd +39 1D_Bif_2.65_add_vert_BR/Manual/work.plt
badd +46 1D_Bif_2.65_add_vert_BR/Manual/Data/0/config.ant
badd +171 1D_Bif_2.65_add_vert_BR/Manual/Data/0/bif_cyclic.tna
badd +795 1D_Bif_2.65_add_vert_BR/Manual/Data/0/period.tna
badd +114 ~/Projects/Uni/Masterarbeit/Simulation/Models/60_MinimalRepr/1D_Bif_LFR16/Manual/work.plt
badd +48 1D_Bif_2.65_add_vert_BR/Manual/Data/1/config.ant
badd +48 1D_Bif_2.65_add_vert_BR/Manual/Data/2/config.ant
badd +818 1D_Bif_2.65_add_vert_BR/Manual/Data/2/period.tna
badd +1 1D_Bif_2.65_add_vert_BR/Manual/Data/2/bif_cyclic.tna
badd +3 1D_Bif_2.65_add_vert_BR/Manual/Data/2/periodic_symbolic_sequence.tna
badd +1 1D_Bif_2.65_add_vert_BR/Manual/Data/2/1.tna
badd +67 ~/Projects/Uni/Masterarbeit/symbolic-regions/src/symbolic.rs
badd +20 ~/Projects/Uni/Masterarbeit/symbolic-regions/src/main.rs
badd +15 ~/Projects/Uni/Masterarbeit/symbolic-regions/src/lib.rs
badd +2 1D_Bif_2.65_add_vert_BR/Manual/Data/2/symbolic_regions.tna
badd +37 1D_Bif_2.65_add_vert_BR/Manual/Data/1/bif_cyclic.tna
badd +31 1D_Bif_2.65_add_vert_BR/Manual/result_fm
badd +0 1D_Bif_2.65_add_vert_BR/Manual/Data/3/config.ant
argglobal
%argdel
edit 1D_Bif_2.65_add_vert_BR/Manual/work.plt
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 136 + 136) / 273)
exe 'vert 2resize ' . ((&columns * 136 + 136) / 273)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 243 - ((59 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 243
normal! 05|
lcd ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding
wincmd w
argglobal
if bufexists(fnamemodify("~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/1D_Bif_2.65_add_vert_BR/Manual/Data/3/config.ant", ":p")) | buffer ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/1D_Bif_2.65_add_vert_BR/Manual/Data/3/config.ant | else | edit ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/1D_Bif_2.65_add_vert_BR/Manual/Data/3/config.ant | endif
if &buftype ==# 'terminal'
  silent file ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/1D_Bif_2.65_add_vert_BR/Manual/Data/3/config.ant
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 57 - ((55 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 57
normal! 0
lcd ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 136 + 136) / 273)
exe 'vert 2resize ' . ((&columns * 136 + 136) / 273)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
