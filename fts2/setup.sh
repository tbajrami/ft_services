minikube delete > /dev/null
echo all traces of minikube deleted
minikube start --driver=docker > /dev/null
echo minikube is running...

#RETRIEVE MINIKUBE IP FOR SETUP
kubectl describe service kubernetes \
| grep Endpoints | tr ':' '\n' | sed -n '2p' | tr -d ' ' > ip.txt
sed -i "s/IPXX/$(sed 's:/:\\/:g' ip.txt)/" srcs/config.yaml
sed -i "s/IPXX/$(sed 's:/:\\/:g' ip.txt)/" srcs/config.yaml
sed -i "s/IPXX/$(sed 's:/:\\/:g' ip.txt)/" srcs/nginx/nginx.conf
sed -i "s/IPXX/$(sed 's:/:\\/:g' ip.txt)/" srcs/nginx/nginx.conf
sed -i "s/IPXX/$(sed 's:/:\\/:g' ip.txt)/" srcs/ftps/vsftpd.conf

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
echo WORDPRESS LOGINS : wordpress/wordpress/password/mysql/wp_ THEN tedd/password
echo PHPMYADMIN LOGINS : wordpress/password
echo GRAFANA LOGINS : admin/admin THEN skip
echo FTPS LOGINS : user/password

#RUNNING DASHBOARD
minikube dashboard &