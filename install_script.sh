#!/usr/bin/bash 

# get the repo
git clone https://github.com/cmu-db/noisepage-pilot
cd noisepage-pilot

# install required python modules for package noisepage-pilot installation
python3 -m pip install --user --upgrade pip setuptools wheel build

# install noisepage-pilot requirements into ~/.local
python3 -m pip install --user --upgrade -r requirements.txt

# change this to append to ~/.bashrc or ~/.bash_profile? 
export PATH=${PATH}:${HOME}/.local/bin

# build behavior package and install all dependencies (invokes setup.py)
python3 -m build .

# run data generation
doit behavior --all
