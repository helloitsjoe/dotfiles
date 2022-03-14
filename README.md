# Dotfiles

My collection of dotfiles

## Usage

After cloning this repo into `~/dotfiles`, you can link the dotfiles directly
to your existing dotfiles:

```sh
sh makesymlinks.sh
```

This will also create a backup of your old dotfiles in `~/dotfiles_old`.

## Vim

Install plugins:

```
:PlugInstall
```

## `.zshrc`

You can add a `~/.local.zsh` file for custom configuration and it will be
automatically sourced.
