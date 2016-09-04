include:
  - icinga2

enable_syslog_feature:
  cmd.run:
    - name: icinga2 feature enable syslog
    - watch_in:
      - service: icinga2
    - unless: icinga2 feature list | grep Enabled | grep syslog
