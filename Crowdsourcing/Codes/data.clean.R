#################################################################
############################ clean data #################
library(stringr)
setwd("D:/Rocky_Mountain/Results")
files <- list.files()
#i = 1
for(i in 1:length(files)) {
files1 <- list.files(paste("./",files[i],sep=""))
df <- read.csv(paste("./", files[i], "/", files1[3],sep = ""))
dv <- read.csv(paste("./", files[i], "/", files1[1],sep = ""))

################# bud consistency ###############
dv$bud_cs <- 1- (abs(dv$bud1 - dv$bud2)/(dv$bud1 + dv$bud2))
dv$bud_cs[is.nan(dv$bud_cs)] <- 1  #### the count of bud equal to 0 in both process #####

#flower consistency
dv$flower_cs <- 1- (abs(dv$flower1 - dv$flower2)/(dv$flower1 + dv$flower2))
dv$flower_cs[is.nan(dv$flower_cs)] <- 1

#fruit consistency
dv$fruit_cs <- 1- (abs(dv$fruit1 - dv$fruit2)/(dv$fruit1 + dv$fruit2))
dv$fruit_cs[is.nan(dv$fruit_cs)] <- 1

dups <- dv[, c("bud_cs", "flower_cs", "fruit_cs")]
res <- which(dups$bud_cs == 0 | dups$flower_cs == 0 | dups$fruit_cs ==0)
Username <- unique(dv$username1[res])
df.final <- df[which(!df$username %in% Username),]

write.csv(df.final,file = paste("D:/Rocky_Mountain/summary/",files[i],".csv",sep=""))
}

################################################## combine all the csv files ###########
setwd("D:/Rocky_Mountain/summary")
files <- list.files()
data.final <- c()
for(i in 1:length(files)){
  data.res <- read.csv(files[i])
  data.final <- rbind(data.final,data.res)
}





