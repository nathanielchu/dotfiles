#!/usr/bin/env bash

if ! [ -x "$(command -v "${1}")" ]; then
  echo "Installing ${1}"
  sudo apt-get update # Update package list before installing
  if ! sudo apt-get install -y "${1}"; then
    echo "Error installing ${1}"
    exit 1
  fi
else
  echo "${1} already installed"
fi
