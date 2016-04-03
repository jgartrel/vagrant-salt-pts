/srv/pillar/vagrant/init.sls:
  file.managed:
    - source: salt://base/files/pillar.sls
    - template: jinja
    - makedirs: True
