# terminal-colors

Every new macOS Terminal window or tab gets its own background color, rotating through a bright palette. When you have five sessions open at once (say, five Claude Code projects), you can tell them apart at a glance.

No more making a new Terminal profile by hand each time.

## Install

Paste this into Terminal:

```zsh
curl -fsSL https://raw.githubusercontent.com/evanroth/terminal-colors/main/terminal-colors.zsh -o ~/.terminal-colors.zsh
echo 'source ~/.terminal-colors.zsh' >> ~/.zshrc
```

Then open a new window (⌘N). The first time, macOS asks whether **Terminal** may control **Terminal**. Click **OK**. If you missed it, turn it on in System Settings → Privacy & Security → Automation → Terminal.

## How it works

When a new window or tab starts its shell, the script:

1. reads the last color used from `~/.terminal_color_index`,
2. picks the next one in the palette,
3. uses AppleScript to set the background of *that* tab (found by its tty, so it hits the right window even if you switch away).

The palette has 10 colors that all work with black text. Window 11 starts again from the first color.

## Customize

Define your own palette **before** the `source` line in `~/.zshrc`. Each color is R G B, with each value from 0 to 65535:

```zsh
TERMINAL_COLORS=(
  "65535 65535 0"    # yellow
  "0 60000 65535"    # cyan
  "65535 0 65535"    # magenta
)
source ~/.terminal-colors.zsh
```

## Notes

- **Apple Terminal only.** In iTerm2 and other terminals it does nothing.
- **Apple Silicon + Rosetta:** if Terminal is set to "Open using Rosetta", AppleScript fails with `can't open default scripting component`. The script works around this by running AppleScript natively. You can also uncheck *Open using Rosetta* in Terminal's Get Info window.
- Restored windows after a Terminal restart each get a new color.

## Uninstall

Remove the `source ~/.terminal-colors.zsh` line from `~/.zshrc` and delete `~/.terminal-colors.zsh` and `~/.terminal_color_index`.

## License

Public domain ([CC0](LICENSE)). Do whatever you like with it.
