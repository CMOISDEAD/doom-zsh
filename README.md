<h1 align="center">doom-zsh</h1>

<p align="center">A minimal, clear and useful zsh prompt.</p>

```text
~/projects/api node v22.11.0 took 4s                 main ⇡1 !2 ?1
✘ 1 ❯
```

## Philosophy

- **Minimal.** Few sections, little code, no required dependencies and no special fonts.
- **Clear.** Every element means one thing, and nothing is there for decoration.
- **Useful.** A section appears only when it matters: a failed command, a slow command, a project's toolchain, a remote host.

If a tool is not installed, its section stays hidden. Everything is configured from your `.zshrc`, so you never have to edit the theme.

## Requirements

- zsh 5.3 or newer
- git 2.35 or newer, for the git section

## Installation

### Plain zsh

```zsh
git clone --depth=1 https://github.com/CMOISDEAD/doom-zsh.git ~/.zsh/doom
echo 'source ~/.zsh/doom/doom.zsh-theme' >> ~/.zshrc
```

### Oh My Zsh

```zsh
git clone --depth=1 https://github.com/CMOISDEAD/doom-zsh.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/doom"
```

Then set `ZSH_THEME="doom/doom"` in your `.zshrc`.

### Plugin managers

| Manager  | Line for your `.zshrc`                    |
| -------- | ----------------------------------------- |
| zinit    | `zinit light CMOISDEAD/doom-zsh`          |
| zplug    | `zplug "CMOISDEAD/doom-zsh", as:theme`    |
| antidote | `antidote bundle CMOISDEAD/doom-zsh`      |

## Sections

Set these lists before loading the theme to choose and order what you see:

```zsh
DOOM_SECTIONS_LEFT=(user host dir node rust python exec_time jobs new_line status char)
DOOM_SECTIONS_RIGHT=(git)
```

The lists above are the defaults. For a single-line prompt, remove `new_line`.

| Section     | Shows                                       | Enabled |
| ----------- | ------------------------------------------- | ------- |
| `user`      | Username, when it is worth noting           | Yes     |
| `host`      | Hostname over SSH                           | Yes     |
| `dir`       | Current directory                           | Yes     |
| `node`      | Node.js version in JavaScript projects      | Yes     |
| `rust`      | Rust version in Cargo projects              | Yes     |
| `python`    | Python version and active virtualenv        | Yes     |
| `exec_time` | Duration of slow commands                   | Yes     |
| `jobs`      | Background jobs                             | Yes     |
| `new_line`  | Line break                                  | Yes     |
| `status`    | Exit code of a failed command               | Yes     |
| `char`      | Prompt character, red after a failure       | Yes     |
| `git`       | Branch and repository status                | Yes     |
| `aws`       | Active AWS profile                          | No      |
| `time`      | Current time                                | No      |
| `vi_mode`   | Vi mode, updated as you switch              | No      |
| `logo`      | Custom symbol (needs a Nerd Font by default) | No      |

### Git symbols

| Symbol       | Meaning                    |
| ------------ | -------------------------- |
| `⇣3` `⇡2`    | Behind, ahead of upstream  |
| `*1`         | Stashes                    |
| `merge`      | Merge, rebase, cherry-pick, revert or bisect in progress |
| `~1`         | Conflicts                  |
| `+1`         | Staged changes             |
| `!1`         | Unstaged changes           |
| `?1`         | Untracked files            |

## Options

Every section reads options named `DOOM_<SECTION>_<OPTION>`. Set them before loading the theme.

| Option   | Meaning                                  | Example                       |
| -------- | ---------------------------------------- | ----------------------------- |
| `SHOW`   | Set to `false` to hide the section       | `DOOM_RUST_SHOW=false`        |
| `PREFIX` | Text before the section                  | `DOOM_DIR_PREFIX="in "`       |
| `SUFFIX` | Text after the section                   | `DOOM_TIME_SUFFIX="]"`        |
| `SYMBOL` | Symbol before the content                | `DOOM_NODE_SYMBOL="⬢ "`       |
| `COLOR`  | Color name or 256-color number           | `DOOM_DIR_COLOR=blue`         |

`char` is always shown and uses `DOOM_CHAR_COLOR_SUCCESS` and `DOOM_CHAR_COLOR_FAILURE` instead of `COLOR`.

Section-specific options:

| Option                       | Default  | Meaning                                                         |
| ---------------------------- | -------- | --------------------------------------------------------------- |
| `DOOM_SEPARATOR`             | a space  | Text between sections                                           |
| `DOOM_DIR_TRUNC`             | `3`      | Path components to show                                         |
| `DOOM_USER_SHOW`             | `needed` | `always`, `true` (also over SSH), `needed` (root or switched user), `false` |
| `DOOM_HOST_SHOW`             | `true`   | `always`, `true` (over SSH), `false`                            |
| `DOOM_HOST_SHOW_FULL`        | `false`  | Show the fully qualified hostname                               |
| `DOOM_HOST_COLOR_SSH`        | `green`  | Hostname color over SSH                                         |
| `DOOM_USER_COLOR_ROOT`       | `red`    | Username color for root                                         |
| `DOOM_CHAR_SYMBOL_ROOT`      | `#`      | Prompt character for root                                       |
| `DOOM_CHAR_COLOR_SUCCESS`    | `green`  | Prompt character color                                          |
| `DOOM_CHAR_COLOR_FAILURE`    | `red`    | Prompt character color after a failure                          |
| `DOOM_EXEC_TIME_ELAPSED`     | `2`      | Minimum seconds before showing the duration                     |
| `DOOM_TIME_12HR`             | `true`   | Use a 12-hour clock                                             |
| `DOOM_TIME_FORMAT`           | `false`  | Custom format, such as `%D{%H:%M}`                              |
| `DOOM_NODE_DEFAULT_VERSION`  | empty    | Hide the section on this version                                |
| `DOOM_RUST_VERBOSE_VERSION`  | `false`  | Keep suffixes such as `-nightly`                                |
| `DOOM_JOBS_AMOUNT_THRESHOLD` | `1`      | Show the count above this number of jobs                        |

## Custom sections

A section is a function named `doom_<name>` that sets `REPLY`. An empty `REPLY` hides it. Sections run on every prompt, so keep them fast and use `doom_cached` for slow commands:

```zsh
DOOM_SECTIONS_LEFT=(dir kube new_line status char)
DOOM_KUBE_SYMBOL="k8s "
DOOM_KUBE_COLOR=blue

doom_kube() {
  [[ -f Chart.yaml ]] || return
  doom_cached kube kubectl config current-context
  doom_segment KUBE "$REPLY"
}
```

`doom_segment NAME text` applies the `DOOM_NAME_*` options. `doom_cached key command` keeps a command's output until the directory or `PATH` changes. Escape `%` in text you do not control with `${text//\%/%%}`.

## License

[MIT](LICENSE)
