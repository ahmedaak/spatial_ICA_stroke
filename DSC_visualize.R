# script to visualize Dice coefficients between Tmax ROIs and independent components
# written by Ahmed Khalil, MD PhD on 23.06.2021

# define paths
data_path <- "S:/AG/AG-CSB_NeuroRad2/khalila/STUDENTS/Yiing_MSc/DATA/ALLDATA"
file_list <- read.csv(file = "../copying_files_progress.csv", header = T, sep = ";")

# ask user what they want to plot
metric <- readline("Would you like to plot the dice coefficient (dice) or the correlation coefficient (cor)?")

# select all patients
patients <- list.dirs(data_path,recursive = F,full.names = F)
# exclude recanalized patients
patients <- patients[! patients %in% c("148","169","187")]

par(mfrow=c(8,6))
# loop through patients
for (i in patients) {
  print(i)
  # load DSC values
  DSC <- read.csv2(paste(data_path,i,paste(metric,".txt",sep=""),sep="/"),header = F,sep = " ",)
  # remove "\t" from DSC value
  DSC$V2 <- substr(x = DSC$V2,1,nchar(DSC$V2)-1)
  DSC$V2 <- as.numeric(DSC$V2)
  # TODO keep only component number in first column
  DSC$V1 <-  gsub(pattern = paste("/home/khalila/CSB_NeuroRad2/khalila/STUDENTS/Yiing_MSc/DATA/ALLDATA/",i,"/func_unfilt.ica/stats/thresh_zstat",sep=""),x = DSC$V1,replacement="")
  DSC$V1 <- gsub(pattern = "_reg.nii.gz",x = DSC$V1,replacement="")
  # get HIC number 
  hic_num <- file_list[file_list$subject==i,c(7,8)]
  ylim_plot <- max(DSC$V2)+0.1
  # replace NA with zero in second HIC column (otherwise next line doesn't work)
  hic_num$HIC_2[is.na(hic_num$HIC_2)] <- 0
  # plot results
  plot(DSC,ylim=c(0,ylim_plot),pch=ifelse(DSC$V1==hic_num$HIC | DSC$V1==hic_num$HIC_2,16,1), col = ifelse(DSC$V1==hic_num$HIC | DSC$V1==hic_num$HIC_2,"red","black"))
}

