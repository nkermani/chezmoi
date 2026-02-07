#!/usr/bin/env python3
import sys
import subprocess
import time
import os

def focus_app(desktop_file):
    # Ensure animations are disabled for speed
    subprocess.run(["gsettings", "set", "org.gnome.desktop.interface", "enable-animations", "false"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
    
    app_name = ""
    if "kitty" in desktop_file:
        app_name = "kitty"
    elif "brave" in desktop_file:
        app_name = "brave"
    elif "discord" in desktop_file:
        app_name = "discord"
    elif "Evince" in desktop_file:
        app_name = "evince"
    elif "Nautilus" in desktop_file:
        app_name = "nautilus"
        
    if app_name:
        res = subprocess.run(["/home/nkermani/.nkermani/bin/42/simple_focus", app_name], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
        if res.returncode == 0:
            return

    if "Nautilus" in desktop_file:
        try:
            subprocess.run(["gdbus", "call", "--session", "--dest", "org.gnome.Nautilus", "--object-path", "/org/gnome/Nautilus", "--method", "org.gtk.Application.Activate", "{}"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
            return
        except:
            pass
    
    if "kitty" in desktop_file:
        try:
            subprocess.run(["/home/nkermani/.nkermani/apps/kitty.app/bin/kitty", "--single-instance"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
            return
        except:
            pass

    if "Evince" in desktop_file:
        return

    paths = [

        desktop_file,
        f"/usr/share/applications/{desktop_file}",
        f"/home/nkermani/.local/share/applications/{desktop_file}"
    ]
    
    for path in paths:
        if not os.path.exists(path):
            continue
            
        try:
            subprocess.run(["gio", "launch", path], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
            return
        except:
            continue

if __name__ == "__main__":
    if len(sys.argv) > 1:
        focus_app(sys.argv[1])
