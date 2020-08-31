FROM ubuntu:xenial
MAINTAINER TommyLike<tommylikehu@gmail.com>

# ttyd user and group
ARG user=ttyd
ARG group=ttyd
ARG uid=1000
ARG gid=1000

# update package
RUN apt update -y && \
    apt install -y curl && \
    apt install -y wget && \
    apt install -y git && \
    apt install -y zsh

# Install k9s
RUN curl -L https://github.com/derailed/k9s/releases/download/v0.21.7/k9s_Linux_x86_64.tar.gz -o k9s_Linux_x86_64.tar.gz && \
    tar -xvf k9s_Linux_x86_64.tar.gz && chmod +x ./k9s && mv ./k9s /usr/local/bin && rm ./k9s_Linux_x86_64.tar.gz

# Install oh my zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- -t robbyrussell

# Install ttyd
RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.6.1/ttyd_linux.x86_64 -o ttyd && \
    chmod +x ./ttyd && cp ./ttyd /usr/local/bin && rm ./ttyd

# Create user of ttyd
RUN groupadd -g ${gid} ${group} \
    && useradd -c "ttyd user" -d /home/${user} -u ${uid} -g ${gid} -m ${user}
    # && echo "ttyd ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY ./lib/.zshrc /home/${user}/
COPY ./lib/entrypoint.sh /usr/local/bin

RUN chown ${user}:${group} /usr/local/bin/k9s && chown ${user}:${group} /usr/local/bin/ttyd && \
    cp -R /root/.oh-my-zsh /home/ttyd && chown -R ${user}:${group} /home/ttyd/.oh-my-zsh && \
    chown -R ${user}:${group} /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

USER ${user}
ENV USER ${user}

ENTRYPOINT ["entrypoint.sh"]
