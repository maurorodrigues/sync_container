# sync_container

This is a simple and rudimentar approach to synchronize tests start time being run simultaneously on multiple containers without the need of
some orchestration mechanism, just using podman - or docker - to spawn the containers.

It consists on a simple python server that waits for a POST request on port 8080 and blocks until a certain number of request - the number
of containers running the tests - perform the request. Then it unblocks all callers that can proceed to their testing roughly simultaneously.


## How To build the container image

I wrote this with `buildah` in mind instead of `docker build`. To build the container image:

```
./sync_container.sh
```

## Running

```
podman run -e instances=<NUMBER OF CONTAINERS> sync-container
```

## Clients

Clients must do a POST request to the sync server so make sure 

```
curl --retry 6 -X POST <SYNC SERVER IP>:8080 -H 'Content-Type: application/son' -d '{}' 2>/dev/null
```
