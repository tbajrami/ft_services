minikube delete
minikube start --driver=docker

#INSTALL METALLB
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f config.yaml

#INSTALL NGINX
eval $(minikube docker-env)
docker build -t s-nginx ./srcs/nginx
docker build -t s-wordpress ./srcs/wordpress
kubectl apply -f nginx.yaml
kubectl apply -f wordpress.yaml

#RUNNING DASHBOARD
#minikube dashboard &