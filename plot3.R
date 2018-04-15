plot3<-function(wd){
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
  
  plot(proc_ds$DateTime, as.numeric(as.character(proc_ds$Sub_metering_1)),type="l",xlab="", ylab ="Energy sub metering")
  lines(proc_ds$DateTime, proc_ds$Sub_metering_3,type="l", col="blue")
  lines(proc_ds$DateTime, as.numeric(as.character(proc_ds$Sub_metering_2)),type='l', col='red')
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))

  dev.print(png, file = "plot3.png", width = 680, height = 480)
  dev.off()
}