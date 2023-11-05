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

(Linux) The icons require the Hack Nerd fonts available from https://www.nerdfonts.com/font-downloads.

- Install the ttf fonts in ~/.fonts
- Then run:

```
fc-cache -fv
```

- If you're using gnome-terminal, be sure to restart gnome-terminal-server after updating the font cache.

# Debugger

nvim-dap assumes that lldb is installed, and provides the `lldb-vscode-14` binary.  In ubuntu 22.04, this is
provided by the `lldb` package.

```
apt-get install lldb
```
