import re

def findTerminatorIdcs(text):
    tIdcs = []
    terminators = re.compile('(?s:.)([\\.!?"])(?s:.)')
    matches = re.finditer(terminators, text)

    for m in matches:
        tIdx = m.start(1)
        print(tIdx)

        prev = text[tIdx-1]
        term = text[tIdx]
        after = text[tIdx+1]

        if term == '"':
            if after == "\n":
                tIdcs.append(tIdx)

        elif term == ".":
            if after != "." and prev != ".":
                tIdcs.append(tIdx)

        else:
            tIdcs.append(tIdx)

    return tIdcs

# def splitByLineCount(text, count):
#     splits = []
#
#     tIdcs = findTerminatorIdcs(text)
#
#     lIdx = 0
#     rIdx = count
#     while rIdx < len(splits):
#         splits.append(text[lIdx:rIdx])
#         lIdx = rIdx
#         rIdx+=count
#
#     splits.append(text[lIdx:])
#
#     return splits
