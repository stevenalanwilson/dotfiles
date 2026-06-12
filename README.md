# dotfiles

Zsh configuration for macOS (Apple Silicon). Clone and run `install.sh` on a fresh machine to get everything set up.

## Quick start

```sh
git clone https://github.com/stevenalanwilson/dotfiles.git ~/dotfiles
cd ~/dotfiles
zsh install.sh
```

The install script is safe to re-run — it skips anything already installed and backs up any existing dotfiles before symlinking.

## What gets installed

### Shell
| Tool | Purpose |
|---|---|
| [Oh My Zsh](https://ohmyz.sh/) | Plugin and theme management |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Prompt theme |

### CLI tools (via Homebrew)
| Tool | Replaces | Purpose |
|---|---|---|
| [eza](https://github.com/eza-community/eza) | `ls` | Coloured listings with icons and git status |
| [bat](https://github.com/sharkdp/bat) | `cat` / `less` | Syntax-highlighted file viewing |
| [fzf](https://github.com/junegunn/fzf) | — | Fuzzy finder (history, files, dirs) |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` | Smart directory jumping |
| [fd](https://github.com/sharkdp/fd) | `find` | Fast file search |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` | Fast recursive search |
| [fnm](https://github.com/Schniz/fnm) | pinned node versions | Node.js version manager |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | — | History-based inline suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | — | Live command validation |
| [gh](https://cli.github.com/) | — | GitHub CLI |
| [uv](https://github.com/astral-sh/uv) | pip/venv | Fast Python package manager |
| [pipx](https://github.com/pypa/pipx) | — | Install Python CLI tools in isolation |
| terraform | — | Infrastructure as code |

## Files

| File | Symlinked to | Purpose |
|---|---|---|
| `zshrc` | `~/.zshrc` | Main shell config |
| `zsh_aliases` | `~/.zsh_aliases` | All aliases |
| `p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt config |

## Key bindings (fzf)

| Binding | Action |
|---|---|
| `Ctrl+R` | Fuzzy search command history |
| `Ctrl+T` | Fuzzy insert a file path |
| `Alt+C` | Fuzzy `cd` into a directory |

## Alias highlights

### File listing
```sh
ll    # long list — icons, git status, dirs first
lt    # tree view, 2 levels
llt   # long tree view with git status
```

### Git
```sh
gs    # git status -sb
gl    # log — oneline graph, last 20
gcb   # checkout -b (new branch)
gpr   # open pull request in browser
gpf   # push --force-with-lease
```

### Node
```sh
nrd   # npm run dev
nrb   # npm run build
```

### Utilities
```sh
reload   # source ~/.zshrc
aliases  # open .zsh_aliases in $EDITOR
ip       # show public IP
ports    # list listening ports
path     # print PATH one entry per line
```

## Node version management

Node is managed by fnm. Project-level `.node-version` or `.nvmrc` files are picked up automatically on `cd`.

```sh
fnm install 22     # install a version
fnm use 22         # use in current shell
fnm default 22     # set global default
```

## Adding aliases

```sh
aliases   # opens ~/.zsh_aliases
reload    # reloads the shell
```

Then commit and push so your next machine gets the update automatically.
