" check if loaded already
if &cp || exists("g:loaded_quarsarsplugin")
    finish
endif
let g:loaded_quarsarsplugin = "v0.01"


" include the 3rdparty
let s:path = '/home/fatiao/src/test/env_test/work_things/my_vim_plugin/3rdParty/quickmenu.vim/'
let s:f0 = s:path . 'autoload/quickmenu.vim'
let s:f1 = s:path . 'syntax/quickmenu.vim'
exec 'source ' . s:f0
exec 'source ' . s:f1

" my plugin 's logic

map <F2> :call GenTagFileC()<CR>

func! GenTagFileC()
    " silently ctags the editing file & save the tags to <this_file_name.tag>
    let s:file = expand('%:p')
    let s:this_file_tag = s:file . '.tag'
    " echo s:this_file_tag
    exec 'silent !' . 'rm ' . s:this_file_tag . ' 2>/dev/null' | exec ':redraw!'

    "now only support C lang
    exec 'silent !' . 'ctags --language-force=C -f ' . s:this_file_tag . ' ' . s:file | exec ':redraw!'
endfunc

