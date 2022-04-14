#!/bin/bash

# _term() {
#     echo "Caught SIGTERM signal!"
#     kill -TERM "$child"
# }

# trap _term SIGTERM

chmod +x ./run.sh

chmod 777 ./run.sh

cp ./run.sh /srsRAN/build/srsue/src/

./srsRAN/build/srsue/src/run.sh

# child=$!

# wait "$child"