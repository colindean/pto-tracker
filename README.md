Weekly PTO reminder
===================

OOTB assumptions:

* You are on macOS
* You are using Homebrew for package management
* You have already installed dependencies by running
  [`brew bundle`](https://github.com/Homebrew/homebrew-bundle#install)
  in this directory.
* You have [`msmtp`](https://marlam.de/msmtp/) correctly configured to use something (probably your
  company's SMTP relay used for automation) for outbound mail or know enough
  about `msmtp` to hardcode the script to do so.

Usage
-----

Put a symlink to `pto.sh` as `pto` somewhere on your `$PATH`.

In `2017-pto.ledger`, set your opening balance, if you started the year with some days leftover from 2016.

Add a new entry when you've used some PTO:

```ledger
2017-02-11 My Birthday
  PTO:Vacation      -1 days
  MyCompany

2017-07-05 Long Independence Day Weekend
  PTO:Vacation      -1 days
  PTO:PersonalChoice -2 days
  MyCompany
```

Edit `send_pto.sh` and `cx.cad.pto.plist` to customize for your name, email, and path to stuff.

Put `cx.cad.pto.plist` into `$HOME/Library/LaunchAgents` and run `launchctl load cx.cad.pto.plist` to schedule it.

Example `~/.msmtprc`
--------------------

Provided that your company has a relay that allows traffic to example.com
without authentication, probably behind a firewall or VPN:

```
defaults

logfile ~/.msmtp.log

account firstname.lastname@example.com
host smtp.example.com
port 25
protocol smtp
from firstname.lastname@example.com

account default : firstname.lastname@example.com
```
