#!/usr/bin/env python3
import sys
import subprocess
import time
import os

def focus_app(desktop_file):
    subprocess.run(["gsettings", "set", "org.gnome.desktop.interface", "enable-animations", "false"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
    
    app_name = ""
    if "alacritty" in desktop_file:
        app_name = "Alacritty"
    elif "brave" in desktop_file:
        app_name = "brave"
    elif "discord" in desktop_file:
        app_name = "discord"
    elif "code" in desktop_file:
        app_name = "code"
    elif "Evince" in desktop_file:
        app_name = "evince"
    elif "Nautilus" in desktop_file:
        app_name = "nautilus"
    elif "geforcenow" in desktop_file:
        app_name = "GeForce NOW"
        
    if app_name:
        res = subprocess.run(["/home/nkermani/.nkermani/bin/42/simple_focus", app_name], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
        if res.returncode == 0:
            return

    if "alacritty" in desktop_file:
        alacritty_bin = "/home/nkermani/.nkermani/bin/alacritty"
        if not os.path.exists(alacritty_bin):
            alacritty_bin = "alacritty"
        
        env = os.environ.copy()
        env["SHLVL"] = "0"
        
        subprocess.Popen([alacritty_bin], env=env, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
        return

    paths = [
        desktop_file,
        f"/usr/share/applications/{desktop_file}",
        f"/home/nkermani/.local/share/applications/{desktop_file}",
        f"/home/nkermani/.local/share/chezmoi/private_dot_local/private_share/private_applications/{desktop_file}"
    ]
    
    for path in paths:
        if os.path.exists(path):
            try:
                subprocess.Popen(["gio", "launch", path], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
                return
            except:
                continue

    if "code" in desktop_file:
        subprocess.Popen(["code"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
    elif "discord" in desktop_file:
        subprocess.Popen(["discord"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        focus_app(sys.argv[1])
