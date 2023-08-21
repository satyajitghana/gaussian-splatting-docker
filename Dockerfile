FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

RUN apt update && apt install -y vim git zip cmake ninja-build
RUN apt update && apt install -y libglew-dev libassimp-dev libboost-all-dev libgtk-3-dev libopencv-dev libglfw3-dev libavdevice-dev libavcodec-dev libeigen3-dev libxxf86vm-dev libembree-dev python3-opencv

WORKDIR /opt/src

RUN git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive

WORKDIR /opt/src/gaussian-splatting
# checkout the commit in which this dockerfile is working
RUN git checkout f7a116fb1397d9842239127d39dc212f93171f70


WORKDIR /opt/src/gaussian-splatting/submodules
# install required libs
RUN pip install ./simple-knn
RUN pip install ./diff-gaussian-rasterization

WORKDIR /opt/src/gaussian-splatting/SIBR_viewers

RUN git checkout fossa_compatibility && cmake -Bbuild . -DCMAKE_BUILD_TYPE=Release -G Ninja && cmake --build build -j12 --target install

WORKDIR /opt/src/gaussian-splatting

