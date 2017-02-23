## Red snapper recreational season length
setwd("X:/Data_John/council meetings/April 2017/Private Recreational AP/RedSnapperPrivateRecAP")
library(highcharter)

df <- read.csv("Management.csv")

hchart(df, "line", hcaes(x = Year, y = Days)) %>% 
  
  # hc_xAxis(title = list(text = "text"),
  #          opposite = TRUE,
  #          plotLines = list(
  #            list(label = list(text = "This is a plotLine"),
  #                 color = "#FF0000",
  #                 width = 2,
  #                 value = 1996))) %>% 
 # hc_tooltip(crosshairs=TRUE, borderWidth=5)

hc_tooltip(crosshairs = TRUE,backgroundColor = "#D3D3D3",
           pointFormat = "Title <br> Year = {point.x},
           Federal season length = {point.y}",
           headerFormat = "", borderWidth=3) %>% 
  hc_add_theme(hc_theme_economist()) %>% 
  hc_exporting(enabled = TRUE,url="https://export.highcharts.com",
               filename = "redsnapperData") %>% 
  hc_title(text = "Red snapper recreational season length (1986 - 2016)",
           margin = 20, align = "left",
           style = list( useHTML = TRUE))
  