setwd ("//HOME/tkelevin/Mes Documents/FORMATION_DATA_MANAGER/Coursera/Exploratory Data Analysis/Week 4")
getwd()
install.packages("downloader")
library("downloader", lib.loc="C:/Program Files/R/R-3.2.3/library")
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "//HOME/tkelevin/Mes Documents/FORMATION_DATA_MANAGER/Coursera/Exploratory Data Analysis/Week 4")
Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(Emissions)
'data.frame':	6497651 obs. of  6 variables:
  $ fips     : chr  "09001" "09001" "09001" "09001" ...
$ SCC      : chr  "10100401" "10100404" "10100501" "10200401" ...
$ Pollutant: chr  "PM25-PRI" "PM25-PRI" "PM25-PRI" "PM25-PRI" ...
$ Emissions: num  15.714 234.178 0.128 2.036 0.388 ...
$ type     : chr  "POINT" "POINT" "POINT" "POINT" ...
$ year     : int  1999 1999 1999 1999 1999 1999 1999 1999 1999 1999 ...

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



