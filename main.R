library(sp)
library(spacetime)
library(trajectories)
library(ggplot2)


m=1
y=182
token="VAN45IIJ2ZH1JWZNBJ1XJGKDXADAMZBA0P02SKJDQFATMF5S"
date="20150730"

directory="D:/work/Research/location research/datasets/Geolife/Geolife Trajectories 1.3/Data"
saveTO="E:/5-R work/GeoProject/proj_1/data.csv"
datasetURI="E:/5-R work/GeoProject/proj_1/data.csv"

start.time <- Sys.time()
# Start the clock!
ptm <- proc.time()

# system.time(dir<-getFiles(m,y,directory))
# print("-----------------------------------get----------")
# system.time(RawDs<-SaveToDataset(dir,saveTO))
# print("-----------------------------------save----------")
tab = read.csv(datasetURI,header = TRUE, stringsAsFactors=FALSE)
system.time(ds<-updatedDs(tab[1:10,],token,date))
print("-----------------------------------updated---------")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
print("-----------------------------------clock1---------")

# Stop the clock
proc.time() - ptm

qplot(as.numeric(format.Date(RawDs$time,"%H")), geom="histogram",fill=I("lightblue"),col=I("red"),binwidth = 0.5) 
qplot(as.numeric(format.Date(RawDs[RawDs$day=="Friday",]$time,"%H")), geom="histogram",fill=I("lightblue"),col=I("red"),binwidth = 0.5) 
qplot(as.numeric(format.Date(RawDs[RawDs$day=="Sunday",]$time,"%H")), geom="histogram",fill=I("lightblue"),col=I("red"),binwidth = 0.5) 
qplot(RawDs$day, geom="histogram",fill=I("lightblue"),col=I("red"),binwidth = 0.5) 
str(RawDs)

