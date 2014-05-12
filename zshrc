# Created by newuser for 4.3.17

HISTFILE=$HOME/.zhistory  # History settings
HISTSIZE=1000
SAVEHIST=1000                # Default: 200

setopt   appendhistory        # multiple zsh's all append to same history file (rather than last
                              # overwrites)  SET
unsetopt banghist             # Perform textual history expansion, csh-style, treating '!' specially  SET
unsetopt cshjunkiehistory     # A history reference without an event specifier will always refer to
                              # the previous command. Without this option, such a history reference
                              # refers to the same event as the previous history reference, defaulting
                              # to the previous command  UNSET
setopt   extendedhistory      # Save each command's beginning timestamp and the duration (in seconds)
                              # to the history file  UNSET
unsetopt histallowclobber     # Add '|' to output redirections in the history. This allows history
                              # references to clobber files even when CLOBBER is unset  UNSET
unsetopt histbeep             # Beep when attempt to access a history entry which isn't there  SET
setopt   histexpiredupsfirst  # If the internal history needs to be trimmed to add the current command
                              # line, setting this option will cause the oldest history event that has
                              # a duplicate to be lost before losing a unique event from the list  UNSET
unsetopt histfindnodups       # When searching for history entries in the line editor, do not display
                              # duplicates of a line previously found, even if the duplicates are not
                              # contiguous  UNSET
unsetopt histignorealldups    # If a new command line being added to the history list duplicates an
                              # older one, the older command is removed from the list (even if it is
                              # not the previous event)  UNSET
setopt   histignoredups       # Do not enter command lines into the history list if they are
                              # duplicates of the previous event  UNSET
unsetopt histignorespace      # Remove command lines from the history list when the first character on
                              # the line is a space, or when one of the expanded aliases contains a
                              # leading space  UNSET
unsetopt histnofunctions      # Remove function definitions from the history list  UNSET
unsetopt histnostore          # Remove the history (fc -l) command from the history list when invoked  UNSET
setopt   histreduceblanks     # Remove superfluous blanks from each command line being added to the
                              # history list  UNSET
unsetopt histsavenodups       # When writing out the history file, older commands that duplicate newer
                              # ones are omitted  UNSET
setopt   histverify           # Don't execute a line with history expansion directly; reload the line
                              # into the editing buffer  UNSET
setopt   incappendhistory     # New history lines are added to the $HISTFILE incrementally (as soon as
                              # they are entered), rather than waiting until the shell is killed  UNSET
setopt   sharehistory         # Import new commands from the history file and append typed commands to
                              # the history file  UNSET
. ~/.profile 
