#!/bin/bash

# コマンドのリスト
commands=(
    "python run_nerf_new_roll.py --config=ex_config/Roll-out-chair.txt"
    "python run_nerf_new_roll.py --config=ex_config/Roll-out-kouC-360.txt"
    "python run_nerf_new_roll.py --config=ex_config/Roll-out-pkg.txt"
    "python run_nerf_new_roll.py --config=ex_config/Roll-out-tosho-360.txt"
    "python run_nerf_new_roll.py --config=ex_config/Roll-outdoll.txt"
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
