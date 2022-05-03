
heainit
sasinit
cd ../data/0841190101/data_reduction/
export SAS_CCF=../172.25.3.60_8721_xmm-newton.cif
export SAS_ODF=../3634_0841190101_SCX00000SUM.SAS

export src_name='g53_PS2'
export src_reg='( (X,Y) IN circle(26713,28020,300) )'
# export src_source_x=28200
# export src_source_y=30000

export bkg_reg='( (X,Y) IN annulus(26364.704,27961.033,555.25811,1250.3247) )'
# export bkg_source_x=36313
# export bkg_source_y=25929

# SOME DETAILS ON FLAGS

# Including (FLAG==0) in the selection expression is recommended for pn. 
# This selection is even more restrictive than the #XMMEA_EP event attribute flag as it rejects, 
# in addition, events which are close to CCD gaps or bad pixels. In the case of MOS, 
# the filter expression #XMMEA_EM might be sufficient. 

# By default the following event selection is added to the spatial selection expressions: 
# for pn (FLAG==0)&&(PATTERN<=4) and for MOS #XMMEA_EM&&(PATTERN<=12).