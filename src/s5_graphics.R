# stage 6: presentation graphics
library(ggplot2)

qplot(x = DistToStation, 
      y = RDistToStation, 
      data = ss_data %>%
        arrange(DistToStation), 
      geom = "line", 
      linetype = factor(Year),
      colour = AggBusinessType) +
  scale_linetype_manual("Year", breaks=c(2002, 2008, 2014), 
                        values = c("dashed", "longdash", "solid")) +
  scale_colour_discrete("Business Licence Type") + 
  ylab("Cumulative Business Licences") +
  xlab("Distance to Nearest Station (m)")
  
qplot(x = DistToTracks, 
      y = RDistToStation, 
      data = ss_data %>%
        arrange(DistToStation), 
      geom = "line", 
      linetype = factor(Year),
      colour = AggBusinessType) +
  scale_linetype_manual("Year", breaks=c(2002, 2008, 2014), 
                        values = c("dashed", "longdash", "solid")) +
  scale_colour_discrete("Business Licence Type") + 
  ylab("Cumulative Business Licences") +
  xlab("Distance to Nearest Station (m)")