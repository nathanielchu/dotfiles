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
SUBJECT=bootstrap_tmux
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

"${INSTALLER}" tmux

if [ ! -d "~/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

tmux new-session -d
~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux source ~/.tmux.conf

# ------------------------------------------------------------------
