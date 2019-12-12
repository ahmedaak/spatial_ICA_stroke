# plots motion for sICA in stroke paper
# Ahmed Khail, 21.06.2019

# load in motion data for PWI + RS
pwi_hm <- read.csv("72_pwi_hm.txt",header=F)
rs_hm <- read.csv("72_rs_hm.txt", header=F)

# plot motion
png("72_pwi_hm.png", width = 15, height = 8, units = "cm", res=600)
plot(seq(from=1,to=nrow(pwi_hm)*1.39,by=1.39),pwi_hm$V1, type="l",lwd=3,xlab="Time (s)",ylab="Displacement (mm)",ylim=c(0,3.5))
dev.off()

png("72_rs_hm.png", width = 15, height = 8, units = "cm", res=600)
plot(seq(from=1,to=nrow(rs_hm)*2.3,by=2.3),rs_hm$V1, type="l",lwd=3,xlab="Time (s)",ylab="Displacement (mm)",ylim=c(0,3.5))
abline(h=0.5,lty=2,lwd=1, col="red")
dev.off()