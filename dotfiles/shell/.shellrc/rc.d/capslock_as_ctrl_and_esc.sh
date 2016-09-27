# startup.sh

#if [ "$TERM" = "xterm" ]; then
  # make CapsLock behave like Ctrl:
  setxkbmap -option ctrl:nocaps

  if hash xcape &> /dev/null; then
    # make short-pressed Ctrl behave like Escape:
    xcape -e 'Control_L=Escape'
  fi
#fi
