FROM debian
LABEL maintainer="bala"

#ARG TZ=Asia/Shanghai
#ARG APT_MIRROR=mirrors.163.com
ARG DEBIAN_FRONTED=noninteractive
ARG PYTHON=python3

#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN sed -i "s/deb.debian.org/$APT_MIRROR/" /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install chromium-chromedriver || \
    apt-get -y install chromium-driver || \
    apt-get -y install chromedriver cron
RUN apt-get -y install ${PYTHON}-pip
RUN $PYTHON -m pip install selenium
RUN apt-get -y install curl wget
RUN service cron start
RUN mkdir -p /home/bala && \
    useradd -d /home/bala -u 1001 bala && \
    chown bala:bala /home/bala
USER bala
WORKDIR /home/bala
COPY /noip-renew.py /home/bala/
VOLUME ["/home/bala"]
RUN (crontab -l | grep . ; echo -e "12  3  *  *  1,3,5 python3 /home/bala/noip-renew.py \"seltecqa01\" \"Seltec2020\" \"3\"") | crontab - || true
# ENTRYPOINT ["python3", "/home/bala/noip-renew.py"]
