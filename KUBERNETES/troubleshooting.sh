systemctl status kubelet.service

kubectl get nodes

kubectl describe nodes

journalctl -u kubelet

systemctl status kubelet


systemctl status docker

kubectl describe node nodename

sudo systemctl daemon-reload
sudo systemctl restart kubelet


 Active: activating (auto-restart)



systemctl restart kubelet && systemctl status kubelet



journalctl --unit=kubelet -n 100 --no-pager


sudo swapoff -a
sudo kubeadm reset
sudo kubeadm init
systemctl status kubelet


mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

####  clean removal of kubernetes ######

sudo kubeadm reset

sudo apt purge kubectl kubeadm kubelet kubernetes-cni -y
sudo apt autoremove
sudo rm -fr /etc/kubernetes/; sudo rm -fr ~/.kube/; sudo rm -fr /var/lib/etcd; sudo rm -rf /var/lib/cni/

sudo systemctl daemon-reload

sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

# remove all running docker containers
sudo docker rm -f $(sudo docker ps -a -q)


sudo kubeadm join 10.10.10.161:6443 --token ul5j9m.7kj86xqrhna4e1tg --discovery-token-ca-cert-hash sha256:478334527b8807a95227d5da5b5661123b7e4280de21d14d35443be8f4b0d70f




###### Exploring running pods

kubectl get pods -o wide --all-namespaces  

kubectl describe pods metrics-metrics-server-5c55945f5c-mk64b -n kube-system

kubectl logs metrics-metrics-server-5c55945f5c-7lz6h -n kube-system

kubectl logs --previous metrics-metrics-server-5c55945f5c-mk64b -n kube-system

### delete pod

kubectl delete pod metrics-metrics-server-5c55945f5c-mk64b -n kube-system
 


kubectl get svc --namespace=kube-system

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
kube-dns                 ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   3h15m
metrics-metrics-server   ClusterIP   10.104.61.136   <none>        443/TCP                  46m

kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
kubectl get pods dnsutils

NAME       READY   STATUS    RESTARTS   AGE
dnsutils   1/1     Running   0          22s


kubectl exec -i -t dnsutils -- nslookup kubernetes.default

    Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   kubernetes.default.svc.cluster.local
Address: 10.96.0.1


kubectl exec -ti dnsutils -- cat /etc/resolv.conf

nameserver 10.96.0.10
search default.svc.cluster.local svc.cluster.local cluster.local
options ndots:5

sudo nano /etc/hosts

10.10.10.161 master-node
10.10.10.162 worker01
10.10.10.163 worker02


kubectl exec -i -t metrics-metrics-server-5c55945f5c-7lz6h -- nslookup worker01 -n kube-system


sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
    