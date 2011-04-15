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
syntax enable
set t_Co=256
colorscheme solarized
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
call togglebg#map("<F5>")

