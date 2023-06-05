#!/usr/bin/env bash
#
#


plugins_dir="./site/pack/vendor/start"
first=false

if [[ ! -d "${plugins_dir}" ]]; then
    mkdir -p "${plugins_dir}"
    first=true
fi

if [[ ! -d "${plugins_dir}/nvim-treesitter" ]]; then
    echo "[plugins] treesitter: installing..."
    git clone https://github.com/nvim-treesitter/nvim-treesitter "${plugins_dir}/nvim-treesitter"
    echo "[plugins] treesitter: installed"
    echo
fi

if [[ ! -d "${plugins_dir}/nvim-treesitter-textobjects" ]]; then
    echo "[plugins] textobjects: installing..."
    git clone https://github.com/nvim-treesitter/nvim-treesitter-textobjects "${plugins_dir}/nvim-treesitter-textobjects"
    echo "[plugins] textobjects: installed"
    echo
fi

if $first; then
    echo first
    nvim --headless --clean -u init.lua -c "TSUpdate | TSInstall zig | 3sleep | q"
    echo
fi

# nvim --clean -u init.lua main.zig #-c "q"


echo Time
time nvim --clean -u init.lua main.zig -c "q"
echo

if type hyperfine &>/dev/null; then
    echo Hyperfine
    hyperfine 'nvim --clean -u init.lua main.zig -c "q"'
    echo
fi
