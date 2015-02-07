data<-read.table("household_power_consumption.txt", sep= ";",header=TRUE)
s<-data[data[,1]=="1/2/2007",]
q<-data[data[,1]=="2/2/2007",]
sq<-rbind(s,q)



sq[,1]<-as.Date(sq[,1], "%d/%m/%Y")


DateTime<-paste(sq[,1],sq[,2])
sq1<-cbind(DateTime,sq[,3:9])

stime<-strptime(sq1[,1],"%Y-%m-%d %H:%M:%S")
sq2<-cbind(stime,sq1[,2:8])

for(i in 2:8) {
  sq2[,i]<-as.character(sq2[,i])
  sq2[,i]<-as.double(sq2[,i])
  sq2[sq2[,2] == "?"] <- NA
}


png(file = "./plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
#first plot

with(sq2,plot(stime, Global_active_power, type="l",
              ylab="Global Active Power",xlab=""))
#second plot

with(sq2,plot(stime, Voltage, type="l",
              ylab="Voltage",xlab="datetime"))
#third plot
with(sq2,plot(stime, Sub_metering_1, type="l",
              ylab="Energy sub metering",xlab=""))
lines(stime, sq2$Sub_metering_2, type="l", col="red")
lines(stime, sq2$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black","blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1),cex=0.8, pt.cex = 1)

#fourth plot

with(sq2,plot(stime, Global_reactive_power, type="l",
              ylab="Global Reactive Power",xlab="datetime",lwd=0.7))

dev.off()

