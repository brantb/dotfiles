call pathogen#infect()
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

" Search options
set hlsearch    " Highlight search results
set smartcase   " Search strings that are all-lowercase will do a case-insensitive search
set incsearch   " Incremental search
nnoremap <silent> <CR> :noh<CR><CR>  " Clear search highlight by hitting enter

set number      " Show line numbers
set foldcolumn=1
set foldmethod=syntax
set shiftwidth=4
set tabstop=4
set hlsearch    " Highlight search results
set smartcase   " Search strings that are all-lowercase will do a case-insensitive search
set incsearch   " Incremental search
set cursorline  " Highlight current line 

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

" Alt-J/K moves lines around
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

" for typos
map :E :e

" <F9> toggles fold under cursor
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" If there is a fold under the cursor, spacebar toggles it as well
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

