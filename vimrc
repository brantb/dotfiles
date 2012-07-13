call pathogen#infect()
call pathogen#helptags()

if has("mouse")
	set mouse=a
	set mousehide
endif
if has("gui_running")
	set lines=50 columns=100
	if has("gui_win32")
		" gvim/win32 fails to do this automatically
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
	cd $USERPROFILE " Default cwd is System32, which is stupid
endif

" Search options
set hlsearch    " Highlight search results
set smartcase   " Search strings that are all-lowercase will do a case-insensitive search
set incsearch   " Incremental search
nnoremap <silent> <CR> :noh<CR><CR>  " Clear search highlight by hitting enter

set number      " Show line numbers
set foldcolumn=2
set foldmethod=syntax
set foldlevelstart=2
set shiftwidth=4
set tabstop=4
set hlsearch    " Highlight search results
set smartcase   " Search strings that are all-lowercase will do a case-insensitive search
set incsearch   " Incremental search
set cursorline  " Highlight current line 
set autoread	" Reload files that have changed
set guioptions-=T " Hide toolbar

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
map <F4> :NERDTreeMirrorToggle<CR>
let NERDTreeChDirMode=2 " pwd follows NERDtree
let NERDTreeHijackNetrw=0 " So vcscommand can commit directories
let NERDTreeIgnore=['^CVS$', '^\.svn$', '\~$']
let g:nerdtree_tabs_open_on_gui_startup=0

" Set up taglist keybinds
map <F5> :TlistToggle<CR>
let Tlist_Use_Right_Window=1

if has("gui_macvim") && has("gui_running")
	" Map command-[ and command-] to indenting or outdenting
	" while keeping the original selection in visual mode
	vmap <D-]> >gv
	vmap <D-[> <gv

	nmap <D-]> >>
	nmap <D-[> <<

	omap <D-]> >>
	omap <D-[> <<

	imap <D-]> <Esc>>>i
	imap <D-[> <Esc><<i

	" Bubble single lines
	nmap <D-Up> [e==
	nmap <D-Down> ]e==
	nmap <D-k> [e==
	nmap <D-j> ]e==
	imap <D-k> <Esc>[e==gi
	imap <D-j> <Esc>]e==gi

	" Bubble multiple lines
	vmap <D-Up> [e==gv
	vmap <D-Down> ]e==gv
	vmap <D-k> [e==gv
	vmap <D-j> ]e==gv

	" Map Command-# to switch tabs
	map  <D-0> 0gt
	imap <D-0> <Esc>0gt
	map  <D-1> 1gt
	imap <D-1> <Esc>1gt
	map  <D-2> 2gt
	imap <D-2> <Esc>2gt
	map  <D-3> 3gt
	imap <D-3> <Esc>3gt
	map  <D-4> 4gt
	imap <D-4> <Esc>4gt
	map  <D-5> 5gt
	imap <D-5> <Esc>5gt
	map  <D-6> 6gt
	imap <D-6> <Esc>6gt
	map  <D-7> 7gt
	imap <D-7> <Esc>7gt
	map  <D-8> 8gt
	imap <D-8> <Esc>8gt
	map  <D-9> 9gt
	imap <D-9> <Esc>9gt
else
	" Map command-[ and command-] to indenting or outdenting
	" while keeping the original selection in visual mode
	vmap <A-]> >gv
	vmap <A-[> <gv

	nmap <A-]> >>
	nmap <A-[> <<

	omap <A-]> >>
	omap <A-[> <<

	imap <A-]> <Esc>>>i
	imap <A-[> <Esc><<i

	" Bubble single lines
	nmap <A-Up> [e==
	nmap <A-Down> ]e==
	nmap <A-k> [e==
	nmap <A-j> ]e==
	imap <A-k> <Esc>[e==gi
	imap <A-j> <Esc>]e==gi

	" Bubble multiple lines
	vmap <A-Up> [e==gv
	vmap <A-Down> ]e==gv
	vmap <A-k> [e==gv
	vmap <A-j> ]e==gv

	" Map Control-# to switch tabs
	map  <C-0> 0gt
	imap <C-0> <Esc>0gt
	map  <C-1> 1gt
	imap <C-1> <Esc>1gt
	map  <C-2> 2gt
	imap <C-2> <Esc>2gt
	map  <C-3> 3gt
	imap <C-3> <Esc>3gt
	map  <C-4> 4gt
	imap <C-4> <Esc>4gt
	map  <C-5> 5gt
	imap <C-5> <Esc>5gt
	map  <C-6> 6gt
	imap <C-6> <Esc>6gt
	map  <C-7> 7gt
	imap <C-7> <Esc>7gt
	map  <C-8> 8gt
	imap <C-8> <Esc>8gt
	map  <C-9> 9gt
	imap <C-9> <Esc>9gt
endif


" jj/kk exits insert mode
inoremap jj <Esc> 
inoremap kk <Esc>

" for typos
map :E :e

" <F9> toggles fold under cursor
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
" <F10> decreases fold level by one
inoremap <F10> <C-O>zm
nnoremap <F10> zm
onoremap <F10> <C-C>zm
vnoremap <F10> zm

" If there is a fold under the cursor, spacebar toggles it as well
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" Indent guides plugin config
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0

" Override the indent guide plugin's color choices based on whether we're
" using a light or dark background. 
function! RecolorIndentGuides()
	if &background == "dark"
		" base02
		:hi IndentGuidesEven guibg=#073642 ctermbg=0
		:hi IndentGuidesOdd  guibg=NONE ctermbg=0
	else
		" base2
		:hi IndentGuidesEven guibg=#eee8d5 ctermbg=7
		:hi IndentGuidesOdd  guibg=#eee8d5 ctermbg=7
	endif
endfunction
autocmd VimEnter,Colorscheme * :call RecolorIndentGuides()

" ctrlp plugin config
let g:ctrlp_custom_ignore = {
			\ 'dir': 'node_modules\|\.git$\|\.hg$\|\.svn$\|^CVS$'
			\ }

