# 笔记
## 复现过程
```sh
docker build -t dzp_gtrs:test --network=host --progress=plain .

docker run --name dzp-gtrs-test -itd --privileged --gpus all --network=host \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=$DISPLAY \
    -e LOCAL_USER_ID="$(id -u)" \
    dzp_gtrs:test /bin/bash

docker exec -it dzp-gtrs-test /bin/bash
```
重整结构
```angular2html
/navsim_workspace
├── GTRS (containing the devkit)
├── exp
└── dataset
    ├── maps
    ├── models
    |    └── dd3d_det_final.pth
    ├── traj_pdm_v2
    |    ├── ori
    |    |   ├── navtrain_16384.pkl
    |    |   └── navtrain_8192.pkl
    |    ├── random_aug
    |    |   ├── rot_30-trans_0-va_0-p_0.5-ensemble.json
    |    |   └── rot_30-trans_0-va_0-p_0.5-ensemble
    |    |       └── split_pickles
    |    |           ├──  xxx.pkl
    |    |           ├──  ...
    ├── navsim_logs
    |    ├── test
    |    ├── trainval
    |    ├── private_test_hard
    |    |         └── private_test_hard.pkl
    │    └── mini
    └── sensor_blobs
    |    ├── test
    |    ├── trainval
    |    ├── private_test_hard
    |    |         ├──  CAM_B0
    |    |         ├──  CAM_F0
    |    |         ├──   ...
    |    └── mini
    └── navhard_two_stage
    |    ├── openscene_meta_datas
    |    ├── sensor_blobs
    |    ├── synthetic_scene_pickles
    |    └── synthetic_scenes_attributes.csv
    └── warmup_two_stage
    |    ├── openscene_meta_datas
    |    ├── sensor_blobs
    |    ├── synthetic_scene_pickles
    |    └── synthetic_scenes_attributes.csv
    └── private_test_hard_two_stage
         ├── openscene_meta_datas
         └── sensor_blobs

```
确保硬盘映射好以后，修改环境变量
```sh
echo 'export NUPLAN_MAP_VERSION="nuplan-maps-v1.0"' >> ~/.bashrc \
 && echo 'export NUPLAN_MAPS_ROOT="/navsim_workspace/dataset/maps"' >> ~/.bashrc \
 && echo 'export NAVSIM_EXP_ROOT="/navsim_workspace/exp"' >> ~/.bashrc \
 && echo 'export NAVSIM_DEVKIT_ROOT="/navsim_workspace/GTRS"' >> ~/.bashrc \
 && echo 'export OPENSCENE_DATA_ROOT="/navsim_workspace/dataset"' >> ~/.bashrc \
 && echo 'export NAVSIM_TRAJPDM_ROOT="/navsim_workspace/dataset/traj_pdm_v2"' >> ~/.bashrc
```
如果改动了源代码，需要重新安装环境
```sh
git clone https://github.com/superboySB/GTRS_SB

cd GTRS_SB && pip install -e .
```
上述环境变量和映射先一切从简吧