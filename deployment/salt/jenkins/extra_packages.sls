## reload modules after installing new python package
extra_packages:
  pkg.installed:
    - pkgs:
      - python-software-properties
    - reload_modules: true

