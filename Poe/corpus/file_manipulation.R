# a = getwd()
# a = paste(a, "/corpus", sep="")
# setwd(a)
# print (getwd())
library(stylo) 
unlink("../secondary_set",recursive = TRUE)
unlink("../primary_set", recursive = TRUE)
set.seed(as.integer(Sys.time()))					#set the seed for a random generator using the current time
Files = list.files(path=".", pattern = ".txt") 
write(Files,file = "../FinalResultsReport.txt", append = FALSE, ncolumns = 1, sep = "\t")
Cooper = list.files(path = ".", pattern = "Cooper")
# print (Cooper)

# print (randCooper)				#generate a random order for indata's rows
# print (randCooper[1])

Doyle = list.files(path = ".", pattern = "Doyle")
# print (Doyle)

Hawthorne = list.files(path = ".", pattern = "Hawthorne")
# print (Hawthorne)


Irving = list.files(path = ".", pattern = "Irving")
# print (Irving)


Melville = list.files(path = ".", pattern = "Melville")
# print (Melville)


Poe = list.files(path = ".", pattern = "Poe")
# print (Poe)

dir.create(path ="../primary_set")
dir.create(path ="../secondary_set")
dir.create(path = "../result")
result = c()
for (j in 1:10){
	randCooper <- sample(Cooper)
	randDoyle <- sample(Doyle)
	randHawthorne <- sample(Hawthorne)
	randIrving <- sample(Irving)
	randMelville <- sample(Melville)
	randPoe <- sample(Poe)
	
	# Cooper 
	filename= paste("./",randCooper[1], sep="")
	newName = sub("Cooper_", "",randCooper[1])
	newName = paste("../secondary_set/", newName,sep="")
	file.copy(filename, newName)



	#Doyle 
	filename= paste("./",randDoyle[1], sep="")
	newName = sub("Doyle_", "",randDoyle[1])
	newName = paste("../secondary_set/", newName,sep="")
	file.copy(filename, newName)

	#Hawthorne 
	filename= paste("./",randHawthorne[1], sep="")
	newName = sub("Hawthorne_", "",randHawthorne[1])
	newName = paste("../secondary_set/", newName,sep="")
	file.copy(filename, newName)

	#Irving 
	filename= paste("./",randIrving[1], sep="")
	newName = sub("Irving_", "",randIrving[1])
	newName = paste("../secondary_set/", newName,sep="")
	file.copy(filename, newName)

	#Melville
	filename= paste("./",randMelville[1], sep="")
	newName = sub("Melville_", "",randMelville[1])
	newName = paste("../secondary_set/", newName,sep="")
	file.copy(filename, newName)

	#poe
	# file.copy(filename, "../secondary_set/")
	if (randPoe[1] == "Poe_ADream_1831.txt"){
		filename = paste("./",randPoe[2], sep="")
		newName = sub("Poe_", "", randPoe[2])
		newName = paste("../secondary_set/", newName,sep="")
		file.copy(filename, newName)
	}else{
		filename= paste("./",randPoe[1], sep="")
		newName = sub("Poe_", "", randPoe[1])
		newName = paste("../secondary_set/", newName,sep="")
		file.copy(filename, newName)
	}

	filename= paste("./","Poe_ADream_1831.txt", sep="")
	newName = sub("Poe_", "","Poe_ADream_1831.txt")
	newName = paste("../secondary_set/", newName,sep="")
	file.copy(filename, newName)

	# if("Poe_ADream_1831.txt" %in% names(randPoe)) randPoe <- randPoe[ - which(names(randPoe) == "Poe_ADream_1831.txt")]

	# randPoe$Poe_ADream_1831.txt <- NULL
	for (i in 2:length(randCooper)){
		filename= paste("./",randCooper[i], sep="")
		file.copy(filename, "../primary_set/")
	}

	for (i in 2:length(randDoyle)){
		filename= paste("./",randDoyle[i], sep="")
		file.copy(filename, "../primary_set/")
	}

	for (i in 2:length(randMelville)){
		filename= paste("./",randMelville[i], sep="")
		file.copy(filename, "../primary_set/")
	}

	for (i in 2:length(randIrving)){
		filename= paste("./",randIrving[i], sep="")
		file.copy(filename, "../primary_set/")
	}

	for (i in 2:length(randHawthorne)){
		filename= paste("./",randHawthorne[i], sep="")
		file.copy(filename, "../primary_set/")
	}

	for (i in 2:length(randPoe[randPoe != "Poe_ADream_1831.txt"])){

		filename= paste("./",randPoe[i], sep="")
		file.copy(filename, "../primary_set/")
		# print (randPoe[i])
	}

	classify(gui = FALSE, path="../", training.corpus.dir = "./primary_set", test.corpus.dir = "./secondary_set")
	resultName = paste("../result/final_result", j,sep="_")


	
	# result = paste(result, linn[4:10])
	

	file.copy("../final_results.txt", resultName)
}

for (i in 1:10){

	fileName=paste("../result/final_result", i, sep="_")
	conn=file(fileName,open="r")
	linn=readLines(conn)
	result = linn[4:10]
	write(result, file = "../Results.txt", append = TRUE, sep = "")
}

