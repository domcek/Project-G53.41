heainit
sasinit
cd /mnt/storage/work/g53_2019/0841190101/data_reduction/
export SAS_CCF=../172.25.3.60_8721_xmm-newton.cif
export SAS_ODF=../3634_0841190101_SCX00000SUM.SAS

export src_name='g53_bkgbp'

export bkg_reg='( (X,Y) IN polygon(20445.201,32591.03,21080.844,33777.426,24584.857,33744.131,24505.663,31185.928,20429.124,31240.778) )'
export src_reg_pn_excl=' '
export bkg_source_x=30652
export bkg_source_y=22031

# SOME DETAILS ON FLAGS

# Including (FLAG==0) in the selection expression is recommended for pn. 
# This selection is even more restrictive than the #XMMEA_EP event attribute flag as it rejects, 
# in addition, events which are close to CCD gaps or bad pixels. In the case of MOS, 
# the filter expression #XMMEA_EM might be sufficient. 

# By default the following event selection is added to the spatial selection expressions: 
# for pn (FLAG==0)&&(PATTERN<=4) and for MOS #XMMEA_EM&&(PATTERN<=12).