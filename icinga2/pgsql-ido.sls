include:
  - icinga2.postgresql
  - icinga2

debconf_enable_pgsql_ido:
  debconf.set:
    - name: icinga2-ido-pgsql
    - data:
        'icinga2-ido-pgsql/dbconfig-install': {'type': 'boolean', 'value': 'true'}

debconf_dbconfig_pgsql_ido:
  debconf.set:
    - name: icinga2-ido-pgsql
    - data:
        'icinga2-ido-pgsql/enable': {'type': 'boolean', 'value': 'true'}

debconf_dbconfig_pgsql_dbname:
  debconf.set:
    - name: icinga2-ido-pgsql
    - data:
        'icinga2-ido-pgsql/db/dbname': {'type': 'string', 'value': 'icinga'}

icinga2-ido-pgsql:
  pkg.installed:
    - require:
      - debconf: debconf_enable_pgsql_ido
      - debconf: debconf_dbconfig_pgsql_ido
      - debconf: debconf_dbconfig_pgsql_dbname
      - pkg: icinga2
      - pkg: postgresql_packages_for_icinga_ido
    - watch_in:
      - service: icinga2

enable_ido:
  cmd.run:
    - name: icinga2 feature enable ido-pgsql
    - require:
      - pkg: icinga2-ido-pgsql
    - watch_in:
      - service: icinga2

/etc/dbconfig-common/icinga-idoutils.conf:
  file.symlink:
    - target: icinga2-ido-pgsql.conf
    - require:
      - pkg: icinga2-ido-pgsql
