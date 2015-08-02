library(RCurl)
library(RJSONIO)

x="28.16952,112.9723" 
y="VAN45IIJ2ZH1JWZNBJ1XJGKDXADAMZBA0P02SKJDQFATMF5S"
z="20150730"
 FoursquareSearch<-function(x,y,z){
  w<-paste("https://api.foursquare.com/v2/venues/search?ll=",x,"&radius=2000&oauth_token=",y,"&v=",z,sep="")
  u<-getURL(w)
  test<-fromJSON(u)
  locationname=""
  lat=""
  long=""
  dist=1
  zip=""
  herenowcount=""
  likes=""
  category=""
  if(length(test$response$venues)!=0){
  for(n in 1:length(test$response$venues)) {
    
    
    tryCatch({
      locationname[n] = test$response$venues[[n]]$name
      lat[n] = test$response$venues[[n]]$location$lat
      long[n] = test$response$venues[[n]]$location$lng
      dist[n] = test$response$venues[[n]]$location$distance
      category[n]=test$response$venues[[n]]$categories[[1]]$name
      

      xb<-as.data.frame(cbind(
        locationname,
        lat,
        long,
        category,
        dist))
      
    },error=function(cond) {
      
#       message("error ",n)
#       message(cond)
      
    },finally={
      
      
      next
    }
    )
    #    xb$pulled=date()
  }
  xb$dist=as.numeric(levels(xb$dist))[xb$dist]
  xb=na.omit(xb)
  xb=xb[xb$dist==min(xb$dist),]
  return(xb[1,])
  
  }
  else
  {
    print("no venues around")
    xb<-as.data.frame(cbind(locationname=NA,lat=NA,long=NA,category=NA,dist=1000))
    return(xb)
  }
  
 }
