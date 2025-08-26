# Dotfiles

## Installation
```shell
git clone git@github.com:nathanielchu/dotfiles.git
```

Recommended install location is ~/dotfiles

Clone the repository.

```shell
./bootstrap.sh
```

Install necessary packages and create symlinks.

### Stow

```shell
stow [package]
```

Create symlinks using stow.

### Dependencies

#### Vim

The .vimrc installation requires the following dependencies. 

```shell
sudo apt-get install nodejs
sudo apt-get install yarn
sudo apt-get install ctags
sudo ./install-ripgrep.sh
```

Install the required plugin dependencies.

```
:source ~/.vimrc
:PlugInstall
```

Install the vim plugins using vim-plug.
