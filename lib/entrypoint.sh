#!/bin/bash

KUBECONFIG=""
TTYD_PORT=${TTYD_PORT:-8080}
TTYD_USERNAME=${TTYD_USERNAME:-""}
TTYD_PASSWORD=${TTYD_PASSWORD:-""}
START_CMD=${START_CMD:-"zsh"}
for entry in `ls ~/.kube/*.yaml`
do
  KUBECONFIG=${KUBECONFIG}${entry}:
done
export KUBECONFIG=${KUBECONFIG}

if [ -z ${TTYD_USERNAME}  ]
then
  ttyd --port ${TTYD_PORT} ${START_CMD}
else
  ttyd --port ${TTYD_PORT} --credential ${TTYD_USERNAME}:${TTYD_PASSWORD} ${START_CMD}
fi