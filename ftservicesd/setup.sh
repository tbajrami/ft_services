minikube delete > /dev/null
echo all traces of minikube deleted
minikube start --driver=docker > /dev/null
echo minikube is running...

#INSTALL & CONFIGURE LOAD BALANCER
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system > /dev/null 2>&1
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml > /dev/null
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml > /dev/null
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
kubectl apply -f srcs/config.yaml > /dev/null
echo load balancer metallb is configured

#BUILD IMAGES
eval $(minikube docker-env)
docker build -t s-nginx ./srcs/nginx > /dev/null
echo nginx container built
docker build -t s-wordpress ./srcs/wordpress > /dev/null
echo wordpress container built
docker build -t s-mysql ./srcs/mysql > /dev/null
echo mysql container built
docker build -t s-phpmyadmin ./srcs/phpmyadmin > /dev/null
echo phpmyadmin container built
docker build -t s-grafana ./srcs/grafana > /dev/null
echo grafana container built
docker build -t s-influxdb ./srcs/influxdb > /dev/null
echo influxdb container built
docker build -t s-ftps ./srcs/ftps > /dev/null
echo ftps container built

#DEPLOY SERVICES
kubectl apply -f srcs/nginx.yaml > /dev/null
kubectl apply -f srcs/wordpress.yaml > /dev/null
kubectl apply -f srcs/mysql.yaml > /dev/null
kubectl apply -f srcs/phpmyadmin.yaml > /dev/null
kubectl apply -f srcs/grafana.yaml > /dev/null
kubectl apply -f srcs/influxdb.yaml > /dev/null
kubectl apply -f srcs/ftps.yaml > /dev/null
echo all services are deployed

#USER WARNING
echo
echo WORDPRESS LOGINS : wordpress/wordpress/password/mysql-service/wp_ THEN tedd/password
echo PHPMYADMIN LOGINS : wordpress/password
echo GRAFANA LOGINS : admin/admin THEN skip
echo FTPS LOGINS : user/password
echo
echo all depends on minikube ip, which may be different depending where the project is launched
echo as we are requested to work with only one IP address, it can be wrong
echo if nothing works, type "'kubectl describe svc kubernetes'", the "'Endpoints'" IP is the good one
echo then modify these files with new ip :
echo srcs/config.yaml '(range with unique IP)'
echo srcs/ftps/vsftpd '(line pasv_address)'
echo srcs/nginx/nginx.conf '(wordpress and phpmyadmin routes)'

#RUNNING DASHBOARD
minikube dashboard &