library(stylo) 
set.seed(as.integer(Sys.time()))					#set the seed for a random generator using the current time
Files = list.files(path=".", pattern = ".txt") 
write(Files,file = "../FinalResultsReport.txt", append = FALSE, ncolumns = 1, sep = "\t")
authors <- c()
for (i in Files){
	names = unlist(strsplit(i, "[_]"))
	authorName<-names[[1]]
	if (authorName %in% authors){
	}
	else{
		authors <- c(authors,authorName)
	}
}
# print (authors)
result = c()
NUMOFTESTS = 2
# j tests
for (j in 1:NUMOFTESTS){
	if (!file.exists("../secondary_set")){
		dir.create(file.path("..", "secondary_set"))
	} 
	else{
		unlink("../secondary_set",recursive = TRUE)
		dir.create(file.path("..", "secondary_set"))
	}
	if (!file.exists("../primary_set")){
		dir.create(file.path("..", "primary_set"))
	} 
	else{
		unlink("../primary_set",recursive = TRUE)
		dir.create(file.path("..", "primary_set"))
	}
	if (!file.exists("../result")){
		dir.create(file.path("..", "result"))
	} 

 
	for (i in authors){
		#prefix
		authorName = paste(i, "_" ,sep = "")
		# print (authorName)
		#generate a list of filenames by this author temp
		temp<-list.files(path = ".", pattern = i)
		
		# dir.create(path = "../result")
		if(length(temp) >1){
			# randomly sample temp 
			temp <- sample(temp)
			# path for the first file in temp
			if (authorName == "Poe_"){
				# print ("a")
				filename = "Poe_ADream_1831.txt"
				newName = "../secondary_set/ADream_1831.txt"
				file.copy(filename, newName)
				if (temp[1] == "Poe_ADream_1831.txt"){
					filename = paste("./",temp[2], sep="")
					newName = sub("Poe_", "", temp[2])
					newName = paste("../secondary_set/", newName,sep="")
					file.copy(filename, newName)

				}
			}
			filename= paste("./",temp[1], sep="")
			# print (filename)
			# cut out the prefix
			newName = sub(authorName, "",temp[1])
			# generate the path name for that file
			newName = paste("../secondary_set/", newName,sep="")
			# copy the file to secondary set
			file.copy(filename, newName)
			

			# move others to primary set
			for (k in 2:length(temp)){
				if (temp[k] != "Poe_ADream_1831.txt"){
					filename= paste("./",temp[k], sep="")
					file.copy(filename, "../primary_set/")
				}
			}
		
		}
		else{

			filename= paste("./",temp[1], sep="")
			file.copy(filename, "../primary_set/")

		}
	}
	
	classify(gui = FALSE, path="../", training.corpus.dir = "./primary_set", test.corpus.dir = "./secondary_set")
	resultName = paste("../result/final_result", j,sep="_")	
	file.copy("../final_results.txt", resultName)
}

for (i in 1:NUMOFTESTS){

	fileName=paste("../result/final_result", i, sep="_")
	conn=file(fileName,open="r")
	linn=readLines(conn)
	result = linn[4:10]
	write(result, file = "../Results.txt", append = TRUE, sep = "")
}