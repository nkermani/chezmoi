# #!/usr/bin/env python3
# import sys
# import subprocess
# import time
# import os
# 
# def focus_app(args):
#     if not args:
#         return
#     desktop_file = args[0]
#     extra_args = args[1:]
#     
#     subprocess.run(["gsettings", "set", "org.gnome.desktop.interface", "enable-animations", "false"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#     
#     app_name = ""
#     if "alacritty" in desktop_file:
#         app_name = "Alacritty"
#     elif "kitty" in desktop_file:
#         app_name = "kitty"
#     elif "brave" in desktop_file:
#         app_name = "brave"
#     elif "firefox" in desktop_file:
#         app_name = "firefox"
#     elif "discord" in desktop_file:
#         app_name = "discord"
#     elif "code" in desktop_file:
#         app_name = "Visual Studio Code"
#     elif "Evince" in desktop_file:
#         app_name = "evince"
#     elif "pdf" in desktop_file:
#         app_name = "evince"
#     elif "Nautilus" in desktop_file:
#         app_name = "nautilus"
#     elif "geforcenow" in desktop_file:
#         app_name = "GeForce NOW"
#     elif "obsidian" in desktop_file:
#         app_name = "obsidian"
#         
#     if app_name:
#         try:
#             res = subprocess.run(["/home/nkermani/.nkermani/bin/42/simple_focus", app_name], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#             if res.returncode == 0:
#                 return
#         except FileNotFoundError:
#             pass
# 
#     if "alacritty" in desktop_file:
#         alacritty_bin = "/home/nkermani/.nkermani/bin/alacritty"
#         if not os.path.exists(alacritty_bin):
#             alacritty_bin = "alacritty"
#         
#         env = os.environ.copy()
#         env["SHLVL"] = "0"
#         
#         subprocess.Popen([alacritty_bin] + extra_args, env=env, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "kitty" in desktop_file:
#         kitty_bin = "/home/nkermani/.nkermani/bin/kitty"
#         if not os.path.exists(kitty_bin):
#             kitty_bin = "kitty"
#         
#         env = os.environ.copy()
#         env["SHLVL"] = "0"
#         
#         subprocess.Popen([kitty_bin] + extra_args, env=env, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "code" in desktop_file:
#         subprocess.Popen(["/home/nkermani/.nkermani/bin/code"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
#     
#     if "discord" in desktop_file:
#         subprocess.Popen(["discord"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "brave" in desktop_file:
#         subprocess.Popen(["brave-browser"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "firefox" in desktop_file:
#         subprocess.Popen(["firefox"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "Nautilus" in desktop_file:
#         subprocess.Popen(["nautilus"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "Evince" in desktop_file or "pdf" in desktop_file:
#         subprocess.Popen(["evince"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "obsidian" in desktop_file:
#         subprocess.Popen(["obsidian"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if "files" in desktop_file:
#         subprocess.Popen(["nautilus"] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#         return
# 
#     if os.path.isabs(desktop_file) and os.path.exists(desktop_file):
#         try:
#             subprocess.Popen(["gio", "launch", desktop_file] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#             return
#         except:
#             pass
# 
#     paths = [
#         f"/home/nkermani/.nkermani/bin/42/{desktop_file}",
#         f"/home/nkermani/.local/share/applications/{desktop_file}",
#         f"/home/nkermani/.local/share/chezmoi/private_dot_local/private_share/private_applications/{desktop_file}"
#     ]
#     
#     for path in paths:
#         if os.path.exists(path):
#             try:
#                 subprocess.Popen(["gio", "launch", path] + extra_args, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
#                 return
#             except:
#                 continue
# 
# if __name__ == "__main__":
#     if len(sys.argv) > 1:
#         focus_app(sys.argv[1:])
