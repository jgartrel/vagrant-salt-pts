{% from "build_utilities/map.jinja" import build_utilities with context %}

build_utilities:
  pkg.installed:
    - pkgs: {{ build_utilities.pkgs|json }}
