# terminal-colors.zsh
# Gives every new macOS Terminal or iTerm2 window/tab a random HTML color name
# as its background, with matching readable text, and shows the name in the
# title.
#
# https://github.com/evanroth/terminal-colors
# Evan Roth, public domain (CC0)
# Version 1.0.4 (check yours with: echo $TERMINAL_COLORS_VERSION)
#
# Install: source this file from ~/.zshrc
# Commands:
#   newcolor     pick another random color for this window
#   whatcolor    print this window's color name
#   upgradecolors  download the latest version over this file
# New windows also print their color's name in big letters; set
# TERMINAL_COLORS_BANNER=0 before sourcing to turn that off.
# Customize: define TERMINAL_COLORS before sourcing, as
#   "Name BACKGROUNDHEX TEXTHEX" entries, e.g.
#   TERMINAL_COLORS=("Tomato FF6347 FFFFFF" "Gold FFD700 1F2D3D")

typeset -g TERMINAL_COLORS_VERSION=1.0.4
typeset -g TERMINAL_COLORS_FILE=${${(%):-%x}:A}   # this file, for upgradecolors

# Download the latest version from GitHub over this file. Checks the download
# first and leaves your copy alone if anything looks wrong.
upgradecolors() {
  emulate -L zsh
  autoload -Uz is-at-least
  local url=https://raw.githubusercontent.com/evanroth/terminal-colors/main/terminal-colors.zsh
  local tmp=$(mktemp) new
  if ! curl -fsSL $url -o $tmp; then
    print -u2 "upgradecolors: download failed, nothing changed"
    rm -f $tmp; return 1
  fi
  new=${${(M)${(f)"$(<$tmp)"}:#typeset -g TERMINAL_COLORS_VERSION=*}#*=}
  if [[ -z $new ]] || ! zsh -n $tmp; then
    print -u2 "upgradecolors: the download doesn't look right, nothing changed"
    rm -f $tmp; return 1
  fi
  if is-at-least $new $TERMINAL_COLORS_VERSION; then
    print "Terminal Colors is up to date ($TERMINAL_COLORS_VERSION)."
    rm -f $tmp; return
  fi
  cat $tmp > $TERMINAL_COLORS_FILE && rm -f $tmp || return 1
  print "Terminal Colors upgraded from $TERMINAL_COLORS_VERSION to $new. Open a new window to use it."
}

if [[ ( $TERM_PROGRAM == "Apple_Terminal" || $TERM_PROGRAM == "iTerm.app" ) && -o interactive ]]; then

  # The 148 HTML/CSS color names. Text color follows W3Schools'
  # color-names page: white if brightness (0.299R+0.587G+0.114B) < 150,
  # otherwise #1F2D3D.
  if (( ! ${+TERMINAL_COLORS} )); then
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
  # with patorjk.com's FIGfont editor), 6 rows each, separated by |
  typeset -gA _terminal_colors_glyphs=(
    A ' █████╗ |██╔══██╗|███████║|██╔══██║|██║  ██║|╚═╝  ╚═╝'
    B '██████╗ |██╔══██╗|██████╔╝|██╔══██╗|██████╔╝|╚═════╝ '
    C ' ██████╗|██╔════╝|██║     |██║     |╚██████╗| ╚═════╝'
    D '██████╗ |██╔══██╗|██║  ██║|██║  ██║|██████╔╝|╚═════╝ '
    E '███████╗|██╔════╝|█████╗  |██╔══╝  |███████╗|╚══════╝'
    F '███████╗|██╔════╝|█████╗  |██╔══╝  |██║     |╚═╝     '
    G ' ██████╗ |██╔════╝ |██║  ███╗|██║   ██║|╚██████╔╝| ╚═════╝ '
    H '██╗  ██╗|██║  ██║|███████║|██╔══██║|██║  ██║|╚═╝  ╚═╝'
    I '██╗|██║|██║|██║|██║|╚═╝'
    J '     ██╗|     ██║|     ██║|██   ██║|╚█████╔╝| ╚════╝ '
    K '██╗  ██╗|██║ ██╔╝|█████╔╝ |██╔═██╗ |██║  ██╗|╚═╝  ╚═╝'
    L '██╗     |██║     |██║     |██║     |███████╗|╚══════╝'
    M '███╗   ███╗|████╗ ████║|██╔████╔██║|██║╚██╔╝██║|██║ ╚═╝ ██║|╚═╝     ╚═╝'
    N '███╗   ██╗|████╗  ██║|██╔██╗ ██║|██║╚██╗██║|██║ ╚████║|╚═╝  ╚═══╝'
    O ' ██████╗ |██╔═══██╗|██║   ██║|██║   ██║|╚██████╔╝| ╚═════╝ '
    P '██████╗ |██╔══██╗|██████╔╝|██╔═══╝ |██║     |╚═╝     '
    Q ' ██████╗ |██╔═══██╗|██║   ██║|██║▄▄ ██║|╚██████╔╝| ╚══▀▀═╝ '
    R '██████╗ |██╔══██╗|██████╔╝|██╔══██╗|██║  ██║|╚═╝  ╚═╝'
    S '███████╗|██╔════╝|███████╗|╚════██║|███████║|╚══════╝'
    T '████████╗|╚══██╔══╝|   ██║   |   ██║   |   ██║   |   ╚═╝   '
    U '██╗   ██╗|██║   ██║|██║   ██║|██║   ██║|╚██████╔╝| ╚═════╝ '
    V '██╗   ██╗|██║   ██║|██║   ██║|╚██╗ ██╔╝| ╚████╔╝ |  ╚═══╝  '
    W '██╗    ██╗|██║    ██║|██║ █╗ ██║|██║███╗██║|╚███╔███╔╝| ╚══╝╚══╝ '
    X '██╗  ██╗|╚██╗██╔╝| ╚███╔╝ | ██╔██╗ |██╔╝ ██╗|╚═╝  ╚═╝'
    Y '██╗   ██╗|╚██╗ ██╔╝| ╚████╔╝ |  ╚██╔╝  |   ██║   |   ╚═╝   '
    Z '███████╗|╚══███╔╝|  ███╔╝ | ███╔╝  |███████╗|╚══════╝'
  )

  # Draw a word in big letters into $reply (6 rows). Each letter slides left
  # until it touches the previous one (figlet's "fitting" layout).
  _terminal_colors_art() {
    setopt localoptions extendedglob
    local ch a mid
    local -i r k n x cut
    local -a g
    reply=('' '' '' '' '' '')
    for ch in ${(s::)${(U)1}}; do
      (( ${+_terminal_colors_glyphs[$ch]} )) || continue
      g=("${(@s:|:)_terminal_colors_glyphs[$ch]}")
      k=${#reply[1]}
      for r in {1..6}; do
        n=$(( ${#reply[r]} - ${#${reply[r]%% #}} + ${#g[r]} - ${#${g[r]## #}} ))
        (( ${#reply[r]} < k )) && k=${#reply[r]}
        (( n < k )) && k=n
      done
      for r in {1..6}; do
        a=${reply[r]} cut=$(( ${#a} - k )) mid=
        for (( x = 1; x <= k; x++ )); do
          if [[ ${a[cut+x]} != ' ' ]]; then mid+=${a[cut+x]}; else mid+=${g[r][x]:- }; fi
        done
        reply[r]=${a[1,cut]}$mid${g[r][k+1,-1]}
      done
    done
    reply=("${(@)reply%% #}")
  }

  # Print the color name in big letters, breaking long names at their
  # capital letters to fit the window. Outlines are dimmed.
  _terminal_colors_banner() {
    setopt localoptions extendedglob
    [[ ${#${:-█}} == 1 ]] || return   # needs a UTF-8 locale
    local word cur row dim=$'\e[2m' undim=$'\e[22m'
    local -i width
    local -a words lines reply
    words=(${(s: :)1//(#b)([A-Z])/ $match[1]})
    for word in $words; do
      _terminal_colors_art $cur$word
      width=0
      for row in $reply; (( ${#row} > width )) && width=${#row}
      if [[ -n $cur ]] && (( width >= COLUMNS )); then
        lines+=($cur) cur=$word
      else
        cur+=$word
      fi
    done
    lines+=($cur)
    print
    for word in $lines; do
      _terminal_colors_art $word
      for row in $reply; print -r -- "${row//(#m)[^█ ]##/$dim$MATCH$undim}"
    done
    print
  }

  _terminal_colors_apply() {  # name background-hex text-hex
    export TERMINAL_COLOR_NAME=$1 TERMINAL_COLOR_BG=$2

    # Window title (programs like Claude Code may replace it while they run)
    print -n "\e]0;$1\a"

    # iTerm2 sets colors with escape sequences, for this session only
    if [[ $TERM_PROGRAM == "iTerm.app" ]]; then
      local key
      print -n "\e]1337;SetColors=bg=$2\a"
      for key in fg bold curbg; print -n "\e]1337;SetColors=$key=$3\a"
      return
    fi

    # Background, text and cursor colors with escape sequences: instant,
    # and they survive a terminal reset
    print -n "\e]11;rgb:${2[1,2]}/${2[3,4]}/${2[5,6]}\a"
    print -n "\e]10;rgb:${3[1,2]}/${3[3,4]}/${3[5,6]}\a\e]12;rgb:${3[1,2]}/${3[3,4]}/${3[5,6]}\a"

    # Bold text color has no escape sequence, so set it with AppleScript in
    # the background, on the tab whose tty is ours
    local fg="{$(( 16#${3[1,2]} * 257 )), $(( 16#${3[3,4]} * 257 )), $(( 16#${3[5,6]} * 257 ))}"

    # AppleScript fails inside Rosetta (Intel emulation) on Apple Silicon,
    # so always run it natively there.
    local osa=(/usr/bin/osascript)
    [[ $(sysctl -n hw.optional.arm64 2>/dev/null) == 1 ]] && osa=(arch -arm64 /usr/bin/osascript)

    $osa -e "tell application \"Terminal\"
      repeat with w in windows
        repeat with t in tabs of w
          if tty of t is \"$TTY\" then
            set bold text color of t to $fg
            return
          end if
        end repeat
      end repeat
    end tell" >/dev/null 2>&1 &!
  }

  newcolor() {
    local r=$(( RANDOM % ${#TERMINAL_COLORS} + 1 ))
    _terminal_colors_apply ${=TERMINAL_COLORS[$r]}
    [[ $1 == -q ]] || print $TERMINAL_COLOR_NAME
  }

  whatcolor() { print $TERMINAL_COLOR_NAME }

  newcolor -q
  [[ $TERMINAL_COLORS_BANNER == 0 ]] || _terminal_colors_banner $TERMINAL_COLOR_NAME
fi
