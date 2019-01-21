
docker build -t busfahrer/multi-client:latest -t busfahrer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t busfahrer/multi-server:latest -t busfahrer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t busfahrer/multi-worker:latest -t busfahrer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push busfahrer/multi-client:latest
docker push busfahrer/multi-server:latest
docker push busfahrer/multi-worker:latest

docker push busfahrer/multi-client:$SHA
docker push busfahrer/multi-server:$SHA
docker push busfahrer/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=busfahrer/multi-server:$SHA
kubectl set image deployments/client-deployment client=busfahrer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=busfahrer/multi-worker:$SHA
