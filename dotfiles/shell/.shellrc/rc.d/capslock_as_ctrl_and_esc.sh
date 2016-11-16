# startup.sh

# make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps 2>/dev/null

if hash xcape &> /dev/null; then
  # make short-pressed Ctrl behave like Escape:
  xcape -e 'Control_L=Escape'
fi
