#!/bin/sh
curl https://www.hs.fi/fingerpori/ | egrep '^data-srcset' | sed -E 's,^data-srcset="(.*) [0-9a-z]+"$,https:\1,' | head -n 1
