#!/bin/bash

apt install -y postgresql-client

# This script is run normally every hour my k8s cron to create a pg_dump of the database.
# The format of the dump file name includes a timestamp, and the last dump is always copied
# to the file specified in POSTGRES_DUMPLATEST env variable, default value is public_dump_latest.sql
# If needed, then the restoredb.sh script can be used to recreate the Postgres database from the
# public_dump_latest.sql dump file.
export POSTGRES_HOSTNAME=${POSTGRES_HOSTNAME:-localhost}
export POSTGRES_PORT=${POSTGRES_PORT:-5432}
export POSTGRES_USER=${POSTGRES_USER:-postgres}
export POSTGRES_DB=${POSTGRES_DB:-postgres}
export PGPASSWORD=$POSTGRES_PASSWORD
export POSTGRES_DUMPDIR=${POSTGRES_DUMPDIR:-/data/dumps}
export POSTGRES_DUMPLATEST=${POSTGRES_DUMPLATEST:-public_dump_latest.sql}

if [[ ! -d ${POSTGRES_DUMPDIR} ]]; then
  echo "Directory ${POSTGRES_DUMPDIR} not found, attempting to create directory"
  mkdir -p ${POSTGRES_DUMPDIR}
  if [ $? != 0 ]; then
    echo "Could not create directory ${POSTGRES_DUMPDIR}, cannot create dump file"
    exit 1
  fi
fi

if [[ -z ${PGPASSWORD} ]]; then
  echo "env variable POSTGRES_PASSWORD must be set to the correct Postgres password"
  echo "Use 'export POSTGRES_PASSWORD=YourPassword' to set POSTGRES_PASSWORD before running this script"
  exit 2
fi

USERS_EXISTS="SELECT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'Users');"
echo ${USERS_EXISTS} > users_exists.sql
DBEXISTS=`psql --dbname=${POSTGRES_DB} --host=${POSTGRES_HOSTNAME} --port=${POSTGRES_PORT} --username=${POSTGRES_USER} -f users_exists.sql | grep ' t'`

DUMPFILE=${POSTGRES_DUMPDIR}/`date +"public_dump-%Y-%m-%d-%H-%M.sql"`
DUMPLATEST=${POSTGRES_DUMPDIR}/${POSTGRES_DUMPLATEST}

if [[ -n ${DBEXISTS} ]]; then
  echo "Users table found, creating dump file ${DUMPFILE} and copying to ${DUMPLATEST}"
else
  echo "Users table not found, nothing to backup, pg_dump will not be run"
  exit 3
fi

echo "Creating dump file ${DUMPFILE}"
pg_dump --exclude-schema=hdb_catalog --if-exists --clean --dbname=${POSTGRES_DB} --host=${POSTGRES_HOSTNAME} --port=${POSTGRES_PORT} --username=${POSTGRES_USER} --file ${DUMPFILE}
cp -f ${DUMPFILE} ${DUMPLATEST}
rm -f users_exists.sql
