#Imports a file with lines in the form "type symbolName 0xADDRESS"
#modified from the ImportSymbolsScript.py
#@category Data
#@author 
 
import re
from ghidra.util.data import DataTypeParser

f = askFile("Give me a file to open", "Go baby go!")

dtp = ghidra.util.data.DataTypeParser(None, DataTypeParser.AllowedDataTypes.ALL)

for line in file(f.absolutePath):  # note, cannot use open(), since that is in GhidraScript
    line = line.strip()
    if line == "":
        continue
    if line[0] == "#":
        #ignore comments
        continue

    pieces = re.split(r"\s+", line)
    name = pieces[1]
    address = toAddr(pieces[2])
    ts = pieces[0]
    print "creating", ts, "symbol", name, "at address", address
    if ts == "func":
        createFunction(address, name)
    else:
        t = dtp.parse(ts)
        createData(address, t)
        createLabel(address, name, False)