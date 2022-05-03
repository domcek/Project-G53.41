# Spectral extraction of the background in 2019 dataset
### Include setup file setup_g53_xx.sh
# run as:
# bash g53_xmm_extraction_v3.sh /path/to/setup/file
# Steps before use of this script: 0) cifbuild/odfingest 1) epchain/emchain 2)pn-filter/mos-filter 3) barycentric correction
source $1

# MOS 1
# Sky BKG region spectrum #
evselect table=mos1S001-clean.fits withspectrumset=yes spectrumset=m1_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg} ${src_reg_pn_excl})"

# add background region scaling information into fits file #
backscale spectrumset=m1_${src_name}_bkg.pi badpixlocation=mos1S001-clean.fits

# Response matrix #
rmfgen spectrumset=m1_${src_name}_bkg.pi rmfset=m1_${src_name}_bkg.rmf

# Making detector map for arfgen #
evselect table=mos1S001-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=m1_${src_name}_bkg_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg} ${src_reg_pn_excl})"

# Ancillary matrix #
arfgen spectrumset=m1_${src_name}_bkg.pi arfset=m1_${src_name}_bkg.arf detmaptype=dataset \
detmaparray=m1_${src_name}_bkg_detmap.fits extendedsource=yes withrmfset=true \
rmfset=m1_${src_name}_bkg.rmf setbackscale=yes withbadpixcorr=true badpixlocation=mos1S001-clean.fits \
withfilteredset=true filteredset=m1_${src_name}_bkg_detmap_filter.fits withsourcepos=yes \
sourcecoords=pos sourcex=${bkg_source_x} sourcey=${bkg_source_y} 

ftgrouppha infile=m1_${src_name}_bkg.pi respfile=m1_${src_name}_bkg.rmf outfile=m1_${src_name}_bkgopt.pi grouptype=opt 

# specgroup spectrumset=m1_${src_name}_bkgopt.pi rmfset=m1_${src_name}_bkg.rmf \
# arfset=m1_${src_name}_bkg.arf  groupedset=m1_${src_name}_bkgopt.grp


#MOS 2

# Sky BKG region spectrum #
evselect table=mos2S002-clean.fits withspectrumset=yes spectrumset=m2_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=11999 filtertype=expression \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg} ${src_reg_pn_excl})"

# add background region scaling information into fits file #
backscale spectrumset=m2_${src_name}_bkg.pi badpixlocation=mos2S002-clean.fits

# Response matrix #
rmfgen spectrumset=m2_${src_name}_bkg.pi rmfset=m2_${src_name}_bkg.rmf

# Making detector map for arfgen #
evselect table=mos2S002-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=m2_${src_name}_bkg_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY \
expression="#XMMEA_EM && (PATTERN<=12) && (${bkg_reg} ${src_reg_pn_excl})"

# Ancillary matrix #
arfgen spectrumset=m2_${src_name}_bkg.pi arfset=m2_${src_name}_bkg.arf detmaptype=dataset \
detmaparray=m2_${src_name}_bkg_detmap.fits extendedsource=yes withrmfset=true \
rmfset=m2_${src_name}_bkg.rmf setbackscale=yes withbadpixcorr=true badpixlocation=mos2S002-clean.fits \
withfilteredset=true filteredset=m2_${src_name}_bkg_detmap_filter.fits withsourcepos=yes \
sourcecoords=pos sourcex=${bkg_source_x} sourcey=${bkg_source_y} 

ftgrouppha infile=m2_${src_name}_bkg.pi respfile=m2_${src_name}_bkg.rmf outfile=m2_${src_name}_bkgopt.pi grouptype=opt 

# specgroup spectrumset=m2_${src_name}_bkgopt.pi rmfset=m2_${src_name}_bkg.rmf \
# arfset=m2_${src_name}_bkg.arf  groupedset=m2_${src_name}_bkgopt.grp

# PN

# SKY BKG spectrum #
evselect table=pnS003-clean.fits withspectrumset=yes spectrumset=pn_${src_name}_bkg.pi energycolumn=PI \
spectralbinsize=5 withspecranges=yes specchannelmin=0 specchannelmax=20479 expression="(FLAG==0) && (PATTERN<=4) && ( ${bkg_reg} ${src_reg_pn_excl})"

# add background region scaling information into fits file #
backscale spectrumset=pn_${src_name}_bkg.pi badpixlocation=pnS003-clean.fits

# Response matrix #
rmfgen spectrumset=pn_${src_name}_bkg.pi rmfset=pn_${src_name}_bkg.rmf

## Making detector map for arfgen
evselect table=pnS003-clean.fits destruct=false withfilteredset=true withimageset=true \
imageset=pn_${src_name}_bkg_detmap.fits imagebinning=binSize ximagebinsize=120 yimagebinsize=120 \
writedss=true updateexposure=true xcolumn=DETX ycolumn=DETY \
expression="(FLAG==0) && (PATTERN<=4) && ( ${bkg_reg} ${src_reg_pn_excl} )"

#generating effective area map
arfgen spectrumset=pn_${src_name}_bkg.pi arfset=pn_${src_name}_bkg.arf detmaptype=dataset \
detmaparray=pn_${src_name}_bkg_detmap.fits extendedsource=yes withrmfset=true rmfset=pn_${src_name}_bkg.rmf \
setbackscale=yes withbadpixcorr=true badpixlocation=pnS003-clean.fits withfilteredset=true  \
filteredset=pn_${src_name}_bkg_detmap_filter.fits withsourcepos=yes sourcecoords=pos \
sourcex=${bkg_source_x} sourcey=${bkg_source_y} 

# Optimal binning (from Kaastra & Bleeker (2016; A&A 587, A151) )
ftgrouppha infile=pn_${src_name}_bkg.pi respfile=pn_${src_name}_bkg.rmf outfile=pn_${src_name}_bkgopt.pi grouptype=opt 

# grouping

rm m1_${src_name}_bkgopt.grp
grppha << EOF
m1_${src_name}_bkgopt.pi
m1_${src_name}_bkgopt.grp
chkey RESPFILE m1_${src_name}_bkg.rmf
chkey ANCRFILE m1_${src_name}_bkg.arf
exit
EOF

rm m2_${src_name}_bkgopt.grp
grppha << EOF
m2_${src_name}_bkgopt.pi
m2_${src_name}_bkgopt.grp
chkey RESPFILE m2_${src_name}_bkg.rmf
chkey ANCRFILE m2_${src_name}_bkg.arf
exit
EOF

rm pn_${src_name}_bkgopt.grp
grppha << EOF
pn_${src_name}_bkgopt.pi
pn_${src_name}_bkgopt.grp
chkey RESPFILE pn_${src_name}_bkg.rmf
chkey ANCRFILE pn_${src_name}_bkg.arf
exit
EOF















