call pathogen#runtime_append_app_bundles()
call pathogen#helptags()

if has("mouse")
	set mouse=a
	set mousehide
endif

syntax on
set t_Co=256
colorscheme zenburn

