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
SUBJECT=bootstrap_dotfiles
LOCK_FILE=/tmp/"${SUBJECT}".lock
if [ -f "${LOCK_FILE}" ]; then
   echo "Script is already running"
   exit
fi

trap "rm -f "${LOCK_FILE}"" EXIT
touch "${LOCK_FILE}"

# --- Options processing -------------------------------------------
USAGE="Usage: "${0}""
if [ "${#}" -gt 0 ] ; then
    echo "${USAGE}"
    exit 1;
fi

# --- Body ---------------------------------------------------------
__dir="$(cd "$(dirname "${BASH_SOURCE[${__b3bp_tmp_source_idx:-0}]}")" && pwd)"
cd "${__dir}"

# Detect operating system and install stow
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

echo "Detected OS: ${OS}"

# Install stow
./install_package.sh stow

BOOTSTRAP="bootstrap.sh"
for d in */ ; do
    package="$(basename ${d})"
    echo "${package}"
    stow "${package}"
    cd "${d}"
    test -f bootstrap.sh && ./bootstrap.sh
    cd ..
done

# ------------------------------------------------------------------
