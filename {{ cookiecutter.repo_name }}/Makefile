
all: locale

check:
	black --line-length 120 --check apps/ {{ cookiecutter.package_name }}/ bin/
	isort --check-only --diff apps/ {{ cookiecutter.package_name }}/ bin/
	pylint -rn -sn --disable=import-error apps {{ cookiecutter.package_name }}
	pip-compile requirements.in -o requirements.txt

upgrade:
	pip-compile -U requirements.in -o requirements.txt

translate:
	python manage.py makemessages -a -i "venv/*"
	python manage.py compilemessages -i "venv/*"

deploy:
	ansible-playbook release.yaml -i config/hosts.ini

