#!/usr/bin/env bash

set -eu

PROJECT_ROOT="$(realpath "$(dirname  -- "${BASH_SOURCE[0]}")")"

SRC_PATH="${PROJECT_ROOT}/files/post-checkout"
DEST_PATH="/usr/share/git-core/templates/hooks/post-checkout"

function yn_question() {
  MSG="$1"
  read -p "$MSG ([Y]es or [n]o):" < /dev/tty # See: https://stackoverflow.com/a/38484237
  SELECTED="$(echo "${REPLY}" | tr "[A-Z]" "[a-z]")"

  if [[ -z "${SELECTED}" ]]; then
    SELECTED="yes"
  fi

  case "${SELECTED}" in
    y|yes)
      echo "yes"
      ;;
    n|no)
      echo "no"
      ;;
    *)
      echo "Please enter one of 'y', 'yes', 'n', or 'no'. (Case insensitive)" > /dev/stderr
      echo "$(yn_question "$MSG")"
      ;;
  esac
}

echo "To install git-multiple-identities, this script requires sudo permission."
sudo echo "" &> /dev/null

if [[ -e "${DEST_PATH}" ]]; then
  case "$(yn_question "Do you want to overwrite existing ${DEST_PATH}?")" in
    yes)
      sudo rm "${DEST_PATH}"
      ;;
    no)
      echo "Installation is canceled."
      exit 1
      ;;
  esac
fi

sudo cp "${SRC_PATH}" "${DEST_PATH}"
sudo chmod +x "${DEST_PATH}"

if ! type jq || ! type uuid || ! type iselect; then
  if type apt-get; then
    sudo apt-get install --yes jq uuid iselect || echo "This script requires 'jq', 'uuid', and 'iselect' commands. Please install them manually."
  else
    echo "This script requires 'jq', 'uuid', and 'iselect' commands. Please install them manually."
  fi
fi

echo "Installation complete."
