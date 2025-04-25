#!/usr/bin/env python3
import sys
import os

def generate_beep():
    """Generate a beep sound that works on both Windows and Unix systems."""
    try:
        if sys.platform == "win32":
            import winsound
            winsound.Beep(1000, 500)  # 1000Hz for 500ms
        else:
            # On Unix systems, try to play a beep using system command
            os.system('play -nq -t alsa synth 0.5 sine 1000 2>/dev/null || beep -f 1000 -l 500 2>/dev/null || printf "\a"')
    except:
        # If all else fails, try the terminal bell
        print('\a', flush=True)
