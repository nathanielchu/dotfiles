#!/usr/bin/env bash
# ------------------------------------------------------------------
# automated installation
# ------------------------------------------------------------------

# --- Flags --------------------------------------------------------
set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)

# --- Locks --------------------------------------------------------
SUBJECT=bootstrap_vim
LOCK_FILE=/tmp/"${SUBJECT}".lock
if [ -f "${LOCK_FILE}" ]; then
   echo "Script is already running"
   exit
fi

trap "rm -f "${LOCK_FILE}"" EXIT
touch "${LOCK_FILE}"

# --- Body ---------------------------------------------------------
__dir="$(cd "$(dirname "${BASH_SOURCE[${__b3bp_tmp_source_idx:-0}]}")" && pwd)"
cd "${__dir}"

# setup vim install
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update

# Install node.js and yarn
sudo apt update
sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash
sudo apt update
sudo apt -y install gcc g++ make
sudo apt -y install nodejs
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

INSTALLER="../install_package.sh"

"${INSTALLER}" vim
"${INSTALLER}" ctags

if ! [ -x "$(command -v rg)" ]; then
	echo "Installing ripgrep"
	sudo ./install-ripgrep.sh
else
	echo "ripgrep already installed"
fi

vim -E -s -c "source ~/.vimrc" +PlugInstall +qall

# ------------------------------------------------------------------
