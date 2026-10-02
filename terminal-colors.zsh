# terminal-colors.zsh
# Gives every new macOS Terminal window/tab its own background color,
# rotating through a palette, so parallel sessions are easy to tell apart.
#
# https://github.com/evanroth/terminal-colors
# Evan Roth, public domain (CC0)
#
# Install: source this file from ~/.zshrc
# Customize: define TERMINAL_COLORS before sourcing, e.g.
#   TERMINAL_COLORS=("65535 65535 0" "0 60000 65535")   # R G B, each 0-65535

if [[ $TERM_PROGRAM == "Apple_Terminal" && -o interactive ]]; then
  : ${TERMINAL_COLORS_STATE:=$HOME/.terminal_color_index}

  if (( ! ${+TERMINAL_COLORS} )); then
    TERMINAL_COLORS=(
      "65535 65535 0"       # yellow
      "65535 0 65535"       # magenta
      "0 65535 48000"       # aqua green
      "65535 42000 0"       # orange
      "30000 50000 65535"   # sky blue
      "40000 65535 0"       # lime
      "65535 30000 45000"   # pink
      "45000 35000 65535"   # lavender
      "65535 35000 30000"   # coral
      "0 60000 65535"       # cyan
    )
  fi

  () {
    local last=$(cat $TERMINAL_COLORS_STATE 2>/dev/null)
    [[ $last == <-> ]] || last=0
    local n=$(( last % ${#TERMINAL_COLORS} + 1 ))
    echo $n >| $TERMINAL_COLORS_STATE
    local rgb=(${=TERMINAL_COLORS[$n]})

    # AppleScript fails inside Rosetta (Intel emulation) on Apple Silicon,
    # so always run it natively there.
    local osa=(/usr/bin/osascript)
    [[ $(sysctl -n hw.optional.arm64 2>/dev/null) == 1 ]] && osa=(arch -arm64 /usr/bin/osascript)

    $osa -e "tell application \"Terminal\"
      repeat with w in windows
        repeat with t in tabs of w
          if tty of t is \"$(tty)\" then set background color of t to {${rgb[1]}, ${rgb[2]}, ${rgb[3]}}
        end repeat
      end repeat
    end tell" >/dev/null 2>&1 &!
  }
fi
