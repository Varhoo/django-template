# Default Django project

Authors: Pavel Studeník

Template for deploying Django project in Docker image by Ansible script to production.

Project is only tempalate for project. But it is possible to build and run it as default. For local build docker image you can use command:

```
docker build -t proj .
```

For deploying on production it is used anssbile script. The file config/hosts.ini contain hostname of target server.

```
ansible-playbook -i config/hosts.ini deploy.yaml
```
