#!/bin/bash
# Go related env configuration
# Execute after installing Go

mkdir -p $HOME/go/src/github.com/cicovic-andrija
cat >> $HOME/.bashrc << 'EOF'

# Go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
EOF
