base:
  'role:webserver':
    - match: pillar
    - configure_hosts
    - apache
  'role:loadbalancer':
    - match: pillar
    - configure_hosts
    - haproxy
