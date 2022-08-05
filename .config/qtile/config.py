import os
import re
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile import layout, bar, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule
from libqtile.command import lazy
from libqtile.widget import Spacer
# import arcobattery

# VARIABLES
mod = "mod4"  # Set mod key to SUPER (WinKey)
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')
# my_term = "alacritty"
# my_browser = "firefox"


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


# KEYBINDINGS + ~/.config/qtile/sxhkd/sxhkdrc (shared WMs keybindings)
keys = [

    # SUPER + FUNCTION KEYS
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),

    # SUPER + SHIFT KEYS
    Key([mod, "shift"], "r", lazy.restart()),
    # Key([mod, "shift"], "q", lazy.window.kill()),

    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),

    # CHANGE FOCUS
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

    # ROTATE THROUGH WINDOWS IN GROUP
    Key([mod], "Left", lazy.group.prev_window()),
    Key([mod], "Right", lazy.group.next_window()),


    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),

    # FLIP LAYOUT FOR BSP
    # Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    # Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    # Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    # Key([mod, "mod1"], "h", lazy.layout.flip_left()),

    # MOVE WINDOWS UP OR DOWN BSP LAYOUT
    # Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    # Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    # Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    # Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    # Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    # Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    # Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    # Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
]

groups = []

# FOR QWERTY KEYBOARDS
group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]

# icons:                 discord:ﭮ           cloud: 樂             ﲳ ﲴ ﴔ ﯢ ﱘ   robot:ﮧ 嗢
group_labels = ["", "", "", "", "", "", "ﭮ", ""]
# group_labels = ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "0"]

group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]
# group_layouts = ["monadtall", "matrix", "monadtall", "bsp", "monadtall", "matrix", "monadtall", "bsp", "monadtall", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend([
        # CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift"], "Tab", lazy.screen.prev_group()),

        # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),

        # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), lazy.group[i.name].toscreen()),
    ])

# LAYOUT VARIABLES
gaps = 5
border_width = 2
border_focus_color = "#fc5d7c"
border_normal_color = "#595f6f"


def init_layout_theme():
    return {
        "margin": gaps,
        "border_width": border_width,
        "border_focus": border_focus_color,
        "border_normal": border_normal_color
    }


