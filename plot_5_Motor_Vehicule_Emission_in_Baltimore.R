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



# Question 5 #

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(ggplot2)

sub <- subset(Emissions, fips == "24510" & type=="ON-ROAD")
balt.sources <- aggregate(sub[c("Emissions")], list(type = sub$type, year = sub$year, zip = sub$fips), sum)
qplot(year, Emissions, data = balt.sources, geom= "line") + ggtitle("Motor Vehicle Emissions in Baltimore County") + xlab("Year") + ylab("Emissions")

png(filename='plot_5_Motor_Vehicule_Emission_in_Baltimore.png', width=480, height=480, units='px')
qplot(year, Emissions, data = balt.sources, geom= "line") +  ggtitle("Motor Vehicle Emissions in Baltimore County") + xlab("Year") + ylab("Emissions")
dev.off()



