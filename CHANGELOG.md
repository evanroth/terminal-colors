# Changelog

To upgrade, see [Upgrade](README.md#upgrade) in the README.

## 1.1.0 (2026-11-17)

- Linux support: GNOME Terminal, Konsole, kitty, Alacritty, WezTerm, xterm and other terminals that understand the OSC 10/11 color sequences.
- bash support: the same file now works in zsh and bash 4 or newer. Source it from `~/.bashrc`.
- The color name goes back into the window title at every prompt, after programs like Claude Code or vim change it.

## 1.0.4 (2026-10-04)

- `upgradecolors` command: downloads the latest version over your copy. It checks the download first and leaves your copy alone if anything looks wrong.

## 1.0.3 (2026-10-04)

- New windows change color instantly: background, text and cursor colors are now set with escape sequences instead of AppleScript. Colors also match the HTML colors more closely.
- New windows print their color name in big letters (the figlet font ANSI Shadow). Set `TERMINAL_COLORS_BANNER=0` to turn it off.
- `TERMINAL_COLORS_VERSION` holds the installed version.

## 1.0.2 (2026-10-04)

- Faster color picking with zsh's built-in random numbers, by [Jamie Dubs](https://github.com/jamiew) ([#2](https://github.com/evanroth/terminal-colors/pull/2)).

## 1.0.1 (2026-10-03)

- iTerm2 support.

## 1.0.0 (2026-10-02)

- Every new Terminal window or tab gets a random HTML color name as its background, with readable text and the name in the window title.
- `newcolor` and `whatcolor` commands.
