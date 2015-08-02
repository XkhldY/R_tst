

SaveToDataset<-function(dir,location){
  
#   dir<-getFiles(m,y,directory)
  x=1
  #init the dataset
  db=data.frame(1,2,3,as.POSIXct("2009-10-11 11:53:42",tz = "GMT"),5,6)
  names(db) = c("lat", "long", "elev", "time","duration","ID")
  setwd("D:/work/Research/location research/datasets/Geolife/Geolife Trajectories 1.3/Data")
for (f in list.files(dir, pattern = "*plt", full.names = TRUE)) {
  print(f)
  tab = read.csv(f, skip = 6, stringsAsFactors=FALSE)
  tab = na.omit(tab)
  
  
  
  tryCatch(
{
  #compine date and time in GMT format
  tab$time = as.POSIXct(paste(tab[,6],tab[,7]),tz = "GMT") 
  
  
  
  #   tab[tab[,4] == -777, 4] = NA # altitude 
  tab = tab[,-c(3,5,6,7)]
  names(tab) = c("lat", "long", "elev", "time")
  #   
  #   
  #   dup = duplicated(tab["time"])
  #   
  #   if (any(dup))
  #     tab = tab[-dup,]
  #   
  #   tab = tab[c(TRUE, diff(tab$time) != 0),]
  
  
  db[2*x-1,]=head(tab,1)
  db[2*x,]=tail(tab,1)
  
  #calculating the duration of the trajectory
  db[2*x,5]=db[2*x-1,5]=as.numeric(difftime( tail(tab,1)$time, head(tab,1)$time))
  
  #adding the file ID from the folder number
  s1 = unlist(strsplit(f, split='/', fixed=TRUE))
  db[2*x,6]=db[2*x-1,6]=as.numeric(s1[1])
  x=x+1;
  
},error=function(cond) {
  
  message("Here's the original error message:")
  message(x)
  message(cond)
  
},finally={
  
  
  next
})


}
# Write CSV in R

attributes(db$time)$tzone <- "Asia/Shanghai"
rownames(db) <- NULL
day=as.Date(db$time)
db$day=weekdays(day)
write.table(db, file = location,row.names=FALSE, sep=",")
return(db)

}
