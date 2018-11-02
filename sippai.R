# [패키지] ----
install.packages("readxl")
install.packages("devtools")
install.packages("ggmap")
install_github("dkahle/ggmap")
install.packages("leafletR")
install.packages("sp")
install.packages("KernSmooth")
install.packages("RColorBrewer")

library(readxl)
library(ggplot2)
library(ggmap)
library(devtools)
library(leafletR)
library(dplyr)
library(sp)
library(KernSmooth)
library(RColorBrewer)

# [작업경로] ----
setwd("c://R/BigData/Project")

# [작업] ----

dt = read.csv("market1.csv")
View(dt)
data <- dt[dt$시도명 == "서울특별시" & dt$상권업종대분류명 == "음식", ]
View(data)
data.gu <- data[data$시군구명 == "광진구", ]
data.gu <- data.gu[data.gu$행정동명 == "자양3동"|data.gu$행정동명 == "자양4동", ]
data.gu.loc <- data.gu[ ,c("위도","경도")]
d2d <- KernSmooth::bkde2D(cbind(data.gu.loc$경도,data.gu.loc$위도) , bandwidth = c(0.0015, 0.0015))
contour(d2d$x1,d2d$x2,d2d$fhat)


data.kmeans <- kmeans(data.gu.loc, centers = 6, iter.max = 100000)
data.kmeans$centers

data.gu.loc$cluster <- as.factor(data.kmeans$cluster)
qplot(경도, 위도, colour = cluster, data = data.gu.loc)

# 안됨.

lines = contourLines(x=d2d$x1, y=d2d$x2, z=d2d$fhat, nlevels = 20)
dd1 = sapply(1:length(lines), function(i) Polygon(as.matrix(cbind(lines[[i]]$x,lines[[i]]$y))))
dd2 = sapply(1:length(lines), function(i) Polygons(list(dd1[[i]]),i))
poly_data = data.frame(Value = sapply(1:length(lines),function(i) lines[[i]]$level))
dd3 = SpatialPolygonsDataFrame(SpatialPolygons(dd2), data = poly_data)

dd_json = toGeoJSON(dd3, name="Market")
values = unique(sapply(1:length(lines), function(i) lines[[i]]$level))

sty = styleCat(prop = "Value", val=values, style.val = brewer.pal(length(values), "Greens"), leg = "Market Distribution")
map = leaflet(dd_json, base.map = "osm", popup = "Value", style=sty)
