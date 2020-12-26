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
# docker build -t s-nginx ./srcs/nginx
# docker build -t s-wordpress ./srcs/wordpress
# docker build -t s-mysql ./srcs/mysql
# docker build -t s-phpmyadmin ./srcs/phpmyadmin
# docker build -t s-grafana ./srcs/grafana
# docker build -t s-influxdb ./srcs/influxdb
docker build -t s-ftps ./srcs/ftps

#DEPLOY SERVICES
# kubectl apply -f nginx.yaml
# kubectl apply -f wordpress.yaml
# kubectl apply -f mysql.yaml
# kubectl apply -f phpmyadmin.yaml
# kubectl apply -f grafana.yaml
# kubectl apply -f influxdb.yaml
kubectl apply -f ftps.yaml

#RUNNING DASHBOARD
#minikube dashboard &