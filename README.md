# work_things
this repo contains some things useful for work.

# putty's config
  `igvita-desert.reg`
  for more info please check https://www.igvita.com/2008/04/14/custom-putty-color-themes/

# a custom vim plugin(quarsars.vim) for symbols-listing and jumping
  what `quarsars.vim` can do: 
  1. toggle a window which contains definitions
  2. jump to the definitions by hitting `ENTER`
  3. only support `*.c` file
  4. a start point example of vim plugin developing
  
  what `quarsars.vim` <B>cannot</B> do:
  1. auto-complete
  2. list member of a struct
  3. c++-based symbols such as `class`
  4. ...
  
###  install
  run `./my_vim_plugin/install.sh`
  
###  usage
  `<F3>` to toggle the window
 
  `<Enter>` to jump to definition
  
  
###  3rdparty: quickmenu.vim
  this simple plugin was developed based on [quickmenu.vim](https://github.com/skywind3000/quickmenu.vim), for more info please check [quickmenu.vim](https://github.com/skywind3000/quickmenu.vim).
