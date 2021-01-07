# Default Django project

Author: Pavel Studeník

Template for deploying Django project in Docker image by Ansible script to production.

Project is only template for project. But it is possible to build and run it as default.
For local build of docker image you can use command:

```
docker build -t proj .
```

For deploying on production it is used Ansible script. The file config/hosts.ini 
contains hostname of target server.

```
ansible-playbook -i config/hosts.ini deploy.yaml
```

# Create Database:

```
docker run -e POSTGRES_PASSWORD={{ password }} --name postgresql \
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
docker run -ti --rm -v $(pwd):/app -w /app coala/base:0.11 coala -n
```

Test with Selinux:

```
docker run -ti --rm -v $(pwd):/app:Z -w /app coala/base:0.11 coala -n
```
