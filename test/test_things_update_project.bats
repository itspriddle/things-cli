load test_helper

@test "things update-project --auth-token is required" {
  run things update-project
  assert_output --partial "Must specify --auth-token=token"
  assert_failure
}

@test "things update-project --id is required" {
  run things update-project --auth-token=token
  assert_output --partial "Must specify --id=id"
  assert_failure
}

@test "things update-project --area-id option" {
  run things update-project --auth-token=token --id=1 --area-id=1
  assert_output --partial "area-id=$(urlencode "1")"
  assert_success
}

@test "things update-project --area option" {
  run things update-project --auth-token=token --id=1 --area="SOME AREA"
  assert_output --partial "area=$(urlencode "SOME AREA")"
  assert_success
}

@test "things update-project --area-id takes precedence over --area" {
  run things update-project --auth-token=token --id=1 --area-id=1 --area="SOME AREA"
  assert_output --partial "area-id=$(urlencode "1")"
  refute_output --partial "area=$(urlencode "SOME AREA")"
  assert_success
}

@test "things update-project --canceled / --cancelled option" {
  run things update-project --auth-token=token --id=1 --canceled
  assert_output --partial "canceled=true"
  assert_success

  run things update-project --auth-token=token --id=1 --cancelled
  assert_output --partial "canceled=true"
  assert_success
}

@test "things update-project --canceled takes precedence over --completed" {
  run things update-project --auth-token=token --id=1 --canceled --completed
  assert_output --partial "canceled=true"
  refute_output --partial "completed=true"
  assert_success
}

@test "things update-project --completed option" {
  run things update-project --auth-token=token --id=1 --completed
  assert_output --partial "completed=true"
  assert_success

  run things update-project --auth-token=token --id=1 --cancelled
  assert_output --partial "canceled=true"
  assert_success
}

@test "things update-project --completion-date option" {
  run things update-project --auth-token=token --id=1 --completion-date="2021-05-20"
  assert_output --partial "completion-date=2021-05-20"
  assert_success
}

@test "things update-project --deadline option" {
  run things update-project --auth-token=token --id=1 --deadline="2021-05-20"
  assert_output --partial "deadline=2021-05-20"
  assert_success
}

@test "things update-project --notes option" {
  run things update-project --auth-token=token --id=1 --notes="NOTES NOTES"
  assert_output --partial "notes=$(urlencode "NOTES NOTES")"
  assert_success
}

@test "things update-project --append-notes option" {
  run things update-project --auth-token=token --id=1 --append-notes="APPEND NOTES"
  assert_output --partial "append-notes=$(urlencode "APPEND NOTES")"
  assert_success
}

@test "things update-project --prepend-notes option" {
  run things update-project --auth-token=token --id=1 --prepend-notes="PREPEND NOTES"
  assert_output --partial "prepend-notes=$(urlencode "PREPEND NOTES")"
  assert_success
}

@test "things update-project --reveal option" {
  run things update-project --auth-token=token --id=1 --reveal
  assert_output --partial "reveal=true"
  assert_success
}

@test "things update-project --tags option" {
  run things update-project --auth-token=token --id=1 --tags="tag1,tag 3,tag2"
  assert_output --partial "tags=$(urlencode "tag1,tag 3,tag2")"
  assert_success
}

@test "things update-project --add-tags option" {
  run things update-project --auth-token=token --id=1 --add-tags="tag1,tag 3,tag2"
  assert_output --partial "add-tags=$(urlencode "tag1,tag 3,tag2")"
  assert_success
}

@test "things update-project --when option" {
  run things update-project --auth-token=token --id=1 --when="2021-05-20"
  assert_output --partial "when=2021-05-20"
  assert_success
}

@test "things update-project --todo option" {
  run things update-project --auth-token=token --id=1 --todo="Todo 1" --todo="Todo 2"
  assert_output --partial "to-dos=$(join "$(urlencode "Todo 1")" "$(urlencode "Todo 2")")"
  assert_success
}

@test "things update-project accepts title as input" {
  run things update-project --auth-token=token --id=1 "New Project"
  assert_output --partial "title=$(urlencode "New Project")"
  assert_success
}

@test "things update-project accepts title and notes as input" {
  run things update-project --auth-token=token --id=1 "New Project

The notes"
  assert_output --partial "title=$(urlencode "New Project")&notes=$(urlencode "The notes")"
  assert_success
}

@test "things update-project accepts title as input via STDIN" {
  add() {
    echo "New Project" | things update-project --auth-token=token --id=1 -
  }

  run add

  assert_output --partial "title=$(urlencode "New Project")"
  assert_success
}

@test "things update-project accepts title and notes as input via stdin" {
  add() {
    { echo "New Project"; echo; echo "The notes"; } | things update-project --auth-token=token --id=1 -
  }

  run add

  assert_output --partial "title=$(urlencode "New Project")&notes=$(urlencode "The notes")"
  assert_success
}
