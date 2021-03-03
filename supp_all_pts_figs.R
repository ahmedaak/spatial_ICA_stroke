library(oro.nifti)
library(neurobase)
library(RColorBrewer)
library(colorspace)
library(png)

# path to images
data_path <- "/AG/AG-CSB_NeuroRad2/khalila/STUDENTS/Yiing_MSc/DATA/ALLDATA"
epi_temp <- readNIfTI("../figures/figure2/AK_103_EPI_template_brain.nii.gz")


# define colormaps
jet.colors <- colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))
fire.colors <- colorRampPalette(c("#000000","#120056","#32009f","#6500d7","#8d00be","#ae0291","#c60854","#de2c23","#f25600","#fb7a00","#ff9900","#ffb700","#ffd400","#ffec33","#ffff90"))
tsa.colors <- colorRampPalette(rev(c("#67001f","#b2182b","#d6604d","#f4a582","#fddbc7","black","#d1e5f0","#92c5de","#4393c3","#2166ac","#053061")))
# read in list
file_list <- read.csv(file = "../copying_files_progress.csv", header = T, sep = ";")

# loop through subjects
for (s in file_list$subject) {
  print(s)
 # get HIC number 
  hic_num <- file_list[file_list$subject==s,7]
  # get best slice for visualization
  slice <- file_list[file_list$subject==s,6]
  # load in DWI
  dwi <- readNIfTI(paste(data_path, s, "dwi2epiWarped.nii.gz", sep = "/"))
  # check if HIC exists
  if (!hic_num == "X"){
  # load in HIC
  hic <-  readNIfTI(paste(data_path, "/", s, "/func_unfilt.ica/stats/thresh_zstat",hic_num,"_reg.nii.gz", sep=""))
  }
  
  # load in Tmax
  tmax <- readNIfTI(paste(data_path, s, "Tmax_norm.nii.gz", sep = "/"))
  
  # load in TSA
  tsa <- readNIfTI(paste(data_path, s, "TSA_norm.nii.gz", sep = "/"))
  
  # DWI image
  png(filename = paste("../figures/all_figs/",s,"_dwi.png",sep = ""))
  image(dwi,  z = slice, plot.type = "single") 
  dev.off()
  
  if (!hic_num == "X"){
  # HIC image
  png(filename = paste("../figures/all_figs/",s,"_hic.png",sep = ""))
  overlay(epi_temp, ifelse(hic > 0, hic, NA), z = slice, plot.type = "single", col.y=fire.colors(15), zlim.y=c(0,15))
  dev.off()
  }
  
  # Tmax image
  png(filename = paste("../figures/all_figs/",s,"_tmax.png",sep = ""))
  image(robust_window(tmax, probs = c(0.1,0.99)),  z = slice, plot.type = "single",col=jet.colors(7))
  #image(tmax,  z = slice, plot.type = "single",col=jet.colors(7), zlim=c(0,200))
  dev.off()
  
  # TSA image
  png(filename = paste("../figures/all_figs/",s,"_tsa.png",sep = ""))
  #image(tsa,  z = slice, plot.type = "single", col=tsa.colors(11), zlim=c(-20,20))
  overlay(epi_temp, ifelse(tsa > 0,tsa,NA),z=slice,plot.type="single",col.y=fire.colors(7))
  dev.off()
  
  
  # MAKE MONTAGES
  # set up plot
  par(mar=rep(0,4))

  # set up layout
  layout(matrix(1:4, ncol=4, byrow=TRUE))
  
  # load in images
  dwi_i <- readPNG(paste("../figures/all_figs/",s,"_dwi.png",sep = ""))
  par(bg = "black")
  plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")
  rasterImage(dwi_i,0,0,1,1)
  if (!hic_num == "X"){
    hic_i <- readPNG(paste("../figures/all_figs/",s,"_hic.png",sep = ""))
    par(bg = "black")
    plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")
    rasterImage(hic_i,0,0,1,1)
  } else {
    hic_i <- readPNG(paste("../figures/all_figs/noHIC_placeholder.png",sep = ""))
    par(bg = "black")
    plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")
    rasterImage(hic_i,0,0,1,1)
  }
  tmax_i <- readPNG(paste("../figures/all_figs/",s,"_tmax.png",sep = ""))
  par(bg = "black")
  plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")
  rasterImage(tmax_i,0,0,1,1)
  
  tsa_i <- readPNG(paste("../figures/all_figs/",s,"_tsa.png",sep = ""))
  par(bg = "black")
  plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n")
  rasterImage(tsa_i,0,0,1,1)

  # save to disk
  dev.print(png, paste("../figures/all_figs/",s,"_fig.png", sep = ""),width = 1200, height = 300)
}

