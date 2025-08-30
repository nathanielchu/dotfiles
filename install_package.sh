#!/usr/bin/env bash

# Detect operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

if ! [ -x "$(command -v "${1}")" ]; then
  echo "Installing ${1} on ${OS}"
  
  if [[ "$OS" == "linux" ]]; then
    # Linux: use apt-get
    sudo apt-get update # Update package list before installing
    if ! sudo apt-get install -y "${1}"; then
      echo "Error installing ${1}"
      exit 1
    fi
  elif [[ "$OS" == "macos" ]]; then
    # macOS: use Homebrew
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
      echo "Homebrew not found. Installing Homebrew first..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Update Homebrew before installing
    brew update
    if ! brew install "${1}"; then
      echo "Error installing ${1}"
      exit 1
    fi
  fi
else
  echo "${1} already installed"
fi
