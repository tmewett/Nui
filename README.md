# Nui

Nui is a set of configurations and programs that is designed to give a modern, well-designed, and desktop-integrated terminal experience across Linux and macOS.

Default configuration of lots of shells and command-line tools are often unconventional, dated, dangerous, or otherwise user-unfriendly. They are clunky to use and poorly integrate with the modern GUI desktop environment. It is harder than it needs to be to start interacting with and learning via the terminal.

Nui attempts to fix this, by providing new, easy-to-use defaults suitable for beginners or the time-constrained.

## Features

* based on Fish, a friendly shell with many usability enhancements over Bash
* better text editor integration
* smart trash / recycle bin `rm` integration
* easily open GUI apps and new terminal windows
* auto-detection of macOS, Xfce, GNOME, (TODO tmux)
* better help experience; tools for `--help` and `man`
* fast file and history search keyboard shortcuts, with fzf
* usability tweaks to misc. tools

### Desktop-aware
Nui knows you probably have a GUI desktop, and has lots of useful changes to take advantage of this.

`x` and `t` start programs in new windows:

    # Start programs fully detached from the terminal
    # (Much easier to type than `nohup ... &>/dev/null &`)
    x firefox

    # Start commands in new terminals
    t ./long-running-script.sh

    # Or open a new window in the cwd
    t

### File-first
In GUI desktops, it's conventional to find or select a file first, and then decide what you want to do with it. There is also the notion of a *default program* for a file type.

In shells, it's the opposite; you have to type a command first, then an argument. This means, when exploring files e.g. with Tab-completion, you might have to spend time editing the first part of your command based on what you find.

The command `r` is designed to feel like the left-click of the terminal. It opens files with the desktop default program for its type, and opens directories in the default file manager.

### Smart rm
In interactive shells, `rm` sends files to the recycle bin instead of permanently deleting them, for safety. Scripts are unaffected. To really delete, use `rm!`.

### Fuzzy search for files and command history
If fzf is installed, Nui will enable its keybinds in Fish, giving you fast fuzzy searching.

### Nicer help
Lots of `--help` screens are very, very long. You often have to scroll up to find the flag you're looking for, and then your prompt is way off-screen so you can't type while refering to the help text.

`h ...` runs the given command, appended with `--help`, in a scrollable pager in a new window.

TODO `man` is also configured to open in a new window.

### EDITOR
When old-school tools need to open text editors, they look in the environment variable EDITOR for the program name. However, GUI editors and new terminal windows do not always work well when used, as they may not wait for the file to be closed like some programs expect.

Nui manages the EDITOR variable for you, and lets you configure your text editor by shell vars in a smarter way, providing extra options to create a better desktop-terminal integration.

### Misc. improvements
* less: Added small help banner
* less: Searches in show in the middle of the screen, not the very top
* df: Show sizes in MB/GB by default

## Reference

### Commands

* x
* in-terminal / t
* r
* nui-editor / e
* nui-editor-wait

See `--help` for usage.

### Keyboard commands

These are available in the shell, using fzf:

* Ctrl-T: search for file and put it on the command line
* Ctrl-R: search for command in history
* Alt-C: search for directory and cd to it
* Ctrl-O: search for a file and open it with `r` (new for Nui)

Note that [Fish already has a bunch of useful keyboard commands](https://fishshell.com/docs/current/interactive.html#shared-bindings), like:

* Alt-L lists the contents of the directory at the cursor.
* Alt-O opens the file at the cursor in a pager.
* Alt-E edit the current command line in an external editor. The editor is chosen from the first available of the $VISUAL or $EDITOR variables.
* Alt-S Prepends sudo to the current commandline. If the commandline is empty, prepend sudo to the last commandline.

### Variables

Boolean options should be set to either the strings `true` or `false`.

Command options should be set as a list, not a single string; i.e. do `set NUI_EDITOR my-cmd --my-opt`, not `set NUI_EDITOR "my-cmd --my-opt"`.

* NUI_OPENER is the command which `r` uses to open the given file or directory. Defaults: `rifle`, `open`, `xdg-open`.

* NUI_H_NEW_WINDOW sets whether `h` opens help text in a new terminal window. Default: `true`.

* NUI_RM_TRASHES sets whether `rm` moves files to the trash in user shells. *Requires 'trash-cli' to be installed on Linux.* Doesn't work on macOS yet. Default: `true`.

* NUI_TERMINAL is a command to open a new terminal window with no command. Default: Terminal.app for macOS; guesses for Xfce, GNOME.

* NUI_TERMINAL_CMD is a command to open a new terminal window with the command appended. (This is to account for any extra flags needed to run a specific command.) Default: $NUI_TERMINAL.

* NUI_EDITOR is your usual editor command. Default: `r`.

* NUI_EDITOR_WAIT is an optional extra command, which waits for the given file to be closed before continuing. Some editors provide flags which do this, e.g. `code --wait`, or `geany --new-instance`. Default: $NUI_EDITOR with a manual continue prompt.

* NUI_TERMINAL_EDITOR is for when GUI is unavailable, for example over SSH. Defaults: `nano`, `vi`.
