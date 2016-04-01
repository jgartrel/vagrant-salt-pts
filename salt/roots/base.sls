php:
  pkg.installed:
    - name: php

httpd:
  pkg.installed: []
  service.running:
    - require:
      - pkg: httpd

mysql-server:
  pkg.installed:
    - name: mariadb-server
  service.running:
    - name: mariadb
    - require:
      - pkg: mariadb-server

/var/www/html/info.php:
  file.managed:
    - contents: '<?php phpinfo();'
