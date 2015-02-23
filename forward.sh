#!/bin/bash

trap "shut_down" SIGKILL SIGTERM SIGHUP SIGINT EXIT

shut_down(){
  printf "%s\n" "Caught SIGTERM signal!" 
  kill -TERM $child 2>/dev/null
}

ADDR=${1:-$FORWARD_ADDR}
exec socat TCP-LISTEN:10000,fork TCP:$ADDR

child=$! 
wait $child
