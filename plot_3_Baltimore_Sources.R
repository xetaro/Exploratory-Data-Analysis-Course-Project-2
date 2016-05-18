setwd ("//.../Coursera/Exploratory Data Analysis/Week 4")
getwd()
install.packages("downloader")
library("downloader")
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "//HOME/tkelevin/Mes Documents/FORMATION_DATA_MANAGER/Coursera/Exploratory Data Analysis/Week 4")
Emissions <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(Emissions)
dim(Emissions)
# [1] 6497651       6
names(Emissions)
# [1] "fips"      "SCC"       "Pollutant" "Emissions" "type"      "year" 
years <- unique(Emissions$year)

#Calulate total emissions by year (with aggregate)#

total_emissions <- with(Emissions, aggregate(Emissions, by = list(year), sum))
total_emissions
## Group.1       x
## 1    1999 7332967
## 2    2002 5635780
## 3    2005 5454703
## 4    2008 3464206


# Question 3 #

library(ggplot2)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#Calulate total emissions of Baltimore city by year

Balt_emissions <- Emissions[Emissions$fips=="24510",]

png(filename='plot_3_Baltimore_Sources.png', width=480, height=480, units='px')
balt.sources <- aggregate(Balt_emissions[c("Emissions")], list(type = Balt_emissions$type, year = Balt_emissions$year), sum)
qplot(year, Emissions, data = balt.sources, color = type, geom= "line")+ ggtitle("Total Emissions PM2.5 in Baltimore County by Source Type") + xlab("Year") + ylab("PM2.5 Emissions")                            
dev.off()


