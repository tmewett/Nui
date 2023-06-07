function x
    argparse -s "h/help" -- $argv
    or return 1

    function _print_help
        echo \
"Usage: x COMMAND...

Run a command in the background, hiding all output,
and surviving after the terminal is closed."
    end

    if set -q _flag_help
        _print_help
        return
    end

    $argv > /dev/null 2>&1 &
    # Can't use `and` after background job, so hide error.
    disown 2> /dev/null
end
