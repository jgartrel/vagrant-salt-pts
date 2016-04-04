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
{%- if pts.symlink_repo %}
  file.symlink:
    - name: {{ pts.home }}/.phoronix-test-suite
    - target: {{ pts.repo }}
    - user: {{ pts.user }}
{%- else %}
  git.latest:
    - name: {{ pts.repo }}
    - target: {{ pts.home }}/.phoronix-test-suite
    - submodules: True
    - user: {{ pts.user }}
    - require:
      - pkg: git
{%- endif %}
  cmd.run:
    - name: ./phoronix-test-suite enterprise-setup
    - cwd: {{ pts.home }}/.phoronix-test-suite/pts
    - user: {{ pts.user }}
    - creates: {{ pts.home }}/.phoronix-test-suite/core.pt2so

build_tests:
{%- if pts.symlink_repo %}
  cmd.run:
    - name: ./phoronix-test-suite install {{ pts.test_suite }}
    - cwd: {{ pts.home }}/.phoronix-test-suite/pts
    - user: {{ pts.user }}
    - creates: {{ pts.home }}/.phoronix-test-suite/installed-tests/local
{%- else %}
  cmd.wait:
    - name: ./phoronix-test-suite force-install {{ pts.test_suite }}
    - cwd: {{ pts.home }}/.phoronix-test-suite/pts
    - user: {{ pts.user }}
    - watch:
        - git: af-pts-repo
{%- endif %}
