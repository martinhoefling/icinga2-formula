include:
  - icinga2

enable_ido:
  cmd.run:
    - name: icinga2 feature enable syslog
    - require:
      - sls: icinga2
    - watch_in:
      - service: icinga2
    - unless: icinga2 feature list | grep Enabled | grep syslog
