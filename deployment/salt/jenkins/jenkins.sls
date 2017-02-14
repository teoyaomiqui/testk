## according to salt stack documentation python-sowftware-properties
## is correct way to go if "pkg.managed" state is used
include:
  - jenkins.extra_packages

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
    - reload_modules: true

  pkg:
    - installed
  service.running:
    - name: jenkins
    - enable: True
    - require:
      - pkg: jenkins
    - init_delay: 20
    - watch:
      - file: jenkins_user

    - mod_watch:
      - sfun: running
      - reload: true
      - force: true
      - init_delay: 20

## create jenkins definition xml file, with provided hashed password, reload jenkins service
jenkins_user:
  file.managed:
    - name: /var/lib/jenkins/users/{{ pillar["jenkins"]["user"] }}/config.xml
    - source: salt://jenkins/files/user_config.xml
    - user: jenkins
    - group: jenkins
    - mode: 644
    - template: jinja
    - makedirs: true
    - require:
      - pkg: jenkins


## create job definition xml file from template
job_xml:
  file.managed:
    - name: /tmp/job-1.xml
    - source: salt://jenkins/files/job-1.xml
    - template: jinja

## deploy template from jenkins node via http api on localhost
jenkins.create_job:
  module.run:
    - name: jenkins.create_job
    - m_name: web
    - config_xml: /tmp/job-1.xml
    - require:
      - sls: jenkins.extra_packages
      - service: jenkins
      - file: jenkins_user
      - file: job_xml
