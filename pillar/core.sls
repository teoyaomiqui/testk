hosts:
  - hostname: web-1
    ip: 192.168.12.20
    role: web_server
    ram: 1024
  - hostname: web-2
    ip: 192.168.12.21
    role: web_server
    ram: 1024
  - hostname: loadbalancer-1
    ip: 192.168.12.30
    role: load_balancer
    ram: 1024
  - hostname: monitor-1
    ip: 192.168.12.41
    ram: 4096
    role: monitor
