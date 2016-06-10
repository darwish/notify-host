#!/bin/bash

# `notify-host` command wrapper.
# This function wraps commands and calls `notify-host` when they complete.
#
# The title of the prompt sent to `notify-host` reflects whether or not the
# command exited successfully, and includes the time it took for the command
# to run. The message sent will be the entire command that was run.
#
# The exit code of this function will be the exit code of the command.
#
# E.g.
#    $> notify my-long-running-command
#       # Prompt gives: "Task Complete (50.32s)" "my-long-running-command"
function notify() {
    args=$@

    # Record time command was started
    start=$(date +%s.%N)

    # Run command itself
    "$@"

    # Capture exit code of command
    ret=$?

    # Record time command finished
    end=$(date +%s.%N)

    # Calculate and format nicely the time that the command took to run
    time=$(printf %.2f $(echo "$end - $start" | bc))

    # Run notify-host with the results of the command. The title of the prompt
    # will be different depending on whether the command was successful or not.
    if [[ $ret -eq 0 ]]; then
        notify-host -m "$args" -p "Task Complete (${time}s)"
    else
        notify-host -m "$args" -p "Task Failed (${time}s)" -t error
    fi

    # Return the command's exit code so that scripts will know whether or not
    # to continue.
    return $ret
}

# Sample notify function.
# Wraps call to mysql command line client with `notify` function to alert
# the user when the query has finished running.
#
# E.g.
#     $> db "select count(*) from mydb.users;"
#     $> echo "select count(*) from mydb.users;" | db
#
# function db() {
# 	sql=${1:-$(cat)} # Take first arg if passed, otherwise take stdin
# 	echo "$sql" | notify mysql -uuser -ppass
# }