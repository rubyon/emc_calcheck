#!/bin/bash

rm -rf /home/emc/emc_calcheck/tmp/pids/server.pid

export RBENV_ROOT="/home/emc/.rbenv"

export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

foreman start -f Procfile.dev
