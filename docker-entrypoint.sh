#!/bin/bash
set -e

HTTPDUSER='www-data'
setfacl -dR -m u:"$HTTPDUSER":rwX -m u:$(whoami):rwX var
setfacl -R -m u:"$HTTPDUSER":rwX -m u:$(whoami):rwX var

php bin/console cache:clear --no-warmup
php bin/console cache:warmup

exec "$@"
