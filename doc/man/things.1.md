# things 1 "Jul 2021" things "User Manuals"

## SYNOPSIS

`things` [GLOBAL OPTIONS] _COMMAND_ [OPTIONS]

## DESCRIPTION

CLI for Things 3 by Cultured Code (https://culturedcode.com/things/).

https://github.com/itspriddle/things-cli#readme

## COMMANDS

*things add*
  Adds new todos to Things.

*things update*
  Update exiting todo

*things add-project*
  Add new project.

*things update-project*
  Update exiting project.

*things show*
  Show an area, project, tag, or todo in Things.

*things search*
  Invoke and show the search screen in Things.

*things help [COMMAND]*
  Show documentation for things-cli and its subcommands.

## GLOBAL OPTIONS

`-V`, `--version`
  Print version information about things-cli and Things.

`--debug`
  Enable debug mode for things-cli.

## things add [OPTIONS] [--] [-|TITLE]

Adds new todos to Things.

If `-` is given as a title, it is read from STDIN. When titles have multiple
lines of text, the first is set as the todo's title and the remaining lines
are set as the todo's notes. Notes set this way take precedence over the
`--notes=` option.

**OPTIONS**

*--canceled*, *--cancelled*
   Whether or not the todo should be set to canceled. Default: false. Takes
   priority over completed.

*--notes*
  The text to use for the notes field of the todo. Maximum unencoded
  length: 10,000 characters.

*--show-quick-entry*
  Whether or not to show the quick entry dialog (populated with the
  provided data) instead of adding a new todo. Ignored if titles is
  specified. Default: false.

*--checklist-item=ITEM*
  Checklist item to be added to the todo. Can be specified multiple times
  to create additional checklist items (maximum of 100).

*--completed*
  Whether or not the todo should be set to complete. Default: false.
  Ignored if canceled is also set to true.

*--completion-date=<DATE>*
  ISO8601 date time string. The date to set as the completion date for the
  todo in the database. Ignored if the todo is not completed or canceled,
  or if the date is in the future.

*--creation-date=DATE*
  ISO8601 date time string. The date to set as the creation date for the
  todo in the database. Ignored if the date is in the future.

*--deadline=DATE*
  The deadline to apply to the todo.

*--heading=HEADING*
  The title of a heading within a project to add to. Ignored if a project
  is not specified, or if the heading doesn't exist.

*--list=LIST*
  The title of a project or area to add to. Ignored if list-id is present.

*--list-id=ID*
  The ID of a project or area to add to. Takes precedence over list.

*--reveal*
  Whether or not to navigate to and show the newly created todo. If
  multiple todos have been created, the first one will be shown. Ignored
  if show-quick-entry is also set to true. Default: false.

*--tags=TAG1[,TAG2,TAG3...]*
  Comma separated strings corresponding to the titles of tags. Does not
  apply a tag if the specified tag doesn't exist.

*--when=DATE|DATETIME*
  Possible values: today, tomorrow, evening, anytime, someday, a date
  string, or a date time string. Using a date time string adds a reminder
  for that time. The time component is ignored if anytime or someday is
  specified.

*--titles=TITLE1[,TITLE2,TITLE3...]*
  Use instead of title to create multiple todos. Takes priority over title
  and show-quick-entry. The other parameters are applied to all the
  created todos.

*--use-clipboard=VALUE*
  Possible values can be replace-title (newlines overflow into notes,
  replacing them), replace-notes, or replace-checklist-items (newlines
  create multiple checklist rows). Takes priority over title, notes, or
  checklist-items.

**EXAMPLES**

    things add "Finish add to Things script"

    things add "Add a todo with notes
    The first line of text is the note title and the rest of the text is
    notes."

    echo "Create a todo from STDIN" | things add -

    things add -
    Another way to create a todo from STDIN

    I can type a long form note here for my todo, then press ctrl-d...
    ^d

    things add --deadline=2020-08-01 "Ship this script"

    things add --when="2020-08-01 12:30:00" "Lunch time"

    things add --show-quick-entry \
      "Add a pending todo to the quick entry window"

## things update [OPTIONS...] [--] [-|TITLE]

Updates an existing todo identified by `--id=`.

If `-` is given as a title, it is read from STDIN. When titles have
multiple lines of text, the first is set as the todo's title and the
remaining lines are set as the todo's notes. Notes set this way take
precedence over the `--notes=` option.

**OPTIONS**

*--auth-token=TOKEN*
   The Things URL scheme authorization token. Required. See below for more
   information on authorization.

*--id=ID*
  The ID of the todo to update. Required.

*--notes=NOTES*
  The notes of the todo. This will replace the existing notes. Maximum
  unencoded length: 10,000 characters. Optional.

*--prepend-notes=NOTES*
  Text to add before the existing notes of a todo. Maximum unencoded
  length: 10,000 characters. Optional.

*--append-notes=NOTES*
  Text to add after the existing notes of a todo. Maximum unencoded
  length: 10,000 characters. Optional.

*--when=DATE|DATETIME*
  Set the when field of a todo. Possible values: today, tomorrow,
  evening, someday, a date string, or a date time string. Including a time
  adds a reminder for that time. The time component is ignored if someday
  is specified. This field cannot be updated on repeating todo.
  Optional.

*--deadline=DATE*
  The deadline to apply to the todo. This field cannot be updated on
  repeating todo. Optional.

*--tags=TAG1[,TAG2,TAG3...]*
  Comma separated strings corresponding to the titles of tags. Replaces
  all current tags. Does not apply a tag if the specified tag doesn't
  exist. Optional.

*--add-tags=TAG1[,TAG2,TAG3...]*
  Comma separated strings corresponding to the titles of tags. Adds the
  specified tags to a todo. Does not apply a tag if the specified tag
  doesn't exist. Optional.

*--completed*
  Complete a todo or set a todo to incomplete. Ignored if canceled is also
  set to true. Setting completed=false on a canceled todo will also mark
  it as incomplete. This field cannot be updated on repeating todos.
  Optional.

*--canceled*, *--cancelled*
  Cancel a todo or set a todo to incomplete. Takes priority over
  completed. Setting canceled=false on a completed todo will also mark it
  as incomplete. This field cannot be updated on repeating todos.

*--reveal*
  Whether or not to navigate to and show the updated todo. Default: false.
  Optional.

*--duplicate*
  Set to true to duplicate the todo before updating it, leaving the
  original todo untouched. Repeating todo cannot be duplicated. Default:
  false. Optional.

*--completion-date=DATE*
  ISO8601 date time string. Set the creation date for the todo in the
  database. Ignored if the date is in the future. Optional.

*--creation-date=DATE*
  ISO8601 date time string. Set the completion date for the todo in the
  database. Ignored if the todo is not completed or canceled, or if the
  date is in the future. This field cannot be updated on repeating
  todo. Optional.

*--heading=HEADING*
  The title of a heading within a project to move the todo to. Ignored if
  the todo is not in a project with the specified heading. Can be used
  together with list or list-id.

*--list=LIST*
  The title of a project or area to move the todo into. Ignored if
  `--list-id=` is present.

*--list-id=LISTID*
  The ID of a project or area to move the todo into. Takes precedence
  over `--list=`.

*--checklist-item=ITEM*
  Checklist items of the todo (maximum of 100). Will replace all existing
  checklist items. Can be specified multiple times on the command line.

*--prepend-checklist-item=ITEM*
  Add checklist items to the front of the list of checklist items in the
  todo (maximum of 100). Can be specified multiple times on the command
  line.

*--append-checklist-item=ITEM*
  Add checklist items to the end of the list of checklist items in the
  todo (maximum of 100). Can be specified multiple times on the command
  line.

**EXAMPLES**

   XXX

**SEE ALSO**

Authorization: https://culturedcode.com/things/support/articles/2803573/#overview-authorization

## things add-project [OPTIONS...] [-|TITLE]

Adds a new project to Things.

If `-` is given as a title, it is read from STDIN. When titles have
multiple lines of text, the first is set as the todo's title and the
remaining lines are set as the todo's notes. Notes set this way take
precedence over the `--notes=` option.

**OPTIONS**

*--area-id=AREAID*
  The ID of an area to add to. Takes precedence over area. Optional.

*--area=AREA*
  The title of an area to add to. Ignored if area-id is present. Optional.

*--canceled*, *--cancelled*
  Whether or not the project should be set to canceled. Default: false.
  Takes priority over completed. Will set all child todos to be canceled.
  Optional.

*--completed*
  Whether or not the project should be set to complete. Default: false.
  Ignored if canceled is also set to true. Will set all child todos to be
  completed. Optional.

*--completion-date=DATE*
  ISO8601 date time string. The date to set as the completion date for the
  project in the database. If the todos parameter is also specified, this
  date is applied to them, too. Ignored if the todo is not completed or
  canceled, or if the date is in the future. Optional.

*--deadline=DATE*
  The deadline to apply to the project. Optional.

*--notes=NOTES*
  The text to use for the notes field of the project. Maximum unencoded
  length: 10,000 characters. Optional.

*--reveal*
  Whether or not to navigate into the newly created project. Default:
  false. Optional.

*--tags=TAG1[,TAG2,TAG3...]*
  Comma separated strings corresponding to the titles of tags. Does not
  apply a tag if the specified tag doesn't exist. Optional.

*--when=DATE|DATETIME*
  Possible values: today, tomorrow, evening, anytime, someday, a date
  string, or a date time string. Using a date time string adds a reminder
  for that time. The time component is ignored if anytime or someday is
  specified. Optional.

*--todo=TITLE*
  Title of a todo to add to the project. Can be specified more than once
  to add multiple todos. Optional.

**EXAMPLES**

    things add-project "Take over the world"

## things update-project [OPTIONS...] [--] [-|TITLE]

Updates an existing project identified by `--id=`.

If `-` is given as a title, it is read from STDIN. When titles have
multiple lines of text, the first is set as the project's title and the
remaining lines are set as the project's notes. Notes set this way take
precedence over the `--notes=` option.

**OPTIONS**

*--auth-token=TOKEN*
   The Things URL scheme authorization token. Required. See below for more
   information on authorization.

*--id=ID*
  The ID of the project to update. Required.

*--notes=NOTES*
  The notes of the project. This will replace the existing notes. Maximum
  unencoded length: 10,000 characters. Optional.

*--prepend-notes=NOTES*
  Text to add before the existing notes of a project. Maximum unencoded
  length: 10,000 characters. Optional.

*--append-notes=NOTES*
  Text to add after the existing notes of a project. Maximum unencoded
  length: 10,000 characters. Optional.

*--when=DATE|DATETIME*
  Set the when field of a project. Possible values: today, tomorrow,
  evening, someday, a date string, or a date time string. Including a time
  adds a reminder for that time. The time component is ignored if someday
  is specified. This field cannot be updated on repeating projects.
  Optional.

*--deadline=DATE*
  The deadline to apply to the project. This field cannot be updated on
  repeating projects. Optional.

*--tags=TAG1[,TAG2,TAG3...]*
  Comma separated strings corresponding to the titles of tags. Replaces
  all current tags. Does not apply a tag if the specified tag doesn't
  exist. Optional.

*--add-tags=TAG1[,TAG2,TAG3...]*
  Comma separated strings corresponding to the titles of tags. Adds the
  specified tags to a project. Does not apply a tag if the specified tag
  doesn't exist. Optional.

*--area=AREA*
  The ID of an area to move the project into. Takes precedence over
  `--area=`. Optional.

*--area-id=AREAID*
  The title of an area to move the project into. Ignored if `--area-id=`
  is present. Optional.

*--completed*
  Complete a project or set a project to incomplete. Ignored if canceled
  is also set to true. Setting to true will be ignored unless all child
  todos are completed or canceled and all child headings archived. Setting
  to false on a canceled project will mark it as incomplete. This field
  cannot be updated on repeating projects. Optional.

*--canceled, --cancelled*
  Cancel a project or set a project to incomplete. Takes priority over
  completed. Setting to true will be ignored unless all child todos are
  completed or canceled and all child headings archived. Setting to false
  on a completed project will mark it as incomplete. This field cannot be
  updated on repeating projects. Optional.

*--reveal*
  Whether or not to navigate to and show the updated project. Default:
  false. Optional.

*--duplicate*
  Set to true to duplicate the project before updating it, leaving the
  original project untouched. Repeating projects cannot be duplicated.
  Default: false. Optional.

*--completion-date=DATE*
  ISO8601 date time string. Set the creation date for the project in the
  database. Ignored if the date is in the future. Optional.

*--creation-date=DATE*
  ISO8601 date time string. Set the completion date for the project in the
  database. Ignored if the project is not completed or canceled, or if the
  date is in the future. This field cannot be updated on repeating
  projects. Optional.

*--todo=TITLE*
  Title of a todo to add to the project. Can be specified more than once
  to add multiple todos. Optional.

**EXAMPLES**

    XXX

**SEE ALSO**

Authorization: https://culturedcode.com/things/support/articles/2803573/#overview-authorization

**OPTIONS**

**EXAMPLES**

## things show [OPTIONS...] [--] [-|QUERY]

Navigate to and show an area, project, tag or todo, or one of the
built-in lists, optionally filtering by one or more tags.

If `-` is given as a query, it is read from STDIN.

**OPTIONS**

*--filter=FILTER*
  Comma separated strings corresponding to the titles of tags that the
  list should be filtered by.

*--id=ID*
  The ID of an area, project, tag or todo to show; or one of the following
  built-in list IDs: inbox, today, anytime, upcoming, someday, logbook,
  tomorrow, deadlines, repeating, all-projects, logged-projects. Takes
  precedence over QUERY. Required if QUERY is not supplied.

**EXAMPLES**

    things show today

    things show inbox

    echo logbook | things show -

    things show -
    upcoming
    ^d

## things search [--] [-|QUERY]

Searches things for the specified query. if no query is specified, opens
the search window.

If `-` is given as a query, it is read from STDIN.

**EXAMPLES**

    XXX

## things help [COMMAND]

Prints documentation for things-cli commands.

## BUG REPORTS

Issues can be reported on GitHub:

<https://github.com/itspriddle/things-cli/issues>

## AUTHOR

Joshua Priddle <jpriddle@me.com>

## LICENSE

MIT License

Copyright (c) 2021 Joshua Priddle <jpriddle@me.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## SEE ALSO

open(1)
