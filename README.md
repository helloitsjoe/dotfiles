# Dotfiles

My collection of dotfiles

## Usage

After cloning this repo into `~/dotfiles`, you can link the dotfiles directly
to your existing dotfiles:

```sh
sh makesymlinks.sh
```

This will also create a backup of your old dotfiles in `~/dotfiles_old`.

## Tools

- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [oh-my-zsh](https://ohmyz.sh/)

## Vim

Install plugins:

```
:PlugInstall
```

## `.zshrc`

You can add a `~/.local.zsh` file for custom configuration and it will be
automatically sourced.
