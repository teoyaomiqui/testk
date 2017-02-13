apache2:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: apache2
#  file.managed:
#    - name: /etc/apache2/apache2.conf
#    - source: salt://apache2.conf
#    - template: jinja
#    - user: apache2
#    - group: apache2
#    - mode: 644
#    - require:
#      - user: apache2

apache2_index_page:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://files/index.html
    - user: www-data
    - group: www-data
    - mode: 644
    - template: jinja
    - defaults:
        hostname: {{ grains['fqdn'] }}
    - require:
      - pkg: apache2

