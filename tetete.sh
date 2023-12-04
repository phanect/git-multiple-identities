#!/usr/bin/env bash

set -eu

CONFIG_DIR="${HOME}/.config/git-multiple-identities"
CONFIG_PATH="${CONFIG_DIR}/config.json"

sleep 2

  SELECTED_IDENTITY_WITH_INDEX="$(iselect \
    --all-select --exit-no-select --strip-result --position-result \
    --name="Select identity to use in this repository." \
    "$(cat "${CONFIG_PATH}" | jq 'try .identities[] | .name + " <" + .email + ">"')${IFS}Create new identity")"
