# Default Django project

Authors: Pavel Studeník


Project is only tempalate for project. But it is possible to build and run it as dedault. For local build docker image you can use command:

```
docker build -t proj .
```

For deploying on production it is used anssbile script:

```
ansible-playbook -i config/hosts.ini deploy.yaml
```
