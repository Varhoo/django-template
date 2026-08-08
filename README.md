# django-template

Cookiecutter template for a Docker-ready Django project with Ansible deployment and GitLab CI.

Author: Pavel Studeník

## What you get

A generated project includes:

- Django + Django REST framework on Python 3.13
- `apps/core` starter app with basic views and tests
- Docker image (Alpine + uWSGI) and `docker-compose` for local runs
- Split settings (`basic` / `production`)
- Ansible playbooks for registry publish and host deploy
- GitLab CI: lint → build → test → manual image push
- Code quality: black, isort, pylint, pre-commit
- `bin/generate_secret_key.py` for Django `SECRET_KEY` values

## Create a project

```bash
pip install cookiecutter
cookiecutter https://github.com/Varhoo/django-template
```

Prompts cover author, repo name, and package name (dashes become underscores). After generation, a unique `SECRET_KEY` is written into settings.

## Next steps

See the generated project's `README.md` for local development, Docker, database setup, and production deploy.
