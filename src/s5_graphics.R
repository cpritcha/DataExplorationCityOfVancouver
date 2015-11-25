# stage 5: presentation graphics
# ss_data, not_ss_data come from running `s5_graphics.Rmd`
library(ggplot2)

# Southern Stations
qplot(x = DistToStation,
      y = RDistToStation,
      data = ss_data %>%
        arrange(DistToStation),
      geom = "line",
      linetype = factor(Year),
      colour = AggBusinessType) +
  scale_linetype_manual("Year", breaks=c(2002, 2008, 2014),
                        values = c("dotted", "longdash", "solid")) +
  scale_colour_discrete("Business Licence Type") +
  ylab("Cumulative Business Licences") +
  xlab("Distance to Nearest Station (m)")

qplot(x = DistToTracks,
      y = RDistToTracks,
      data = ss_data %>%
        arrange(DistToTracks),
      geom = "line",
      linetype = factor(Year),
      colour = AggBusinessType) +
  scale_linetype_manual("Year", breaks=c(2002, 2008, 2014),
                        values = c("dotted", "longdash", "solid")) +
  scale_colour_discrete("Business Licence Type") +
  ylab("Cumulative Business Licences") +
  xlab("Distance to Nearest Station (m)")

# Northern Stations
qplot(x = DistToStation,
      y = RDistToStation,
      data = not_ss_data %>%
        arrange(DistToStation),
      geom = "line",
      linetype = factor(Year),
      colour = AggBusinessType) +
  scale_linetype_manual("Year", breaks=c(2002, 2008, 2014),
                        values = c("dotted", "longdash", "solid")) +
  scale_colour_discrete("Business Licence Type") +
  ylab("Cumulative Business Licences") +
  xlab("Distance to Nearest Station (m)")

qplot(x = DistToTracks,
      y = RDistToTracks,
      data = not_ss_data %>%
        arrange(DistToTracks),
      geom = "line",
      linetype = factor(Year),
      colour = AggBusinessType) +
  scale_linetype_manual("Year", breaks=c(2002, 2008, 2014),
                        values = c("dotted", "longdash", "solid")) +
  scale_colour_discrete("Business Licence Type") +
  ylab("Cumulative Business Licences") +
  xlab("Distance to Nearest Station (m)")
