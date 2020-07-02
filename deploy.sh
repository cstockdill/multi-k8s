docker build -t cstockdill/multi-client:latest -t cstockdill/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cstockdill/multi-server:latest -t cstockdill/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cstockdill/multi-worker:latest -t cstockdill/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cstockdill/multi-client
docker push cstockdill/multi-server
docker push cstockdill/multi-worker
docker push cstockdill/multi-client:$SHA
docker push cstockdill/multi-server:$SHA
docker push cstockdill/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cstockdill/multi-server:$SHA
kubectl set image deployments/client-deployment client=cstockdill/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cstockdill/multi-worker:$SHA

