# Setup file for region 1 (legacy identification _yp)
heainit
sasinit
cd ../data/0841190101/data_reduction/
export SAS_CCF=../172.25.3.60_8721_xmm-newton.cif
export SAS_ODF=../3634_0841190101_SCX00000SUM.SAS

export src_name='g53_yp'
export src_reg='(X,Y) IN annulus(26500,28000,1300,4200) && (X,Y) IN pie(26500,28000,310,420) '
export src_reg_pn_excl=' && !(X,Y) IN box(25893.07,27382.364,735.5,13256.44,357.49991) && !(X,Y) IN circle(24404.241,30669.657,308.3) && !(X,Y) IN circle(26171.967,26875.983,250) && !(X,Y) IN circle(24539.903,31227.379,144.68) && !(X,Y) IN circle(27930.692,31603.005,199) && !(X,Y) IN circle(28637.968,31554.78,199) && !(X,Y) IN circle(29129.131,30862.685,199) && !(X,Y) IN circle(26204.469,27871.056,199) && !(X,Y) IN circle(26751.447,27993.846,199) && !(X,Y) IN circle(28224.936,26520.352,278.88719) && !(X,Y) IN circle(24911.995,30018.074,144) && !(X,Y) IN circle(30479.392,29833.922,199) && !(X,Y) IN circle(30077.525,26201.095,199) '
export src_source_x=29091
export src_source_y=28074

export bkg_reg='( (X,Y) IN polygon(28330.055,22217.869,30051.069,23241.156,33555.102,23210.129,33477.567,20651.875,27849.419,20837.965) )'
export bkg_source_x=30652
export bkg_source_y=22031

# SOME DETAILS ON FLAGS

# Including (FLAG==0) in the selection expression is recommended for pn. 
# This selection is even more restrictive than the #XMMEA_EP event attribute flag as it rejects, 
# in addition, events which are close to CCD gaps or bad pixels. In the case of MOS, 
# the filter expression #XMMEA_EM might be sufficient. 

# By default the following event selection is added to the spatial selection expressions: 
# for pn (FLAG==0)&&(PATTERN<=4) and for MOS #XMMEA_EM&&(PATTERN<=12).