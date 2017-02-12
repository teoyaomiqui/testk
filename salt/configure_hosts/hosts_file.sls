{% for host in pillar["hosts"] %} 
{{ host["hostname"] }}: 
  host.present:
    - ip: {{ host["ip"] }}
    - names:
      - {{ host["hostname"] }}
{% endfor %}
