#!/bin/bash

set -eu

export LOG_LEVEL="DEBUG"
export PYTHONPATH='src'
echo "No tests run, please specify 'pytest' or 'coverage' in cookiecutter.unit_test_style"
flake8 src
