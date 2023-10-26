import json
from json.decoder import JSONDecodeError
import os
import traceback
import sys

print(sys.argv)
if len(sys.argv) != 7:
  print("Usage: ")
  exit(1)
[generatedPath, fixedPath, savedPath, hintsFilePath, newHintsFilePath, matchMode] = sys.argv[1:]
print(generatedPath, fixedPath, savedPath, hintsFilePath, newHintsFilePath, matchMode)

generatedFiles = [f for f in os.listdir(generatedPath) if os.path.isfile(os.path.join(generatedPath, f))]
generated = {f: os.path.join(generatedPath, f) for f in generatedFiles}
saved = {f: os.path.join(savedPath, f) for f in generatedFiles}
fixedFiles = [f for f in os.listdir(fixedPath) if os.path.isfile(os.path.join(fixedPath, f))]
fixed = {f: os.path.join(fixedPath, f) for f in fixedFiles}

print(generated, fixed)

# Abort if the files are not same in examples and fixed
print(set(generated.keys()) != set(fixed.keys()))
if set(generated.keys()) != set(fixed.keys()):
  newFiles = [f for f in generated if f not in fixed]
  print(f'New {len(newFiles)} {newFiles}')
  missingFiles = [f for f in fixed if f not in generated]
  print(f'Missing {len(missingFiles)} {missingFiles}')
  if matchMode == 'strict':
    exit(1)
  elif matchMode == 'mixNew':
    for f in newFiles:
      fixed[f] = generated[f]
  elif matchMode == 'mixMissing':
    for f in missingFiles:
      generated[f] = fixed[f]
      saved[f] = fixed[f]
  elif matchMode == 'mixAll':
    for f in newFiles:
      fixed[f] = generated[f]
    for f in missingFiles:
      generated[f] = fixed[f]
      saved[f] = fixed[f]
  else:
    print(f"Invalid match mode {matchMode}")

def checkPath(path:str, hints):
  splits = path.split('.')
  for i in range(len(splits)):
    nPath = ".".join(splits[:i+1])
    # print("froward", nPath)
    if nPath in hints:
      return hints[nPath]
  for i in range(len(splits)-1):
    nPath = "." + ".".join(splits[len(splits)-1-i:])
    # print("backward", nPath)
    if nPath in hints:
      return hints[nPath]
  return None

def reUseMissing(pPath:str, k:str, hints):
  path = f'{pPath}.{k}'
  splits = path.split('.')
  for i in range(len(splits)):
    nPath = ".".join(splits[:i+1])
    # print("froward", nPath)
    if nPath in hints['ReUseMissing']:
      return True
  for i in range(len(splits)-1):
    nPath = "." + ".".join(splits[len(splits)-1-i:])
    # print("backward", nPath)
    if nPath in hints['ReUseMissing']:
      return True
  return False

def isIgnored(pPath:str, k:str, hints, isNew=True):
  path = f'{pPath}.{k}'
  splits = path.split('.')
  for i in range(len(splits)):
    nPath = ".".join(splits[:i+1])
    # print("froward", nPath)
    if nPath in hints['IgnoreNew' if isNew else 'IgnoreMissing']:
      return True
  for i in range(len(splits)-1):
    nPath = "." + ".".join(splits[len(splits)-1-i:])
    # print("backward", nPath)
    if nPath in hints['IgnoreNew' if isNew else 'IgnoreMissing']:
      return True
  return False


  
def compareDict(gDict, fDict, hints, path=''):
  # print(type(gDict), type(fDict), path)
  anyHint = checkPath(path, hints)
  print("checkPath", path, anyHint)
  if anyHint:
    return anyHint
  if type (gDict) != type (fDict):
    print(f'Type mismatch at {path}')
    raise TypeError()
  if path.endswith('.tags'):
    return [{"key": "keyName", "value": "value"}] if type(gDict) == type([]) else {"tagName": "value"}
  if type(gDict) == type(['']) and len(gDict) != len(fDict):
    print(f'Array length mismatch at {path}')
    raise TypeError()
  if type(gDict) == type(['']):
    for i in range(len(gDict)):
      gDict[i] = compareDict(gDict[i], fDict[i], hints, f'{path}[{i}]')
      print(gDict)
  elif type(gDict) == type({}):
    fKeys = set(fDict.keys())
    gKeys = set(gDict.keys())
    mergedKeys = list(fKeys|gKeys)
    for k in mergedKeys:
      if k in gDict:
        if k not in fDict:
          print(f'New key {k} at {path}')
          if not isIgnored(path, k, hints):
            raise KeyError()
          hints[f'{path}.{k}'] = gDict[k]
        else:
          gDict[k] = compareDict(gDict[k], fDict[k], hints, f'{path}.{k}')
      elif k in fDict:
        if k not in gDict:
          print(f'Missing key {k} at {path}')
          if reUseMissing(path, k, hints):
            gDict[k] = fDict[k]
            print(f'ReUsed: Missing key {k} at {path}')
          elif not isIgnored(path, k, hints, False):
            raise KeyError()
  else:
    print(f'{path}: {gDict} {fDict}')
    k = path.split('.')[-1]
    if k not in hints:
      hints[k] = set()
    hints[k].add(fDict)
    if path not in hints:
      hints[path] = set()
    hints[path].add(fDict)
    # print(hints)
    gDict = fDict
  return gDict

# Merge Examples with Fixed
hints = None
FailedComparisons = []
with open(hintsFilePath) as hintsFile:
  try:
    hints = json.load(hintsFile)
  except json.JSONDecodeError:
    pass
  if not hints:
    hints = {}
  for key in generated:
    gDict = None
    isCompleted = False
    k = [generated[key], fixed[key], saved[key]]
    try:
      with open(k[0]) as gDictFile, open(k[1]) as fDictFile:
          gDict = json.load(gDictFile)
          fDict = json.load(fDictFile)
          oDict = compareDict(gDict, fDict, hints, os.path.basename(k[0]))
          isCompleted = True
          # print(f'Success: Compare {k}')
    except:
      traceback.print_exc()
      print(f'Failed: Compare {k}')
    if isCompleted:
      with open(k[2], "w") as outFile:
        json.dump(gDict, outFile, indent=2, sort_keys=True)
        outFile.write("\n")
    else:
      FailedComparisons += [k[:2]]

# Check for duplicates in new hints
multiHints = []
for k in hints:
  if type(hints[k]) == type(set()):
    if len(hints[k]) == 1:
      hints[k] = list(hints[k])[0]
    else:
      hints[k] = list(hints[k])
      multiHints += [k]
print("Duplicate Values for:", multiHints)

# Dump new hints
with open(newHintsFilePath, "w") as newHintsFile:
  json.dump(hints, newHintsFile, sort_keys=True, indent=2)
  newHintsFile.write("\n")

print("FailedComparisons", FailedComparisons)