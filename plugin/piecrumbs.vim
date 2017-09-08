""
" @section Intro, intro
" @order intro version dicts functions
" This plugin displays a colored breadcrumbs string under statusline
" using echo command. I wanted a lightweight plugin for this so I decided
" to write my own.
"
" Once you move your cursor, it will traverse through the higher level
" class and methods until it reaches function/class definition with
" no indentation. It will display the collected info using echo command.

""
" If enabled, piecrumbs will automatically echo current breadcrumbs once you
" move your cursor in Normal or Insert modes. Defaults to 1 (enabled.)
let g:piecrumbs_auto = get(g:, 'piecrumbs_auto', 1)

""
" If enabled, piecrumbs will display class & method signatures near each
" breadcrumb. Defaults to 1 (enabled.)
let g:piecrumbs_show_signatures = get(g:, 'piecrumbs_show_signatures', 1)

""
" String to use as glue for breadcrumbs. Defaults to ' :: '.
let g:piecrumbs_glue = get(g:, 'piecrumbs_glue', ' :: ')

""
" Renders breadcrumbs using echo command.
" If setting(g:piecrumbs_auto) is 1 (default), renders function/class
" signatures as well.
function! PieCrumbs()
    if g:piecrumbs_show_signatures
        let regexp = '\(def\|class\) \([a-zA-Z_]*\)\(\(:\|([^:]*)\):\)'
    else
        let regexp = '\(def\|class\) \([a-zA-Z_]*\)[(:]'
    endif
    let line_count = line('$')
    let lineno = getpos('.')[1]
    let lineno_initial = lineno
    let min_indent = -1
    while lineno <= line_count
        let min_indent = match(getline(lineno), '\S')
        if min_indent != -1
            break
        endif
        let lineno += 1
    endwhile
    let s = ''
    let path = []
    while lineno > 0
        let line = getline(lineno)
        let indent = match(line, '\S')
        if (indent < min_indent || lineno == lineno_initial) && indent != -1
            let min_indent = indent
            let match = matchlist(line, regexp)
            if len(match) != 0
                call add(path, [match[1], match[2], match[4]])
            endif
        endif
        let lineno = lineno - 1
    endwhile
    call reverse(path)
    echo ''
    let is_first = 1
    for part in path
        if is_first == 1
            let is_first = 0
        else
            echohl Number
            echon g:piecrumbs_glue
        endif
        if part[0] ==  'def'
            echohl Function
        elseif part[0] == 'class'
            echohl Keyword
        endif
        echon part[1]
        echohl Normal
        echon part[2]
    endfor
endfunction

if g:piecrumbs_auto
    autocmd CursorMoved * call PieCrumbs()
    autocmd CursorMovedI * call PieCrumbs()
endif

