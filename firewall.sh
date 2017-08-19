#!/bin/bash

IPTABLES="/usr/sbin/iptables"

_stop()
{
  $IPTABLES -F
  $IPTABLES -X
  $IPTABLES -Z
}

_start()
{
  $IPTABLES -A INPUT -i lo -j ACCEPT
  $IPTABLES -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT

  $IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
  $IPTABLES -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
  $IPTABLES -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

  $IPTABLES -A INPUT -p icmp -j ACCEPT
  $IPTABLES -A INPUT -p udp --dport 161 -s 192.168.44.1 -j ACCEPT
  $IPTABLES -A INPUT -p tcp --dport 80 -s 192.168.44.0/24 -j ACCEPT
  $IPTABLES -A INPUT -s 192.168.44.10 -j ACCEPT
  $IPTABLES -A INPUT -s 192.168.44.5  -j ACCEPT
  $IPTABLES -A INPUT -j DROP
}

_stop
sleep 10
_start

