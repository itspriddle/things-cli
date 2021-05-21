load test_helper

@test "things runs" {
  run things
  assert_output --partial "Usage: things"
  assert_success
}

@test "things -V prints version" {
  run things -V
  assert_output --partial "things-cli"
  assert_output --partial "Things3.app"
  assert_success
}

@test "things --debug enables debug mode" {
  run things --debug
  assert_output --partial "set -euo pipefail"
  assert_success
}

@test "invalid command prints error" {
  run things not-a-real-command
  assert_output --partial "Invalid command \`things not-a-real-command'"
  assert_failure
}

@test "invalid long option prints error" {
  run things --not-a-real-option
  assert_output --partial "Invalid option \`--not-a-real-option'"
  assert_failure
}

@test "invalid short option prints error" {
  run things -1
  assert_output --partial "Invalid option \`-1'"
  assert_failure
}
