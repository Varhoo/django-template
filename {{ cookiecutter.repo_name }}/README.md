# {{ cookiecutter.repo_name }}

Django project generated from [Varhoo/django-template](https://github.com/Varhoo/django-template).

Author: {{ cookiecutter.author }} ({{ cookiecutter.author_email }})

Stack: Django, Django REST framework, Docker (uWSGI), Ansible, GitLab CI.

## Quick start

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

Or with Docker Compose:

```bash
docker compose up --build
```

The app listens on port 8000. Settings default to `{{ cookiecutter.package_name }}.settings` (development).

## Project layout

| Path | Purpose |
|------|---------|
| `apps/core/` | Starter Django app |
| `{{ cookiecutter.package_name }}/settings/` | `basic.py` (dev) and `production.py` |
| `bin/` | Entrypoint and helpers (`generate_secret_key.py`) |
| `ansible/` | Deploy playbooks and roles |
| `config/hosts.ini.example` | Inventory template for Ansible |

## SECRET_KEY

Cookiecutter fills `SECRET_KEY` on project creation. To generate a new one:

```bash
python bin/generate_secret_key.py
```

Put the value into `{{ cookiecutter.package_name }}/settings/basic.py` (or your production secrets store). Never commit production keys.

## Database

Development uses SQLite by default. For PostgreSQL (e.g. production):

```bash
docker run -e POSTGRES_PASSWORD=<password> --name postgresql.prod \
  -v /var/lib/postgresql/data:/var/lib/postgresql/data \
  -it -p 127.0.0.1:5432:5432 postgres
```

```sql
CREATE DATABASE <db>;
CREATE USER <user> WITH PASSWORD '<password>';
GRANT ALL PRIVILEGES ON DATABASE <db> TO <user>;
```

## Docker image

```bash
docker build -t {{ cookiecutter.repo_name }} .
```

The image runs migrations, collects static files, then starts uWSGI (`bin/docker-entrypoint.sh`). Production settings are used when `settings/production.py` is present.

## Code quality

```bash
make check
```

Runs black, isort, pylint, and refreshes `requirements.txt` via `pip-compile`.

Other Makefile targets:

| Target | Action |
|--------|--------|
| `make upgrade` | Upgrade pinned dependencies |
| `make translate` | Update and compile gettext messages |
| `make deploy` | Run Ansible release against `config/hosts.ini` |

Install git hooks once:

```bash
pre-commit install
```

## Deploy

1. Copy `config/hosts.ini.example` to `config/hosts.ini` and set hosts.
2. Adjust `ansible/group_vars/all.yml` (domain, registry, ports, paths).
3. Set production values in `{{ cookiecutter.package_name }}/settings/production.py` (`ALLOWED_HOSTS`, `CSRF_TRUSTED_ORIGINS`).
4. Release:

```bash
ansible-playbook -i config/hosts.ini ansible/release.yaml
```

Or: `make deploy`.

## CI

`.gitlab-ci.yml` runs:

1. **lint** — black + isort  
2. **build** — Docker image to the GitLab registry  
3. **test** — `manage.py test` and pylint  
4. **deploy** — manual push of the `latest` tag  
