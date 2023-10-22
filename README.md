# nvim
Neovim + LSP configurations

Requires vim-plug:

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

tmux (3.2+) settings to fix colors:

```
set -g default-terminal "xterm-256color"
set -ag terminal-overrides ",xterm-256color:Tc"
```
