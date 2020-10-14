#!/bin/bash

KUBECONFIG=""
TTYD_PORT=${TTYD_PORT:-8080}
TTYD_USERNAME=${TTYD_USERNAME:-"root"}
TTYD_PASSWORD=${TTYD_PASSWORD:-"password"}
START_CMD=${START_CMD:-"zsh"}
for entry in `ls ~/.kube/*.yaml`
do
  KUBECONFIG=${KUBECONFIG}${entry}:
done
export KUBECONFIG=${KUBECONFIG}
ttyd --port ${TTYD_PORT} --credential ${TTYD_USERNAME}:${TTYD_PASSWORD} ${START_CMD}
