haproxy:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/haproxy/haproxy.cfg

## add basic configure file for HAProxy
## with more complicated deployment scenarios, this should be reworked
## perhaps etcd and confd, would be more flexible solution
/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://haproxy/files/haproxy.cfg
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: haproxy

