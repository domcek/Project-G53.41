# Spectral extraction of the source region in 2008 dataset
### Include setup file setup_g53_xx.sh
# run as:
# bash g53_xmm_extraction_v3.sh /path/to/setup/file
# Steps before use of this script: 0) cifbuild/odfingest 1) epchain/emchain 2)pn-filter/mos-filter 3) barycentric correction
source $1


echo "--------------------------"
echo "      Processing MOS2     "
echo "--------------------------"


# SRC region spectrum #
evselect table=mos2U002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_src.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg} ${src_reg_pn_excl})"

# add source region scaling information into fits file #
backscale spectrumset=m2_${src_name}_src.pi badpixlocation=mos2U002-clean.fits

# Sky BKG region spectrum #
evselect table=mos2U002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg})"

# add background region scaling information into fits file #
backscale spectrumset=m2_${src_name}_bkg.pi badpixlocation=mos2U002-clean.fits

# Response matrix #
rmfgen spectrumset=m2_${src_name}_src.pi rmfset=m2_${src_name}_src.rmf

# Making detector map for arfgen
evselect table=mos2U002-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=m2_${src_name}_src_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY expression="#XMMEA_EM && (PATTERN<=12) && (${src_reg} ${src_reg_pn_excl})"

# Ancillary matrix #
arfgen spectrumset=m2_${src_name}_src.pi arfset=m2_${src_name}_src.arf detmaptype=dataset \
detmaparray=m2_${src_name}_src_detmap.fits extendedsource=yes withrmfset=true \
rmfset=m2_${src_name}_src.rmf setbackscale=yes withbadpixcorr=true badpixlocation=mos2U002-clean.fits \
withfilteredset=true filteredset=m2_${src_name}_src_detmap_filter.fits withsourcepos=yes \
sourcecoords=pos sourcex=${src_source_x} sourcey=${src_source_y} 

# Optimal binning (from Kaastra & Bleeker (2016; A&A 587, A151) )
ftgrouppha infile=m2_${src_name}_src.pi backfile=m2_${src_name}_bkg.pi respfile=m2_${src_name}_src.rmf outfile=m2_${src_name}_srcopt.pi grouptype=opt 

# Grouping 
specgroup spectrumset=m2_${src_name}_srcopt.pi mincounts=25 oversample=3 rmfset=m2_${src_name}_src.rmf \
arfset=m2_${src_name}_src.arf backgndset=m2_${src_name}_bkg.pi groupedset=m2_${src_name}_srcbkgopt.grp

echo "--> done   "

rm m2_${src_name}_srcbkgopt.grp
grppha << EOF
m2_${src_name}_srcopt.pi
m2_${src_name}_srcbkgopt.grp
chkey RESPFILE m2_${src_name}_src.rmf
chkey ANCRFILE m2_${src_name}_src.arf
chkey BACKFILE m2_${src_name}_bkg.pi
exit
EOF

