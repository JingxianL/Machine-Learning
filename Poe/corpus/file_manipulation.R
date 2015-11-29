library(stylo) 

set.seed(as.integer(Sys.time()))					#set the seed for a random generator using the current time
Files = list.files(path=".", pattern = ".txt") 
write(Files,file = "../FinalResultsReport.txt", append = FALSE, ncolumns = 1, sep = "\t")

#Sys.glob(),

authors = c("CarolineGilman", 
	"Cooper", 
	"Doyle", 
	"EdwardsLytton",
	"EganPierce",
	"FerrierEdmonstone",
	"Hawthorne", 
	"Irving",
	"JamesCooper",
	"JohnBowring",
	"JohnGalt",
	"MariaEdgeworth", 
	"Melville", 
	"Poe",
	"RoberSouthey",
	"ThomasQuincey",
	"WalterScott",
	"WilliamAinsworth",
	"WilliamGodwin"
)



# result = c()
dir.create(path = "../result")
# j tests
for (j in 1:2){
	unlink("../secondary_set",recursive = TRUE)
	unlink("../primary_set", recursive = TRUE)
	dir.create(path ="../secondary_set")
	dir.create(path ="../primary_set")
	
	# for each author, 
	for (i in authors){
		#prefix
		authorName = paste(i, "_" ,sep = "")
		#generate a list of filenames by this author temp
		temp<-list.files(path = ".", pattern = i)
		
		# dir.create(path = "../result")
		if(length(temp) >1){
			# randomly sample temp 
			temp <- sample(temp)
			# path for the first file in temp
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
				filename= paste("./",temp[k], sep="")
				file.copy(filename, "../primary_set/")
			}
		}
		else{

			filename= paste("./",temp[1], sep="")
			file.copy(filename, "../primary_set/")

		}
		
		
	}
	
	# #poe
	# # file.copy(filename, "../secondary_set/")
	# if (randPoe[1] == "Poe_ADream_1831.txt"){
	# 	filename = paste("./",randPoe[2], sep="")
	# 	newName = sub("Poe_", "", randPoe[2])
	# 	newName = paste("../secondary_set/", newName,sep="")
	# 	file.copy(filename, newName)
	# }else{
	# 	filename= paste("./",randPoe[1], sep="")
	# 	newName = sub("Poe_", "", randPoe[1])
	# 	newName = paste("../secondary_set/", newName,sep="")
	# 	file.copy(filename, newName)
	# }

	# filename= paste("./","Poe_ADream_1831.txt", sep="")
	# newName = sub("Poe_", "","Poe_ADream_1831.txt")
	# newName = paste("../secondary_set/", newName,sep="")
	# file.copy(filename, newName)

	# # if("Poe_ADream_1831.txt" %in% names(randPoe)) randPoe <- randPoe[ - which(names(randPoe) == "Poe_ADream_1831.txt")]

	# # randPoe$Poe_ADream_1831.txt <- NULL
	# for (i in 2:length(randCooper)){
	# 	filename= paste("./",randCooper[i], sep="")
	# 	file.copy(filename, "../primary_set/")
	# }

	

	classify(gui = FALSE, path="../", training.corpus.dir = "./primary_set", test.corpus.dir = "./secondary_set")
	resultName = paste("../result/final_result", j,sep="_")


	
	# result = paste(result, linn[4:10])
	

	file.copy("../final_results.txt", resultName)
}

for (i in 1:2){

	fileName=paste("../result/final_result", i, sep="_")
	conn=file(fileName,open="r")
	linn=readLines(conn)
	result = linn[4:10]
	write(result, file = "../Results.txt", append = TRUE, sep = "")
}

