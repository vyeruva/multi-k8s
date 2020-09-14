docker build -t reddyshack/multi-client:latest -t reddyshack/mult-client:$SHA -f ./client/Dockerfile ./client
docker build -t reddyshack/multi-server:latest -t reddyshack/mult-server:$SHA -f ./server/Dockerfile ./server
docker build -t reddyshack/multi-worker:latest -t reddyshack/mult-worker:$SHA -f ./worker/Dockerfile ./worker

docker push reddyshack/multi-client:latest
docker push reddyshack/multi-server:latest
docker push reddyshack/multi-worker:latest

docker tag reddyshack/multi-client:latest reddyshack/mult-client:$SHA
docker tag reddyshack/multi-server:latest reddyshack/mult-server:$SHA
docker tag reddyshack/multi-worker:latest reddyshack/mult-worker:$SHA

docker push reddyshack/multi-client:$SHA
docker push reddyshack/multi-server:$SHA
docker push reddyshack/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=reddyshack/multi-server:$SHA
kubectl set image deployments/client-deployment client=reddyshack/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=reddyshack/multi-worker:$SHA