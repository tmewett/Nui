function in-terminal
    argparse -s "h/help" -- $argv
    or return 1

    function _print_help
        echo -n \
"Usage: in-terminal [COMMAND...]
       t [COMMAND...]

Open a new terminal window, optionally with a given command.
"
        # TODO Document variables
    end

    if set -q _flag_help
        _print_help
        return
    end

    set argc (count $argv)
    if set -q _NUI_MACOS
        if test $argc -eq 0
            x open -a $NUI_TERMINAL_APP .
            return
        else
            set script (mktemp -t in-terminal)
            begin
                echo "#!/usr/bin/env fish"
                echo "rm (status filename)"
                echo "cd "(string escape -- (pwd))
                echo (string join -- ' ' (string escape -- $argv))
            end > $script
            chmod +x $script
            x open -a $NUI_TERMINAL_APP $script
            return
        end
    end

    if test $argc -eq 0
        $NUI_TERMINAL
    else
        $NUI_TERMINAL_CMD $argv
    end
end
