setwd ("//.../Coursera/Exploratory Data Analysis/Week 4")
getwd()
install.packages("downloader")
library("downloader")
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "//.../Coursera/Exploratory Data Analysis/Week 4")
Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(Emissions)

dim(Emissions)
[1] 6497651       6

names(Emissions)
[1] "fips"      "SCC"       "Pollutant" "Emissions" "type"      "year" 

years <- unique(Emissions$year)

# Question 2 #

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

#Calulate total emissions of Baltimore city by year
Balt_emissions <- Emissions[Emissions$fips=="24510",]
total_Balt <- tapply(Balt_emissions$Emissions,Balt_emissions$year,sum)
total_Balt
1999     2002     2005     2008 
3274.180 2453.916 3091.354 1862.282 

png(filename='plot_2_Baltimore.png', width=480, height=480, units='px')
plot(names(total_Balt ), total_Balt, type = "l",
          xlab = "Year", ylab = expression("PM2.5 Emissions"),
          main = expression("Total Emissions Baltimore City"), pch = 19, col = "green", lwd = 6)
dev.off()



