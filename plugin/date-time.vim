#!/usr/bin/env vim
" date-time.vim - Commands for injecting date and/or time into current buffer
" Version: 0.0.1
" Maintainer: S0AndS0
" License: AGPL-3.0


""
" Fast finish if already loaded or Vim version is bellow target
if exists('g:date_time__loaded') || v:version < 700
  finish
endif
let g:date_time__loaded = 1


""
" Replace visual selection with date/time via `strftime`
" Example: Selection of `%R` → `16:22`
" Example: Selection of `%F` → `2022-03-26`
" Example: Selection of `%Y-%m-%d_%H:%M:%S` → `2022-03-26_18:27:42`
" See: https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:Date_Time__Replace_Selection() abort range
  let l:end = getpos("'>")[2]
  let l:start = getpos("'<")[2]

  let l:lnum = a:firstline
  while l:lnum <= a:lastline
    call s:Date_Time__Replace_Line({ 'lnum': l:lnum, 'start': l:start, 'end': l:end })
    let l:lnum += 1
  endwhile
endfunction


""
" Replace line number between start, and end, columns with `strftime`
" Parameter: {dic} options - Unordered key/value pares
" Parameter: {number} options.lnum - Target line number in current buffer
" Parameter: {number} options.start - Start column number
" Parameter: {number} options.end - End column number
function! s:Date_Time__Replace_Line(options) abort
  let l:line = getline(a:options.lnum)

  let l:selection = l:line[max([a:options.start - 1, 0]):(a:options.end - 1)]

  if a:options.start > 1
    let l:head = l:line[:(a:options.end - (len(l:selection) + 1))]
  else
    let l:head = ''
  endif

  let l:tail = l:line[a:options.end:]

  let l:date_time = strftime(l:selection)
  call setline(a:options.lnum, l:head . l:date_time . l:tail)
endfunction


""
" Append or insert current date
" Parameter: {string} where - 'a' or 'i' append or insert respectively
function! s:Date_Time__Date(where) abort
  if a:where == 'a'
    execute 'normal a' . strftime(g:date_time.date.append.format)
  else
    execute 'normal i' . strftime(g:date_time.date.insert.format)
  endif
  normal l
endfunction


""
" Append or insert current time
" Parameter: {string} where - 'a' or 'i' append or insert respectively
function! s:Date_Time__Time(where) abort
  if a:where == 'a'
    execute 'normal a' . strftime(g:date_time.time.append.format)
  else
    execute 'normal i' . strftime(g:date_time.time.insert.format)
  endif
  normal l
endfunction


""
" Merged dictionary without mutation
" Parameter: {dict} defaults
" Parameter: {...dict[]} overrides
" Return: {dict}
" See: {docs} :help type()
" See: {link} https://vi.stackexchange.com/questions/20842/how-can-i-merge-two-dictionaries-in-vim
function! s:Dict_Merge(defaults, ...) abort
  let l:new = copy(a:defaults)
  if a:0 == 0
    return l:new
  endif

  for l:override in a:000
    for [l:key, l:value] in items(l:override)
      if type(l:value) == type({}) && type(get(l:new, l:key)) == type({})
        let l:new[l:key] = s:Dict_Merge(l:new[l:key], l:value)
      else
        let l:new[l:key] = l:value
      endif
    endfor
  endfor

  return l:new
endfunction


""
"
function! s:Register_Commands() abort
  " Append and/or insert current date (YYYY-MM-DD)
  if g:date_time.date.append.enable
    command! ADate call <SID>Date_Time__Date('a')
  endif
  if g:date_time.date.insert.enable
    command! IDate call <SID>Date_Time__Date('i')
  endif

  " Append and/or insert current time (HH:MM)
  if g:date_time.time.append.enable
    command! ATime call <SID>Date_Time__Time('a')
  endif
  if g:date_time.time.insert.enable
    command! ITime call <SID>Date_Time__Time('i')
  endif

  " Replace selection as date/time format
  if g:date_time.replace.enable
    command! -range RNow call <SID>Date_Time__Replace_Selection()
  endif
