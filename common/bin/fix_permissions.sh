#!/bin/sh
# Fix permissions on the given directory to allow group read/write of 
# regular files and execute of directories.
find $1 -exec chgrp 0 {} \;
find $1 -exec chmod g=u {} \;
find $1 -exec chmod g+rw {} \;
find $1 -type d -exec chmod g+x {} +