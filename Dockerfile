FROM ubuntu:20.04
#FROM ubuntu:latest
LABEL MAINTAINER tuduweb<tuduweb@outlook.com>

ENV isLocal=1 isVNC=1

RUN ln -fs /bin/bash /bin/sh  #切换 sh 为bash
RUN if [[ ${isLocal} = 1 ]]; then \
		sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
		&& sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list ; \
	fi
RUN	apt-get clean \
	&& apt-get update \
	&& apt-get install git -y #-qq #quiet

# clean apt cache
RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apk/*



RUN mkdir /root/obs \
	&& git clone https://github.com/obsproject/obs-studio /root/obs/obs-studio  --recursive


ENV	RTT_CC=gcc OBS_ROOT=/root/obs/obs-studio

WORKDIR $OBS_ROOT
RUN ./CI/build-linux.sh --disable-pipewire


# RUN if [ ${isLocal} = 1 ]; then pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple ; fi
# RUN if [[ "$isLocal" = 1 ]]; then pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple/ ; else pip install requests ; fi

#EXPOSE 80

#RUN python -c "import tools.menuconfig; tools.menuconfig.touch_env()"
#RUN source ~/.env/env.sh && pushd bsp/$RTT_BSP && pkgs --update && popd
# scons -C bsp/$RTT_BSP
#CMD echo "----in docker----"
CMD /bin/bash
