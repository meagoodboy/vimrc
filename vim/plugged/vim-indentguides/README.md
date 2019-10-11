<p align="center">
<img src="https://raw.githubusercontent.com/thaerkh/vim-indentguides/master/wiki/screenshots/demo.png" >
</p>

# Features

Space indents are visually identified by the "┆" character, while tabs are distinguished by "|".
Manually calling the command `IndentGuidesToggle` will toggle indent guides scoped to a specific buffer.

If there are any files you would like to not add indent guides for, add the filetype to the ignore list:
```
let g:indentguides_ignorelist = ['text']
```

If you'd like to change the default space and tab indent characters, modify the following in your vimrc:
```
let g:indentguides_spacechar = '┆'
let g:indentguides_tabchar = '|'
```

# Installation

### Using Plug

Paste the following in your `~/.vimrc` file:
```
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'thaerkh/vim-indentguides'
call plug#end()
```
If you don't already have Plug, this will auto-download Plug for you and install the indentguides plugin.

If you already have Plug, simply paste `Plug 'thaerkh/vim-indentguides'` and call `:PlugInstall` to install the plugin.

Remember to `:PlugUpdate` often to get all the latest features and bug fixes!
### Using Vundle

Paste this in your `~./vimrc`:
```
Plugin 'thaerkh/vim-indentguides'
```
### Using Pathogen

cd into your bundle path and clone the repo:
```
cd ~/.vim/bundle
git clone https://github.com/thaerkh/vim-indentguides
```

# License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
