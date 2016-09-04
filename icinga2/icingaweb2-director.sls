{%- from "icinga2/map.jinja" import icinga2 with context %}
{%- set config = icinga2.get('icingaweb2', {}) %}

{%- set director_db_user = config.get('director_db_user', 'director') %}
{%- set director_db_password = config.get('director_db_password', 'director') %}
{%- set director_db_name = config.get('director_db_name', 'director') %}

required_packages:
  pkg.installed:
    - pkgs:
      - php5-curl

director-db-user:
  postgres_user.present:
    - name: {{ director_db_user }}
    - password: {{ director_db_password }}
    - require:
      - sls: icinga2.postgresql

director-db:
  postgres_database.present:
    - name: {{ director_db_name }}
    - owner: {{ director_db_user }}
    - owner_recurse: True
    - require:
      - postgres_user: director-db-user
