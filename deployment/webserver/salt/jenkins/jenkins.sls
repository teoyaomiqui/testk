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
      - pkg: extra_packages 
  pkg:
    - installed

