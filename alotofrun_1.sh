#!/bin/bash

# コマンドのリスト
commands=(
    "python run_nerf.py --config=drc_config/Roll-blender360.txt"
    "python run_nerf.py --config=drc_config/Roll-hikage-doll-360.txt"
    "python run_nerf.py --config=drc_config/Roll-inkena11.txt"
    "python run_nerf.py --config=drc_config/Roll-in-doll.txt"
    "python run_nerf.py --config=drc_config/Roll-KE101-origin-adr.txt"
    "python run_nerf.py --config=drc_config/Roll-KENA-302.txt"
    "python run_nerf.py --config=drc_config/Roll-LAB.txt"
)

# 並列実行する関数
run_parallel() {
    for cmd in "$@"; do
        eval "$cmd" &
    done
    wait
}

# コマンドを2つずつ実行
for ((i=0; i<${#commands[@]}; i+=1)); do
    run_parallel "${commands[@]:i:1}"
done
