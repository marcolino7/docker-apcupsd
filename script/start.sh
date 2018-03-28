#!/bin/bash

# Start Apache2 Service
service apache2 start

# Start apcupsd
service apcupsd start

# Running Python
/usr/bin/python2.7 /usr/bin/apcupsd-json

# Running Bash
/bin/bash