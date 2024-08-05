#!/bin/bash

# コマンドのリスト
commands=(
    "python run_nerf.py --config=configs/Norm-blender360.txt"
    "python run_nerf.py --config=configs/Norm-hikage-doll-360.txt"
    "python run_nerf.py --config=configs/Norm-KE101-origin-adr.txt"
    "python run_nerf.py --config=configs/Norm-LAB.txt"
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
