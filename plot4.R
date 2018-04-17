#Parent Working Direcotry
CWD = getwd()

if(!file.exists("./projectdata")){dir.create("./projectdata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#change current working directory to "projectdata"
setwd("./projectdata")

if(!file.exists("./projectdata/householdPowerConsumption.zip")){
    download.file(fileurl, destfile = "./projectdata/householdPowerConsumption.zip", method = "auto", mode = "wb")

    #unzip the file and extract files to projectdata
    unzip("householdPowerConsumption.zip")
}

#let's extract the data to data.frame hPC
hPC <- read.table("household_power_consumption.txt", sep=";", header = T)

#move back to CWD 
setwd(CWD)

#let's move to cloned directory for project
setwd("./ExData_Plotting1")

#open a png file to write results
png("./plot4.png")

#let's merge data and time as POSIXct format
hPC <- within(hPC, { timestamp=as.POSIXct(paste(Date, Time), format="%d/%m/%Y%H:%M:%S")})

#create a variable representing date in date format using as.Date()
hPCModified <- hPC %>% mutate(plotDate = as.Date(hPC$Date, "%d/%m/%Y"))

#subset the data frame, to contain only first two days of feb 2007
subhPC <- subset(hPCModified, plotDate >= "2007-02-01" & 
                              plotDate <= "2007-02-02")

# setting sytax for 4 plot in single file
par(mfrow=c(2,2))

#First Plot
#let's plot the active global power for first two days of feb 2007
plot(subhPC$timestamp, as.numeric(as.character(subhPC$Global_active_power)),
     type="l", ylab="Global Active Power (Kilowatts)", xlab="")

#Second Plot
#let's plot the volage for first two days of feb 2007
plot(subhPC$timestamp, as.numeric(as.character(subhPC$Voltage)),
     type="l", ylab="Voltage", xlab="datetime")

#Third Plot
#let's plot energy sub-metering for first two days of feb 2007
plot(subhPC$timestamp, as.numeric(as.character(subhPC$Sub_metering_1)),type="l", 
     ylab = "Energy sub metering", xlab="")
lines(subhPC$timestamp, as.numeric(as.character(subhPC$Sub_metering_2)), col="red")
lines(subhPC$timestamp, as.numeric(as.character(subhPC$Sub_metering_3)), col="blue")

#let's put the legend to the plot
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, lwd = 2, col=c("black", "red", "blue"))

#Fourth Plot
#let's plot the volage for first two days of feb 2007
plot(subhPC$timestamp, as.numeric(as.character(subhPC$Global_reactive_power)),
     type="l", ylab="Global_reactive_power", xlab="datetime")

#close the rdevice .png file.
dev.off()

#restoring back Parent Working Directory
setwd(CWD)

