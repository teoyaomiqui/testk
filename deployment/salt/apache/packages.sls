apache2:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: apache2

## for current set up, there is no need to modify default enabled site config
## that ubuntu apache package provides

#  file.managed:
#    - name: /etc/apache2/apache2.conf
#    - source: salt://apache/files/apache2.conf
#    - template: jinja
#    - user: apache2
#    - group: apache2
#    - mode: 644
#    - require:
#      - user: apache2

## modify index.html, to display "i'am ${fqdn}"
## perhaps could use ${hostname} instead. 

apache2_index_page:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://apache/files/index.html
    - user: www-data
    - group: www-data
    - mode: 644
    - template: jinja
    - defaults:
        hostname: {{ grains['fqdn'] }}
    - require:
      - pkg: apache2

