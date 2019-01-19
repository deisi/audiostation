#!/Bin/bash
# Build and bring up a docker container

docker-compose -f $compose_file build
docker-compose up -d
docker-compose down
