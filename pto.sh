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

END=""
case "${1}" in
  f|fut|future)
    END=""
    ;;
  *)
    END="--end ${NOW}"
    ;;
esac

SCRIPT_DIR="$(cd "$(dirname "$(readlink "${BASH_SOURCE[0]}")")" && pwd)"

LEDGER_FILE="$SCRIPT_DIR/$YEAR-pto.ledger"

BEGIN="--begin '${YEAR}/01/01'"

echo "Balance:"

$LEDGER -f "$LEDGER_FILE" ${END} bal --effective --empty --force-color --color --budget

echo "Usage:"

$LEDGER -f "$LEDGER_FILE" ${END} reg --effective --empty --force-color --color --columns 72 --budget not payee "Budget transaction"

echo ""
echo "Edit $LEDGER_FILE to change things."
