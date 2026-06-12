# dotfiles — Steven Wilson

Zsh configuration for macOS (Apple Silicon). Clone and run `install.sh` on a fresh machine to get everything set up in one go.

## Quick start

```sh
git clone https://github.com/stevenalanwilson/dotfiles.git ~/dotfiles
cd ~/dotfiles
zsh install.sh
```

The install script is safe to re-run — it skips anything already installed and backs up existing dotfiles before symlinking.

---

## What gets installed

### Shell
| Tool | Purpose |
|---|---|
| [Oh My Zsh](https://ohmyz.sh/) | Plugin and theme management |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Prompt theme with instant prompt |

### CLI tools (via Brewfile)
| Tool | Replaces | Purpose |
|---|---|---|
| [eza](https://github.com/eza-community/eza) | `ls` | Coloured listings with icons and git status |
| [bat](https://github.com/sharkdp/bat) | `cat` / `less` | Syntax-highlighted file viewing with Catppuccin Mocha theme |
| [fzf](https://github.com/junegunn/fzf) | — | Fuzzy finder (history, files, dirs) |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` | Smart directory jumping that learns your habits |
| [fd](https://github.com/sharkdp/fd) | `find` | Fast, friendly file search |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` | Fast recursive search |
| [fnm](https://github.com/Schniz/fnm) | pinned node versions | Fast Node.js version manager |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | — | History-based inline suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | — | Live command validation (green/red) |
| [gh](https://cli.github.com/) | — | GitHub CLI |
| [uv](https://github.com/astral-sh/uv) | pip/venv | Fast Python package manager |
| [pipx](https://github.com/pypa/pipx) | — | Python CLI tools in isolation |
| terraform | — | Infrastructure as code |
| [gemini-cli](https://github.com/google-gemini/gemini-cli) | — | Gemini AI CLI |

### Casks
- **Claude Code** — terminal AI coding agent

### VS Code extensions
AWS Toolkit, Amazon Q, Anthropic Claude Code, Terraform, Docker, Python, Jest, Remote Containers, GitHub Actions, Neon

### Global npm
`pnpm`, `vercel`, `@nestjs/cli`

---

## Files

| Repo file | Symlinked to | Purpose |
|---|---|---|
| `zshrc` | `~/.zshrc` | Main shell config — plugins, PATH, tool initialisers |
| `zsh_options` | `~/.zsh_options` | History config and zsh options |
| `zsh_aliases` | `~/.zsh_aliases` | All aliases |
| `zsh_functions` | `~/.zsh_functions` | Shell functions |
| `p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt config |
| `gitconfig` | `~/.gitconfig` | Git identity, aliases, defaults |
| `gitignore_global` | `~/.gitignore_global` | Global gitignore (.DS_Store, .env, etc.) |
| `ssh_config` | `~/.ssh/config` | SSH hosts (1Password agent) |
| `npmrc` | `~/.npmrc` | npm defaults (author, save-exact, no fund/audit noise) |
| `bat_config` | `~/.config/bat/config` | bat theme and display options |
| `Brewfile` | — | All Homebrew packages, casks, VS Code extensions, global npm |
| `install.sh` | — | Full setup script |
| `macos.sh` | — | macOS system defaults (run once) |

---

## Key bindings (fzf)

| Binding | Action |
|---|---|
| `Ctrl+R` | Fuzzy search command history |
| `Ctrl+T` | Fuzzy insert a file path |
| `Alt+C` | Fuzzy `cd` into a directory |

---

## Alias reference

### Navigation
```sh
..       # cd ..
...      # cd ../..
proj     # cd ~/Projects
z foo    # jump to any frecent dir matching "foo"
```

### Projects
```sh
p73      # 73rdAllestreeWebApp
psaw     # SAW personal site
pai      # AI-cost-explination
pkit     # app-prototyping-kit
pagent   # agentflow-flows
pdots    # ~/dotfiles
```

### File listing (eza)
```sh
ls     # icons
ll     # long list — icons, git status, dirs first
lt     # tree view, 2 levels deep
llt    # long tree view with git status
```

### Git
```sh
gs       # git status -sb
gl       # log — oneline graph, last 20
ga       # git add
gc       # git commit -m
gca      # amend last commit (no message change)
gp       # git push
gpf      # push --force-with-lease
gd       # git diff
gds      # git diff --staged
gcb      # checkout -b (new branch)
gpr      # open pull request in browser (gh)
gundo    # reset --soft HEAD~1 (undo last commit, keep changes)
gunstage # reset HEAD -- (unstage files)
```

### Node / npm
```sh
ni     # npm install
nr     # npm run
nrd    # npm run dev
nrb    # npm run build
nlg    # npm list -g --depth=0
pni    # pnpm install
pnrd   # pnpm run dev
pnrb   # pnpm run build
```

### Python / uv
```sh
py     # python3
venv   # uv venv && source .venv/bin/activate
ipy    # ipython
```

### Terraform
```sh
tf     # terraform
tfi    # terraform init
tfp    # terraform plan
tfa    # terraform apply
tfd    # terraform destroy
tfo    # terraform output
```

### Utilities
```sh
reload     # source ~/.zshrc
zshrc      # open .zshrc in VS Code
aliases    # open .zsh_aliases in VS Code
functions  # open .zsh_functions in VS Code
dotfiles   # cd ~/dotfiles and open in VS Code
ip         # show public IP address
localip    # show local network IP
ports      # list listening ports
path       # print PATH one entry per line
week       # print ISO week number
now        # print current datetime
cleanup    # remove .DS_Store and *.log files from current dir
```

### macOS
```sh
showfiles  # show hidden files in Finder
hidefiles  # hide hidden files in Finder
flushdns   # flush DNS cache
screensaver # start screen saver
```

---

## Functions

```sh
mkcd <dir>       # mkdir and cd in one step
gitclone <url>   # git clone and cd into the repo
port <number>    # kill whatever process is on that port
json [file]      # pretty-print JSON from a file or pipe
extract <file>   # extract any archive (tar, zip, gz, bz2, 7z...)
serve [port]     # start a local HTTP server (default: 8000)
dirsize [path]   # show directory sizes, sorted largest first
backup <file>    # create a dated .bak copy of a file
hist             # fuzzy search command history with fzf
recent [n]       # show last n git commits (default: 5)
```

---

## History

Configured in `zsh_options`:

- 50,000 lines stored and saved
- Deduplicated — no repeated entries
- Shared across all open terminal sessions in real time
- Commands prefixed with a space are not saved

---

## Node version management

Node is managed by fnm. `.node-version` or `.nvmrc` files in a project directory are picked up automatically on `cd`.

```sh
fnm install 22     # install a version
fnm use 22         # use in current shell
fnm default 22     # set global default
fnm list           # show installed versions
```

---

## bat

File viewing uses [bat](https://github.com/sharkdp/bat) with the Catppuccin Mocha theme, line numbers, and git change markers enabled. The theme is installed automatically by `install.sh`.

---

## macOS defaults

`macos.sh` applies these settings (prompted during install, or run manually):

- **Finder** — hidden files visible, path bar, list view, search current folder, no extension-change warning
- **Keyboard** — fast key repeat, no auto-correct, no smart quotes or dashes
- **Screenshots** — saved to `~/Desktop/Screenshots`, PNG format, no shadow
- **Dock** — auto-hide, faster animation, no recent apps, smaller icons
- **Trackpad** — tap to click
- **Menu bar** — battery percentage, 24-hour clock

---

## SSH & 1Password

Keys are managed by the 1Password SSH agent. After install:

1. Open 1Password
2. Go to **Settings → Developer → SSH Agent → Enable**
3. Your SSH keys are available automatically — no `ssh-add` needed

---

## Git maintenance

`git maintenance` is enrolled on all repos in `~/Projects` and `~/dotfiles`. It runs background tasks (garbage collection, commit-graph updates, prefetch) on a schedule to keep git fast. To enrol a new repo:

```sh
git maintenance start
```

---

## Keeping dotfiles up to date

Because files are **symlinked** (not copied), edits made via `zshrc`, `aliases`, or `functions` commands directly update the repo files. Just commit and push:

```sh
cd ~/dotfiles
git add -A
git commit -m "update aliases"
git push
```

To add a new Homebrew package:

```sh
brew install something
brew bundle dump --force   # regenerates Brewfile
git add Brewfile && git commit -m "add something" && git push
```
