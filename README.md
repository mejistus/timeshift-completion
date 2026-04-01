# timeshift-completion

Zsh completion plugin for [Timeshift](https://github.com/linuxmint/timeshift) (v25.12.4+). Designed for [Oh My Zsh](https://ohmyz.sh/).

## Features

- Complete all actions (`--create`, `--restore`, `--delete`, `--list`, etc.)
- Context-aware options: `--comments`/`--tags` only appear after `--create`, `--snapshot`/`--target-device`/`--skip-grub` only after `--restore`, etc.
- Dynamic snapshot name completion (parsed from `timeshift --list`)
- Dynamic device completion (parsed from `timeshift --list-devices`, with `/dev` fallback)
- Tag values completion (`O` `B` `H` `D` `W` `M`)

## Installation

### Oh My Zsh

```bash
# Clone into custom plugins directory
git clone https://github.com/<your-user>/timeshift-completion \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/timeshift-completion

# Or just copy the file
mkdir -p ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/timeshift-completion
cp timeshift-completion.plugin.zsh \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/timeshift-completion/
```

Then add `timeshift-completion` to your plugin list in `~/.zshrc`:

```zsh
plugins=(... timeshift-completion)
```

Reload your shell:

```bash
source ~/.zshrc
```

### Manual

Source the file directly in your `~/.zshrc`:

```zsh
source /path/to/timeshift-completion.plugin.zsh
```

## Usage

```bash
timeshift --<TAB>          # Show all actions and global options
timeshift --create --<TAB> # Show --comments, --tags and global options
timeshift --restore --<TAB> # Show --snapshot, --target-device, --skip-grub, etc.
timeshift --delete --<TAB>  # Show --snapshot and global options
timeshift --tags <TAB>      # Show tag values: O B H D W M
timeshift --snapshot <TAB>  # List existing snapshots
timeshift --snapshot-device <TAB>  # List available devices
```

> Snapshot and device completion calls `sudo timeshift ...` under the hood. If no results appear, ensure the current user has sudo access.

## Supported Options

| Category | Options |
|----------|---------|
| Actions | `--check` `--create` `--restore` `--delete` `--delete-all` `--list` `--list-snapshots` `--list-devices` `--help` `--version` |
| Create | `--comments <string>` `--tags {O,B,H,D,W,M}` |
| Restore | `--snapshot <name>` `--target-device <dev>` `--target <dev>` `--grub-device <dev>` `--grub <dev>` `--skip-grub` |
| Delete | `--snapshot <name>` |
| Global | `--snapshot-device <dev>` `--yes` `--btrfs` `--rsync` `--debug` `--verbose` `--quiet` `--scripted` |

## Requirements

- Zsh 5.0+
- Timeshift v25.12.4+ installed and in `$PATH`
- `sudo` access (for dynamic snapshot/device completion)

## License

MIT
