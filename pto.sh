#!/bin/bash
BREW="/usr/local/bin/brew"
LEDGER="ledger"
if [[ -z "$(command -v $LEDGER)" ]]; then
  LEDGER="$($BREW --prefix $LEDGER)/bin/ledger"
  if [[ ! -e $LEDGER ]]; then
    echo "Cannot find ledger in path or at $LEDGER"
    exit 1
  fi
fi


YEAR="$(date +%Y)"
NOW="$(date +%Y/%m/%d)"

SCRIPT_DIR="$(cd "$(dirname "$(readlink "${BASH_SOURCE[0]}")")" && pwd)"

LEDGER_FILE="$SCRIPT_DIR/$YEAR-pto.ledger"

echo "Balance:"

$LEDGER -f "$LEDGER_FILE" --begin "$YEAR/01/01" --end "$NOW" bal --effective --empty --force-color --color

echo "Usage:"

$LEDGER -f "$LEDGER_FILE" --begin "$YEAR/01/01" --end "$NOW" reg --effective --empty --force-color --color --columns 72

echo "Edit $LEDGER_FILE to change things."
