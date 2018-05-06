# docker-lnd
LND in docker, using official binary releases

# Usage

Create a directory as lnd base directory.
```
mkdir -p /data/lnd
```

Create lnd configuration file. Please refer to the documentation of LND project.
```
cat <<EOT >> /data/lnd/lnd.conf
[Application Options]
externalip=<your external IP address>
# Expose 10009 and 8080
rpclisten=0.0.0.0:10009
restlisten=0.0.0.0:8080

[Bitcoin]
bitcoin.active=1
bitcoin.testnet=1
bitcoin.node=bitcoind

[Bitcoind]
bitcoind.rpcuser=<bitcoind rpc user>
bitcoind.rpcpass=<bitcoind rpc password>
bitcoind.zmqpath=tcp://<bitcoind-container-ip>:28332

EOT
```

Start lnd.
```
docker run  \
    -d \
    -v /data/lnd:/root/.lnd \
    -p 9735:9735 \
    --name lnd \
    wutianji/lnd
```

Optionally, you can create a shortcut for lncli.
```
alias lncli-docker="docker run --rm -it -v /data/lnd:/root/.lnd --entrypoint /bin/lncli wutianji/lnd --rpcserver=<lnd-container-ip>:10009"
```
You need to add `--rpcserver=<lnd-container-ip>:10009` to lncli in order to access lnd within the docker.

It is recommanded to configure user-defined network, and attach lnd related containers to it. Thus you can use service name as host names.
