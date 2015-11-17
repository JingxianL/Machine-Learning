import re
FileList = open("FinalResultsReport.txt", 'rw')
Results = open("Results.txt", 'rw')
nameList={}
for line in FileList:
	line = re.split("_", line)
	author = line[0]
	name = line[1:]
	name="".join(name)
	start = 0
	end = name.find('.', start)
	name = name[start:end]
	nameList[name] = author

print nameList

ADreamTruePos = 0
ADreamFalseNeg = 0
for line in Results:
	line = line.rstrip()
	line = re.split(' ', line)
	print line[2]
	if line[0] == "ADream_1831":
		if line[2] == "Poe":
			ADreamTruePos+=1
		else:
			ADreamFalseNeg+=1

print ADreamTruePos
print ADreamFalseNeg

PoeTruePos = 0 
PoeFalseNeg = 0
for line in Results:
	line = line.rstrip()
	line = re.split(' ', line)
	