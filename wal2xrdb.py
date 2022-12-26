import json

final_list = []

with open('/home/subado/.cache/wal/colors.json', "r") as file:
    data = json.load(file)

colors = []
for i in data['colors']:
    colors.append(data['colors'][i])


def set_color(names: list, color_id: int):
    for i in names:
        final_list.append(i + ": " + str(colors[color_id]))


norm_fg = ["dwm.normfgcolor", "dwm.titlenormfgcolor", "dwm.tagsnormfgcolor", "dwm.urgfgcolor", "dmenu.foreground", "dmenu.outforeground"]

norm_bg = ["dwm.normbgcolor", "dwm.titlenormbgcolor", "dwm.tagsnormbgcolor", "dwm.hidnormbgcolor", "dwm.hidselbgcolor", "dwm.urgbgcolor", "dmenu.background", "dmenu.outbackground"]

norm_border = ["dwm.normbordercolor", "dwm.titlenormbordercolor", "dwm.tagsnormbordercolor"]

norm_float = ["dwm.normfloatcolor", "dwm.titlenormfloatcolor", "dwm.tagsnormfloatcolor", "dwm.urgfloatcolor"]

sel_fg = ["dwm.selfgcolor", "dwm.titleselfgcolor", "dwm.tagsselfgcolor"]

sel_bg = ["dwm.selbgcolor", "dwm.selbordercolor", "dwm.selfloatcolor", "dwm.titleselbgcolor", "dwm.titleselbordercolor", "dwm.titleselfloatcolor", "dwm.tagsselbgcolor", "dwm.tagsselbordercolor", "dwm.tagsselfloatcolor", "dwm.hidnormfgcolor", "dmenu.selbackground"]

hidsel_fg = ["dwm.hidselfgcolor"]

urg_border = ["dwm.urgbordercolor"]

set_color(norm_fg, 7)
set_color(norm_bg, 0)
set_color(norm_border, 8)
set_color(norm_float, 13)
set_color(urg_border, 9)
set_color(sel_fg, 15)
set_color(sel_bg, 2)
set_color(hidsel_fg, 10)

file = open("/home/subado/.Xresources", "w")

for i in final_list:
    file.write(i + '\n')

file.close()
