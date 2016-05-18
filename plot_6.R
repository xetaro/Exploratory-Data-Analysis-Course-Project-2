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
#[1] 6497651       6

names(Emissions)
#[1] "fips"      "SCC"       "Pollutant" "Emissions" "type"      "year" 

years <- unique(Emissions$year)

str(SCC)

dim(SCC)
#[1] 11717    15

names(SCC)
#[1] "SCC"                 "Data.Category"       "Short.Name"          "EI.Sector"           "Option.Group"       
#[6] "Option.Set"          "SCC.Level.One"       "SCC.Level.Two"       "SCC.Level.Three"     "SCC.Level.Four"     
#[11] "Map.To"              "Last.Inventory.Year" "Created_Date"        "Revised_Date"        "Usage.Notes" 

# Question 6 #

# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2) 

sub1 <- subset(Emissions, fips == "24510" & type=="ON-ROAD")
balt.sources <- aggregate(sub1[c("Emissions")], list(type = sub1$type, year = sub1$year, zip = sub1$fips), sum)

sub2 <- subset(Emissions, fips == "06037" & type=="ON-ROAD")
LA.sources <- aggregate(sub2[c("Emissions")], list(type = sub2$type, year = sub2$year, zip = sub2$fips), sum)

final_data <- rbind(balt.sources, LA.sources)

qplot(year, Emissions, data = final_data, color = zip, geom= "line", ylim = c(-100, 5000)) + ggtitle("Motor Vehicle Emissions in Baltimore and Los Angeles Counties") + xlab("Year") + ylab("Emissions")

png(filename='plot_6.png', width=480, height=480, units='px')
qplot(year, Emissions, data = final_data, color = zip, geom= "line", ylim = c(-100, 5000)) + ggtitle("Motor Vehicle Emissions in Baltimore and Los Angeles Counties") + xlab("Year") + ylab("Emissions")
dev.off()



