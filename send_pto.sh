#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREW="/usr/local/bin/brew"
AHA="$($BREW --prefix aha)/bin/aha"
SENDMAIL="$($BREW --prefix msmtp)/bin/msmtp"

from="PTO Update <colin.dean@target.com>"
to="Colin Dean <colin.dean@target.com>"
subject="PTO Update for $(date +"%Y %b %d")"

(
echo "From: ${from}";
echo "To: ${to}";
echo "Subject: ${subject}";
echo "Content-Type: text/html";
echo "MIME-Version: 1.0";
echo "";
echo "$($SCRIPT_DIR/pto.sh | $AHA)";
) | ${SENDMAIL} -t
