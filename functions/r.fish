function r
    argparse "h/help" -- $argv
    or return 1

    function _print_help
        echo -n \
"Usage: r FILE
        r [DIR]

Open a file with \$NUI_OPENER (currently: $NUI_OPENER), or open a directory,
defaulting to the current directory.
"
    end

    if set -q _flag_help
        _print_help
        return
    end

    set argc (count $argv)
    if test "$argc" -eq 0
        $NUI_OPENER .
    else if test $argc -gt 1
        echo "error: too many arguments"
        return 1
    else
        $NUI_OPENER $argv[1]
    end
end
