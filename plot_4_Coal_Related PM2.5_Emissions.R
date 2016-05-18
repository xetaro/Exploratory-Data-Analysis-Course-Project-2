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



# Question 4 #

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(ggplot2)

SCC.sub <- SCC[grepl("Coal" , SCC$Short.Name), ]
Emissions.sub <- Emissions[Emissions$SCC %in% SCC.sub$SCC, ]

plot4 <- ggplot(Emissions.sub, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) + xlab("year") +ylab("Coal-Related PM2.5 Emissions") + ggtitle("Total Coal-Related PM2.5 Emissions")
print(plot4)

png(filename='plot_Total_Emissions_by_Year.png', width=480, height=480, units='px')
plot4 <- ggplot(Emissions.sub, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) + xlab("year") +ylab("Coal-Related PM2.5 Emissions") + ggtitle("Total Coal-Related PM2.5 Emissions")
dev.off()



