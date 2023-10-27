import sys

print(sys.argv)
if len(sys.argv) != 2:
  print(f"Usage: {sys.argv[0]} <filename>")
  exit(1)

def getLastEmpty(i, lines):
  for j, l in list(enumerate(lines[:i]))[::-1]:
    if not l.rstrip():
      return j

with open(sys.argv[1], 'r') as model, open(f'{sys.argv[1]}.n.txt', 'w') as part, open(f'{sys.argv[1]}.e.txt', 'w') as en:
  lines = model.read().split('\n')
  start = 0
  triggered = False
  set_start = set()
  set_stop = set()
  for i, l in enumerate(lines):
    if l.rstrip().startswith('enum'):
      stop = getLastEmpty(i, lines)
      print(start, stop, i)
      set_stop.add(stop)
      for j in range(start, stop):
        part.write(lines[j]+'\n')
      for j in range(stop, i):
        en.write(lines[j]+'\n')
      triggered = True
    if triggered:
      en.write(l+'\n')
      if l.rstrip() == '}':
        triggered = False
        start = i+1
        print(start)
    set_start.add(start)
  print(sorted(list(set_start)))
  print(sorted(list(set_stop)))
  for j in range(start, len(lines)):
    part.write(lines[j]+'\n')