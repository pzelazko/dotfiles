# Tips
# Ripgrep
It's a search tool much faster than grep.
https://github.com/BurntSushi/ripgrep

# Customized Fonts
Required for fancy symbols in your terminal.

## Nerd Fonts (recommended)
https://github.com/ryanoasis/nerd-fonts
recommended for Ubuntu:
https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf

## Powerline Fonts
https://github.com/powerline/fonts

# Terminal color schemes
## Mater terminal
solarized colorscheme:
https://github.com/oz123/solarized-mate-terminal

# YouCompleteMe
When you're using cmake to build your project, just use `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON` to generate `compile_commands.json` file with flags.

Otherwise use  [this](https://github.com/rdnetto/YCM-Generator.git)  to auto-generate `.ycm_extra_conf.py` file.

On Cygwin there's a YouCompleteMe compilation error, you need to edit two lines in `wrap_python.hpp:85-86` - the second condition `(defined(__CYGWIN__))`

# Mapping CapsLock
AutoHotKey allows to create scripts for key bindings (eg. CapsLock for both Esc and lCtrl keys)
On http://blog.danskingdom.com/category/windows-8/ there's a description on how to execute AutHotKey
on Windows startup - you need to create Task on logon with highest privileges.
Alternatively, \*.reg files create key bindings.

You can find ready-to-use scripts in [scripts](scripts).

## Ubuntu
For Ubuntu, install xcape tool.

## Mac
https://www.saltycrane.com/blog/2017/07/how-map-caps-lock-escape-when-tapped-and-control-when-held-mac-os-sierra/

# Forwarding X11 on Windows
Taken from http://kflu.github.io/2017/01/24/2017-01-24-win-x11-forward/.

On server:
1. Add to /etc/ssh/sshd_config:
AllowAgentForwarding yes
AllowTcpForwarding yes
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost no
2. Restart sshd - `service sshd restart`
3. Ensure xauth is installed

On client:

1. Run xming x server
2. In terminal (e.g. mintty) put
```bash
export DISPLAY=localhost:0.0
ssh -Y <ssh server>
```
4. Check if it's working with `xclock`

bonus: now you can share clipboard between Vim and Windows
