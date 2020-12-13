##### Create a docker network, to be able to control addresses

```
docker network create --subnet=172.20.0.0/24 fortinet
```


##### build fortigate docker image from dockerfile make sure that start.sh is near Dockerfile, in the same folder.

```
docker build --tag fortigate .
```


##### docker run command with config don't forget to assign the network and an ip to the docker.

```
docker run -it --rm \
  --privileged \
  --net fortinet --ip 172.20.4.2 \
  -e VPNCONFIG=/root/fortigate/{config-file-name} \
  -v {config-directory-path}:/root/fortivpn \
  fortigate
```


##### docker run command with username and password don't forget to assign the network and an ip to the docker

```
docker run -it --rm \
  --privileged \
  --net fortinet --ip 172.20.4.2 \
  -e VPNADDR={vpn-gateway-ip} \
  -e VPNPORT={vpn-gateway-port} \
  -e VPNUSER={vpn-gateway-username} \
  -e VPNPASS={vpn-gateway-password} \
  fortigate
```
  
 ##### you need to add route on main host to route vpn traffic to the internal docker ip
```
ip ro add {vpn-subnet} via 172.20.4.2
```


 
