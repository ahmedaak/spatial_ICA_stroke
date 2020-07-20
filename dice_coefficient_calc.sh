#!/usr/bin/env bash

# This script calculates the Dice similarity coefficient (a measure of spatial overlap) between Tmax perfusion lesions and independent components derived from rsfMRI data
# Written by Ahmed Khalil, MD PhD - January 2020

# define data path
DATA_PATH=/home/khalila/CSB_NeuroRad2/khalila/STUDENTS/Yiing_MSc/DATA/ALLDATA

cd $DATA_PATH
for i in */
do
cd $i

for s in func_unfilt.ica/stats/thresh_zstat*reg.nii.gz
do
dice=`3ddot -dodice Tmax*_cmasks.nii.gz $s `

printf "%d %s %f  \n" $i $s $dice >> $DATA_PATH/dice_results.csv

done
done

