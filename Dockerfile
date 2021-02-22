FROM pwntools/pwntools:latest
ENV TERM xterm-256color
ENV LC_ALL C.UTF-8

user root

RUN cd /etc/apt && \
    sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' sources.list

RUN apt-get update && \
    apt-get install -y gcc-multilib cmake vim

USER pwntools
# install pwndbg
WORKDIR /home/pwntools
RUN git clone https://github.com/pwndbg/pwndbg.git
WORKDIR /home/pwntools/pwndbg
RUN ./setup.sh

# install radare2
WORKDIR /home/pwntools
RUN git clone https://github.com/radare/radare2 
WORKDIR /home/pwntools/radare2 
RUN sys/install.sh

# install r2pipe
RUN pip install r2pipe
RUN pip3 install r2pipe

# install r2ghidra
RUN r2pm update
RUN r2pm -ci r2ghidra

WORKDIR /home/pwntools
CMD ["bash", "-l"]
