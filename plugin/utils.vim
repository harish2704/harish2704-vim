fun! OpenInNewTab(fname, ... )
    " let l:cWinPos = winnr()
    let l:totalWins = winnr('$')
    let l:tabOffset = 0
    let l:currentTabNo = tabpagenr()
    if l:totalWins == 1
        let l:tabOffset=1
    end
    if  exists('a:1')
        if a:1 < l:currentTabNo
            let l:tabOffset = 0
        endif
        let l:targetTabNo = ( a:1-l:tabOffset )
        echo l:targetTabNo
        if l:targetTabNo < 1
            return
        endif
        execute 'close'
        execute 'tabn'.( l:targetTabNo)
        execute 'vs '.a:fname
    else
        execute 'tabedit ' . a:fname
    end
endfunction

fun! OpenInNewTabI( ... )
    if  exists('a:1')
        let l:targetTab = a:1
    else
        let l:targetTab = input('Enter tabNo: ')
    endif
    call OpenInNewTab( @%, l:targetTab )
endfunction

fun! SpList( files, ... )
    let l:prefix = ''
    let l:suffix = ''
    if exists('a:1')
        let l:prefix = a:1
    endif
    if exists('a:2')
        let l:suffix = a:2
    endif

    execute 'e ' . l:prefix . a:files[0] . l:suffix
    call remove( a:files, 0 )
    for file in a:files
        execute 'sp ' . l:prefix . file . l:suffix
    endfor
endfunction

fun! OpenSnippets()
    let l:ftypes = split( &filetype , '\.')
    let l:prefix = '~/.vim/bundle/vim-snippets/snippets/'
    let l:suffix = '.snippets'
    execute 'tabnew'
    call SpList( l:ftypes, l:prefix, l:suffix )
endfunction

nmap <C-W>t :call OpenInNewTab(@%)<CR>
command! -nargs=? Mt call OpenInNewTabI(<args>)
command! OpenSnippets call OpenSnippets()
command! Cd cd %:p:h
