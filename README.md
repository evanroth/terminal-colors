# terminal-colors

Every new macOS Terminal or iTerm2 window or tab gets a random [HTML color name](https://www.w3schools.com/tags/ref_colornames.asp) as its background, from AliceBlue to YellowGreen. The text color is set so it stays readable, and the color's name shows in the window title. When you have five sessions open at once (say, five Claude Code projects), you can tell them apart at a glance, and refer to them by name: "the Tomato one."

No more making a new Terminal profile by hand each time.

## Install

Paste this into Terminal (or iTerm2):

```zsh
curl -fsSL https://raw.githubusercontent.com/evanroth/terminal-colors/main/terminal-colors.zsh -o ~/.terminal-colors.zsh
echo 'source ~/.terminal-colors.zsh' >> ~/.zshrc
```

Then open a new window (⌘N). In Terminal, the first time, macOS asks whether **Terminal** may control **Terminal**. Click **OK**. If you missed it, turn it on in System Settings → Privacy & Security → Automation → Terminal. iTerm2 needs no permission.

## Commands

- `newcolor`: don't like the color you got? Roll again.
- `whatcolor`: print this window's color name.

## How it works

When a new window or tab starts its shell, the script:

1. picks one of the 148 HTML/CSS color names at random,
2. picks the text color the way the [W3Schools color names page](https://www.w3schools.com/tags/ref_colornames.asp) does: white (`#FFFFFF`) if the color's brightness (0.299 R + 0.587 G + 0.114 B) is under 150, otherwise dark slate (`#1F2D3D`),
3. sets the background, text, bold and cursor colors of *that* tab: in Terminal with AppleScript (finding the tab by its tty, so it hits the right window even if you switch away), in iTerm2 with its `SetColors` escape sequences,
4. sets the window title to the color name.

**About the title:** programs that set their own title (Claude Code, vim, ssh, etc.) replace it while they run. Run `whatcolor` to check.

## Customize

Define your own palette **before** the `source` line in `~/.zshrc`. Each entry is `Name BACKGROUND TEXT`, with hex colors:

```zsh
TERMINAL_COLORS=(
  "Tomato FF6347 FFFFFF"
  "Gold FFD700 1F2D3D"
  "Teal 008080 FFFFFF"
)
source ~/.terminal-colors.zsh
```

## Notes

- **Apple Terminal and iTerm2 only.** In other terminals it does nothing. Terminal is colored with AppleScript; iTerm2 with its own escape sequences, which change only the current session (tab or split pane), not your profile.
- **Apple Silicon + Rosetta:** if Terminal is set to "Open using Rosetta", AppleScript fails with `can't open default scripting component`. The script works around this by running AppleScript natively. You can also uncheck *Open using Rosetta* in Terminal's Get Info window.
- Colors are random, so two windows can occasionally match. Use `newcolor`.

## Uninstall

Remove the `source ~/.terminal-colors.zsh` line from `~/.zshrc` and delete `~/.terminal-colors.zsh`.

## License

Public domain ([CC0](LICENSE)). Do whatever you like with it.
