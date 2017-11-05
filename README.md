# Default Django project

Authors: Pavel Studeník


Local build docker images:

```
docker build -t proj .
```

deploying by asnbile script to server
```
ansible-playbook -i config/hosts.ini deploy.yaml
```