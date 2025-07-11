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
