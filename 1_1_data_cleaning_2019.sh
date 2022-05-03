### Data reduction for 2019 observation

cd ../data/0841190101/

export SAS_CCF=~/Dropbox/work/2019_g53/zenodo/data/0841190101/172.25.3.60_8721_xmm-newton.cif 
# .cif file usually build by cifbuild - encountered issues locally, used the xmm website instead - https://www.cosmos.esa.int/web/xmm-newton/cifbuild

export SAS_ODF=~/Dropbox/work/2019_g53/zenodo/data/0841190101/odf
odfingest
export SAS_ODF=~/Dropbox/work/2019_g53/zenodo/data/0841190101/3634_0841190101_SCX00000SUM.SAS # output of odfingest

cd data_reduction
################################# REDUCTION AND CLEANING  #################################

epchain withoutoftime=true 2>&1 | tee log_epchain_oot.log 
epchain 2>&1 | tee log_epchain.log 
emchain 2>&1 | tee log_emchain.log 
mos-filter 2>&1 | tee log_mos-filter.log 

################################# pn-filter specific  #################################

# For pn standard pn-filter doesn't work and requires energy range change
# Following set of commands are individual commands of the pn-filter

##### pn-filter with adjustments (energy range in espfilt) ####

mv P0841190101PNS003PIEVLI0000.FIT pnS003.fits
mv P0841190101PNS003OOEVLI0000.FIT pnS003-oot.fits

espfilt eventset=pnS003-oot.fits specchanmin=10000
mv P0841190101PNS003-objevlifilt.FIT pnS003-clean-oot.fits
mv P0841190101PNS003-objlc.FIT pnS003-rate-oot.fits
mv P0841190101PNS003-corlc.FIT pnS003-ratec-oot.fits
mv P0841190101PNS003-gti.FIT pnS003-gti-oot.fits
mv P0841190101PNS003-gti.txt pnS003-gti-oot.txt
mv P0841190101PNS003-hist.qdp pnS003-hist-oot.qdp

espfilt eventset=pnS003.fits specchanmin=10000
mv P0841190101PNS003-objevlifilt.FIT pnS003-clean.fits
mv P0841190101PNS003-objlc.FIT pnS003-rate.fits
mv P0841190101PNS003-corlc.FIT pnS003-ratec.fits
mv P0841190101PNS003-gti.FIT pnS003-gti.fits
mv P0841190101PNS003-gti.txt pnS003-gti.txt
mv P0841190101PNS003-hist.qdp pnS003-hist.qdp


evselect table=pnS003.fits withimageset=yes imageset=pnS003-obj-image-det-unfilt.fits xcolumn='DETX' ximagesize=780 ximagemax=19500 ximagemin=-19499 ycolumn='DETY' yimagesize=780 expression='(PI in [300:12000])&&(PATTERN <= 4)&&((FLAG & 0xcfa097c) == 0)' filtertype=expression ignorelegallimits=yes yimagemax=19500 yimagemin=-19499 imagebinning=imageSize

evselect table=pnS003-oot.fits withimageset=yes imageset=pnS003-obj-image-det-unfilt-oot.fits xcolumn='DETX' ximagesize=780 ximagemax=19500 ximagemin=-19499 ycolumn='DETY' yimagesize=780 expression='(PI in [300:12000])&&(PATTERN <= 4)&&((FLAG & 0xcfa097c) == 0)' filtertype=expression ignorelegallimits=yes yimagemax=19500 yimagemin=-19499 imagebinning=imageSize

evselect table=pnS003-clean.fits withimageset=yes imageset=pnS003-obj-image-det.fits xcolumn='DETX' ximagesize=780 ximagemax=19500 ximagemin=-19499 ycolumn='DETY' yimagesize=780 expression='(PI in [300:12000])&&(PATTERN <= 4)&&((FLAG & 0xcfa097c) == 0)' filtertype=expression ignorelegallimits=yes yimagemax=19500 yimagemin=-19499 imagebinning=imageSize

evselect table=pnS003-clean-oot.fits withimageset=yes imageset=pnS003-obj-image-det-oot.fits xcolumn='DETX' ximagesize=780 ximagemax=19500 ximagemin=-19499 ycolumn='DETY' yimagesize=780 expression='(PI in [300:12000])&&(PATTERN <= 4)&&((FLAG & 0xcfa097c) == 0)' filtertype=expression ignorelegallimits=yes yimagemax=19500 yimagemin=-19499 imagebinning=imageSize

evselect table=pnS003-clean.fits withimageset=yes imageset=pnS003-obj-image-sky.fits squarepixels=yes ignorelegallimits=yes withxranges=yes withyranges=yes xcolumn='X' ximagesize=900 ximagemax=48400 expression='(PI in [300:12000])&&(PATTERN <= 4)&&((FLAG & 0xcfa097c) == 0)' filtertype=expression ximagemin=3401 ycolumn='Y' yimagesize=900 yimagemax=48400 yimagemin=3401 updateexposure=yes filterexposure=yes

evselect table=pnS003-clean-oot.fits withimageset=yes imageset=pnS003-obj-image-sky-oot.fits squarepixels=yes ignorelegallimits=yes withxranges=yes withyranges=yes xcolumn='X' ximagesize=900 ximagemax=48400 expression='(PI in [300:12000])&&(PATTERN <= 4)&&((FLAG & 0xcfa097c) == 0)' filtertype=expression ximagemin=3401 ycolumn='Y' yimagesize=900 yimagemax=48400 yimagemin=3401 updateexposure=yes filterexposure=yes
