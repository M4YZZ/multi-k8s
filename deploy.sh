docker build -t mary007/multi-client:latest -t mary007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mary007/multi-server:latest -t mary007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mary007/multi-worker:latest -t mary007/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#push the docker images to the docekr-hub
docker push mary007/multi-client:latest
docker push mary007/multi-server:latest
docker push mary007/multi-worker:latest
docker push mary007/multi-client:$SHA
docker push mary007/multi-server:$SHA
docker push mary007/multi-worker:$SHA
#apply all the configs inside k8s folder
kubectl apply -f k8s
#imperatice cmd to set the latest images on each deployment
kubectl set image deployments/server-deployment server=mary007/multi-server:$SHA
kubectl set image deployments/client-deployment client=mary007/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mary007/multi-worker:$SHA




 