layout_theme = init_layout_theme()
layouts = [
    layout.MonadTall(margin=8, border_width=border_width, border_focus=border_focus_color, border_normal=border_normal_color),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Matrix(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Stack(**layout_theme),
    # layout.Spiral(**layout_theme),
    # layout.MonadWide(margin=8, border_width=border_width, border_focus=border_focus_color, border_normal=border_normal_color),
    # layout.Bsp(**layout_theme),
]


# COLORS FOR THE BAR
# Theme name : Gruvbox
# def init_colors():
#     return [
#         ["#282828", "#282828"],  # color 0  # black/background
#         ["#cc241d", "#cc241d"],  # color 1  # red
#         ["#98971a", "#98971a"],  # color 2  # green
#         ["#d79921", "#d79921"],  # color 3  # yellow
#         ["#458588", "#458588"],  # color 4  # blue
#         ["#b16286", "#b16286"],  # color 5  # magenta/purple
#         ["#689d6a", "#689d6a"],  # color 6  # cyan/aqua
#         ["#a89984", "#a89984"],  # color 7  # white/gray
#         ["#928374", "#928374"],  # color 8  # gray
#         ["#fb4934", "#fb4934"],  # color 9  # red_alt
#         ["#b8bb26", "#b8bb26"],  # color 10 # green_alt
#         ["#fabd2f", "#fabd2f"],  # color 11 # yellow_alt
#         ["#83a598", "#83a598"],  # color 12 # blue_alt
#         ["#d3869b", "#d3869b"],  # color 13 # magenta_alt
#         ["#8ec07c", "#8ec07c"],  # color 14 # cyan_alt
#         ["#ebdbb2", "#ebdbb2"],  # color 15 # white/foreground
#     ]
#
#
# colors = init_colors()

# Theme name : Monokai
def init_colors():
    return [
        ["#181819", "#181819"],  # color 0  # black/background
        ["#fc5d7c", "#fc5d7c"],  # color 1  # red
        ["#9ed072", "#9ed072"],  # color 2  # green
        ["#e7c664", "#e7c664"],  # color 3  # yellow
        ["#76cce0", "#76cce0"],  # color 4  # blue
        ["#b39df3", "#b39df3"],  # color 5  # magenta/purple
        ["#f39660", "#f39660"],  # color 6  # cyan/aqua/orange
        ["#7f8490", "#7f8490"],  # color 7  # white/gray
        ["#595f6f", "#595f6f"],  # color 8  # gray
        ["#55393d", "#55393d"],  # color 9  # red_alt
        ["#394634", "#394634"],  # color 10 # green_alt
        ["#4e432f", "#4e432f"],  # color 11 # yellow_alt
        ["#354157", "#354157"],  # color 12 # blue_alt
        ["#b39df3", "#b39df3"],  # color 13 # magenta_alt
        ["#f39660", "#f39660"],  # color 14 # cyan_alt
        ["#e2e2e3", "#e2e2e3"],  # color 15 # white_alt/foreground
        ['#2c2e34', '#2c2e34'],  # color 16 # bg0
    ]


colors = init_colors()

# BAR VARIABLES

# Fonts
font = "mononoki Nerd Font Mono"  # default text & icon font
fontsize = 14

# Icons
bar_icon_size = 26
monitoring_icon_size = 22
tray_icon_size = 20

# Colors
background = colors[16]
foreground = colors[15]

# Separators
sep_linewidth = 2
sep_padding = 10
sep_size_percent = 100


# WIDGETS FOR THE BAR
def init_widgets_defaults():
    return dict(
        font=font,
        fontsize=14,
        padding=2,
        background=background,
        foreground=foreground
    )


widget_defaults = init_widgets_defaults()


def init_widgets_list():
    # prompt = f"{os.environ['USER']}@{socket.gethostname()}: "
    # prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

    widgets_list = [
        widget.Spacer(
            length=5
        ),
        # WORKSPACES
        widget.GroupBox(
            font=font,
            fontsize=bar_icon_size,
            padding_x=14,
            highlight_color=background,  # highlight box color (same as bg)
            highlight_method="line",
            block_highlight_text_color=colors[1],  # focus text/icon color
            this_current_screen_border=colors[1],  # bottom border color when focus
            borderwidth=2,  # bottom border width
            active=colors[5],  # open windows
            inactive=colors[8],  # no windows
            disable_drag=True,
            rounded=False,
            center_aligned=True,
            hide_unused=False,
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # WINDOW
        widget.WindowName(
            font=font,
            fontsize=fontsize,
            foreground=colors[1]
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # LAYOUT
        widget.CurrentLayout(
            font=font,
            fontsize=fontsize,
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # KEYBOARD LAYOUT
        widget.KeyboardLayout(
            background=background,
            configured_keyboards=["us", "es"],
            display_map={
                "us": "EN",
                "es": "ES"
            },
            fontsize=fontsize,
            update_interval=1
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # THERMALSENSOR 﨏
        widget.TextBox(
            fontsize=monitoring_icon_size,
            text="  ",
            padding=0,
            # foreground=["#cc241d", "#458588"]  # from blue to red
            foreground=colors[4]  # from blue to red
        ),
        widget.ThermalSensor(
            font=font,
            fontsize=fontsize,
            fmt="TEMP {} ",
            foreground=foreground,
            metric=True,
            padding=3,
            threshold=80,
            foreground_alert=colors[1],
            tag_sensor="edge"
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # RAM
        widget.TextBox(
            fontsize=monitoring_icon_size,
            text=" ﯟ ",
            padding=0,
            foreground=colors[2]
        ),
        widget.Memory(
            format="MEM {MemUsed:.0f}M ",
            measure_mem="M",
            update_interval=1,
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # CPU
        widget.TextBox(
            fontsize=monitoring_icon_size,
            text="  ",
            foreground=colors[6],
            padding=0,
        ),
        widget.CPU(
            format="CPU {load_percent}% ",
            update_interval=1.0
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # DATETIME
        widget.TextBox(
            font=font,
            fontsize=monitoring_icon_size,
            text="  ",
            # text="  ",
            foreground=colors[3],
            padding=0,
        ),
        widget.Clock(
            format="%d/%m/%Y %H:%M:%S ",
            udpate_internal=1.0
        ),
        widget.Sep(
            linewidth=sep_linewidth,
            padding=sep_padding,
            size_percent=sep_size_percent
        ),
        # SYSTRAY
        widget.Systray(
            icon_size=tray_icon_size,
            padding=4,
        ),
        widget.Spacer(
            length=5
        ),
    ]
    return widgets_list


widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2


widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()


def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26, opacity=0.8)),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26, opacity=0.8))
    ]


screens = init_screens()


# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []

# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME
# BEGIN

#########################################################
################ assgin apps to groups ##################
#########################################################
# @hook.subscribe.client_new
# def assign_app_group(client):
#     d = {}
#     #####################################################################################
#     ### Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient ###
#     #####################################################################################
#     d[group_names[0]] = ["Navigator", "Firefox", "Vivaldi-stable", "Vivaldi-snapshot", "Chromium", "Google-chrome", "Brave", "Brave-browser",
#               "navigator", "firefox", "vivaldi-stable", "vivaldi-snapshot", "chromium", "google-chrome", "brave", "brave-browser", ]
#     d[group_names[1]] = [ "Atom", "Subl", "Geany", "Brackets", "Code-oss", "Code", "TelegramDesktop", "Discord",
#                "atom", "subl", "geany", "brackets", "code-oss", "code", "telegramDesktop", "discord", ]
#     d[group_names[2]] = ["Inkscape", "Nomacs", "Ristretto", "Nitrogen", "Feh",
#               "inkscape", "nomacs", "ristretto", "nitrogen", "feh", ]
#     d[group_names[3]] = ["Gimp", "gimp" ]
#     d[group_names[4]] = ["Meld", "meld", "org.gnome.meld" "org.gnome.Meld" ]
#     d[group_names[5]] = ["Vlc","vlc", "Mpv", "mpv" ]
#     d[group_names[6]] = ["VirtualBox Manager", "VirtualBox Machine", "Vmplayer",
#               "virtualbox manager", "virtualbox machine", "vmplayer", ]
#     d[group_names[7]] = ["Thunar", "Nemo", "Caja", "Nautilus", "org.gnome.Nautilus", "Pcmanfm", "Pcmanfm-qt",
#               "thunar", "nemo", "caja", "nautilus", "org.gnome.nautilus", "pcmanfm", "pcmanfm-qt", ]
#     d[group_names[8]] = ["Evolution", "Geary", "Mail", "Thunderbird",
#               "evolution", "geary", "mail", "thunderbird" ]
#     d[group_names[9]] = ["Spotify", "Pragha", "Clementine", "Deadbeef", "Audacious",
#               "spotify", "pragha", "clementine", "deadbeef", "audacious" ]
#     ######################################################################################
#
# wm_class = client.window.get_wm_class()[0]
#
#     for i in range(len(d)):
#         if wm_class in list(d.values())[i]:
#             group = list(d.keys())[i]
#             client.togroup(group)
#             client.group.cmd_toscreen(toggle=False)

# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME


main = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]

follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(wm_class='Arcolinux-welcome-app.py'),
        Match(wm_class='Arcolinux-tweak-tool.py'),
        Match(wm_class='Arcolinux-calamares-tool.py'),
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='Arandr'),
        Match(wm_class='feh'),
        Match(wm_class='Galculator'),
        Match(wm_class='arcolinux-logout'),
        Match(wm_class='xfce4-terminal'),
    ],  fullscreen_border_width=0, border_width=0
)
auto_fullscreen = True

focus_on_window_activation = "smart"  # or smart

wmname = "LG3D"

# --- Copyright (C) and Licence ---
# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage

# Modified by Juan Gajardo (monk3yd)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
