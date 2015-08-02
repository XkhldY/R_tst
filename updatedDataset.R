
 updatedDs<-function(tab,Token,date)
 {

#init the dataset
db=tab
# db=data.frame(1,2,3,as.POSIXct("2009-10-11 11:53:42",tz = "GMT"),5,6,7,8)
# names(db) = c("lat", "long", "elev", "time","duration","ID","category","distance")
db$category=""
db$distance=1

five=""

for (x in 1:length(tab$ID)) {
  

  tryCatch(
{
 
  #preparing to send to Foursquare api
  latlong=toString(c(tab[x,]$lat,tab[x,]$long))
  latlong<-gsub(" ","",latlong)
  #use foursquare Api
  foursquare1<-FoursquareSearch(latlong,token,date)
  
  
  five[x]<-as.character(foursquare1$category)
  
  db[x,"category"]=five[x]
  db[x,"distance"]=foursquare1$dist
  db[db[,"distance"] > 50, "category"] = NA 
  print(x)
  

  
},error=function(cond) {
  
  message("Here's the original error message:")
  message(x)
  message(cond)
  
},finally={
  
  
  next
}
  )
}
# 
 return (db)
 }