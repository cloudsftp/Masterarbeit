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
badd +40 2D_Regions_2.725/Manual/plot.plt
badd +53 2D_Regions_2.725/Manual/Data/0/config.ant
badd +14 2D_Regions_2.725/Manual/result_fm
badd +30 2D_Period_2.7/config.json
badd +9 Cob_2.69_B/config.json
badd +7 2D_Period_2.69/config.json
badd +49 model.cpp
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
badd +30 2D_Regions_2.675/Manual/plot.plt
badd +13 2D_Regions_2.675/Manual/result_fm
badd +5 ~/Projects/Uni/Masterarbeit/Simulation/Models/60_MinimalRepr/2D_Period_Whole_Lotta_Points/extras.plt
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
badd +28 2D_Regions_2.8_add_hor/config.json
badd +57 2D_Regions_2.8_add_hor/Manual/Data/0/config.ant
badd +48 2D_Regions_2.8_add_hor/Manual/Data/1/config.ant
badd +57 2D_Regions_2.8_add_hor/Manual/Data/2/config.ant
badd +57 2D_Regions_2.8_add_hor/Manual/Data/3/config.ant
badd +59 2D_Regions_2.8_add_hor/Manual/plot.plt
badd +15 2D_Regions_2.8_add_hor/Manual/result_fm
argglobal
%argdel
edit 2D_Regions_2.8_add_hor/Manual/plot.plt
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
let s:l = 1 - ((0 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding
wincmd w
argglobal
if bufexists(fnamemodify("~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/2D_Regions_2.725/Manual/plot.plt", ":p")) | buffer ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/2D_Regions_2.725/Manual/plot.plt | else | edit ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/2D_Regions_2.725/Manual/plot.plt | endif
if &buftype ==# 'terminal'
  silent file ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding/2D_Regions_2.725/Manual/plot.plt
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
let s:l = 27 - ((13 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 27
normal! 0
lcd ~/Projects/Uni/Masterarbeit/Simulation/Models/62_MinimalRepr_Adding
wincmd w
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
