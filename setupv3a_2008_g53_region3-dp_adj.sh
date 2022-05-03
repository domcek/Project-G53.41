# Setup file for region 3 2008 observation (legacy identification 2008_dp_adj)

heainit
sasinit
cd ../data/0503740101/data_reduction/
export SAS_CCF=../ccf.cif
export SAS_ODF=../1521_0503740101_SCX00000SUM.SAS

export src_name='g53_2008_dp_adj'
export src_reg='(X,Y) IN annulus(18336,38908,1300,4200) && (X,Y) IN pie(18336,38908,170,290) '
export src_reg_pn_excl=' && !(X,Y) IN circle(18007.791,37784.502,250) && !(X,Y) IN circle(18040.935,38779.572,199) && !(X,Y) IN circle(18587.998,38902.002,199) && !(X,Y) IN circle(20060.532,37427.535,278.88) && !(X,Y) IN circle(22317.148,40739.681,199) && !(X,Y) IN circle(21912.931,37107.066,199) '
export src_source_x=16812
export src_source_y=36866

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