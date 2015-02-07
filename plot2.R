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

sq2[,9]<-weekdays(sq2[,1])
par(mar=c(5.1,4.1,4.1,2.1))

with(sq2,plot(stime, Global_active_power, type="l",
            ylab="Global Active Power (kilowatts)",xlab="", lwd=1))

dev.copy(png, "plot2.png")
dev.off()
