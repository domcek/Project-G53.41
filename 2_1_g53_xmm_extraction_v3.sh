# Spectral extraction of the source region in 2019 dataset
### Include setup file setup_g53_xx.sh
# run as:
# bash g53_xmm_extraction_v3.sh /path/to/setup/file
# Steps before use of this script: 0) cifbuild/odfingest 1) epchain/emchain 2)pn-filter/mos-filter 3) barycentric correction
source $1

echo "--------------------------"
echo "      Processing MOS1     "
echo "--------------------------"


# SRC region spectrum #
evselect table=mos1S001-clean.fits withspectrumset=yes spectrumset=m1_${src_name}_src.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg} ${src_reg_pn_excl})"

# add source region scaling information into fits file #
backscale spectrumset=m1_${src_name}_src.pi badpixlocation=mos1S001-clean.fits

# Sky BKG region spectrum #
evselect table=mos1S001-clean.fits withspectrumset=yes spectrumset=m1_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg})"

# add background region scaling information into fits file #
backscale spectrumset=m1_${src_name}_bkg.pi badpixlocation=mos1S001-clean.fits

# Response matrix #
rmfgen spectrumset=m1_${src_name}_src.pi rmfset=m1_${src_name}_src.rmf

# Making detector map for arfgen #
evselect table=mos1S001-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=m1_${src_name}_src_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg} ${src_reg_pn_excl})"

# Ancillary matrix #
arfgen spectrumset=m1_${src_name}_src.pi arfset=m1_${src_name}_src.arf detmaptype=dataset \
detmaparray=m1_${src_name}_src_detmap.fits extendedsource=yes withrmfset=true \
rmfset=m1_${src_name}_src.rmf setbackscale=yes withbadpixcorr=true badpixlocation=mos1S001-clean.fits \
withfilteredset=true filteredset=m1_${src_name}_src_detmap_filter.fits withsourcepos=yes \
sourcecoords=pos sourcex=${src_source_x} sourcey=${src_source_y} 

# Optimal binning (from Kaastra & Bleeker (2016; A&A 587, A151) )
ftgrouppha infile=m1_${src_name}_src.pi backfile=m1_${src_name}_bkg.pi respfile=m1_${src_name}_src.rmf outfile=m1_${src_name}_srcopt.pi grouptype=opt 

# Grouping 
specgroup spectrumset=m1_${src_name}_srcopt.pi rmfset=m1_${src_name}_src.rmf \
arfset=m1_${src_name}_src.arf backgndset=m1_${src_name}_bkg.pi groupedset=m1_${src_name}_srcbkgopt.grp

echo "--> done   "

echo "--------------------------"
echo "      Processing MOS2     "
echo "--------------------------"




# SRC region spectrum #
evselect table=mos2S002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_src.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg} ${src_reg_pn_excl})"

# add source region scaling information into fits file #
backscale spectrumset=m2_${src_name}_src.pi badpixlocation=mos2S002-clean.fits

# Sky BKG region spectrum #
evselect table=mos2S002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg})"

# add background region scaling information into fits file #
backscale spectrumset=m2_${src_name}_bkg.pi badpixlocation=mos2S002-clean.fits

# Response matrix #
rmfgen spectrumset=m2_${src_name}_src.pi rmfset=m2_${src_name}_src.rmf

# Making detector map for arfgen
evselect table=mos2S002-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=m2_${src_name}_src_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg} ${src_reg_pn_excl})"

# Ancillary matrix #
arfgen spectrumset=m2_${src_name}_src.pi arfset=m2_${src_name}_src.arf detmaptype=dataset \
detmaparray=m2_${src_name}_src_detmap.fits extendedsource=yes withrmfset=true \
rmfset=m2_${src_name}_src.rmf setbackscale=yes withbadpixcorr=true badpixlocation=mos2S002-clean.fits \
withfilteredset=true filteredset=m2_${src_name}_src_detmap_filter.fits withsourcepos=yes \
sourcecoords=pos sourcex=${src_source_x} sourcey=${src_source_y} 

# Optimal binning (from Kaastra & Bleeker (2016; A&A 587, A151) )
ftgrouppha infile=m2_${src_name}_src.pi backfile=m2_${src_name}_bkg.pi respfile=m2_${src_name}_src.rmf outfile=m2_${src_name}_srcopt.pi grouptype=opt 

