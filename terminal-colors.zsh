# terminal-colors.zsh
# Gives every new terminal window/tab a random HTML color name as its
# background, with matching readable text, and shows the name in the title.
# Works in macOS Terminal, iTerm2 and Linux terminals (GNOME Terminal,
# Konsole, kitty, Alacritty, WezTerm, xterm, ...), from zsh or bash 4+.
#
# https://github.com/evanroth/terminal-colors
# Evan Roth, public domain (CC0)
# Version 1.1.0 (check yours with: echo $TERMINAL_COLORS_VERSION)
#
# Install: source this file from ~/.zshrc or ~/.bashrc
# Commands:
#   newcolor     pick another random color for this window
#   whatcolor    print this window's color name
#   upgradecolors  download the latest version over this file
# New windows also print their color's name in big letters; set
# TERMINAL_COLORS_BANNER=0 before sourcing to turn that off.
# Customize: define TERMINAL_COLORS before sourcing, as
#   "Name BACKGROUNDHEX TEXTHEX" entries, e.g.
#   TERMINAL_COLORS=("Tomato FF6347 FFFFFF" "Gold FFD700 1F2D3D")
#
# The same file runs in zsh and bash, so the code sticks to what both
# understand. Functions start with "emulate -L ksh" in zsh, which makes zsh
# split words and number arrays from 0 the way bash does.

# bash 3 (macOS's /bin/bash) is too old; zsh and bash 4+ are fine
if [ -n "$BASH_VERSION" ] && [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
  return 0
fi

typeset -g TERMINAL_COLORS_VERSION=1.1.0
if [ -n "$ZSH_VERSION" ]; then   # this file, for upgradecolors
  typeset -g TERMINAL_COLORS_FILE=${${(%):-%x}:A}
else
  TERMINAL_COLORS_FILE=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/${BASH_SOURCE[0]##*/}
fi

# Is version $1 newer than version $2?
_terminal_colors_newer() {
  [ -z "$ZSH_VERSION" ] || emulate -L ksh
  local a=$1. b=$2. x y
  while [ -n "$a$b" ]; do
    x=${a%%.*} y=${b%%.*} a=${a#*.} b=${b#*.}
    [ "${x:-0}" -gt "${y:-0}" ] && return 0
    [ "${x:-0}" -lt "${y:-0}" ] && return 1
  done
  return 1
}

# Download the latest version from GitHub over this file. Checks the download
# first and leaves your copy alone if anything looks wrong.
upgradecolors() {
  [ -z "$ZSH_VERSION" ] || emulate -L ksh
  local url=https://raw.githubusercontent.com/evanroth/terminal-colors/main/terminal-colors.zsh
  local tmp new shell=${BASH:-zsh}
  tmp=$(mktemp) || return 1
  if ! curl -fsSL "$url" -o "$tmp"; then
    echo "upgradecolors: download failed, nothing changed" >&2
    rm -f "$tmp"; return 1
  fi
  new=$(sed -n 's/^typeset -g TERMINAL_COLORS_VERSION=//p' "$tmp")
  if [ -n "$new" ] && ! _terminal_colors_newer "$new" "$TERMINAL_COLORS_VERSION"; then
    echo "Terminal Colors is up to date ($TERMINAL_COLORS_VERSION)."
    rm -f "$tmp"; return 0
  fi
  if [ -z "$new" ] || ! "$shell" -n "$tmp" 2>/dev/null; then
    echo "upgradecolors: the download doesn't look right, nothing changed" >&2
    rm -f "$tmp"; return 1
  fi
  cat "$tmp" > "$TERMINAL_COLORS_FILE" && rm -f "$tmp" || return 1
  echo "Terminal Colors upgraded from $TERMINAL_COLORS_VERSION to $new. Open a new window to use it."
}

# Run only in interactive shells, in terminals that understand the color
# escape sequences
_terminal_colors_enabled() {
  case $- in *i*) ;; *) return 1 ;; esac
  case $TERM_PROGRAM in Apple_Terminal|iTerm.app) return 0 ;; esac
  case $OSTYPE in linux*) ;; *) return 1 ;; esac
  # Not over ssh (it would recolor the local window), not inside tmux or
  # screen, not on the text console
  [ -z "$SSH_CONNECTION$SSH_TTY$TMUX$STY" ] || return 1
  case $TERM in ''|dumb|linux|screen*|tmux*) return 1 ;; esac
  return 0
}

