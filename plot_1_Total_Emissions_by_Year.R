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

#Calulate total emissions by year (with aggregate)#
total_emissions <- with(Emissions, aggregate(Emissions, by = list(year), sum))
total_emissions
 Group.1       x
1    1999 7332967
2    2002 5635780
3    2005 5454703
4    2008 3464206

# or #

#Calulate total emissions by year (with tapply)#

total_emissions <- tapply(Emissions$Emissions,Emissions$year,sum)
total_emissions
1999    2002    2005    2008 
7332967 5635780 5454703 3464206 

# Question 1 #

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

png(filename='plot_Total_Emissions_by_Year.png', width=480, height=480, units='px')
plot(names(total_emissions), total_emissions, type = "o",
     xlab = "Year", ylab = expression("PM2.5 Emissions"),
     main = expression("Total Emissions by Year"), pch = 19, col = "red", lwd = 4)
dev.off()



