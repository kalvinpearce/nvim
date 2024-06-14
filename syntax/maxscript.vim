" Vim syntax file
" Language:	MAXScript 8.0
" Maintainer:	Josh Lee <jleedev@gmail.com
" Last Change:	2007 May 17
" Remark:	Based on MAXScript Reference 8.0
" License:	This file is placed in the public domain.
"
" Todo:
" String escapes
" Time literals
" Pathname literals
" Point literals
" Array literals
" Bitarray literals
" Name literals
" Refine the keywords: split into statements/operators
" More punctuation
" Mismatched parentheses
" A selection of built-in functions and objects

syn case ignore

" Reserved words
syn keyword msKeyword about and animate as at by case collect continue coordsys do else exit fn for function global if in local macroscript mapped max not of off on or parameters persistent plugin rcmenu return rollout set struct then to tool undo utility when where while with 
syn keyword msException throw try catch
syn keyword msUnused from

" Builtins
syn keyword msBoolean true false on off
syn keyword msGlobal pi e x_axis y_axis z_axis ok undefined unsupplied dontcollect
syn keyword msColor red green blue white bkack orange yellow brown gray

" Strings
syn region msString start=/"/ end=/"/ skip=/\\\\\|\\"/

" Comments
syn region msComment start=/\/\*/ end=/\*\// contains=msTodo
syn match msComment /--.*/ contains=msTodo
syn sync ccomment msComment
set comments+=:--
set commentstring=--%s

syn keyword msTodo TODO FIXME NOTE XXX contained

" Literals
syn match msNumber "-\=\<\d*\.\=[0-9_]\>"

" Highlighting
hi def link msComment	Comment
hi def link msTodo	Todo

hi def link msGlobal	Constant
hi def link msString	String
hi def link msBoolean	Boolean
hi def link msColor	Constant
hi def link msNumber	Number

hi def link msKeyword	Keyword
hi def link msException	Exception

hi def link msUnused	Error

" vim: ts=8 noet
