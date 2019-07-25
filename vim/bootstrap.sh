sudo apt-get install nodejs
sudo apt-get install yarn
sudo apt-get install ctags
sudo ./install-ripgrep.sh

vim -E -s -c "source ~/.vimrc" +PlugInstall +qall
