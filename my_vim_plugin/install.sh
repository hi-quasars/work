#!/bin/bash
curr=$(cd `dirname $0`; pwd)
source ${curr}/../common.sh


# check if ctags is installed
ctags --version > /dev/null
if [ $? != 0 ]; then
	pr_info "not installed ctags" warn
	sudo apt-get install ctags	
else
	pr_info "ctags already installed." info
fi

quarsars_vim="quarsars.vim"
cat ~/.vimrc | grep "source ${curr}/${quarsars_vim}" > /dev/null

if [ $? != 0 ]; then
	pr_info "not installed quarsars.vim" warn
	echo "source ${curr}/${quarsars_vim}" >> ~/.vimrc
else
	pr_info "quarsars.vim already installed." info
fi

