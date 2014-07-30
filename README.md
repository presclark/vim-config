vim-config
==========

Installation:

	Clone this repo

Create symlinks:

    ln -s ~/vim-config/.vim/ ~/.vim
    ln -s ~/vim-config/.vim/vimrc ~/.vimrc

If you're using Windows, this can be accomplished by running the windows-install.cmd file in a command prompt (should be run as an admin).

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

See: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/ for a good primer.

