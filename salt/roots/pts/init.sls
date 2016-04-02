{% from "pts/map.jinja" import pts with context %}

include:
  - build_utilities
  - git

phoronix-test-suite:
  pkg.installed:
    - pkgs: {{ pts.pkgs|json }}
  user.present:
    - name: {{ pts.user }}
    - home: {{ pts.home }}

af-pts-repo:
  git.latest:
    - name: {{ pts.repo }}
    - target: {{ pts.home }}/.phoronix-test-suite
    - submodules: True
    - user: {{ pts.user }}
    - require:
      - pkg: git
