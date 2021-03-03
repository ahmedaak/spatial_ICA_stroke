# script for creating figures of individual DWIs, perfusion (Tmax) maps, and rsfMRI-based independent components

library(oro.nifti)
library(colorspace)
library(neurobase)
library(RColorBrewer)
# define jet colormap
jet.colors <- colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))
fire.colors <- colorRampPalette(c("#000000","#120056","#32009f","#6500d7","#8d00be","#ae0291","#c60854","#de2c23","#f25600","#fb7a00","#ff9900","#ffb700","#ffd400","#ffec33","#ffff90"))
tsa.colors <- colorRampPalette(rev(c("#67001f","#b2182b","#d6604d","#f4a582","#fddbc7","black","#d1e5f0","#92c5de","#4393c3","#2166ac","#053061")))

# path to data
data_path <- c("S:/AG/AG-CSB_NeuroRad2/khalila/STUDENTS/Yiing_MSc/DATA/ALLDATA")
subs <- list.dirs(path=data_path, recursive = F, full.names = F)

# read in list
file_list <- read.csv(file = "../copying_files_progress.csv", header = T, sep = ";")

epi_temp <- readNIfTI("../figures/figure2/AK_103_EPI_template_brain.nii.gz")

for (i in subs) {
dwi <- readNIfTI(paste(data_path, i, "dwi2epiWarped.nii.gz", sep = "/"))
tmax <- readNIfTI(paste(data_path, i, "Tmax_norm.nii.gz", sep = "/"))
tsa <- readNIfTI(paste(data_path, i, "TSA_norm.nii.gz", sep = "/"))
IC_list <- intersect(list.files(paste(data_path, i,"func_unfilt.ica","stats",sep="/"), pattern = "thresh_"), list.files(paste(data_path, i,"func_unfilt.ica","stats",sep="/"), pattern = "_reg.nii.gz$"))
# get HIC number 
hic_num <- file_list[file_list$subject==i,7]

for (f in c("dwi", "tmax", "tsa")){
  # plot mosaics
  png(paste("../figures/individual_figs/",i,"_",f,"_mosaic.png",sep=""))
  if (f == "tmax"){
    #image(get(f), zlim=c(1,130),col=jet.colors(7))} 
    slice(robust_window(get(f), probs = c(0,0.99)), z = seq(20,65,2), col = jet.colors(7), bg = "#00007F")}
  else if (f == "tsa") {
    #overlay(epi_temp, ifelse(tsa > 0,tsa,NA),z=seq(20,65,2),col.y=fire.colors(7))
    slice(get(f),z=seq(20,65,2),col=tsa.colors(11))
  }  
  else {
    #image(get(f))}
    slice(get(f), z = seq(20,65,2))}
  dev.off()
}

for (g in c(IC_list)){
  # load in IC NIFTI
  ic <- readNIfTI(paste(data_path, i,"func_unfilt.ica","stats",g, sep="/"))
  # plot mosaic
  # append "HIC" to file name if this is the HIC
  if (g == paste("thresh_zstat",hic_num,"_reg.nii.gz", sep="")) {
    png(paste("../figures/individual_figs/",i,"_",unlist(strsplit(g, split="_reg",fixed=TRUE))[1],"_HIC_mosaic.png",sep=""))
  }
    else {
  png(paste("../figures/individual_figs/",i,"_",unlist(strsplit(g, split="_reg",fixed=TRUE))[1],"_mosaic.png",sep=""))}
  #overlay(epi_temp, ifelse(ic > 0, ic, NA))
  slice_overlay(x=epi_temp, y=ic, z = seq(20,65,2), col.y=fire.colors(15), zlim.y=c(0,15))
  dev.off()
}
}