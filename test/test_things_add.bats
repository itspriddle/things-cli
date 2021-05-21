load test_helper

@test "things add can be called without options" {
  run things add
  assert_output --partial "show-quick-entry=true"
  assert_success
}

@test "things add --when option" {
  run things add --when="2021-05-20"
  assert_output --partial "when=2021-05-20"
  assert_success
}

@test "things add --deadline option" {
  run things add --deadline="2021-05-20"
  assert_output --partial "deadline=2021-05-20"
  assert_success
}

@test "things add --canceled takes precedence over --completed" {
  run things add --canceled --completed
  assert_output --partial "canceled=true"
  refute_output --partial "completed=true"
  assert_success
}

@test "things add --completed option" {
  run things add --completed
  assert_output --partial "completed=true"
  assert_success

  run things add --cancelled
  assert_output --partial "canceled=true"
  assert_success
}

@test "things add --checklist-item option" {
  run things add --checklist-item="ITEM 1" --checklist-item="ITEM 2"
  assert_output --partial "checklist-items=$(join "$(urlencode "ITEM 1")" "$(urlencode "ITEM 2")")"
  assert_success
}

@test "things add --creation-date option" {
  run things add --creation-date="2021-05-20"
  assert_output --partial "creation-date=2021-05-20"
  assert_success
}

@test "things add --completion-date option" {
  run things add --completion-date="2021-05-20"
  assert_output --partial "completion-date=2021-05-20"
  assert_success
}

@test "things add --list option" {
  run things add --list=LIST
  assert_output --partial "list=LIST"
  assert_success
}

@test "things add --list-id option" {
  run things add --list-id=1
  assert_output --partial "list-id=1"
  assert_success
}

@test "things add --list-id takes precedence over --list" {
  run things add --list-id=1 --list=LIST
  assert_output --partial "list-id=1"
  refute_output --partial "list=LIST"
  assert_success
}

@test "things add --heading option" {
  run things add --heading="THE HEADING"
  assert_output --partial "$(urlencode "THE HEADING")"
  assert_success
}

@test "things add --reveal option" {
  run things add --reveal
  assert_output --partial "reveal=true"
  assert_success
}

@test "things add --show-quick-entry option" {
  run things add --show-quick-entry "TITLE"
  assert_output --partial "show-quick-entry=true"
  assert_success
}

@test "things add --notes option" {
  run things add --notes="NOTES NOTES"
  assert_output --partial "notes=$(urlencode "NOTES NOTES")"
  assert_success
}

@test "things add --tags option" {
  run things add --tags="tag1,tag 3,tag2"
  assert_output --partial "tags=$(urlencode "tag1,tag 3,tag2")"
  assert_success
}

@test "things add --titles option" {
  run things add --titles="TITLE 1,TITLE 2"
  assert_output --partial "$(join "$(urlencode "TITLE 1")" "$(urlencode "TITLE 2")")"
  assert_success
}

@test "things add --use-clipboard option" {
  run things add --use-clipboard=replace-title
  assert_output --partial "use-clipboard=replace-title"
  assert_success
}

@test "things add accepts title as input" {
  run things add "New Project"
  assert_output --partial "title=$(urlencode "New Project")"
  assert_success
}

@test "things add accepts title and notes as input" {
  run things add "New Todo

The notes"
  assert_output --partial "title=$(urlencode "New Todo")&notes=$(urlencode "The notes")"
  assert_success
}

@test "things add accepts title as input via STDIN" {
  add() {
    echo "New Todo" | things add -
  }

  run add

  assert_output --partial "title=$(urlencode "New Todo")"
  assert_success
}

@test "things add accepts title and notes as input via stdin" {
  add() {
    { echo "New Todo"; echo; echo "The notes"; } | things add -
  }

  run add

  assert_output --partial "title=$(urlencode "New Todo")&notes=$(urlencode "The notes")"
  assert_success
}
