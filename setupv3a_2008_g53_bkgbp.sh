heainit
sasinit
cd ../data/0503740101/data_reduction/
export SAS_CCF=../ccf.cif
export SAS_ODF=../1521_0503740101_SCX00000SUM.SAS

export src_name='g53_2008_bkgbp'

export src_reg_pn_excl=' '
export bkg_reg='( (X,Y) IN polygon(20445.201,32591.03,21080.844,33777.426,24584.857,33744.131,24505.663,31185.928,20429.124,31240.778) )'
export bkg_source_x=22209
export bkg_source_y=32507

# SOME DETAILS ON FLAGS

# Including (FLAG==0) in the selection expression is recommended for pn. 
# This selection is even more restrictive than the #XMMEA_EP event attribute flag as it rejects, 
# in addition, events which are close to CCD gaps or bad pixels. In the case of MOS, 
# the filter expression #XMMEA_EM might be sufficient. 

# By default the following event selection is added to the spatial selection expressions: 
# for pn (FLAG==0)&&(PATTERN<=4) and for MOS #XMMEA_EM&&(PATTERN<=12).