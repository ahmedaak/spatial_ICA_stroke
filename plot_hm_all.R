# this script plots head motion for all patients in the "spatial ICA in stroke" study

# list of subjects
subs_all <- c("sub0005","sub0008","sub0019","sub0028","sub0029","sub0030","sub0031","sub0036","sub0037","sub0044","sub0047","sub0056","sub0057","sub0058","sub0059","sub0067","sub0072","sub0089","sub0092","sub0106","sub0121","sub0127","sub0128","sub0130","sub0145","sub0146","sub0147","sub0148","sub0153","sub0154","sub0165","sub0168","sub0169","sub0171","sub0174","sub0175","sub0183","sub0184","sub0186","sub0187","sub0189","sub0192","sub0193","sub0197","sub0203","sub0206","sub0213")
  
# list of HIC false NEGATIVE subjects
subs_fn <- c("sub0013","sub0137","sub0159","sub0160")

hm_mean_all <- c()
hm_max_all <- c()
hm_mean_fn <- c()
hm_max_fn <- c()

for (s in c(subs_fn,subs_all)) {
# get motion estimates
hm <- read.csv(paste("/AG/AG-CSB_NeuroRad2/khalila/DATA/Resting_BOLD_delay/",s,"/hm/hm_fd.txt", sep =""), header = F)
hm_mean <- mean(hm$V1)
hm_max <- max(hm$V1)
if (s %in% subs_fn){
  hm_mean_fn <- c(hm_mean_fn, hm_mean)
  hm_max_fn <- c(hm_max_fn, hm_max)
  print(paste(s, "mean FD =", hm_mean, " max FD =", hm_max))
  
} else
{
  hm_mean_all <- c(hm_mean_all, hm_mean)
  hm_max_all <- c(hm_max_all, hm_max)
  print(paste(s, "mean FD =", hm_mean, " max FD =", hm_max))
}

# plot motion trace for each subject
png(paste("../figures/individual_figs/",s,"_motion.png",sep=""), width = 15, height = 8, units = "cm", res=600)
par(bg="black")
plot(seq(1,length(hm$V1),1)*2.3,hm$V1, type = "l", xlab = "Time (s)", col.lab = "white",ylab = "Displacement (mm)",xlim=c(0,350), main = "Head motion", col = "white", col.main="white")
axis(1,col.ticks = "white",col.axis="white",col.lab="white", col="white")
axis(2,col.ticks = "white",col.axis="white",col.lab="white", col="white")
abline(h=0.5,lty=2,lwd=1, col="red")
dev.off()
}

# plot motion summary
pdf("/AG/AG-CSB_NeuroRad2/khalila/PROJECTS/sICA_2019/figures/supp_fig6/hm_fig.pdf", width = 4, height = 4)
plot(hm_max_fn,hm_mean_fn, col = "red", log = "xy", pch = 4, xlab = "Maximum framewise displacement (mm)", ylab = "Mean framewise displacement (mm)")
points(hm_max_all,hm_mean_all, pch = 16)
dev.off()

