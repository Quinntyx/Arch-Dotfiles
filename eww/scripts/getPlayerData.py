#!/bin/python3.10

from gi.repository import Playerctl, GLib
import os 

player = Playerctl.Player()

wlist = [
    "Monstercat",
    "Monstercat Uncaged",
    "Monstercat Instinct",
    "NoCopyrightSounds",
    "Trap Nation",
    "Skylest",
    "Aria",
    "Asuna",
    "CloudKid",
    "AirwaveMusicTV",
    "MrMoMMusic"
]


def splitByLayer(string, delim=' ', onlyspaced=False):
    """
    Splits only the outermost layer of string. 
    """
    brackets = "([<"
    ending = ")]>"
    out = []
    temp = []
    level = 0
    prevspace = False
    for i in string:
        if i == delim and level <= 0:
            if (not onlyspaced) or (onlyspaced and prevspace):
                out.append(''.join(temp))
                temp = []
            else:
                temp.append(i)
            continue
        if i in brackets:
            level += 1
            if not level > 1: 
                out.append(''.join(temp))
                temp = [i]
        elif i in ending:
            level -= 1
            temp.append(i)
            out.append(''.join(temp))
            temp = []
        else:
            temp.append(i)
        if onlyspaced and i == ' ': prevspace = True
        else: prevspace = False

    if temp: out.append(''.join(temp))

    return out


def multiSplit(string, delim):
    out = []
    temp = []
    for i in string:
        if i in delim:
            out.append(''.join(temp))
            temp = []
            continue
        temp.append(i)
    out.append(''.join(temp))
    return out


def extractFeat(featString):
    if featString.startswith('('):
        featString = featString[1:-1]
    print(featString)

    featString = ' '.join(featString.split()[1:])
    print(featString)
    return [i.strip() for i in multiSplit(featString, ',&')]


def extract(title):
    """
    A method that will return the artists extracted from the video's title, and a title with those segments removed. 
    """
    source = "other"
    title = title.strip(' -')
    stitle = splitByLayer(title, '-', True)
    if '-' in title:
        # has dash, usually attributes artist. 
        if title.endswith("YouTube"):
            # is yt video, crop off the end. 
            stitle.pop()
            source = "yt"
            if stitle[0].startswith('('):
                del stitle[0]
        

        stitle = [i for i in stitle if i]

        print("asdf", stitle)

        stitle = [i for i in stitle if not i.startswith('[')]
        print("asdfg", stitle)
        while stitle[0].startswith('(') or not stitle[0]:
            # prepended segments
            del stitle[0]
        stitle = [i.strip() for i in stitle if i.strip()]
        artists = multiSplit(stitle[0], ',&')
        stitle = stitle[1:]
    else: 
        stitle = [i for i in stitle if i]

        stitle = [i for i in stitle if not i.startswith('[')]
        while stitle[0].startswith('(') or not stitle[0]:
            # prepended segments
            del stitle[0]

        artists = []

    atitle = []
    for i in stitle:
        atitle.extend(splitByLayer(i))
    stitle = atitle

    print(stitle)
    print(artists)

    for n, i in enumerate(stitle):
        print(n, i)
        if ("ft" in i or "feat." in i) and i.startswith("("):
            artists.extend(extractFeat(i))
            print(i)
            break
        elif "ft" in i or "feat." in i:
            # we gotta do some more complex stuff to search for end
            if ',' in ''.join(stitle[n:]):
                # rule out situation where theres only one feat artist
                featstring = stitle[n:]
                while not featstring[-2].endswith(','):
                    featstring.pop()
                artists.extend(extractFeat(' '.join(featstring)))
            else:
                print("n:", n, "i:", i, stitle[n:n + 2], "seg", stitle)
                featstring = stitle[n:n + 2]
                # no comma just go
                artists.extend(extractFeat(' '.join(featstring)))
            print(featstring)
            break
    
    print("def", stitle)

    try: del stitle[n + 1:n + len(featstring) + 1]
    except: pass

    stitle = [i for i in stitle if "ft" not in i and "feat" not in i]

    title = ' '.join([i for i in stitle if i])

    artists = [i for i in list(set([i.strip() for i in artists])) if i]
    print(artists)
    title = title.strip()

    return artists, title, source
    

def metadata_format(player, metadata):
    try:
        artists, title, source = extract(metadata['xesam:title'])
        if not artists: artists = metadata['xesam:artist']
        for i in metadata['xesam:artist']:
            if i not in wlist and i not in artists:
                artists.append(i)
    
        with open('/tmp/title.tmp', 'w') as f:
            f.write(title)

        with open('/tmp/artists.tmp', 'w') as f:
            f.write(', '.join(artists))
            # os.system(f"dunstify '{fstr}'")

        with open('/tmp/number.tmp', 'w') as f:
            f.write(str(metadata['xesam:trackNumber']))

    except Exception as e:
        os.system(f"dunstify 'Media Encountered Fatal Error' '{e}'")
        raise e

if __name__ == "__main__":
    player.connect('metadata', metadata_format)
    GLib.MainLoop().run()

