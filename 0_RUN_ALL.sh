### Data reduction and cleaning ###
bash 1_1_data_cleaning_2019.sh
bash 1_2_data_cleaning_2008.sh

### Spectral extraction ###
# SNR Regions
bash 2_1_g53_xmm_background_v3.sh setupv3a_g53_bkgbp.sh 
bash 2_1_g53_xmm_extraction_v3.sh setupv3a_g53_region1-yp.sh
bash 2_1_g53_xmm_extraction_v3.sh setupv3a_g53_region2-gp.sh
bash 2_1_g53_xmm_extraction_v3.sh setupv3a_g53_region3-dp_adj.sh

bash 2_2_g53_xmm_background_v3_2008.sh setupv3a_2008_g53_bkgbp.sh
bash 2_2_g53_xmm_extraction_v3_2008.sh setupv3a_2008_g53_region1-yp.sh
bash 2_2_g53_xmm_extraction_v3_2008.sh setupv3a_2008_g53_region3-dp_adj.sh

# Point sources
bash 2_1_g53_xmm_background_v3.sh setupv2_g53_PSbkg.sh
bash 2_ps_xmm_extraction_v2.sh setupv2_g53_PS1.sh
bash 2_ps_xmm_extraction_v2.sh setupv2_g53_PS2.sh

### Moving data for spectral analysis ###
bash 3_prepare_spectral_analysis.sh
# ---> Spectral analysis in XSPEC

### Create images in broad (0.8-4.0keV) and rgb (r 0.8-1.5keV, g 1.5-2.5keV, b 2.5-4.0keV)
bash 4_image_generation.sh
bash 4_image_generation_2008.sh
# ---> used in ds9 to produce figure1

