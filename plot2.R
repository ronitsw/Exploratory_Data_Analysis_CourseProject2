# Load the data! (same as previous)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Use Baltimore's fip , 24510, to create an NEI subset. 
bmorefip <- NEI[NEI$fips=="24510",]

# Sum the emissions from Baltimore by year 
sumBal <- aggregate(Emissions ~ year, bmorefip,sum)

png("plot2.png",width=480,height=480,units="px",bg="transparent")

barplot(
  sumBal$Emissions,
  names.arg=sumBal$year,
  xlab="Year",
  ylab="PM2.5 Emissions",
  main="Total Emissions From Baltimore City"
)

dev.off()

