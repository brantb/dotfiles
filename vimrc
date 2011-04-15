call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("mouse")
	set mouse=a
	set mousehide
endif

syntax enable
set t_Co=256
set background=dark
colorscheme solarized
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
set guifont=Inconsolata:h14

