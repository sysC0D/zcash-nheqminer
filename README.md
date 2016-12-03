# zcash-nheqminer
This repo 'Zcash Miner' is optimized for Docker CPU mining.
Miner use https://github.com/nicehash/nheqminer.git (branch Linux)

## Quick Start
Just launch Docker with env variable :
```bash
docker run -d \
 -e workeruser='WebLogin.Worker' \
 -e workerpwd='WorkerPassword' \
 -e stratum='zec-eu.suprnova.cc:2142' \
 -e cpulim='2' \
 --name zcash-sysc0d sysc0d/zcash-nheqminer
```
