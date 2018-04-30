icinga_repo_required_packages:
  pkg.installed:
    - name: python-apt

icinga_repo_absent:
  pkgrepo.absent:
    - name: debmon

icinga_repo:
  pkgrepo.managed:
    - humanname: icinga2
    - name: deb http://packages.icinga.com/debian icinga-{{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/icinga2.list
    - key_url: https://packages.icinga.com/icinga.key
    - require:
      - pkg: icinga_repo_required_packages

foromer_icinga_repo:
  pkgrepo.absent:
    - ppa: formorer/icinga
