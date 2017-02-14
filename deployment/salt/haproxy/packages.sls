haproxy:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/haproxy/haproxy.cfg

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://haproxy/files/haproxy.cfg
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: haproxy

