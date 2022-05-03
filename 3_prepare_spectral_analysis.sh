# Moves around the data after complition of data reduction, filtering and extraction

mkdir ../data/analysis
mkdir ../data/analysis/background_g53
mkdir ../data/analysis/region1
mkdir ../data/analysis/region2
mkdir ../data/analysis/region3
mkdir ../data/analysis/background_ps
mkdir ../data/analysis/PS1
mkdir ../data/analysis/PS2


cd ../data/analysis/background_g53
mv ../../0841190101/data_reduction/*g53_bkgbp* .
mv ../../0503740101/data_reduction/*g53_2008_bkgbp* .

cd ../region1

mv ../../0841190101/data_reduction/*g53_yp* .
mv ../../0503740101/data_reduction/*g53_2008_yp* .

cd ../region2

mv ../../0841190101/data_reduction/*g53_gp* .
# region 2 not covered in 2008

cd ../region3

mv ../../0841190101/data_reduction/*g53_dp_adj* .
mv ../../0503740101/data_reduction/*g53_2008_dp_adj* .

cd ../background_g53
mv ../../0841190101/data_reduction/*g53_PSbkg* .

cd ../PS1
mv ../../0841190101/data_reduction/*g53_PS1* .

cd ../PS2
mv ../../0841190101/data_reduction/*g53_PS2* .