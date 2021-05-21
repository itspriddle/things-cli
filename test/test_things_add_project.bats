load test_helper

@test "things add-project can be called without options" {
  run things add-project
  assert_output "things:///add-project?"
}

@test "things add-project --area-id option" {
  run things add-project --area-id=1
  assert_output --partial "area-id=$(urlencode "1")"
  assert_success
}

@test "things add-project --area option" {
  run things add-project --area="SOME AREA"
  assert_output --partial "area=$(urlencode "SOME AREA")"
  assert_success
}

@test "things add-project --area-id takes precedence over --area" {
  run things add-project --area-id=1 --area="SOME AREA"
  assert_output --partial "area-id=$(urlencode "1")"
  refute_output --partial "area=$(urlencode "SOME AREA")"
  assert_success
}

@test "things add-project --canceled / --cancelled option" {
  run things add-project --canceled
  assert_output --partial "canceled=true"
  assert_success

  run things add-project --cancelled
  assert_output --partial "canceled=true"
  assert_success
}

@test "things add-project --canceled takes precedence over --completed" {
  run things add-project --canceled --completed
  assert_output --partial "canceled=true"
  refute_output --partial "completed=true"
  assert_success
}

@test "things add-project --completed option" {
  run things add-project --completed
  assert_output --partial "completed=true"
  assert_success

  run things add-project --cancelled
  assert_output --partial "canceled=true"
  assert_success
}

@test "things add-project --completion-date option" {
  run things add-project --completion-date="2021-05-20"
  assert_output --partial "completion-date=2021-05-20"
  assert_success
}

@test "things add-project --deadline option" {
  run things add-project --deadline="2021-05-20"
  assert_output --partial "deadline=2021-05-20"
  assert_success
}

@test "things add-project --notes option" {
  run things add-project --notes="NOTES NOTES"
  assert_output --partial "notes=$(urlencode "NOTES NOTES")"
  assert_success
}

@test "things add-project --reveal option" {
  run things add-project --reveal
  assert_output --partial "reveal=true"
  assert_success
}

@test "things add-project --tags option" {
  run things add-project --tags="tag1,tag 3,tag2"
  assert_output --partial "tags=$(urlencode "tag1,tag 3,tag2")"
  assert_success
}

@test "things add-project --when option" {
  run things add-project --when="2021-05-20"
  assert_output --partial "when=2021-05-20"
  assert_success
}

@test "things add-project --todo option" {
  run things add-project --todo="Todo 1" --todo="Todo 2"
  assert_output --partial "to-dos=$(join "$(urlencode "Todo 1")" "$(urlencode "Todo 2")")"
  assert_success
}

@test "things add-project accepts title as input" {
  run things add-project "New Project"
  assert_output --partial "title=$(urlencode "New Project")"
  assert_success
}

@test "things add-project accepts title and notes as input" {
  run things add-project "New Project

The notes"
  assert_output --partial "title=$(urlencode "New Project")&notes=$(urlencode "The notes")"
  assert_success
}

@test "things add-project accepts title as input via STDIN" {
  add() {
    echo "New Project" | things add-project -
  }

  run add

  assert_output --partial "title=$(urlencode "New Project")"
  assert_success
}

@test "things add-project accepts title and notes as input via stdin" {
  add() {
    { echo "New Project"; echo; echo "The notes"; } | things add-project -
  }

  run add

  assert_output --partial "title=$(urlencode "New Project")&notes=$(urlencode "The notes")"
  assert_success
}
