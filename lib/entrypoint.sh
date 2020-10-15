#!/bin/bash

KUBECONFIG=""
TTYD_PORT=${TTYD_PORT:-8080}
START_CMD=${START_CMD:-"zsh"}
for entry in `ls ~/.kube/*.yaml`
do
  KUBECONFIG=${KUBECONFIG}${entry}:
done
export KUBECONFIG=${KUBECONFIG}
ttyd --port ${TTYD_PORT} ${START_CMD}
