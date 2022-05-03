### Data reduction for 2008 observation

cd ../data/0503740101/

export SAS_ODF=~/Dropbox/work/2019_g53/zenodo/data/0503740101/odf
cifbuild
export SAS_CCF=~/Dropbox/work/2019_g53/zenodo/data/0503740101/ccf.cif 
# .cif file usually build by cifbuild - encountered issues locally, used the xmm website instead - https://www.cosmos.esa.int/web/xmm-newton/cifbuild

odfingest
export SAS_ODF=~/Dropbox/work/2019_g53/zenodo/data/0503740101/1521_0503740101_SCX00000SUM.SAS # output of odfingest

cd data_reduction
################################# REDUCTION AND CLEANING  #################################

epchain withoutoftime=true 2>&1 | tee log_epchain_oot.log 
epchain 2>&1 | tee log_epchain.log 
emchain 2>&1 | tee log_emchain.log 
mos-filter 2>&1 | tee log_mos-filter.log 
pn-filter 2>&1 | tee log_pn-filter.log 
