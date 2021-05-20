load test_helper

@test "things show --id= option is required" {
  run things show
  assert_output "Error: Must specify --id=ID or query"
}

@test "things show --filter= option" {
  run things show --id=1 --filter="foo/bar"
  assert_output --partial "filter=$(urlencode "foo/bar")&"
}

@test "things show accepts input query" {
  run things show "foo bar"
  assert_output --partial "query=$(urlencode "foo bar")&"
}

@test "things show accepts input query from stdin" {
  show() {
    echo "foo bar baz" | things show -
  }

  run show

  assert_output --partial "query=$(urlencode "foo bar baz")&"
}
