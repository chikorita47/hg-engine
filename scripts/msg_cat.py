import os.path
from os import listdir, replace
from os.path import isfile, join, isdir
import sys

caps_list = ['751', '817']

article_list = ['238']

force_lengths = {
    '812': 11,
    '813': 11,
    '814': 7,
    '815': 7,
}

hg_pt_map = {
    '003': '000',
    '197': '368',
    '221': '391',
    '222': '392',
    '223': '393',
    '237': '412',
    '238': '413', # check this
    '720': '610',
    '721': '611',
    '722': '612',
    '729': '618', # check this
    '749': '646',
    '750': '647',
    '751': '648',
    '803': '706',
    '812': '707',
    '813': '708',
    '814': '709',
    '815': '710',
    '816': '711',
    '817': '712',
}


def sorter(e):
    return int(e.split('.')[0])


def main():
    if (sys.argv[1] == '--move-pt'):
        move_pt(sys.argv[2])
    else:
        rawtext = sys.argv[1]
        onlydirs = [f for f in listdir(rawtext) if isdir(join(rawtext, f))]
        for dir in onlydirs:
            process_text(os.path.join(rawtext, dir))


def process_text(folder):
    if isfile(folder):
        return
    caps = False
    articles = False
    force_length = ''
    for s in caps_list:
        if folder.endswith(s):
            caps = True
            break
    for s in article_list:
        if folder.endswith(s):
            articles = True
            break
    for s in force_lengths.keys():
        if folder.endswith(s):
            force_length = s
            break
    onlyfiles = [f for f in listdir(folder) if isfile(join(folder, f))]
    onlyfiles.sort(key=sorter)
    with open(folder + '.txt', 'w', encoding='utf-8') as out:
        for file in onlyfiles:
            with open(os.path.join(folder, file), 'r', encoding='utf-8') as infile:
                s = infile.read().replace('"','”').replace('\'','’').replace('`','’')
                if caps:
                    s = s.upper()
                if articles:
                    s = ('an ' if s.upper().startswith('A') or s.upper().startswith('E') or s.upper().startswith('I') or s.upper().startswith('O') or s.upper().startswith('U') else 'a ') + s
                if s != '':
                    if force_length != '':
                        while len(s) < force_lengths[force_length]:
                            s = ' ' + s
                out.write(s + '\n')


def move_pt(file):
    replace(file, join(os.path.dirname(file), 'pl_msg_'+hg_pt_map[os.path.basename(file).replace('7_', '')]))


if __name__ == '__main__':
    main()