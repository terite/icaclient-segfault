#/usr/bin/env bash
set -euo pipefail

# build once for logs
docker build .

# build again for the hash
IMAGE=$(docker build -q .)

docker run \
  --publish "5920:5920" \
  --interactive \
  --tty \
  "$IMAGE"
