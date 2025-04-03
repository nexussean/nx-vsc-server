#!/bin/bash
if [ -n "$HASHED_PASSWORD_B64" ]; then
  export HASHED_PASSWORD=$(echo "$HASHED_PASSWORD_B64" | base64 -d)
fi

exec /init  # this runs the default LinuxServer startup
