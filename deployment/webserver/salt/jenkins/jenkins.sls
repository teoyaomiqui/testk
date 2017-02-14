include:
  - jenkins.extra_packages

jenkins_job:
  jenkins.present:
    - name: web
    - config: "salt://jenkins/files/job-1.xml"
    - require:
      - sls: jenkins.extra_packages

jenkins.user:
  file.managed:
    - name: /var/lib/jenkins/users/admin/config.xml
    - source: "salt://jenkins/files/user_config.xml"
    - user: jenkins
    - group: jenkins
    - mode: 644
    - template: jinja
    - watch_in:
      - service: jenkins

jenkins:
  pkgrepo.managed:
    - humanname: Jenkins repository
    - name: deb http://pkg.jenkins-ci.org/debian-stable binary/
    - key_url: https://pkg.jenkins.io/debian/jenkins-ci.org.key
    - refresh_db: true
    - file: /etc/apt/sources.list.d/jenkins.list
    - require_in:
      - pkg: jenkins
    - require:
      - sls: jenkins.extra_packages 
  pkg:
    - installed
  service.running:
    - name: jenkins
    - enable: True
    - require:
      - pkg: jenkins
    - watch:
      - pkg: jenkins

