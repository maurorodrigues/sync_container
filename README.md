# sync_container

This is a simple and rudimentar approach to synchronize tests start time being run simultaneously on multiple containers without the need of
some orchestration mechanism, just using podman - or docker - to spawn the containers.

It consists on a simple python server that waits for a POST request on port 8080 and blocks until a certain number of request - the number
of containers running the tests - perform the request. Then it unblocks all callers that can proceed to their testing roughly simultaneously.

## Running

```
podman run -e instances=<NUMBER OF CONTAINERS> sync-server
```

## Clients

Clients must do a POST request to the sync server so make sure 

```
curl --retry 6 -X POST <SYNC SERVER IP>:8080 -H 'Content-Type: application/son' -d '{}' 2>/dev/null
```
