FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

# Please contact with me if you have problems
LABEL maintainer="Zipeng Dai <daizipeng@bit.edu.cn>"
ENV DEBIAN_FRONTEND=noninteractive
# TODO：网络不好的话可以走代理
ENV http_proxy=http://127.0.0.1:8889
ENV https_proxy=http://127.0.0.1:8889

RUN apt-get update && apt-get install -y --no-install-recommends \
    git tmux vim gedit curl wget libgl1 ffmpeg libpng-dev libjpeg-dev

WORKDIR /navsim_workspace
RUN git clone https://github.com/superboySB/GTRS
WORKDIR /navsim_workspace/GTRS
RUN /opt/conda/bin/python3 -m pip uninstall -y torch 
RUN /opt/conda/bin/python3 -m pip install --upgrade pip
RUN /opt/conda/bin/python3 -m pip install --retries=10 --timeout=120 --no-cache-dir -r requirements.txt
RUN /opt/conda/bin/python3 -m pip install --upgrade diffusers[torch]
RUN /opt/conda/bin/python3 -m pip install -e .
WORKDIR /navsim_workspace/exp
WORKDIR /navsim_workspace/dataset

# -----------------------------------------------------
RUN rm -rf /var/lib/apt/lists/* && apt-get clean
ENV GLOG_minloglevel=2
ENV MAGNUM_LOG="quiet"

# TODO：如果走了代理、但是想镜像本地化到其它机器，记得清空代理（或者容器内unset）
# ENV http_proxy=
# ENV https_proxy=
# ENV no_proxy=
CMD ["/bin/bash"]
WORKDIR /navsim_workspace
