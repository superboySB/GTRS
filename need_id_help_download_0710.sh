#!/bin/bash
# 需要帮忙下载到/disk/deepdata/dataset/内部
set -e  # 遇到错误立即退出

echo "开始下载GTRS数据集..."

# 克隆仓库
git clone https://github.com/NVlabs/GTRS.git
cd GTRS

# 进入下载目录
cd download

# 下载地图数据
echo "下载地图数据..."
bash ./download_maps.sh

# 下载各种数据集
echo "下载mini数据集..."
bash ./download_mini.sh

echo "下载trainval数据集..."
bash ./download_trainval.sh

echo "下载test数据集..."
bash ./download_test.sh

echo "下载warmup two stage数据集..."
bash ./download_warmup_two_stage.sh

echo "下载navhard two stage数据集..."
bash ./download_navhard_two_stage.sh

echo "下载private test hard two stage数据集..."
bash ./download_private_test_hard_two_stage.sh

# 选择一个navtrain下载方式（AWS或HuggingFace）
echo "下载navtrain数据集（从HuggingFace）..."
bash ./download_navtrain_hf.sh

# 返回上级目录
cd ..

echo "创建目录结构..."
# 创建必要的目录
mkdir -p dataset/{traj_pdm_v2/{ori,random_aug},models}

# 下载额外数据
echo "下载模拟地面真相数据..."
cd dataset/traj_pdm_v2/ori
wget https://huggingface.co/Zzxxxxxxxx/gtrs/resolve/main/navtrain_8192.pkl
wget https://huggingface.co/Zzxxxxxxxx/gtrs/resolve/main/navtrain_16384.pkl

cd ../random_aug
wget https://huggingface.co/Zzxxxxxxxx/gtrs/resolve/main/rot_30-trans_0-va_0-p_0.5-ensemble.json
wget https://huggingface.co/Zzxxxxxxxx/gtrs/resolve/main/aug_traj_pdm.zip
unzip aug_traj_pdm.zip
rm aug_traj_pdm.zip

# 下载预训练模型
echo "下载预训练视觉backbone..."
cd ../../models
wget https://huggingface.co/Zzxxxxxxxx/gtrs/resolve/main/dd3d_det_final.pth

echo "所有数据下载完成！"