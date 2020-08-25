###Read Raw data and backup
data_raw <- read.table("household_power_consumption.txt", sep = ";")            #Raw data
data <- data_raw                                                                #Backup

###Format date for subsetting
date <- as.Date(data_raw$V1, format="%d/%m/%Y")                                 
data$V1 <- date

###Data subsetting 
data_sub <- subset(data,
                   data$V1 >= "2007-02-01" & data$V1 <= "2007-02-02")

###Data cleanup and further formatting
names(data_sub) <- data_raw[1,]                                                 #Rename columns
data_sub[3:9] <- lapply(data_sub[3:9], as.numeric)                              #Make columns as numeric
t <- paste(data_sub$Date, data_sub$Time)                                        #Paste together date and time
d <- strptime(t, "%Y-%m-%d %H:%M:%S")                                           #Format datetime

df <- cbind(d, data_sub[3:9])                                                   #Merge columns in a dataframe
names(df)[1] <- "Date"                                                          #Rename first column

###Begin Plots

png(file = "plot3.png",                                                         #Set plot device and size
    width = 480,
    height = 480)

#Plot sub meterings
with(df, 
     {plot(Date,
           Sub_metering_1,
           type = "l",
           lty = 1,
           col = "black",
           xlab = "",
           ylab = "Energy sub metering")
       
       lines(Date,
             Sub_metering_2,
             type = "l",
             lty = 1,
             col = "red")
       
       lines(Date,
             Sub_metering_3,
             type = "l",
             lty = 1,
             col = "blue")})


legend("topright" ,c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

dev.off()                                                                       #Close plot device