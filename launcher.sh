#!/bin/bash

_term() {
    echo "Caught SIGTERM signal!"
    kill -TERM "$child"
}

trap _term SIGTERM

./srsRAN/build/srsue/src/srsue

child=$!

wait "$child"