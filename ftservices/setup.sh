minikube delete
minikube start --driver=docker

#INSTALL & CONFIGURE LOAD BALANCER
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f config.yaml

#BUILD IMAGES
eval $(minikube docker-env)
docker build -t s-nginx ./srcs/nginx
docker build -t s-wordpress ./srcs/wordpress
docker build -t s-mysql ./srcs/mysql
docker build -t s-phpmyadmin ./srcs/phpmyadmin
docker build -t s-grafana ./srcs/grafana
docker build -t s-influxdb ./srcs/influxdb

kubectl create namespace monitoring
kubectl create secret generic influxdb-creds \
  --from-literal=INFLUXDB_DB=monitoring \
  --from-literal=INFLUXDB_USER=user \
  --from-literal=INFLUXDB_USER_PASSWORD=<password> \
  --from-literal=INFLUXDB_READ_USER=readonly \
  --from-literal=INFLUXDB_USER_PASSWORD=<password> \
  --from-literal=INFLUXDB_ADMIN_USER=root \
  --from-literal=INFLUXDB_ADMIN_USER_PASSWORD=<password> \
  --from-literal=INFLUXDB_HOST=influxdb  \
  --from-literal=INFLUXDB_HTTP_AUTH_ENABLED=true
kubectl apply -f telegraf.yaml

#DEPLOY SERVICES
kubectl apply -f nginx.yaml
kubectl apply -f wordpress.yaml
kubectl apply -f mysql.yaml
kubectl apply -f phpmyadmin.yaml
kubectl apply -f grafana.yaml
kubectl apply -f influxdb.yaml

#RUNNING DASHBOARD
#minikube dashboard &