#!/usr/bin/env bash

# This script contains commands run in an attempt to replicate the dreambooth project
eval "$(/opt/homebrew/bin/brew shellenv)"
PATH="/opt/homebrew/opt/llvm/bin:${PATH}"
export PATH
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -L/opt/homebrew/opt/libomp/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include -I/opt/homebrew/opt/libomp/include"
export CC="/opt/homebrew/opt/llvm/bin/clang"
