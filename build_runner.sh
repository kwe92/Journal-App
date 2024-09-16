#!/usr/bin/env bash
echo $(dart run build_runner build --delete-conflicting-outputs)


# Creating a Bash Script

#   - .sh file extension:

#       - informs the use that this file is a bash script

#   - shebang construct:

#       - informs the system that this is a bash script !/usr/bin/env bash

#   - make the shell script executable after saving:

#       - run the following command in your terminal: chmod +x filename

# executing a string as a command

# bellow the shebang construct type:

#   - prefix with echo and wrap the string you want to execute in your terminal with parenthesis preceded by $

#   - echo $(the_string_you_wish_to_run_as_a_terminal_command_with_the_underscores)