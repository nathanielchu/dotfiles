# Vim Configurations

This contains a vim environment setup for backup and portability.

## Setup

### Install plugin dependencies

```shell
sudo apt-get install nodejs
sudo apt-get install yarn
sudo apt-get install ctags
sudo ./install-ripgrep.sh
```

Install the required plugin dependencies.

### Symlink .vimrc

```shell
ln -sf ~/.vim/.vimrc ~/.vimrc
```

Create a link to use this vimrc.

Then run the following in Vim:

```
:source ~/.vimrc
:PlugInstall
```

This installs the plugins in plugins.vim using vim-plug.
