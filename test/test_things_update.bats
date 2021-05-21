load test_helper

@test "things update --auth-token is required" {
  run things update
  assert_output --partial "Must specify --auth-token=token"
  assert_failure
}

@test "things update --id is required" {
  run things update --auth-token=token
  assert_output --partial "Must specify --id=id"
  assert_failure
}

@test "things update --when option" {
  run things update --auth-token=token --id=1 --when="2021-05-20"
  assert_output --partial "when=2021-05-20"
  assert_success
}

@test "things update --deadline option" {
  run things update --auth-token=token --id=1 --deadline="2021-05-20"
  assert_output --partial "deadline=2021-05-20"
  assert_success
}

@test "things update --canceled takes precedence over --completed" {
  run things update --auth-token=token --id=1 --canceled --completed
  assert_output --partial "canceled=true"
  refute_output --partial "completed=true"
  assert_success
}

@test "things update --completed option" {
  run things update --auth-token=token --id=1 --completed
  assert_output --partial "completed=true"
  assert_success

  run things update --auth-token=token --id=1 --cancelled
  assert_output --partial "canceled=true"
  assert_success
}

@test "things update --checklist-item option" {
  run things update --auth-token=token --id=1 --checklist-item="ITEM 1" --checklist-item="ITEM 2"
  assert_output --partial "$(join "$(urlencode "ITEM 1")" "$(urlencode "ITEM 2")")"
  assert_success
}

@test "things update --creation-date option" {
  run things update --auth-token=token --id=1 --creation-date="2021-05-20"
  assert_output --partial "creation-date=2021-05-20"
  assert_success
}

@test "things update --completion-date option" {
  run things update --auth-token=token --id=1 --completion-date="2021-05-20"
  assert_output --partial "completion-date=2021-05-20"
  assert_success
}

@test "things update --list option" {
  run things update --auth-token=token --id=1 --list=LIST
  assert_output --partial "list=LIST"
  assert_success
}

@test "things update --list-id option" {
  run things update --auth-token=token --id=1 --list-id=1
  assert_output --partial "list-id=1"
  assert_success
}

@test "things update --list-id takes precedence over --list" {
  run things update --auth-token=token --id=1 --list-id=1 --list=LIST
  assert_output --partial "list-id=1"
  refute_output --partial "list=LIST"
  assert_success
}

@test "things update --heading option" {
  run things update --auth-token=token --id=1 --heading="THE HEADING"
  assert_output --partial "$(urlencode "THE HEADING")"
  assert_success
}

@test "things update --reveal option" {
  run things update --auth-token=token --id=1 --reveal
  assert_output --partial "reveal=true"
  assert_success
}

@test "things update --duplicate option" {
  run things update --auth-token=token --id=1 --duplicate
  assert_output --partial "duplicate=true"
  assert_success
}

@test "things update --notes option" {
  run things update --auth-token=token --id=1 --notes="NOTES NOTES"
  assert_output --partial "notes=$(urlencode "NOTES NOTES")"
  assert_success
}

@test "things update-project --append-notes option" {
  run things update --auth-token=token --id=1 --append-notes="APPEND NOTES"
  assert_output --partial "append-notes=$(urlencode "APPEND NOTES")"
  assert_success
}

@test "things update-project --prepend-notes option" {
  run things update --auth-token=token --id=1 --prepend-notes="PREPEND NOTES"
  assert_output --partial "prepend-notes=$(urlencode "PREPEND NOTES")"
  assert_success
}

@test "things update --tags option" {
  run things update --auth-token=token --id=1 --tags="tag1,tag 3,tag2"
  assert_output --partial "tags=$(urlencode "tag1,tag 3,tag2")"
  assert_success
}

@test "things add --checklist-item option" {
  run things update --auth-token=token --id=1 --checklist-item="ITEM 1" --checklist-item="ITEM 2"
  assert_output --partial "checklist-items=$(join "$(urlencode "ITEM 1")" "$(urlencode "ITEM 2")")"
  assert_success
}

@test "things add --append-checklist-item option" {
  run things update --auth-token=token --id=1 --append-checklist-item="ITEM 1" --append-checklist-item="ITEM 2"
  assert_output --partial "append-checklist-items=$(join "$(urlencode "ITEM 1")" "$(urlencode "ITEM 2")")"
  assert_success
}

@test "things add --prepend-checklist-item option" {
  run things update --auth-token=token --id=1 --prepend-checklist-item="ITEM 1" --prepend-checklist-item="ITEM 2"
  assert_output --partial "prepend-checklist-items=$(join "$(urlencode "ITEM 1")" "$(urlencode "ITEM 2")")"
  assert_success
}

@test "things update --add-tags option" {
  run things update --auth-token=token --id=1 --add-tags="tag1,tag 3,tag2"
  assert_output --partial "add-tags=$(urlencode "tag1,tag 3,tag2")"
  assert_success
}

@test "things update accepts title as input" {
  run things update --auth-token=token --id=1 "New Project"
  assert_output --partial "title=$(urlencode "New Project")"
  assert_success
}

@test "things update accepts title and notes as input" {
  run things update --auth-token=token --id=1 "New Todo

The notes"
  assert_output --partial "title=$(urlencode "New Todo")&notes=$(urlencode "The notes")"
  assert_success
}

@test "things update accepts title as input via STDIN" {
  update() {
    echo "New Todo" | things update --auth-token=token --id=1 -
  }

  run update

  assert_output --partial "title=$(urlencode "New Todo")"
  assert_success
}

@test "things update accepts title and notes as input via stdin" {
  update() {
    { echo "New Todo"; echo; echo "The notes"; } | things update --auth-token=token --id=1 -
  }

  run update

  assert_output --partial "title=$(urlencode "New Todo")&notes=$(urlencode "The notes")"
  assert_success
}
