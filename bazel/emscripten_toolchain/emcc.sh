#!/bin/bash

source $(dirname $0)/env.sh

# Workaround for what I think is a path mapping bug: hackily path map the file
# if it isn't path mapped.
# For some reason the params file isn't being path mapped and I don't know if that
# is a rule set issue or a bazel issue yet.
if [ -e $(echo "$@" | sed s/@//g) ]; then
    args="$@"
else
    args=$(echo "$@" | sed "s=bazel-out/.*/bin=bazel-out/cfg/bin=g")
fi

exec $EMSDK_PYTHON $EMSCRIPTEN/emcc.py ${args}
