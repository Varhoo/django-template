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
ansible-playbook -i config/hosts.ini ansible/release.yaml
```

# Using

Create new project with default configuration:

```
pip install cookiecutter
cookiecutter https://github.com/Varhoo/django-template
```

# Testing
The easiest way to check code is by using predefined makefiles with bash scripts.

```
make check
```

Or execute separated command.

```
docker run -ti --rm -v $(pwd):/app -w /app coala/base:0.11 coala -an
```

