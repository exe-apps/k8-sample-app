docker build -t cruzee/k8-sample-app-client:latest -t cruzee/k8-sample-app-client:$SHA -f ./client/Dockerfile ./client
docker build -t cruzee/k8-sample-app-server:latest -t cruzee/k8-sample-app-server:$SHA -f ./server/Dockerfile ./server
docker build -t cruzee/k8-sample-app-worker:latest -t cruzee/k8-sample-app-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cruzee/k8-sample-app-client:latest
docker push cruzee/k8-sample-app-server:latest
docker push cruzee/k8-sample-app-worker:latest

docker push cruzee/k8-sample-app-client:$SHA
docker push cruzee/k8-sample-app-server:$SHA
docker push cruzee/k8-sample-app-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=cruzee/k8-sample-app-client:$SHA
kubectl set image deployments/server-deployment server=cruzee/k8-sample-app-server:$SHA
kubectl set image deployments/worker-deployment worker=cruzee/k8-sample-app-worker:$SHA