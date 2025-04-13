FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

# install dependency
RUN apt update && \
    apt install -y curl wget git libgl1 libglib2.0-0 \
                   build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
                   libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev \
                   libxmlsec1-dev libffi-dev liblzma-dev libgoogle-perftools-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install python 3.10
USER ubuntu
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN pyenv install 3.10 && pyenv global 3.10
ENV PATH="$PYENV_ROOT/shims:$PATH"

# install 
RUN git clone https://github.com/bbrfkr/stable-diffusion-webui && git checkout docker
WORKDIR ~/stable-diffusion-webui
RUN ./webui-install.sh

