# NoisePage officially supports Ubuntu 20.04.
FROM ubuntu:20.04

# Suppress interactive dialog.
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update

# NoisePage Pilot requirements
RUN apt install -y sudo git python3 python3-pip python3.8-venv

# Postgres compilation requirements
RUN apt install -y bison build-essential flex libreadline-dev libssl-dev libxml2-dev libxml2-utils libxslt-dev xsltproc zlib1g-dev

# Create a non-sudo user and switch to them.
# This is because PostgreSQL binaries don't like being
# run as root, e.g., initdb.
RUN useradd --create-home --shell /bin/bash --home-dir /home/terrier -G sudo terrier
USER terrier
WORKDIR /home/terrier
RUN export PATH=${PATH}:${HOME}/.local/bin

RUN git clone https://github.com/garrisonhess/noisepage-pilot
WORKDIR /home/terrier/noisepage-pilot

# install required python modules for package noisepage-pilot installation
RUN python3 -m pip install --user --upgrade pip setuptools wheel build

# install noisepage-pilot requirements into ~/.local
RUN python3 -m pip install --user --upgrade -r requirements.txt

# build behavior package and install all dependencies (invokes setup.py)
RUN python3 -m build .

RUN ["/bin/bash"]
