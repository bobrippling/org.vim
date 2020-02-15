" Vim syntax file for GNU Emacs' Org mode
"
" Maintainer:   Alex Vear <av@axvr.io>
" License:      Vim (see `:help license`)
" Location:     syntax/org.vim
" Website:      https://github.com/axvr/org.vim
" Last Change:  2020-01-05
"
" Reference Specification: Org mode manual
"   GNU Info: `$ info Org`
"   Web: <https://orgmode.org/manual/index.html>

if exists('b:current_syntax') && b:current_syntax !=# 'outline'
    finish
endif

" Enable spell check for non syntax highlighted text
syntax spell toplevel

" Bold, underine, italic, etc.
syntax region orgItalic        matchgroup=orgItalicDelimiter        start="[^ \t\k]\@<!\/\k\@=\/\@!" end="\k\@<=\/\@<!\/" keepend contains=@Spell
syntax region orgBold          matchgroup=orgBoldDelimiter          start="[^ \t\k]\@<!\*\k\@=\*\@!" end="\k\@<=\*\@<!\*" keepend contains=@Spell
syntax region orgUnderline     matchgroup=orgUnderlineDelimiter     start="[^ \t\k]\@<!_\k\@=_\@!"   end="\k\@<=_\@<!_"   keepend contains=@Spell
syntax region orgStrikethrough matchgroup=orgStrikethroughDelimiter start="[^ \t\k]\@<!+\k\@=+\@!"   end="\k\@<=+\@<!+"   keepend contains=@Spell

if org#option('org_use_italics', 1)
    highlight def orgItalic term=italic cterm=italic gui=italic
else
    highlight def orgItalic term=none cterm=none gui=none
endif

highlight def orgBold term=bold cterm=bold gui=bold
highlight def orgUnderline term=underline cterm=underline gui=underline
highlight def link orgBoldDelimiter      orgBold
highlight def link orgUnderlineDelimiter orgUnderline


" Options
syntax match  orgOption /^\s*#+\w\+.*$/ keepend
syntax region orgTitle matchgroup=orgOption start="^\s*#+TITLE:\s*" end="$" keepend oneline

highlight def link orgBlockDelimiter SpecialComment
highlight def link orgOption SpecialComment
highlight def link orgTitle Title


" Code and vervatim text
syntax region orgCode     matchgroup=orgCodeDelimiter     start="[^ \t\k]\@<!\~\k\@=\~\@!" end="\k\@<=\~\@<!\~" keepend
syntax region orgVerbatim matchgroup=orgVerbatimDelimiter start="[^ \t\k]\@<!=\k\@==\@!"   end="\k\@<==\@<!="   keepend
syntax match  orgVerbatim /^\s*: .*$/ keepend
syntax region orgVerbatim matchgroup=orgBlockDelimiter start="^\s*#+BEGIN_.*"      end="^\s*#+END_.*"      keepend
syntax region orgCode     matchgroup=orgBlockDelimiter start="^\s*#+BEGIN_SRC"     end="^\s*#+END_SRC"     keepend
syntax region orgCode     matchgroup=orgBlockDelimiter start="^\s*#+BEGIN_EXAMPLE" end="^\s*#+END_EXAMPLE" keepend

highlight def link orgVerbatim Identifier
highlight def link orgVerbatimDelimiter orgVerbatim
highlight def link orgCode Statement
highlight def link orgCodeDelimiter orgCode


" Comments
syntax match  orgComment /^\s*#\s\+.*$/ keepend
syntax region orgComment matchgroup=orgBlockDelimiter start="^\s*#+BEGIN_COMMENT" end="^\s*#+END_COMMENT" keepend
highlight def link orgComment Comment


" Headings
syntax match orgHeading1 /^\s*\*\{1}\s\+.*$/ keepend contains=@Spell,orgTag,orgTodo
syntax match orgHeading2 /^\s*\*\{2}\s\+.*$/ keepend contains=@Spell,orgTag,orgTodo
syntax match orgHeading3 /^\s*\*\{3}\s\+.*$/ keepend contains=@Spell,orgTag,orgTodo
syntax match orgHeading4 /^\s*\*\{4}\s\+.*$/ keepend contains=@Spell,orgTag,orgTodo
syntax match orgHeading5 /^\s*\*\{5}\s\+.*$/ keepend contains=@Spell,orgTag,orgTodo
syntax match orgHeading6 /^\s*\*\{6,}\s\+.*$/ keepend contains=@Spell,orgTag,orgTodo

syntax match orgTag /:\w\{-}:/ contained contains=orgTag
exec 'syntax keyword orgTodo contained ' . join(org#option('org_state_keywords', ['TODO', 'NEXT', 'DONE']), ' ')

highlight def link orgHeading1 Title
highlight def link orgHeading2 orgHeading1
highlight def link orgHeading3 orgHeading2
highlight def link orgHeading4 orgHeading3
highlight def link orgHeading5 orgHeading4
highlight def link orgHeading6 orgHeading5
highlight def link orgTodo Todo
highlight def link orgTag Type


" Lists
syntax match orgUnorderedListMarker "^\s*[-+]\s\+" keepend contains=@Spell
syntax match orgOrderedListMarker "^\s*\d\+[.)]\s\+" keepend contains=@Spell
highlight def link orgUnorderedListMarker Statement
highlight def link orgOrderedListMarker orgUnorderedListMarker


" Timestamps
syntax match orgTimestampActive /<\d\{4}-\d\{2}-\d\{2}.\{-}>/ keepend
syntax match orgTimestampInactive /\[\d\{4}-\d\{2}-\d\{2}.\{-}\]/ keepend
highlight def link orgTimestampActive Operator
highlight def link orgTimestampInactive Comment


" Hyperlinks
syntax match orgHyperlink /\[\{2}\([^][]\{-1,}\]\[\)\?[^][]\{-1,}\]\{2}/ containedin=ALL contains=orgHyperLeft,orgHyperRight,orgHyperURL
syntax match orgHyperLeft /\[\{2}/ contained conceal
syntax match orgHyperRight /\]\{2}/ contained conceal
syntax match orgHyperURL /[^][]\{-1,}\]\[/ contained conceal
highlight def link orgHyperlink Underlined


let b:current_syntax = 'org'
