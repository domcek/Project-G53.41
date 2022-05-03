# Spectral extraction of the background in 2008 dataset
### Include setup file setup_g53_xx.sh
# run as:
# bash g53_xmm_extraction_v3.sh /path/to/setup/file
# Steps before use of this script: 0) cifbuild/odfingest 1) epchain/emchain 2)pn-filter/mos-filter 3) barycentric correction
source $1

#MOS 2

# Sky BKG region spectrum #
evselect table=mos2U002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg} ${src_reg_pn_excl})"

# add background region scaling information into fits file #
backscale spectrumset=m2_${src_name}_bkg.pi badpixlocation=mos2U002-clean.fits

# Response matrix #
rmfgen spectrumset=m2_${src_name}_bkg.pi rmfset=m2_${src_name}_bkg.rmf

# Making detector map for arfgen #
evselect table=mos2U002-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=m2_${src_name}_bkg_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg} ${src_reg_pn_excl})"

# Ancillary matrix #
arfgen spectrumset=m2_${src_name}_bkg.pi arfset=m2_${src_name}_bkg.arf detmaptype=dataset \
detmaparray=m2_${src_name}_bkg_detmap.fits extendedsource=yes withrmfset=true \
rmfset=m2_${src_name}_bkg.rmf setbackscale=yes withbadpixcorr=true badpixlocation=mos2U002-clean.fits \
withfilteredset=true filteredset=m2_${src_name}_bkg_detmap_filter.fits withsourcepos=yes \
sourcecoords=pos sourcex=${bkg_source_x} sourcey=${bkg_source_y} 

ftgrouppha infile=m2_${src_name}_bkg.pi respfile=m2_${src_name}_bkg.rmf outfile=m2_${src_name}_bkgopt.pi grouptype=opt 


rm m2_${src_name}_bkgopt.grp
grppha << EOF
m2_${src_name}_bkgopt.pi
m2_${src_name}_bkgopt.grp
chkey RESPFILE m2_${src_name}_bkg.rmf
chkey ANCRFILE m2_${src_name}_bkg.arf
exit
EOF

rm m2_${src_name}_bkg.grp
grppha << EOF
m2_${src_name}_bkg.pi
m2_${src_name}_bkg.grp
chkey RESPFILE m2_${src_name}_bkg.rmf
chkey ANCRFILE m2_${src_name}_bkg.arf
exit
EOF


