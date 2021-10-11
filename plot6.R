# Load the data as before 
NEI <-  readRDS("summarySCC_PM25.rds")
SCC <-  readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicSCC <- SCC[vehicles,]$SCC
vehicNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# with each city's fip and name, subset the vehicles NEI data
vehiclesBmoreNEI <- vehicNEI[vehicNEI$fips=="24510",]
vehiclesBmoreNEI$city <- "Baltimore City"

vehicLANEI <- vehicNEI[vehicNEI$fips=="06037",]
vehicLANEI$city <- "Los Angeles County"

bothNEI <- rbind(vehiclesBmoreNEI,vehicLANEI)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

dev.off()
