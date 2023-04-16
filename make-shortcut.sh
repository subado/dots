#!/usr/bin/env bash

ln -sf $(readlink -f $1) $HOME/.local/bin/$1
