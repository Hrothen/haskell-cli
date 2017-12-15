#!/bin/sh
stack init
stack setup
stack build
stack test
{% if cookiecutter.git_host != "None" %}
git init
git add --all
git commit -m 'Create project skelleton'
{% endif %}
