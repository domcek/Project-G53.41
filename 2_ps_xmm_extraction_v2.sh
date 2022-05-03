# Spectral extraction of the point source in 2019 dataset
### Include setup file setup_g53_xx.sh
# run as:
# bash g53_ps_extraction_v2.sh /path/to/setup/file
# Steps before use of this script: 0) cifbuild/odfingest 1) epchain/emchain 2)pn-filter/mos-filter 3) barycentric correction
source $1

MOS 1 has failed chip in the given location
echo "--------------------------"
echo "      Processing MOS1     "
echo "--------------------------"


# SRC #
evselect table=mos1S001-clean.fits withspectrumset=yes spectrumset=m1_${src_name}_src.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg})"

backscale spectrumset=m1_${src_name}_src.pi badpixlocation=mos1S001-clean.fits

# Sky BKG #
evselect table=mos1S001-clean.fits withspectrumset=yes spectrumset=m1_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg})"

backscale spectrumset=m1_${src_name}_bkg.pi badpixlocation=mos1S001-clean.fits

# Response matrix #
rmfgen spectrumset=m1_${src_name}_src.pi rmfset=m1_${src_name}_src.rmf

arfgen spectrumset=m1_${src_name}_src.pi arfset=m1_${src_name}_src.arf withrmfset=yes \
rmfset=m1_${src_name}_src.rmf badpixlocation=mos1S001-clean.fits detmaptype=psf

# Grouping 
# specgroup spectrumset=m1_${src_name}_src.pi mincounts=25 oversample=3 rmfset=m1_${src_name}_src.rmf \
# arfset=m1_${src_name}_src.arf backgndset=m1_${src_name}_bkg.pi groupedset=m1_${src_name}_srcbkg.grp

specgroup spectrumset=m1_${src_name}_src.pi mincounts=10 oversample=3 rmfset=m1_${src_name}_src.rmf \
arfset=m1_${src_name}_src.arf backgndset=m1_${src_name}_bkg.pi groupedset=m1_${src_name}_srcbkgmin10.grp

echo "--> done   "


echo "--------------------------"
echo "      Processing MOS2     "
echo "--------------------------"

# SRC #
evselect table=mos2S002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_src.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg})"

backscale spectrumset=m2_${src_name}_src.pi badpixlocation=mos2S002-clean.fits

# Sky BKG #
evselect table=mos2S002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg})"

backscale spectrumset=m2_${src_name}_bkg.pi badpixlocation=mos2S002-clean.fits

# Response matrix #
rmfgen spectrumset=m2_${src_name}_src.pi rmfset=m2_${src_name}_src.rmf

# Ancillary matrix #
arfgen spectrumset=m2_${src_name}_src.pi arfset=m2_${src_name}_src.arf withrmfset=yes \
rmfset=m2_${src_name}_src.rmf badpixlocation=mos2S002-clean.fits detmaptype=psf

# Grouping 
# specgroup spectrumset=m2_${src_name}_src.pi mincounts=25 oversample=3 rmfset=m2_${src_name}_src.rmf \
# arfset=m2_${src_name}_src.arf backgndset=m2_${src_name}_bkg.pi groupedset=m2_${src_name}_srcbkg.grp

specgroup spectrumset=m2_${src_name}_src.pi mincounts=10 oversample=3 rmfset=m2_${src_name}_src.rmf \
arfset=m2_${src_name}_src.arf backgndset=m2_${src_name}_bkg.pi groupedset=m2_${src_name}_srcbkgmin10.grp

echo "--> done   "


echo "--------------------------"
echo "      Processing PN       "
echo "--------------------------"

evselect table=pnS003-clean.fits withspectrumset=yes spectrumset=pn_${src_name}_src.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=20479 \
expression="(FLAG==0) && (PATTERN<=4) && ( ${src_reg} ${src_reg_pn_excl} )"

## OoT Events filtering
evselect table=pnS003-clean-oot.fits withspectrumset=yes xcolumn=DETX ycolumn=DETY \
spectrumset=pn_${src_name}_src_oot.pi energycolumn=PI spectralbinsize=5 withspecranges=yes \
specchannelmin=0 specchannelmax=20479 expression="(FLAG==0) && (PATTERN<=4) && ( ${src_reg} ${src_reg_pn_excl} )"

echo "-> Filtering OoT         "

#Change the name of the COUNTS column in the OoT event spectrum to CTS_OOT
fparkey value=CTS_OOT fitsfile=pn_${src_name}_src_oot.pi+1 keyword=TTYPE2

##Copy the CTS_OOT column of the OoT event spectrum into the source spectrum
faddcol infile=pn_${src_name}_src.pi+1 colfile=pn_${src_name}_src_oot.pi+1 colname=CTS_OOT

# Multiply the values in the column CTS_OOT by 0.063 (6.3% for pn in Full Frame Mode)
fcalc clobber=yes infile=pn_${src_name}_src.pi+1 outfile=pn_${src_name}_src.fits clname=CTS_OOT \
expr=CTS_OOT*0.063

# Subtract the rescaled values of the CTS_OOT from the COUNTS column of the source spectrum
fcalc clobber=yes infile=pn_${src_name}_src.fits+1 outfile=pn_${src_name}_src.fits clname=COUNTS \
expr=COUNTS-CTS_OOT

echo "--> done "

echo "--------------------------"
echo "-> Processing pn skybkg PN spectrum"

backscale spectrumset=pn_${src_name}_src.pi badpixlocation=pnS003-clean.fits

# SKY BKG blank sky #
evselect table=pnS003-clean.fits withspectrumset=yes spectrumset=pn_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=20479 \
expression="(FLAG==0) && (PATTERN<=4) && ( ${bkg_reg} )"

backscale spectrumset=pn_${src_name}_bkg.pi badpixlocation=pnS003-clean.fits

rmfgen spectrumset=pn_${src_name}_src.pi rmfset=pn_${src_name}_src.rmf

# Ancillary matrix #
arfgen spectrumset=pn_${src_name}_src.pi arfset=pn_${src_name}_src.arf withrmfset=yes \
rmfset=pn_${src_name}_src.rmf badpixlocation=pnS003-clean.fits detmaptype=psf


# specgroup spectrumset=pn_${src_name}_src.pi mincounts=25 oversample=3 rmfset=pn_${src_name}_src.rmf \
# arfset=pn_${src_name}_src.arf backgndset=pn_${src_name}_bkg.pi groupedset=pn_${src_name}_srcbkg.grp

specgroup spectrumset=pn_${src_name}_src.pi mincounts=10 oversample=3 rmfset=pn_${src_name}_src.rmf \
arfset=pn_${src_name}_src.arf backgndset=pn_${src_name}_bkg.pi groupedset=pn_${src_name}_srcbkgmin10.grp

echo "--> done "
