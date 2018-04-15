plot1<-function(wd){
  setwd(wd)
  
  if(!file.exists('data.zip')){
    url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
    
    download.file(url,destfile = "data.zip")
    unzip("data.zip")
  }
  
  raw_ds<-read.csv(file = 'household_power_consumption.txt',sep=";")
  raw_ds$DateTime<-paste(raw_ds$Date, raw_ds$Time)
  
  raw_ds$DateTime<-strptime(raw_ds$DateTime, "%d/%m/%Y %H:%M:%S")
  
  lower_cut<-which(raw_ds$DateTime==strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
  upper_cut<-which(raw_ds$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
  
  proc_ds<-raw_ds[lower_cut:upper_cut,]
  
  hist(as.numeric(as.character(proc_ds$Global_active_power)), main="Global Active Power",
       col="red",xlab="Global Active Power (kilowatts)")
  
  dev.print(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
}