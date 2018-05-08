set nocp
set nu
set nocompatible
set backspace=indent,eol,start
set backspace=2

" Tab related
set ts=2
set sw=2
set smarttab
set et
set ambiwidth=double


" Format related
set tw=78
set lbr
set fo+=mB


" Indent related
set cin
set ai
set cino=:0g0t0(susj1


" Editing related
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
"set mouse=a
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive


" Misc
set wildmenu
set spell


" Encoding related
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


" File type related
filetype plugin indent on


" Display related
set ru
set sm
set hls
if (has("gui_running"))
    set guioptions+=b
    colo torte
    set nowrap
else
    colo ron
    set wrap
endif
syntax on

"search
set incsearch
set ic
set hls

"=============================================================================
" Platform dependent settings
"=============================================================================


if (has("win32"))


    "-------------------------------------------------------------------------
    " Win32
    "-------------------------------------------------------------------------


    if (has("gui_running"))
        set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
        set guifontwide=NSimSun:h9:cGB2312
    endif


else


    if (has("gui_running"))
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
    endif


endif
