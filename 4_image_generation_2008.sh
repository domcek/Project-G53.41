# Script generates a folder with full band and a folder with rgb-colored image
mkdir ../data/0841190101/image/
mkdir ../data/0503740101/image/broad
mkdir ../data/0503740101/image/rgb

cd ../data/0503740101/image/broad

export SAS_CCF=../../ccf.cif 
export SAS_ODF=../../1521_0503740101_SCX00000SUM.SAS 

eimageget evtfile=../../data_reduction/mos1U002-clean.fits  fwcfile=../../../image_calibration_files/mos1-fwc.fits.gz  gtifile=../../data_reduction/mos1U002-gti.fits attfile=../../data_reduction/P0503740101OBX000ATTTSR0000.FIT pimin='800' pimax='4000'

eimageget evtfile=../../data_reduction/mos2U002-clean.fits  fwcfile=../../../image_calibration_files/mos2-fwc.fits.gz  gtifile=../../data_reduction/mos2U002-gti.fits attfile=../../data_reduction/P0503740101OBX000ATTTSR0000.FIT pimin='800' pimax='4000'

eimageget evtfile=../../data_reduction/pnU002-clean.fits ootfile=../../data_reduction/pnU002-clean-oot.fits fwcfile=../../../image_calibration_files/pn_closed_FF_2019_v1.fits.gz  gtifile=../../data_reduction/pnU002-gti.fits attfile=../../data_reduction/P0503740101OBX000ATTTSR0000.FIT pimin='800' pimax='4000'

eimagecombine prefix='G53_pmm_800_4000' smoothstyle='simple' convolverstyle=gaussian width=2 minwidth=0.0 maxwidth=10.0 desiredsnr=10.0 nconvolvers=20

cd ../rgb

eimageget evtfile=../../data_reduction/mos1U002-clean.fits  fwcfile=../../../image_calibration_files/mos1-fwc.fits.gz  gtifile=../../data_reduction/mos1U002-gti.fits attfile=../../data_reduction/P0503740101OBX000ATTTSR0000.FIT pimin='800 1500 2500' pimax='1500 2500 4000'

eimageget evtfile=../../data_reduction/mos2U002-clean.fits  fwcfile=../../../image_calibration_files/mos2-fwc.fits.gz  gtifile=../../data_reduction/mos2U002-gti.fits attfile=../../data_reduction/P0503740101OBX000ATTTSR0000.FIT pimin='800 1500 2500' pimax='1500 2500 4000'

eimageget evtfile=../../data_reduction/pnU002-clean.fits ootfile=../../data_reduction/pnU002-clean-oot.fits fwcfile=../../../image_calibration_files/pn_closed_FF_2019_v1.fits.gz  gtifile=../../data_reduction/pnU002-gti.fits attfile=../../data_reduction/P0503740101OBX000ATTTSR0000.FIT pimin='800 1500 2500' pimax='1500 2500 4000'

eimagecombine prefix='G53_pmm_800_1500_2500' smoothstyle='simple' convolverstyle=gaussian width=2 minwidth=0.0 maxwidth=10.0 desiredsnr=10.0 nconvolvers=20