# Grouping 
specgroup spectrumset=m2_${src_name}_srcopt.pi mincounts=25 oversample=3 rmfset=m2_${src_name}_src.rmf \
arfset=m2_${src_name}_src.arf backgndset=m2_${src_name}_bkg.pi groupedset=m2_${src_name}_srcbkgopt.grp

echo "--> done   "

echo "--------------------------"
echo "      Processing PN       "
echo "--------------------------"

# SRC region spectrum #
evselect table=pnS003-clean.fits withspectrumset=yes spectrumset=pn_${src_name}_src.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=20479 expression="(FLAG==0) && (PATTERN<=4) && ( ${src_reg} ${src_reg_pn_excl} )"

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

# add source region scaling information into fits file #
backscale spectrumset=pn_${src_name}_src.pi badpixlocation=pnS003-clean.fits

# SKY BKG spectrum #
evselect table=pnS003-clean.fits withspectrumset=yes spectrumset=pn_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=20479 expression="(FLAG==0) && (PATTERN<=4) && ( ${bkg_reg} )"

# add background region scaling information into fits file #
backscale spectrumset=pn_${src_name}_bkg.pi badpixlocation=pnS003-clean.fits

# Response matrix #
rmfgen spectrumset=pn_${src_name}_src.pi rmfset=pn_${src_name}_src.rmf

## Making detector map for arfgen
evselect table=pnS003-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=pn_${src_name}_src_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY expression="(FLAG==0) && (PATTERN<=4) && ( ${src_reg} ${src_reg_pn_excl} )"

#generating effective area map
arfgen spectrumset=pn_${src_name}_src.pi arfset=pn_${src_name}_src.arf detmaptype=dataset \
detmaparray=pn_${src_name}_src_detmap.fits extendedsource=yes withrmfset=true rmfset=pn_${src_name}_src.rmf \
setbackscale=yes withbadpixcorr=true badpixlocation=pnS003-clean.fits withfilteredset=true  \
filteredset=pn_${src_name}_src_detmap_filter.fits withsourcepos=yes sourcecoords=pos \
sourcex=${src_source_x} sourcey=${src_source_y} 

# Optimal binning (from Kaastra & Bleeker (2016; A&A 587, A151) )
ftgrouppha infile=pn_${src_name}_src.pi backfile=pn_${src_name}_bkg.pi respfile=pn_${src_name}_src.rmf outfile=pn_${src_name}_srcopt.pi grouptype=opt 

# grouping
specgroup spectrumset=pn_${src_name}_srcopt.pi rmfset=pn_${src_name}_src.rmf \
arfset=pn_${src_name}_src.arf backgndset=pn_${src_name}_bkg.pi groupedset=pn_${src_name}_srcbkgopt.grp

echo "--> done "

ftgrouppha infile=m1_${src_name}_src.pi backfile=m1_${src_name}_bkg.pi respfile=m1_${src_name}_src.rmf outfile=m1_${src_name}_srcopt.pi grouptype=opt 

ftgrouppha infile=m2_${src_name}_src.pi backfile=m2_${src_name}_bkg.pi respfile=m2_${src_name}_src.rmf outfile=m2_${src_name}_srcopt.pi grouptype=opt 

rm m1_${src_name}_srcbkgopt.grp
grppha << EOF
m1_${src_name}_srcopt.pi
m1_${src_name}_srcbkgopt.grp
chkey RESPFILE m1_${src_name}_src.rmf
chkey ANCRFILE m1_${src_name}_src.arf
chkey BACKFILE m1_${src_name}_bkg.pi
exit
EOF

rm m2_${src_name}_srcbkgopt.grp
grppha << EOF
m2_${src_name}_srcopt.pi
m2_${src_name}_srcbkgopt.grp
chkey RESPFILE m2_${src_name}_src.rmf
chkey ANCRFILE m2_${src_name}_src.arf
chkey BACKFILE m2_${src_name}_bkg.pi
exit
EOF

rm pn_${src_name}_srcbkgopt.grp
grppha << EOF
pn_${src_name}_srcopt.pi
pn_${src_name}_srcbkgopt.grp
chkey RESPFILE pn_${src_name}_src.rmf
chkey ANCRFILE pn_${src_name}_src.arf
chkey BACKFILE pn_${src_name}_bkg.pi
exit
EOF

