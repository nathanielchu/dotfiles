#!/usr/bin/env bash

if ! [ -x "$(command -v "${1}")" ]; then
	echo "Installing "${1}""
	sudo apt-get install "${1}"
else
	echo ""${1}" already installed"
fi
