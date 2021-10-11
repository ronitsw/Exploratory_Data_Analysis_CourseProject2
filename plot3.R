# Load the data! (same as previous)
 NEI <- readRDS("summarySCC_PM25.rds")
 SCC <- readRDS("Source_Classification_Code.rds")
 
 # Use Baltimore's fip , 24510, to create an NEI subset. 
bmorefip <- NEI[NEI$fips=="24510",]

# Sum the emissions from Baltimore by year 
sumBal <- aggregate(Emissions ~ year, bmorefip,sum)

png("plot3.png",width=480,height=480,units="px",bg="transparent")
  
library(ggplot2)
    
 plot<- ggplot(bmorefip,aes(factor(year),Emissions,fill=type)) +
   geom_bar(stat="identity") +
   theme_bw() + guides(fill=FALSE)+
   facet_grid(.~type,scales = "free",space="free") + 
   labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
   labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))
print(plot)

dev.off()