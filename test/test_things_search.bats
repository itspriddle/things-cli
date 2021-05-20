load test_helper

@test "things search accepts input query" {
  run things search "foo bar"
  assert_output --partial "query=$(urlencode "foo bar")"
}

@test "things search accepts input query from stdin" {
  search() {
    echo "foo bar baz" | things search -
  }

  run search

  assert_output --partial "query=$(urlencode "foo bar baz")"
}
