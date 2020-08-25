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

png(file = "plot4.png",                                                         #Set plot device and size
    width = 480,
    height = 480)

par(mfrow = c(2,2))                                                             #Set 2x2 plot "matrix"

#Global Active Power x datetime
with(df, 
     {plot(Date,
           Global_active_power,
           type = "l",
           lty = 1,
           col = "black",
           xlab = "",
           ylab = "Global Active Power")})

#Voltage x datetime
with(df, 
     {plot(Date,
           Voltage,
           type = "l",
           lty = 1,
           col = "black",
           xlab = "datetime",
           ylab = "Voltage")})
       
#Sub_meterign_1,2,3 x datetime
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

#Global Reactive Power x datetime
with(df, 
     {plot(Date,
           Global_reactive_power,
           type = "l",
           lty = 1,
           col = "black",
           xlab = "datetime",
           ylab = "Global_reactive_power")})

dev.off()                                                                       #Close plot device