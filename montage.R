# this script makes a montage out of the individual subjects' images in the "spatial ICA in stroke" project

# load necessary packages
library(png)


# read in list
file_list <- read.csv(file = "../copying_files_progress.csv", header = T, sep = ";")

# MAKE MONTAGES
# set up plot
par(mar=rep(0,4))
# set up layout
layout(matrix(1:56, ncol=4, byrow=TRUE))

# first the pts with only baseline scans
for (s in file_list[!file_list$FU=="Y",]$subject) {
  print(s)
  # load in images
  fig_i <- readPNG(paste("../figures/all_figs/",s,"_fig.png", sep = ""))
  
  # plot
  par(bg = "black")
  plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")
  rasterImage(fig_i,0,0,1,1)
  
}

# two blank plots so follow-ups start on a new row

# plot
par(bg = "black")
plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")

# plot
par(bg = "black")
plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")

# plot
par(bg = "black")
plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")

# plot
par(bg = "black")
plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")

# plot
par(bg = "black")
plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")

# then, pts with follow-up scans
for (s in file_list[file_list$FU=="Y",]$subject) {
  print(s)
  # load in images
  fig_i <- readPNG(paste("../figures/all_figs/",s,"_fig.png", sep = ""))

  # plot
  par(bg = "black")
  plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")
  rasterImage(fig_i,0,0,1,1)

}

# save to disk
dev.print(png, paste("../figures/all_figs/montage.png", sep =),width = 230, height = 212.8, units = "mm", res = 1200)