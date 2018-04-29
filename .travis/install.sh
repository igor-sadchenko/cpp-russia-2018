#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv
    brew install cmake || true

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi

    if which pyenv-virtualenv-init > /dev/null; then
        eval "$(pyenv virtualenv-init -)";
    fi

    pyenv install 2.7.14
    pyenv virtualenv 2.7.14 conan
    pyenv rehash
    pyenv activate conan
    
    CC="clang"
    CXX="clang++"
fi

if [[ "$(uname -s)" == 'Linux' ]]; then
    CC=$C_COMPILER
    CXX=$CXX_COMPILER
fi

python -m pip install conan --upgrade
python -m pip install conan_package_tools

conan user

conan remote add conan.io https://server.conan.io false
