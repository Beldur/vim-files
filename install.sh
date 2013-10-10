ln -s ~/.vim/vimrc ~/.vimrc

cd ~/.vim
git submodule init
git submodule update

(cd ~/.vim/bundle/vimproc.vim && make)
