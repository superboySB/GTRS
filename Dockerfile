FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

# Please contact with me if you have problems
LABEL maintainer="Zipeng Dai <daizipeng@bit.edu.cn>"
ENV DEBIAN_FRONTEND=noninteractive
# TODO：网络不好的话可以走代理
ENV http_proxy=http://127.0.0.1:8889
ENV https_proxy=http://127.0.0.1:8889

RUN apt-get update && apt-get install -y --no-install-recommends \
    git tmux vim gedit

WORKDIR /workspace
RUN /opt/conda/bin/python3 -m pip install --upgrade pip

COPY . /workspace/GTRS_raw
RUN cd GTRS_raw && /opt/conda/bin/python3 -m pip install -r requirements.txt
RUN cd GTRS_raw && /opt/conda/bin/python3 -m pip install --upgrade diffusers[torch]
RUN cd GTRS_raw && /opt/conda/bin/python3 -m pip install -e .

RUN echo 'export NUPLAN_MAP_VERSION="nuplan-maps-v1.0"' >> ~/.bashrc \
 && echo 'export NUPLAN_MAPS_ROOT="/workspace/GTRS_raw/dataset/maps"' >> ~/.bashrc \
 && echo 'export NAVSIM_EXP_ROOT="/workspace/GTRS_raw/exp"' >> ~/.bashrc \
 && echo 'export NAVSIM_DEVKIT_ROOT="/workspace/GTRS_raw"' >> ~/.bashrc \
 && echo 'export OPENSCENE_DATA_ROOT="/workspace/GTRS_raw/dataset"' >> ~/.bashrc \
 && echo 'export NAVSIM_TRAJPDM_ROOT="/workspace/GTRS_raw/dataset/traj_pdm_v2"' >> ~/.bashrc


# -----------------------------------------------------
RUN rm -rf /var/lib/apt/lists/* && apt-get clean
ENV GLOG_minloglevel=2
ENV MAGNUM_LOG="quiet"

# TODO：如果走了代理、但是想镜像本地化到其它机器，记得清空代理（或者容器内unset）
# ENV http_proxy=
# ENV https_proxy=
# ENV no_proxy=
CMD ["/bin/bash"]
WORKDIR /workspace
