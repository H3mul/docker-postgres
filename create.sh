#!/bin/bash
set -e

run_query () {
    QUERY="${1:-}"
    [ -z "$QUERY" ] && return
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "$QUERY"
}

for i in {1..10}
do
    tuple_var="POSTGRES_CREATE_${i}"
    tuple=(${!tuple_var})
    [ "${#tuple[@]}" -eq 0 ] && continue

    db="${tuple[0]}"
    user="${tuple[1]}"
    pass="${tuple[2]}"

    run_query "CREATE DATABASE $db;"
    run_query "CREATE USER $user PASSWORD '$pass';"
    run_query "GRANT ALL PRIVILEGES ON DATABASE $db TO $user;"
done
