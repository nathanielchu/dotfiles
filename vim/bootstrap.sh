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

INSTALLER="../install_package.sh"

"${INSTALLER}" nodejs
"${INSTALLER}" yarn
"${INSTALLER}" ctags

if ! [ -x "$(command -v rg)" ]; then
	echo "Installing ripgrep"
	sudo ./install-ripgrep.sh
else
	echo "ripgrep already installed"
fi

vim -E -s -c "source ~/.vimrc" +PlugInstall +qall

# ------------------------------------------------------------------
