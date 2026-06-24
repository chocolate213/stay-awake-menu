#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HELPER="$ROOT_DIR/StayAwakeMenu/Resources/Scripts/stay-awake"

assert_eq() {
  local expected="$1"
  local actual="$2"
  local message="$3"

  if [[ "$actual" != "$expected" ]]; then
    printf 'not ok - %s\n' "$message" >&2
    printf 'expected: %s\nactual:   %s\n' "$expected" "$actual" >&2
    exit 1
  fi
}

with_fake_caffeinate() {
  local temp_dir
  temp_dir="$(mktemp -d)"
  trap 'rm -rf "$temp_dir"' RETURN

  cat >"$temp_dir/caffeinate" <<'SCRIPT'
#!/usr/bin/env bash
printf '%s\n' "$*" >"$FAKE_CAFFEINATE_ARGS"
SCRIPT
  chmod +x "$temp_dir/caffeinate"

  FAKE_CAFFEINATE_ARGS="$temp_dir/args" PATH="$temp_dir:$PATH" "$@"
  cat "$temp_dir/args"
}

test_watch_pid_for_indefinite_run() {
  local args
  args="$(with_fake_caffeinate "$HELPER" --quiet --watch-pid 12345)"

  assert_eq "-dimsu -w 12345" "$args" "passes watch pid to caffeinate for indefinite runs"
}

test_watch_pid_for_timed_run() {
  local args
  args="$(with_fake_caffeinate "$HELPER" --quiet --watch-pid 12345 --time 2m)"

  assert_eq "-dimsu -w 12345 -t 120" "$args" "passes watch pid and duration to caffeinate"
}

test_watch_pid_rejects_non_numeric_value() {
  local temp_dir
  temp_dir="$(mktemp -d)"
  trap 'rm -rf "$temp_dir"' RETURN

  cat >"$temp_dir/caffeinate" <<'SCRIPT'
#!/usr/bin/env bash
exit 0
SCRIPT
  chmod +x "$temp_dir/caffeinate"

  if PATH="$temp_dir:$PATH" "$HELPER" --quiet --watch-pid nope >/dev/null 2>&1; then
    printf 'not ok - rejects non-numeric watch pid\n' >&2
    exit 1
  fi
}

test_watch_pid_for_indefinite_run
test_watch_pid_for_timed_run
test_watch_pid_rejects_non_numeric_value
printf 'ok - stay-awake helper tests\n'
