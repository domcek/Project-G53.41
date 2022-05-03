# Data Reproduction Package for “Completing the X-ray view of the recently discovered supernova remnant G53.41+0.03“

V. Domček*, J. Vink, P. Zhou, L. Sun and L. Driessen

*Corresponding author: vdomcek@gmail.com, OrcID: 0000-0002-7770-4538

Published in Astronomy & Astrophysics: https://www.aanda.org/articles/aa/full_html/2022/03/aa41258-21/aa41258-21.html

Available on ArXiv: https://arxiv.org/abs/2105.02661

## Software

- Operating system: Ubuntu 18.04.5 LTS (GNU/Linux 5.4.0-64-generic x86_64)
- Software used in this work is publicly available at:
    - Anaconda / Python v3.7.4, including Astropy v3.2.2, NumPy v1.17.2, Matplotlib v3.3.1, SciPy v1.3.1, corner 2.2.1, pandas 0.25.1, jupyterlab v1.1.4
    - Heasoft 6.28, Xspec 12.11.1
    - XMM-Newton SAS release 18.0.0
	- SAOimageDS9 v8.1

## Data

All data files required to run the project and their descriptions are accessible in the Zenodo repository: https://doi.org/10.5281/zenodo.4737383N

## Scripts

All python analysis scripts are provided under “./*”.

Instruction for the order to run them in is provided in bash file “./0_RUN_ALL.sh”. Basic details on the function of the individual scripts is documented in the beginning of each script.

- 1_data_cleaning - reduces data from their raw format into a cleaned eventfile
- 2_extraction - extracts spectra based on the setup file
- 3_prepare_spectral_analysis - moves files around into the analysis folder
- 4_image_generation - generates images of individla observations, can be adjusted for energy range
- setup_xx - contains settings for 2_extraction scripts, pairing with correct extraction script is necessary (see 0_RUN_ALL.sh)

## Jupyter notebooks

All figures of the paper are provided in pdf format in folder "./figures/". They are an output of Jupyter notebooks:

“./zenodo_g53_tables_figures.ipynb” 

"./zenodo_g53_mcmc_figures.ipynb"

Figure 1 is produced directly from SAOimageDS9. You can use ds9's restore function to open the Fig.1 in paper configuration.
