fun! OpenInNewTab(fname, ... )
    " let l:cWinPos = winnr()
    let l:totalWins = winnr('$')
    let l:tabOffset = 0
    let l:currentTabNo = tabpagenr()
    if l:totalWins == 1
        let l:tabOffset=1
    end
    execute 'close'
    if  exists('a:1')
        if a:1 < l:currentTabNo
            let l:tabOffset = 0
        end
        execute 'tabn'.(a:1-l:tabOffset)
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

nmap <C-W>t :call OpenInNewTab(@%)<CR>
command -nargs=? Mt call OpenInNewTabI(<args>)
