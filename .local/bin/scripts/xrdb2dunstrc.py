import subprocess
import configparser
import os

configPath = "/home/subado/.config/dunst/dunstrc"

if not os.path.exists(configPath):
    print("dunstrc not found")
    exit

# Read dunstrc
config = configparser.ConfigParser()
config.read(configPath)


def colorSet(section: str, option: str, color: str):
    config.set(section, option, '"' + color + '"')


data = subprocess.check_output("xrdb -query | grep *. | cut -c 3-", shell=True, universal_newlines=True)
data = data.split()
theme = {}
for i in range(0, len(data), 2):
    theme[data[i].strip(":")] = data[i + 1]

# Set global colors
colorSet("global", "frame_color", theme['color8'])

# Set urgency_low colors
colorSet("urgency_low", "background", theme['background'])
colorSet("urgency_low", "foreground", theme['color15'])
colorSet("urgency_low", "highlight", theme['color2'])

# Set urgency_normal colors
colorSet("urgency_normal", "background", theme['background'])
colorSet("urgency_normal", "foreground", theme['foreground'])
colorSet("urgency_normal", "highlight", theme['color4'])

# Set urgency_critical colors
colorSet("urgency_critical", "background", theme['background'])
colorSet("urgency_critical", "foreground", theme['color9'])
colorSet("urgency_critical", "highlight", theme['color1'])

# Write changes in config to config file
with open(configPath, "w") as configFile:
    config.write(configFile)
