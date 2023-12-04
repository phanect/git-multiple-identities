#!/usr/bin/env bash

set -eu

PROJECT_ROOT="$(realpath "$(dirname  -- "${BASH_SOURCE[0]}")")"

"${PROJECT_ROOT}/install.sh"
git config --global user.name "Jumpei Ogawa"
git config --global user.email "git@phanective.org"
rm -rf clamav-setup/
git clone git@github.com:phanect/clamav-setup.git
