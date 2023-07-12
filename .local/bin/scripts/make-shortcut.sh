#!/usr/bin/env bash

BIN="$1"
NAME="$2"

ln -sf "$(realpath "$BIN")" "$HOME/.local/bin/${NAME:-"${BIN##*/}"}"
