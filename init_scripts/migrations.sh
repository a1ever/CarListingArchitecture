#!/bin/bash

cd "../database" || exit

get_latest_migration() {
    local table="$1"
    local max_version="$2"
    local latest_version="0.0.0"
    local latest_script=""

    for script in V*_"$table"; do
        version=$(echo "$script" | cut -d'_' -f1 | sed 's/V//')
        if [[ "$(ver_compare "$version" "$max_version")" -le 0 && "$(ver_compare "$version" "$latest_version")" -gt 0 ]]; then
            latest_version="$version"
            latest_script="$script"
        fi
    done

    if [[ "$latest_version" == "0.0.0" ]]; then
        echo "err"
    fi
    echo "$latest_script"
}

ver_compare() {
    local v1="$1"
    local v2="$2"
    local IFS=.

    local i v1_parts v2_parts
    read -r -a v1_parts <<<"$v1"
    read -r -a v2_parts <<<"$v2"

    for i in 0 1 2; do
        local num1="${v1_parts[i]}"
        local num2="${v2_parts[i]}"

        num1="${num1:-0}"
        num2="${num2:-0}"

        if ((num1 != num2)); then
            ((num1 > num2)) && echo 1 || echo -1
            return
        fi
    done

    echo 0
}

run_migrations() {
    local table="$1"
    local migration_script="$2"
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f "$migration_script"
}


max_version="${MIGRATIONS_VERSION:-999.999.999}"

if [[ "$MIGRATIONS_VERSION" == "latest" ]]; then
    max_version="999.999.999"
fi

# Loop through unique table names sorted by length so all tables greate in valid order
for table in $(find . -maxdepth 1 -type f -name 'V*_*' | cut -d'_' -f2 | sort -u | awk '{print length, $0}' | sort -n | cut -d' ' -f2-); do
    latest_migration=$(get_latest_migration "$table" "$max_version")
    if [ "$latest_migration" == "err" ]; then
      break
    fi
    run_migrations "$table" "$latest_migration"
done


bash "create_users.sh"