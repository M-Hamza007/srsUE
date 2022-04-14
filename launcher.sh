#!/bin/bash

# _term() {
#     echo "Caught SIGTERM signal!"
#     kill -TERM "$child"
# }

# trap _term SIGTERM

chmod +x ./run.sh

cp ./run.sh /srsRAN/build/srsue/src/

ip netns add ue1

./srsRAN/build/srsue/src/run.sh

# child=$!

# wait "$child"