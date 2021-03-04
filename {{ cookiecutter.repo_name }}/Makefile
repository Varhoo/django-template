
all: locale

check:
	docker run -ti --rm -v '${CURDIR}:/app:Z' -w /app coala/base:0.11 coala -an || true
	pylint {{ cookiecutter.package_name }}
	pip-compile requirements.in -o requirements.txt

upgrade:
	pip-compile -U requirements.in -o requirements.txt

translate:
	python manage.py makemessages -a -i "venv/*"
	python manage.py compilemessages -i "venv/*"

deploy:
	ansible-playbook release.yaml -i config/hosts.ini

