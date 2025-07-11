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
确保硬盘映射好以后，修改环境变量
```sh
echo 'export NUPLAN_MAP_VERSION="nuplan-maps-v1.0"' >> ~/.bashrc \
 && echo 'export NUPLAN_MAPS_ROOT="/navsim_workspace/dataset/maps"' >> ~/.bashrc \
 && echo 'export NAVSIM_EXP_ROOT="/navsim_workspace/exp"' >> ~/.bashrc \
 && echo 'export NAVSIM_DEVKIT_ROOT="/navsim_workspace/GTRS_SB"' >> ~/.bashrc \
 && echo 'export OPENSCENE_DATA_ROOT="/navsim_workspace/dataset"' >> ~/.bashrc \
 && echo 'export NAVSIM_TRAJPDM_ROOT="/navsim_workspace/dataset/traj_pdm_v2"' >> ~/.bashrc
```
安装环境
```sh
git clone https://github.com/superboySB/GTRS

cd GTRS && pip install -e .
```