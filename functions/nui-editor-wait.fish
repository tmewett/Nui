function nui-editor-wait
    # TODO help

    if not set -q _NUI_GRAPHICAL
        $NUI_TERMINAL_EDITOR $argv
    else if set -q NUI_EDITOR_WAIT
        $NUI_EDITOR_WAIT $argv
    else
        echo "Editing file - press Enter when done"
        $NUI_EDITOR $argv
        read -p "" > /dev/null
    end
end
