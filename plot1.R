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

par(mar=c(5.1,4.1,4.1,2.1))
hist(sq2$Global_active_power, col="red", 
  xlab="Global Active Power (kilowatts)", main="Global Active Power")

dev.copy(png, "plot1.png")
dev.off()
