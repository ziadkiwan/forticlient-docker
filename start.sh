run chmod +x start.sh
CMD [ "/start.sh" ]


#create a start.sh script file
#!/bin/sh

if [ -z "$VPNCONFIG" ] && [ -z "$VPNPORT" -o -z "$VPNADDR" -o -z "$VPNUSER" -o -z "$VPNPASS" ]; then
  echo "Variables VPNCONFIG OR VPNPORT,VPNADDR, VPNUSER and VPNPASS must be set."; exit;
fi

export VPNTIMEOUT=${VPNTIMEOUT:-5}

# Setup masquerade, to allow using the container as a gateway
for iface in $(ip a | grep eth | grep inet | awk '{print $2}'); do
  iptables -t nat -A POSTROUTING -s "$iface" -j MASQUERADE
done
if [ -z "$VPNCONFIG" ]; then
 openfortivpn $VPNADDR:$VPNPORT -u $VPNUSER -p $VPNPASS
else
 openfortivpn -c $VPNCONFIG
fi
