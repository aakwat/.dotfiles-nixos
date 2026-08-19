#!/usr/bin/env bash
# Security sweep of a repo. Nothing is installed — each tool runs ephemerally.
# Usage: audit-security [path]
set -uo pipefail

cd "${1:-.}" || exit 1
echo "auditing $PWD"
failed=0

run() {
    printf '\n\033[1m── %s ──\033[0m\n' "$1"
    shift
    nix shell "nixpkgs#$1" -c "$@" || failed=1
}

# --redact keeps found secrets out of terminal scrollback
run "secrets in git history" gitleaks gitleaks detect --no-banner --redact
run "dependency CVEs" osv-scanner osv-scanner scan source .
run "static analysis" semgrep semgrep --config=auto --error .

if test "$failed" -eq 0; then
    printf '\nclean\n'
else
    printf '\nfindings above\n'
fi
exit "$failed"
