#!/usr/bin/env bash 
set -e 
set -o pipefail

ctr=$(buildah from fedora)
buildah config --author='Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>' $ctr
buildah config --workingdir /root $ctr

buildah run $ctr -- /bin/sh -c 'dnf install -y iproute pip; pip install futures'
buildah add $ctr ./server.py
buildah config --cmd="python3 /root/server.py" $ctr
buildah commit --rm $ctr maurosr/sync-container
