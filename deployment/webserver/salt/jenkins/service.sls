include:
  - jenkins.packages

jenkins.service:
  service.running:
    - name: jenkins
    - enable: True
    - require:
      - pkg: jenkins
    - watch:
      - pkg: jenkins

