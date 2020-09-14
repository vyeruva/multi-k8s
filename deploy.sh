docker build -t reddyshack/mult-client:$SHA -f ./client/Dockerfile ./client
docker build -t reddyshack/mult-server:$SHA -f ./server/Dockerfile ./server
docker build -t reddyshack/mult-worker:$SHA -f ./worker/Dockerfile ./worker

docker push reddyshack/multi-client:$SHA
docker push reddyshack/multi-server:$SHA
docker push reddyshack/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=reddyshack/multi-server:$SHA
kubectl set image deployments/client-deployment client=reddyshack/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=reddyshack/multi-worker:$SHA