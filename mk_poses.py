import json
import math
ROTATION = True
def calc_rm(r_x,r_y,r_z):
    r = [
                math.cos(r_y)*math.cos(r_z),-math.cos(r_y)*math.sin(r_z),math.sin(r_y),
                math.sin(r_x)*math.sin(r_y)*math.cos(r_z)+math.cos(r_x)*math.sin(r_z),-math.sin(r_x)*math.sin(r_y)*math.sin(r_z)+math.cos(r_x)*math.cos(r_z),-math.sin(r_x)*math.cos(r_y),
                -math.cos(r_x)*math.sin(r_y)*math.cos(r_z)+math.sin(r_x)*math.sin(r_z),math.cos(r_x)*math.sin(r_y)*math.sin(r_z)+math.sin(r_x)*math.cos(r_z),math.cos(r_x)*math.cos(r_y),
            ]
    return r

def mk_poses(read_json,out_txt):
    # reconstruction.jsonファイルを読み込む
    with open(read_json, 'r') as f:
        data = json.load(f)

    data = data[0]
    # poses.txtファイルを開く
    with open(out_txt, 'w') as f:
        #print(data[0]['shots'])
        for shot_id, shot in data['shots'].items():
            # ファイル名から拡張子を除去
            name = shot_id.split('.')[0]
            
            # カメラの位置(x, y, z)を取得
            x, y, z = shot['translation']
            n = 8
            x, y, z = x/n , y/n , z/n
            # 単位行列(0, -1, 0, 1, 0, 0)を使用して回転行列を作成
            r = [1.0,0.0,0.0,0.0,0.0,-1.0, 0.0, 1.0,  0.0]
            
            if ROTATION==True:
                r_x,r_y,r_z = shot['rotation']
                r = calc_rm(r_x,r_y,r_z)

            
            # poses.txtファイルに書き込む
            f.write(f'{name} {r[0]} {r[1]} {r[2]} {r[3]} {r[4]} {r[5]} {r[6]} {r[7]} {r[8]} {x} {y} {z}\n')
if __name__ == '__main__':
    import argparse

    # 引数パーサを作成
    parser = argparse.ArgumentParser()

    # 引数を定義
    parser.add_argument("-i","--input", default="reconstruction.json",help="入力")
    parser.add_argument("-o","--output", default="poses.txt",help="出力")

    # 引数を解析
    args = parser.parse_args()
    mk_poses(args.input,args.output)