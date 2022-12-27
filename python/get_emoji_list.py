import requests
from bs4 import BeautifulSoup
import re


def read_file(filename):
    with open(filename) as input_file:
        text = input_file.read()
    return text


url = "https://en.wikipedia.org/wiki/Emoji"
filename = "Emoji.html"

r = requests.get(url)

with open(filename, 'wb') as fd:
    for chunk in r.iter_content(chunk_size=128):
        fd.write(chunk)

text = read_file(filename)

soup = BeautifulSoup(text)
table = soup.find('table', attrs={'class': 'wikitable collapsible uncollapsed nounderlines'})
table_body = table.find('tbody')

rows = table_body.find_all('tr')
emoji_list = open('emoji_list.txt', 'w')

for row in rows:
    cols = row.find_all('td', title=True)
    for col in cols:
        emoji_name = col.get('title')
        emoji_name = re.sub(r'U(.*?)\: ', '', emoji_name)
        emoji = col.text.strip()

        emoji_list.write(emoji + ' ' + emoji_name + '\n')

emoji_list.close()
