call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("mouse")
	set mouse=a
	set mousehide
endif
if has("gui_win32")
	source $VIMRUNTIME/mswin.vim
	set guifont=Consolas:h10:cANSI
else
	set guifont=Inconsolata:h14
endif
if has("gui_running") " gvim/win32 fails to do this automatically
	set background=light
else
	set background=dark
endif

set shiftwidth=4
set tabstop=4
syntax enable
filetype plugin indent on
colorscheme solarized

set laststatus=2
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
"set t_Co=256
"call togglebg#map("<F5>")

" Save Taskpaper files automatically
autocmd BufLeave,FocusLost *.taskpaper w
" Run wrapwithtag.vim script when opening html docs (shouldn't this be a
" filetype plugin? meh.
autocmd Filetype html,xml,asp runtime scripts/wrapwithtag.vim

if exists("+autochdir")
	set autochdir " Change to file's current directory automatically
endif

" so full of hate
let g:filetype_asa = "aspvbs"
let g:filetype_asp = "aspvbs"

