#/usr/bin/python

import sys
import re

lines = sys.argv[1]
ms_thresh = int(sys.argv[2])

lines = lines.split("\n")
lines = map(str.strip, lines)

events = ( (float(event[0]), event[1])
           for event in (tuple(line.split(" :: ")) for line in lines) )

first = next(events)
start = first[0]
end = 0
prev = start

durations = []
for event in events:
    time, label = event
    duration = time - prev
    prev = time
    durations.append((duration, label))
    end = time

total = end - start

durations.sort(key=lambda x: x[0], reverse=True)
for dur, lab in durations:
    if dur * 1000 < ms_thresh:
        break
    print "{:4.1f} ms  {:5.2f}% :: {}".format(dur * 1000, dur / total * 100, lab)

print "-" * 60
print "{:4.1f} ms :: {}".format(total * 1000, "Total Time")
