#!/usr/bin/env bash

# Checks that "clickhouse-client/local --help" prints a brief summary of CLI arguments and "--help --verbose" prints all possible CLI arguments
CUR_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=../shell_config.sh
. "$CUR_DIR"/../shell_config.sh

FILE=${CLICKHOUSE_TMP}/${CLICKHOUSE_DATABASE}.sql
echo "SELECT 'Hello from a file'" > ${FILE}

# The best way to write the query parameter, explicit long option.
${CLICKHOUSE_BINARY} --query "SELECT 1"

# Shorthand option:
${CLICKHOUSE_BINARY} -q "SELECT 2"

# It is also accepted as a positional argument 
${CLICKHOUSE_BINARY} "SELECT 3"

# The positional argument can go after normal arguments.
${CLICKHOUSE_BINARY} --param_test Hello "SELECT {test:String}"

# Queries can be read from a file.
${CLICKHOUSE_BINARY} --queries-file ${FILE}

# Or from stdin.
${CLICKHOUSE_BINARY} < ${FILE}

# Also, if a file contains a dot, the positional argument can be interpreted as a file.
${CLICKHOUSE_BINARY} ${FILE}

# This is ambiguous: currently works, but does not have to.
${CLICKHOUSE_BINARY} --query "SELECT 1" "SELECT 2"

# Multiple positional arguments are not allowed.
${CLICKHOUSE_BINARY} "SELECT 1" "SELECT 2" 2>&1 | grep -o -F 'is not supported'

# This is ambiguous - in case of a single word, it can be confused with a tool name.
${CLICKHOUSE_BINARY} "SELECT" 2>&1 | grep -o -F 'Use one of the following commands'

# Everything works with clickhouse/ch/chl and also in clickhouse-local and clickhouse-client.

${CLICKHOUSE_LOCAL} --query "SELECT 1"
${CLICKHOUSE_LOCAL} -q "SELECT 2"
${CLICKHOUSE_LOCAL} "SELECT 3"
${CLICKHOUSE_LOCAL} --param_test Hello "SELECT {test:String}"
${CLICKHOUSE_LOCAL} --queries-file ${FILE}
${CLICKHOUSE_LOCAL} < ${FILE}
${CLICKHOUSE_LOCAL} ${FILE}

${CLICKHOUSE_CLIENT} --query "SELECT 1"
${CLICKHOUSE_CLIENT} -q "SELECT 2"
${CLICKHOUSE_CLIENT} "SELECT 3"
${CLICKHOUSE_CLIENT} --param_test Hello "SELECT {test:String}"
${CLICKHOUSE_CLIENT} --queries-file ${FILE}
${CLICKHOUSE_CLIENT} < ${FILE}
${CLICKHOUSE_CLIENT} ${FILE}

rm ${FILE}
