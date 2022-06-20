![Doom-zsh](./assets/main.png)

<h2 align="center">The Doom zsh theme</h2>

<div align="center">
  <h5>
    <a href="https://spaceship-prompt.sh">Website</a> |
    <a href="https://spaceship-prompt.sh/getting-started">Installing</a> |
    <a href="#features">Features</a> |
    <a href="https://spaceship-prompt.sh/options">Options</a> |
    <a href="https://spaceship-prompt.sh/api">API</a>
  </h5>
</div>

## Themes
To select a specific theme switch branches on github and select the theme or the full version.

#### Rainbow

![doom-zsh-rainbow](./assets/rainbow.png)

#### Pure

![doom-zsh-pure](./assets/pure.png)

## Features

- Multiple themes
- Display node.js, rust, python, ruby (and more) version.
- Multiple customizable sections.
- Customizable order.
- Very fast git update thanks to [romkatv](https://github.com/romkatv/gitstatus).
- Create your own section.
- and more!

## Requirements

To work correctly, you will first need:

- [`zsh`](http://www.zsh.org/) (v5.2 or recent) must be installed.
- [Powerline Font](https://github.com/powerline/fonts) must be installed and used in your terminal (for example, switch font to [Fira Code](https://github.com/tonsky/FiraCode)).

## Installing

Now that the requirements are satisfied, you can install Spaceship ZSH via any of the following tools.

### [oh-my-zsh]

Clone this repo:

```zsh
git clone https://github.com/CMOISDEAD/doom-zsh.git "$ZSH_CUSTOM/themes/doom-prompt" --depth=1
```

Symlink `doom.zsh-theme` to your oh-my-zsh custom themes directory:

```zsh
ln -s "$ZSH_CUSTOM/themes/doom-prompt/doom.zsh-theme" "$ZSH_CUSTOM/themes/doom.zsh-theme"
```

Set `ZSH_THEME="doom"` in your `.zshrc`.

## Related Projects

Here's a list of related projects that have been inspired by Spaceship ZSH.

- [**matchai/spacefish**](https://github.com/matchai/spacefish) - A port of Spaceship ZSH for fish shell intending to achieve complete feature parity.
- [**starship/starship**](https://github.com/starship/starship) - A blazing-fast, cross-shell prompt written in Rust, heavily inspired by Spaceship ZSH.