endfunction


""
"
function! s:Register_Leader() abort
  " Append and/or Insert current date (YYYY-MM-DD)
  if g:date_time.date.append.enable && len(g:date_time.date.append.leader)
    execute 'nnoremap <Leader>'
          \ . g:date_time.date.append.leader
          \ . " :call <SID>Date_Time__Date('a')<CR>"
  endif

  if g:date_time.date.insert.enable && len(g:date_time.date.insert.leader)
    execute 'nnoremap <Leader>'
          \ . g:date_time.date.insert.leader
          \ . " :call <SID>Date_Time__Date('i')<CR>"
  endif

  " Append and/or Insert current time (HH:MM)
  if g:date_time.time.append.enable && len(g:date_time.time.append.leader)
    execute 'nnoremap <Leader>'
          \ . g:date_time.time.append.leader
          \ . " :call <SID>Date_Time__Time('a')<CR>"
  endif

  if g:date_time.time.insert.enable && len(g:date_time.time.insert.leader)
    execute 'nnoremap <Leader>'
          \ . g:date_time.time.insert.leader
          \ . " :call <SID>Date_Time__Time('i')<CR>"
  endif

  " Replace selection as date/time format
  if g:date_time.replace.enable && len(g:date_time.replace.leader)
    execute 'vnoremap <Leader>'
          \ . g:date_time.replace.leader
          \ . ' :call <SID>Date_Time__Replace_Selection()<CR>'
  endif
endfunction


""
" Configurations that may be overwritten
" Property: date.append.enable - `v:true` Register command and leader sequence
" Property: date.append.format - "%F" Date/time string to send to `strftime`
" Property: date.append.leader - "d" Normal mode key sequence to set
"
" Property: date.insert.enable - `v:true` Register command and leader sequence
" Property: date.insert.format - "%F" Date/time string to send to `strftime`
" Property: date.insert.leader - "D" Normal mode key sequence to set
"
" Property: time.append.enable - `v:true` Register command and leader sequence
" Property: time.append.format - "%R" Date/time string to send to `strftime`
" Property: time.append.leader - "t" Normal mode key sequence to set
"
" Property: time.insert.enable - `v:true` Register command and leader sequence
" Property: time.insert.format - "%R" Date/time string to send to `strftime`
" Property: time.insert.leader - "T" Normal mode key sequence to set
"
" Property: replace.enable - `v:true` Register command and leader sequence
" Property: replace.leader - "R" Normal mode key sequence to set
let s:defaults = {
      \   'date': {
      \     'append': {
      \       'enable': v:true,
      \       'format': '%F',
      \       'leader': 'd',
      \     },
      \     'insert': {
      \       'enable': v:true,
      \       'format': '%F',
      \       'leader': 'D',
      \     },
      \   },
      \   'time': {
      \     'append': {
      \       'enable': v:true,
      \       'format': '%R',
      \       'leader': 't',
      \     },
      \     'insert': {
      \       'enable': v:true,
      \       'format': '%R',
      \       'leader': 'T',
      \     },
      \   },
      \   'replace': {
      \     'enable': v:true,
      \     'leader': 'R',
      \   },
      \ }


""
" See: {docs} :help fnamemodify()
" See: {docs} :help readfile()
" See: {docs} :help json_decode()
if exists('g:date_time')
  if type(g:date_time) == type('') && fnamemodify(g:date_time, ':e') == 'json'
    let g:date_time = json_decode(join(readfile(g:date_time), ''))
  endif

  if type(g:date_time) == type({})
    let g:date_time = s:Dict_Merge(s:defaults, g:date_time)
  else
    let g:date_time = s:defaults
  endif
else
  let g:date_time = s:defaults
endif


""
" Registration of commands, mode mapping(s), and settings
call s:Register_Commands()
call s:Register_Leader()

