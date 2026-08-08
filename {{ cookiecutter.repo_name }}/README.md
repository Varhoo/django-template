# Default Django project

Author: Pavel Studeník

A Cookiecutter template for deploying a Django project in a Docker image using an Ansible script for production.

The project serves as a template, but it can be built and run with default settings. 
To build the Docker image locally, you can use the following command:

```
docker build -t proj .
```

For deploying in production, an Ansible script is used. The file config/hosts.ini contains the hostname of the target server.

```
ansible-playbook -i config/hosts.ini insible/release.yaml
```

# Create Database:

```
docker run -e POSTGRES_PASSWORD={{ password }} --name postgresql.prod \
           -v /var/lib/postgresql/data:/var/lib/postgresql/data \
           -it -p 127.0.0.1:5432:5432 postgres
```

# Create new user DB user:

```
CREATE DATABASE {{ db }};
CREATE USER {{ user }} WITH PASSWORD '{{ pass }}';
GRANT ALL PRIVILEGES ON DATABASE {{ db }} to {{ user }};
```

# Test:

```
make check
```

Or run the tools directly:

```
black --line-length 120 --check apps/ <package>/ bin/
isort --check-only --diff apps/ <package>/ bin/
pylint -rn -sn --disable=import-error apps <package>
```

Pre-commit hooks (black, isort, pylint) are configured in `.pre-commit-config.yaml`.
