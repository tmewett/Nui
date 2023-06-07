function nui-editor
    argparse "h/help" -- $argv
    or return 1

    function _print_help
        echo -n \
"Usage: nui-editor [FILE]

Edit a file with the configured editor, specified by environment variables:

* if in a GUI environment, NUI_EDITOR (currently: $NUI_EDITOR)
* otherwise, NUI_TERMINAL_EDITOR (currently: $NUI_TERMINAL_EDITOR)
"
    end

    if set -q _flag_help
        _print_help
        return
    end

    if not set -q _NUI_GRAPHICAL
        $NUI_TERMINAL_EDITOR $argv
    else
        $NUI_EDITOR $argv
    end
end
