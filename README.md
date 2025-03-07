# demo-firewall


## Scan de port TCP sans firewall
root@client:~# nmap -sS 192.168.56.10
Starting Nmap 7.93 ( https://nmap.org ) at 2025-03-07 09:28 UTC
Nmap scan report for 192.168.56.10
Host is up (0.00014s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
MAC Address: 08:00:27:57:05:D8 (Oracle VirtualBox virtual NIC)

Nmap done: 1 IP address (1 host up) scanned in 0.44 seconds

## Scan de port TCP avec firewall
root@client:~# nmap -sS 192.168.56.10
Starting Nmap 7.93 ( https://nmap.org ) at 2025-03-07 09:29 UTC
Nmap scan report for 192.168.56.10
Host is up (0.00045s latency).
Not shown: 998 filtered tcp ports (no-response)
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
MAC Address: 08:00:27:57:05:D8 (Oracle VirtualBox virtual NIC)

Nmap done: 1 IP address (1 host up) scanned in 17.56 seconds