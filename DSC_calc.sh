#!/bin/bash

# Script to calculate Dice similarity coefficient between Tmax ROIs and independent components
# Written by Ahmed Khalil, MD PhD 23.06.2021

# define paths
DATA_PATH=/home/khalila/CSB_NeuroRad2/khalila/STUDENTS/Yiing_MSc/DATA/ALLDATA

cd $DATA_PATH 
# loop through subjects
for i in *

do 

echo $i

	# loop through components 
	for c in $DATA_PATH/$i/func_unfilt.ica/stats/thresh_zstat*reg.nii.gz

	do 

	dsc=$(3ddot -dodice ${i}/Tmax_ROI.nii.gz $c) 
	cor=$(3ddot -docor ${i}/Tmax_ROI.nii.gz $c) 
	echo "${c} ${dsc}" >> $DATA_PATH/$i/dice.txt
	echo "${c} ${cor}" >> $DATA_PATH/$i/cor.txt
	
	done

done

