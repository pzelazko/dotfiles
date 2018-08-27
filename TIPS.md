# Tips
# The Silver Searcher
It's a code searching tool much faster than grep.
* On linux: https://github.com/ggreer/the_silver_searcher
* On windows/cygwin: https://github.com/ggreer/the_silver_searcher/wiki/Windows


# Powerline Fonts
Required for fancy airline symbols.
https://github.com/powerline/fonts

solarized colorscheme for mate terminal:
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

For Ubuntu, install xcape tool.

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
