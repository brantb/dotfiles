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

