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
png("./plot1.png")

#create a variable representing date in date format using as.Date()
hPCModified <- hPC %>% mutate(plotDate = as.Date(hPC$Date, "%d/%m/%Y"))

#subset the data frame, to contain only first two days of feb 2007
subhPC <- subset(hPCModified, plotDate >= "2007-02-01" & 
                              plotDate <= "2007-02-02")

#let's plot the histogram
hist(as.numeric(as.character(subhPC$Global_active_power)), 
     xlab="Global Active Power (Kilowatts)", col = "red", 
     main="Global Active Power")

#close the rdevice .png file.
dev.off()

#restoring back Parent Working Directory
setwd(CWD)

