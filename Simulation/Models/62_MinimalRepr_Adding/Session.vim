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
badd +46 2D_Regions_2.725/Manual/plot.plt
badd +53 2D_Regions_2.725/Manual/Data/0/config.ant
badd +19 2D_Regions_2.725/Manual/result_fm
badd +30 2D_Period_2.7/config.json
badd +9 Cob_2.69_B/config.json
badd +7 2D_Period_2.69/config.json
badd +49 model.cpp
badd +26 2D_Period_2.675/config.json
badd +162 Cob_2.675_B/Manual/plot.plt
badd +10 Cob_2.675_B/Manual/configB1.ant
badd +10 Cob_2.675_B/config.json
badd +35 Cob_2.675_B/Manual/configB2.ant
badd +16 Cob_2.675_B/Manual/periodic_symbolic_sequenceB1.tna
badd +47 Cob_2.675_B/Manual/basins/config.ant
badd +5 Cob_2.675_B/Manual/basins/1.tna
badd +25 Cob_2.675_B/Manual/result_fm
argglobal
%argdel
edit 2D_Regions_2.725/Manual/result_fm
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
let s:l = 17 - ((16 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 17
normal! 012|
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
let s:l = 69 - ((53 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 69
normal! 018|
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
