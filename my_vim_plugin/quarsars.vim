" check if loaded already
if &cp || exists("g:loaded_quarsarsplugin")
    finish
endif
let g:loaded_quarsarsplugin = "v0.01"


" include the 3rdparty
" path where this .vim file locate
let s:curr = expand('<sfile>:p:h') 

let s:qmpath = s:curr . '/3rdParty/quickmenu.vim/'
let s:f0 = s:qmpath . 'autoload/quickmenu.vim'
let s:f1 = s:qmpath . 'syntax/quickmenu.vim'

" the file vi open
let s:file = expand('%:p')
let s:this_file_tag = s:file . '.tag'

exec 'source ' . s:f0
exec 'source ' . s:f1

" my plugin 's logic


map <F2> :call GenTagFileC()<CR>

func! GenTagFileC()
    " silently ctags the editing file & save the tags to <this_file_name.tag>
    " echo s:this_file_tag
    exec 'silent !' . 'rm ' . s:this_file_tag . ' 2>/dev/null' | exec ':redraw!'

    "now only support C lang
    exec 'silent !' . 'ctags --language-force=C -f ' . s:this_file_tag . ' ' . s:file | exec ':redraw!'

    "set tags to ref. the file
    exec 'set tags+=' . s:this_file_tag
endfunc

map <F3> :call GetSymbolsFromTagFileC()<CR>
func! GetSymbolsFromTagFileC()
    " use an external bash script to parse the tag file.
    exec 'silent !' . s:curr . '/parse_ctags_file.sh ' . s:this_file_tag . ' > .tmp.symbols' | exec ':redraw!'
    let s:symbolstr = readfile('.tmp.symbols')
    " s:symbolstr is a list.
    " ready to generate the window which contains those tags from this file.
    
    call quickmenu#reset()
    

    let s:symbols = {}
    let num = 0
    

    for i in s:symbolstr
        if strpart(i, 0, 1) == '#'
            let s:type = strpart(i, 1, strlen(i) - 1)
            call quickmenu#append('# ' . s:type , '')
        else
            let s:symbols.num = i
            call quickmenu#append( i ,'echo 123',  s:type . ': ' . i)
            let num = num + 1
        endif
    endfor
    

    call quickmenu#toggle(0)
endfunc


" to call the obj :call xxx.f()
func! NewFunc(name, opts)
    let context = {'name': a:name, 'opts': a:opts}
   	function! context.f(...)
    	echo "running : " . self.name . "\n"
    	echo self.opts
    	echo "\n"
	endfunction
	
	return context
endfunc


let g:FuncArray = []
let g:FuncArrayNum = 0
map <F4> :call TestClosure()<CR>
func! TestClosure()
	if  g:FuncArrayNum < 3
	    let funcobj = NewFunc('foo' . string(g:FuncArrayNum), { 'a' : g:FuncArrayNum } )
	    call add(g:FuncArray, funcobj)
        let g:FuncArrayNum = g:FuncArrayNum + 1
    else 
        echo 'more than 3!'
    endif
endfunc
