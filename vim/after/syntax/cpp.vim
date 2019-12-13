" Colorize C++ extraction and insertion operators
syntax match outOps "<<\|>>"
hi outOps guifg=#87d700 ctermfg=112
hi Boolean guifg=#dd0000 ctermfg=9
syn keyword cType class
syn keyword cType struct
syn keyword cType public
syn keyword cType protected
syn keyword cType private
syn match cType ":"
syn keyword cType namespace