if _terminal_colors_enabled; then

  # The 148 HTML/CSS color names. Text color follows W3Schools'
  # color-names page: white if brightness (0.299R+0.587G+0.114B) < 150,
  # otherwise #1F2D3D.
  if [ -z "${TERMINAL_COLORS+set}" ]; then
    TERMINAL_COLORS=(
      "AliceBlue F0F8FF 1F2D3D"
      "AntiqueWhite FAEBD7 1F2D3D"
      "Aqua 00FFFF 1F2D3D"
      "Aquamarine 7FFFD4 1F2D3D"
      "Azure F0FFFF 1F2D3D"
      "Beige F5F5DC 1F2D3D"
      "Bisque FFE4C4 1F2D3D"
      "Black 000000 FFFFFF"
      "BlanchedAlmond FFEBCD 1F2D3D"
      "Blue 0000FF FFFFFF"
      "BlueViolet 8A2BE2 FFFFFF"
      "Brown A52A2A FFFFFF"
      "BurlyWood DEB887 1F2D3D"
      "CadetBlue 5F9EA0 FFFFFF"
      "Chartreuse 7FFF00 1F2D3D"
      "Chocolate D2691E FFFFFF"
      "Coral FF7F50 1F2D3D"
      "CornflowerBlue 6495ED FFFFFF"
      "Cornsilk FFF8DC 1F2D3D"
      "Crimson DC143C FFFFFF"
      "Cyan 00FFFF 1F2D3D"
      "DarkBlue 00008B FFFFFF"
      "DarkCyan 008B8B FFFFFF"
      "DarkGoldenRod B8860B FFFFFF"
      "DarkGray A9A9A9 1F2D3D"
      "DarkGrey A9A9A9 1F2D3D"
      "DarkGreen 006400 FFFFFF"
      "DarkKhaki BDB76B 1F2D3D"
      "DarkMagenta 8B008B FFFFFF"
      "DarkOliveGreen 556B2F FFFFFF"
      "DarkOrange FF8C00 1F2D3D"
      "DarkOrchid 9932CC FFFFFF"
      "DarkRed 8B0000 FFFFFF"
      "DarkSalmon E9967A 1F2D3D"
      "DarkSeaGreen 8FBC8F 1F2D3D"
      "DarkSlateBlue 483D8B FFFFFF"
      "DarkSlateGray 2F4F4F FFFFFF"
      "DarkSlateGrey 2F4F4F FFFFFF"
      "DarkTurquoise 00CED1 FFFFFF"
      "DarkViolet 9400D3 FFFFFF"
      "DeepPink FF1493 FFFFFF"
      "DeepSkyBlue 00BFFF FFFFFF"
      "DimGray 696969 FFFFFF"
      "DimGrey 696969 FFFFFF"
      "DodgerBlue 1E90FF FFFFFF"
      "FireBrick B22222 FFFFFF"
      "FloralWhite FFFAF0 1F2D3D"
      "ForestGreen 228B22 FFFFFF"
      "Fuchsia FF00FF FFFFFF"
      "Gainsboro DCDCDC 1F2D3D"
      "GhostWhite F8F8FF 1F2D3D"
      "Gold FFD700 1F2D3D"
      "GoldenRod DAA520 1F2D3D"
      "Gray 808080 FFFFFF"
      "Grey 808080 FFFFFF"
      "Green 008000 FFFFFF"
      "GreenYellow ADFF2F 1F2D3D"
      "HoneyDew F0FFF0 1F2D3D"
      "HotPink FF69B4 1F2D3D"
      "IndianRed CD5C5C FFFFFF"
      "Indigo 4B0082 FFFFFF"
      "Ivory FFFFF0 1F2D3D"
      "Khaki F0E68C 1F2D3D"
      "Lavender E6E6FA 1F2D3D"
      "LavenderBlush FFF0F5 1F2D3D"
      "LawnGreen 7CFC00 1F2D3D"
      "LemonChiffon FFFACD 1F2D3D"
      "LightBlue ADD8E6 1F2D3D"
      "LightCoral F08080 1F2D3D"
      "LightCyan E0FFFF 1F2D3D"
      "LightGoldenRodYellow FAFAD2 1F2D3D"
      "LightGray D3D3D3 1F2D3D"
      "LightGrey D3D3D3 1F2D3D"
      "LightGreen 90EE90 1F2D3D"
      "LightPink FFB6C1 1F2D3D"
      "LightSalmon FFA07A 1F2D3D"
      "LightSeaGreen 20B2AA FFFFFF"
      "LightSkyBlue 87CEFA 1F2D3D"
      "LightSlateGray 778899 FFFFFF"
      "LightSlateGrey 778899 FFFFFF"
      "LightSteelBlue B0C4DE 1F2D3D"
      "LightYellow FFFFE0 1F2D3D"
      "Lime 00FF00 FFFFFF"
      "LimeGreen 32CD32 FFFFFF"
      "Linen FAF0E6 1F2D3D"
      "Magenta FF00FF FFFFFF"
      "Maroon 800000 FFFFFF"
      "MediumAquaMarine 66CDAA 1F2D3D"
      "MediumBlue 0000CD FFFFFF"
      "MediumOrchid BA55D3 FFFFFF"
      "MediumPurple 9370DB FFFFFF"
      "MediumSeaGreen 3CB371 FFFFFF"
      "MediumSlateBlue 7B68EE FFFFFF"
      "MediumSpringGreen 00FA9A 1F2D3D"
      "MediumTurquoise 48D1CC 1F2D3D"
      "MediumVioletRed C71585 FFFFFF"
      "MidnightBlue 191970 FFFFFF"
      "MintCream F5FFFA 1F2D3D"
      "MistyRose FFE4E1 1F2D3D"
      "Moccasin FFE4B5 1F2D3D"
      "NavajoWhite FFDEAD 1F2D3D"
      "Navy 000080 FFFFFF"
      "OldLace FDF5E6 1F2D3D"
      "Olive 808000 FFFFFF"
      "OliveDrab 6B8E23 FFFFFF"
      "Orange FFA500 1F2D3D"
      "OrangeRed FF4500 FFFFFF"
      "Orchid DA70D6 1F2D3D"
      "PaleGoldenRod EEE8AA 1F2D3D"
      "PaleGreen 98FB98 1F2D3D"
      "PaleTurquoise AFEEEE 1F2D3D"
      "PaleVioletRed DB7093 FFFFFF"
      "PapayaWhip FFEFD5 1F2D3D"
      "PeachPuff FFDAB9 1F2D3D"
      "Peru CD853F FFFFFF"
      "Pink FFC0CB 1F2D3D"
      "Plum DDA0DD 1F2D3D"
      "PowderBlue B0E0E6 1F2D3D"
      "Purple 800080 FFFFFF"
      "RebeccaPurple 663399 FFFFFF"
      "Red FF0000 FFFFFF"
      "RosyBrown BC8F8F 1F2D3D"
      "RoyalBlue 4169E1 FFFFFF"
      "SaddleBrown 8B4513 FFFFFF"
      "Salmon FA8072 1F2D3D"
      "SandyBrown F4A460 1F2D3D"
      "SeaGreen 2E8B57 FFFFFF"
      "SeaShell FFF5EE 1F2D3D"
      "Sienna A0522D FFFFFF"
      "Silver C0C0C0 1F2D3D"
      "SkyBlue 87CEEB 1F2D3D"
      "SlateBlue 6A5ACD FFFFFF"
      "SlateGray 708090 FFFFFF"
      "SlateGrey 708090 FFFFFF"
      "Snow FFFAFA 1F2D3D"
      "SpringGreen 00FF7F 1F2D3D"
      "SteelBlue 4682B4 FFFFFF"
      "Tan D2B48C 1F2D3D"
      "Teal 008080 FFFFFF"
      "Thistle D8BFD8 1F2D3D"
      "Tomato FF6347 FFFFFF"
      "Turquoise 40E0D0 1F2D3D"
      "Violet EE82EE 1F2D3D"
      "Wheat F5DEB3 1F2D3D"
      "White FFFFFF 1F2D3D"
      "WhiteSmoke F5F5F5 1F2D3D"
      "Yellow FFFF00 1F2D3D"
      "YellowGreen 9ACD32 1F2D3D"
    )
  fi

  # Letters A-Z of the figlet font "ANSI Shadow" (a TheDraw font converted
  # with patorjk.com's FIGfont editor): sets g to letter $1's 6 rows,
  # separated by |
  _terminal_colors_glyph() {
    case $1 in
      A|a) g=' █████╗ |██╔══██╗|███████║|██╔══██║|██║  ██║|╚═╝  ╚═╝' ;;
      B|b) g='██████╗ |██╔══██╗|██████╔╝|██╔══██╗|██████╔╝|╚═════╝ ' ;;
      C|c) g=' ██████╗|██╔════╝|██║     |██║     |╚██████╗| ╚═════╝' ;;
      D|d) g='██████╗ |██╔══██╗|██║  ██║|██║  ██║|██████╔╝|╚═════╝ ' ;;
      E|e) g='███████╗|██╔════╝|█████╗  |██╔══╝  |███████╗|╚══════╝' ;;
      F|f) g='███████╗|██╔════╝|█████╗  |██╔══╝  |██║     |╚═╝     ' ;;
      G|g) g=' ██████╗ |██╔════╝ |██║  ███╗|██║   ██║|╚██████╔╝| ╚═════╝ ' ;;
      H|h) g='██╗  ██╗|██║  ██║|███████║|██╔══██║|██║  ██║|╚═╝  ╚═╝' ;;
      I|i) g='██╗|██║|██║|██║|██║|╚═╝' ;;
      J|j) g='     ██╗|     ██║|     ██║|██   ██║|╚█████╔╝| ╚════╝ ' ;;
      K|k) g='██╗  ██╗|██║ ██╔╝|█████╔╝ |██╔═██╗ |██║  ██╗|╚═╝  ╚═╝' ;;
      L|l) g='██╗     |██║     |██║     |██║     |███████╗|╚══════╝' ;;
      M|m) g='███╗   ███╗|████╗ ████║|██╔████╔██║|██║╚██╔╝██║|██║ ╚═╝ ██║|╚═╝     ╚═╝' ;;
      N|n) g='███╗   ██╗|████╗  ██║|██╔██╗ ██║|██║╚██╗██║|██║ ╚████║|╚═╝  ╚═══╝' ;;
      O|o) g=' ██████╗ |██╔═══██╗|██║   ██║|██║   ██║|╚██████╔╝| ╚═════╝ ' ;;
      P|p) g='██████╗ |██╔══██╗|██████╔╝|██╔═══╝ |██║     |╚═╝     ' ;;
      Q|q) g=' ██████╗ |██╔═══██╗|██║   ██║|██║▄▄ ██║|╚██████╔╝| ╚══▀▀═╝ ' ;;
      R|r) g='██████╗ |██╔══██╗|██████╔╝|██╔══██╗|██║  ██║|╚═╝  ╚═╝' ;;
      S|s) g='███████╗|██╔════╝|███████╗|╚════██║|███████║|╚══════╝' ;;
      T|t) g='████████╗|╚══██╔══╝|   ██║   |   ██║   |   ██║   |   ╚═╝   ' ;;
      U|u) g='██╗   ██╗|██║   ██║|██║   ██║|██║   ██║|╚██████╔╝| ╚═════╝ ' ;;
      V|v) g='██╗   ██╗|██║   ██║|██║   ██║|╚██╗ ██╔╝| ╚████╔╝ |  ╚═══╝  ' ;;
      W|w) g='██╗    ██╗|██║    ██║|██║ █╗ ██║|██║███╗██║|╚███╔███╔╝| ╚══╝╚══╝ ' ;;
      X|x) g='██╗  ██╗|╚██╗██╔╝| ╚███╔╝ | ██╔██╗ |██╔╝ ██╗|╚═╝  ╚═╝' ;;
      Y|y) g='██╗   ██╗|╚██╗ ██╔╝| ╚████╔╝ |  ╚██╔╝  |   ██║   |   ╚═╝   ' ;;
      Z|z) g='███████╗|╚══███╔╝|  ███╔╝ | ███╔╝  |███████╗|╚══════╝' ;;
      *) g= ;;
    esac
  }

  # Draw a word in big letters into the caller's rows array (6 rows). Each
  # letter slides left until it touches the previous one (figlet's "fitting"
  # layout).
  _terminal_colors_art() {
    [ -z "$ZSH_VERSION" ] || emulate -L ksh
    local word=$1 g rest a gr mid c
    local -i i r k n x cut
    local -a gl
    rows=('' '' '' '' '' '')
    for (( i = 0; i < ${#word}; i++ )); do
      _terminal_colors_glyph "${word:$i:1}"
      [ -n "$g" ] || continue
      rest=$g
      for (( r = 0; r < 6; r++ )); do gl[r]=${rest%%|*} rest=${rest#*|}; done
      k=${#rows[0]}
      for (( r = 0; r < 6; r++ )); do
        a=${rows[r]} gr=${gl[r]}
        rest=${a##*[! ]} n=${#rest}   # trailing spaces of the row so far
        rest=${gr%%[! ]*} n+=${#rest} # plus leading spaces of the letter
        (( ${#a} < k )) && k=${#a}
        (( n < k )) && k=n
      done
      for (( r = 0; r < 6; r++ )); do
        a=${rows[r]} gr=${gl[r]} cut=$(( ${#rows[r]} - k )) mid=
        for (( x = 0; x < k; x++ )); do
          c=${a:$((cut + x)):1}
          [ "$c" = ' ' ] && c=${gr:$x:1} && c=${c:- }
          mid+=$c
        done
        rows[r]=${a:0:$cut}$mid${gr:$k}
      done
    done
    for (( r = 0; r < 6; r++ )); do
      a=${rows[r]} rest=${a##*[! ]} rows[r]=${a:0:$(( ${#a} - ${#rest} ))}
    done
  }

  # Print the color name in big letters, breaking long names at their
  # capital letters to fit the window. Outlines are dimmed.
  _terminal_colors_banner() {
    [ -z "$ZSH_VERSION" ] || emulate -L ksh
    local block='█'
    [ ${#block} = 1 ] || return 0   # needs a UTF-8 locale
    local name=$1 word= cur= row out c dim=$'\e[2m' undim=$'\e[22m'
    local -i i width dimmed cols=${COLUMNS:-0}
    local -a words lines rows
    (( cols > 0 )) || cols=$(tput cols 2>/dev/null || echo 80)
    for (( i = 0; i < ${#name}; i++ )); do
      c=${name:$i:1}
      case $c in
        ' ') [ -n "$word" ] && words+=("$word"); word= ;;
        [[:upper:]]) [ -n "$word" ] && words+=("$word"); word=$c ;;
        *) word+=$c ;;
      esac
    done
    [ -n "$word" ] && words+=("$word")
    for word in "${words[@]}"; do
      _terminal_colors_art "$cur$word"
      width=0
      for row in "${rows[@]}"; do (( ${#row} > width )) && width=${#row}; done
      if [ -n "$cur" ] && (( width >= cols )); then
        lines+=("$cur") cur=$word
      else
        cur+=$word
      fi
    done
    lines+=("$cur")
    echo
    for word in "${lines[@]}"; do
      _terminal_colors_art "$word"
      for row in "${rows[@]}"; do
        out= dimmed=0
        for (( i = 0; i < ${#row}; i++ )); do
          c=${row:$i:1}
          case $c in
            '█'|' ') (( dimmed )) && out+=$undim && dimmed=0 ;;
            *) (( dimmed )) || { out+=$dim; dimmed=1; } ;;
          esac
          out+=$c
        done
        (( dimmed )) && out+=$undim
        printf '%s\n' "$out"
      done
    done
    echo
  }

  _terminal_colors_title() { printf '\033]0;%s\007' "$TERMINAL_COLOR_NAME"; }

  _terminal_colors_apply() {  # name background-hex text-hex
    [ -z "$ZSH_VERSION" ] || emulate -L ksh
    export TERMINAL_COLOR_NAME=$1 TERMINAL_COLOR_BG=$2
    local bg=$2 fg=$3 key

    # Window title (programs like Claude Code may replace it while they run;
    # it comes back at the next prompt)
    _terminal_colors_title

    # iTerm2 sets colors with escape sequences, for this session only
    if [ "$TERM_PROGRAM" = iTerm.app ]; then
      printf '\033]1337;SetColors=bg=%s\007' "$bg"
      for key in fg bold curbg; do printf '\033]1337;SetColors=%s=%s\007' $key "$fg"; done
      return 0
    fi

    # Background, text and cursor colors with escape sequences: instant,
    # and they survive a terminal reset
    printf '\033]11;rgb:%s/%s/%s\007' "${bg:0:2}" "${bg:2:2}" "${bg:4:2}"
    printf '\033]10;rgb:%s/%s/%s\007\033]12;rgb:%s/%s/%s\007' \
      "${fg:0:2}" "${fg:2:2}" "${fg:4:2}" "${fg:0:2}" "${fg:2:2}" "${fg:4:2}"

    # Apple Terminal's bold text color has no escape sequence, so set it with
    # AppleScript in the background, on the tab whose tty is ours
    [ "$TERM_PROGRAM" = Apple_Terminal ] || return 0
    local bold="{$(( 16#${fg:0:2} * 257 )), $(( 16#${fg:2:2} * 257 )), $(( 16#${fg:4:2} * 257 ))}"
    local tty=${TTY:-$(tty)}

    # AppleScript fails inside Rosetta (Intel emulation) on Apple Silicon,
    # so always run it natively there.
    local -a osa=(/usr/bin/osascript)
    [ "$(sysctl -n hw.optional.arm64 2>/dev/null)" = 1 ] && osa=(arch -arm64 /usr/bin/osascript)

    ( "${osa[@]}" -e "tell application \"Terminal\"
      repeat with w in windows
        repeat with t in tabs of w
          if tty of t is \"$tty\" then
            set bold text color of t to $bold
            return
          end if
        end repeat
      end repeat
    end tell" >/dev/null 2>&1 & )
  }

  newcolor() {
    [ -z "$ZSH_VERSION" ] || emulate -L ksh
    local quiet=$1
    set -- ${TERMINAL_COLORS[RANDOM % ${#TERMINAL_COLORS[@]}]}
    _terminal_colors_apply "$1" "$2" "$3"
    [ "$quiet" = -q ] || echo "$TERMINAL_COLOR_NAME"
  }

  whatcolor() { echo "$TERMINAL_COLOR_NAME"; }

  newcolor -q
  [ "$TERMINAL_COLORS_BANNER" = 0 ] || _terminal_colors_banner "$TERMINAL_COLOR_NAME"

  # Put the color name back in the title at every prompt, after programs
  # (and some default prompts) change it
  if [ -n "$ZSH_VERSION" ]; then
    case " ${precmd_functions[*]} " in
      *" _terminal_colors_title "*) ;;
      *) precmd_functions+=(_terminal_colors_title) ;;
    esac
  else
    case $PS1 in
      *TERMINAL_COLOR_NAME*) ;;
      *) PS1+='\[\e]0;${TERMINAL_COLOR_NAME}\a\]' ;;
    esac
  fi
fi
