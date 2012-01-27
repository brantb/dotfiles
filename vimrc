call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("mouse")
	set mouse=a
	set mousehide
endif
if has("gui_running") " gvim/win32 fails to do this automatically
	set lines=50 columns=100
	if has("gui_win32")
		source $VIMRUNTIME/mswin.vim
		set guifont=Consolas:h10:cANSI
		set background=dark
	else
		set guifont=Inconsolata:h14
		set background=light
	endif
else
	set background=dark
endif

if has("win32")
	cd $HOME " Default cwd is System32, which is stupid
endif

set shiftwidth=4
set tabstop=4
syntax enable
filetype plugin indent on
colorscheme solarized

set laststatus=2
set statusline=[%l,%v\ %P%M]\ %f\ %y%r%w[%{&ff}]%{fugitive#statusline()}\ %b\ 0x%B
"set t_Co=256
"call togglebg#map("<F5>")

" Save Taskpaper files automatically and use light background
autocmd BufLeave,FocusLost *.taskpaper w
autocmd Filetype taskpaper set background=light

" Run wrapwithtag.vim script when opening html docs (shouldn't this be a
" filetype plugin? meh.)
autocmd Filetype html,xml,aspvbs runtime scripts/wrapwithtag.vim

" Use aspvbs filetype for .asa and .asp files so we get syntax highlighting
let g:filetype_asa = "aspvbs"
let g:filetype_asp = "aspvbs"

" Use Groovy syntax highlighting for gradle buildfiles
au BufNewFile,BufRead *.gradle setf groovy

" Set up NERDTree keybinds and options
map <F3> :NERDTreeFind<CR>
map <F4> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2 " pwd follows NERDtree
let NERDTreeHijackNetrw=0 " So vcscommand can commit directories
let NERDTreeIgnore=['^CVS$', '^\.svn$', '\~$']

" Set up taglist keybinds
map <F5> :TlistToggle<CR>
let Tlist_Use_Right_Window=1

command! -range=% Entities :<line1>,<line2>call Entities()
function! Entities()
  silent s/À/\&Agrave;/eg
  silent s/Á/\&Aacute;/eg
  silent s/Â/\&Acirc;/eg
  silent s/Ã/\&Atilde;/eg
  silent s/Ä/\&Auml;/eg
  silent s/Å/\&Aring;/eg
  silent s/Æ/\&AElig;/eg
  silent s/Ç/\&Ccedil;/eg
  silent s/È/\&Egrave;/eg
  silent s/É/\&Eacute;/eg
  silent s/Ê/\&Ecirc;/eg
  silent s/Ë/\&Euml;/eg
  silent s/Ì/\&Igrave;/eg
  silent s/Í/\&Iacute;/eg
  silent s/Î/\&Icirc;/eg
  silent s/Ï/\&Iuml;/eg
  silent s/Ð/\&ETH;/eg
  silent s/Ñ/\&Ntilde;/eg
  silent s/Ò/\&Ograve;/eg
  silent s/Ó/\&Oacute;/eg
  silent s/Ô/\&Ocirc;/eg
  silent s/Õ/\&Otilde;/eg
  silent s/Ö/\&Ouml;/eg
  silent s/Ø/\&Oslash;/eg
  silent s/Ù/\&Ugrave;/eg
  silent s/Ú/\&Uacute;/eg
  silent s/Û/\&Ucirc;/eg
  silent s/Ü/\&Uuml;/eg
  silent s/Ý/\&Yacute;/eg
  silent s/Þ/\&THORN;/eg
  silent s/ß/\&szlig;/eg
  silent s/à/\&agrave;/eg
  silent s/á/\&aacute;/eg
  silent s/â/\&acirc;/eg
  silent s/ã/\&atilde;/eg
  silent s/ä/\&auml;/eg
  silent s/å/\&aring;/eg
  silent s/æ/\&aelig;/eg
  silent s/ç/\&ccedil;/eg
  silent s/è/\&egrave;/eg
  silent s/é/\&eacute;/eg
  silent s/ê/\&ecirc;/eg
  silent s/ë/\&euml;/eg
  silent s/ì/\&igrave;/eg
  silent s/í/\&iacute;/eg
  silent s/î/\&icirc;/eg
  silent s/ï/\&iuml;/eg
  silent s/ð/\&eth;/eg
  silent s/ñ/\&ntilde;/eg
  silent s/ò/\&ograve;/eg
  silent s/ó/\&oacute;/eg
  silent s/ô/\&ocirc;/eg
  silent s/õ/\&otilde;/eg
  silent s/ö/\&ouml;/eg
  silent s/ø/\&oslash;/eg
  silent s/ù/\&ugrave;/eg
  silent s/ú/\&uacute;/eg
  silent s/û/\&ucirc;/eg
  silent s/ü/\&uuml;/eg
  silent s/ý/\&yacute;/eg
  silent s/þ/\&thorn;/eg
  silent s/ÿ/\&yuml;/eg
  silent s/’/\&#x92;/eg
endfunction

" for typos
map :W :w
map :E :e

