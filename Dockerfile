FROM ros:melodic-ros-core

MAINTAINER Yosuke Matsusaka <yosuke.matsusaka@gmail.com>

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y git python-pip ros-melodic-panda-moveit-config ros-melodic-rviz-visual-tools && \
    pip install -U --no-cache-dir supervisor supervisor_twiddler && \
    apt-get clean

RUN mkdir -p /workspace/src && \
    git clone --depth 1 -b melodic-devel https://github.com/ros-planning/moveit_tutorials.git /workspace/src/moveit_tutorials

ADD supervisord.conf /etc/supervisor/supervisord.conf

VOLUME ["/opt/ros/melodic", "/workspace/src/moveit_tutorials"]

CMD ["/usr/local/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
