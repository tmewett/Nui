# TERMCMD is used by Ranger to open a terminal.
set -gx TERMCMD in-terminal


if status is-interactive
    if type -q fzf
        # Bind Ctrl-O to quick-search and open a file with r.
        bind \co 'begin
            set -l sel (fzf --no-sort)
            and r $sel
        end'
    end
end

### Variable defaults ###

if not set -q NUI_EDITOR
    set -g NUI_EDITOR xdg-open
end

if not set -q NUI_TERMINAL_EDITOR
    if type -q nano
        set -g NUI_TERMINAL_EDITOR nano
    else if type -q vi
        set -g NUI_TERMINAL_EDITOR vi
    end
end

if not set -q NUI_OPENER
    if type -q rifle
        set -g NUI_OPENER rifle
    else if type -q open
        set -g NUI_OPENER open
    else if type -q xdg-open
        set -g NUI_OPENER xdg-open
    end
end

if not set -q NUI_RM_TRASHES
    set -g NUI_RM_TRASHES true
end

if not set -q NUI_H_NEW_TERMINAL
    set -g NUI_H_NEW_TERMINAL true
end

if not set -q NUI_TERMINAL
    if type -q wt.exe
        function __nui_wt
            wt.exe nt --title "$argv" wsl -d $WSL_DISTRO_NAME --cd (pwd) $argv
        end
        set -g NUI_TERMINAL __nui_wt
    else if type -q exo-open
        set -g NUI_TERMINAL exo-open --launch TerminalEmulator
    else if type -q gnome-terminal
        set -g NUI_TERMINAL gnome-terminal --
    else if type -q kgx  # New GNOME console
        set -g NUI_TERMINAL kgx --
    end
end

if not set -q NUI_TERMINAL_CMD
    set -g NUI_TERMINAL_CMD $NUI_TERMINAL
end

if test (uname -s) = Darwin
    set -g _NUI_MACOS
end

if set -q _NUI_MACOS; or set -q DISPLAY
    set -g _NUI_GRAPHICAL
end
