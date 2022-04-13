#!/bin/bash

# _term() {
#     echo "Caught SIGTERM signal!"
#     kill -TERM "$child"
# }

# trap _term SIGTERM

chmod +x ./run.sh

./srsRAN/build/srsue/src/run.sh

# child=$!

# wait "$child"