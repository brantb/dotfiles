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
		set guifont=Consolas:h10
	elseif has("mac")
		set guifont=Inconsolata:h14
	else
		set guifont=Inconsolata\ Medium\ 12
	endif
endif

set background=dark
set guioptions-=T " Hide toolbar

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

" Source the vimrc file after saving it
autocmd BufWritePost .vimrc source $MYVIMRC

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
endif

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

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

