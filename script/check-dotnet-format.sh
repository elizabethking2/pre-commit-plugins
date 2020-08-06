#!/usr/bin/env bash
# shellcheck source=../lib/setup.sh
source "$(dirname "${BASH_SOURCE[0]}")/../lib/setup.sh" || exit "${EXIT_FAILED_TO_SOURCE}"

# It's legitimate for a linter to exit non-zero; some indicate success-but-lint that way.
set +o errexit

# Skip bash stack-trace, otherwise our bash stack-traces clutter up the output.
export SKIP_BASH_STACKTRACE=1

if [ $# -eq 0 ]; then
  # Run dotnet-format on entire repository
  exec dotnet-format --check . --folder
else
  # Run dotnet-format on the directories of any C# project files found
  for PROJ in "${@}"; do
    dotnet-format --check "$(dirname $PROJ)"
  done
fi
