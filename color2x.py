import json

end_list = []

with open('/home/subado/.cache/wal/colors.json') as file:
    stock = json.load(file)

colors = []
for i in stock['colors']:
    colors.append(stock['colors'][i])

norm_fg = ["dwm.normfgcolor: ", "dwm.titlenormfgcolor: ", "dwm.tagsnormfgcolor: ", "dwm.urgfgcolor: "]

norm_bg = ["dwm.normbgcolor: ", "dwm.titlenormbgcolor: ", "dwm.tagsnormbgcolor: ", "dwm.hidnormbgcolor: ", "dwm.hidselbgcolor: ", "dwm.urgbgcolor: "]

norm_border = ["dwm.normbordercolor: ", "dwm.titlenormbordercolor: ", "dwm.tagsnormbordercolor: "]

norm_float = ["dwm.normfloatcolor: ", "dwm.titlenormfloatcolor: ", "dwm.tagsnormfloatcolor: ", "dwm.urgfloatcolor: "]

sel_fg = ["dwm.selfgcolor: ", "dwm.titleselfgcolor: ", "dwm.tagsselfgcolor: "]

sel_bg = ["dwm.selbgcolor: ", "dwm.selbordercolor: ", "dwm.selfloatcolor: ", "dwm.titleselbgcolor: ", "dwm.titleselbordercolor: ", "dwm.titleselfloatcolor: ", "dwm.tagsselbgcolor: ", "dwm.tagsselbordercolor: ", "dwm.tagsselfloatcolor: ", "dwm.hidnormfgcolor: "]

hidsel_fg = ["dwm.hidselfgcolor: "]

urg_border = ["dwm.urgbordercolor: "]

for color in norm_fg:
    string = str(color) + str(colors[7])
    end_list.append(string)

for color in norm_bg:
    string = str(color) + str(color[0])
    end_list.append(string)

for color in norm_border:
    string = str(color) + str(color[8])
    end_list.append(string)

for color in norm_float:
    string = str(color) + str(colors[13])
    end_list.append(string)

for color in urg_border:
    string = str(color) + str(colors[9])
    end_list.append(string)

for color in sel_fg:
    string = str(color) + str(colors[15])
    end_list.append(string)

for color in sel_bg:
    string = str(color) + str(colors[2])
    end_list.append(string)

for color in hidsel_fg:
    string = str(color) + str(colors[10])
    end_list.append(string)

file = open("/home/subado/.Xresources", "w")

for end_str in end_list:

    file.write(str(end_str) + '\n')

file.close()
