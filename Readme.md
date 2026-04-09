# IPFS testbed

## Testing

```bash
docker compose up --build -d
bash test_basic_auth.sh 
```

## How to generate a cluster secret for IPFS cluster

```bash
export CLUSTER_SECRET=$(od -vN 32 -An -tx1 /dev/urandom | tr -d ' \n')
echo $CLUSTER_SECRET
```
