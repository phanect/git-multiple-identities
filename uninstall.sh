#!/usr/bin/env bash

set -eu

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

INSTALLED_PATH="/usr/share/git-core/templates/hooks/post-checkout"

if [[ -e "${INSTALLED_PATH}" ]]; then
  case "$(yn_question "Do you want to delete ${INSTALLED_PATH}? If you have modified it manually, all your modification would be lost.")" in
    yes)
      sudo rm "${INSTALLED_PATH}"
      echo "Uninstallation complete."
      ;;
    no)
      echo "Uninstallation is canceled."
      exit 1
      ;;
  esac
else
  echo "git-multiple-identities is not installed."
fi
