---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

![image](https://github.com/calhoujd/calhoujd.github.io/blob/cbedbd7c42b3d5d06731594f29379f6ec3284a10/docs/cliPE_methodOverview.jpg?raw=true)

# Welcome to the homepage for curated loci prime editing (cliPE) method resources!

---

## CliPE companion Shiny apps:

Click [here](https://www.example.com) to access the CliPEpy_1 shiny app for designing your cliPE libraries and epegRNA architectures for screening

Click [here]( https://calhoujd12.shinyapps.io/cliper_1_shiny_app/) to access the CliPEr_1 shiny app for converting the fasta output from jellyfish to csv

Click [here](https://calhoujd12.shinyapps.io/cliper_2_shiny_app/) to access the CliPEr_2 shiny app for performing final data analysis using random effect modeling of replicate experiments. Note: You can download 'Book2_e17_3xreps.csv' or 'Book2_e17_4xreps.csv' from github repo [here](https://github.com/calhoujd/calhoujd.github.io/tree/gh-pages) as example files with the correct formatting for the shiny app.

Click [here](https://www.example.com) to access the CliPEr_3 shiny app for [TEXT]

---

Some of the shiny apps above require specific input files, see instructions here:

### Clinvar missense tsv file

1. Navigate to https://www.ncbi.nlm.nih.gov/clinvar/ with Chrome or other web browser

2. Type gene name into search like 'TSC2'

3. On the left-side of the page, click the box next to 'Missense' in the Molecular consequence section

4. Just beneath 'Search results', click 'Download' to bring up the dropdown menu and click 'Create File' button

5. (optional) rename file to something like clinvar_mis_GeneName_DATE.tsv

6. upload tsv to shiny app CliPEpy_1 to design epegRNA libraries

---

### gnomAD missense csv file

1. Navigate to https://gnomad.broadinstitute.org/ with Chrome or other web browser

2. Type gene name into search like 'TSC2'

3. Scroll down and just above 'configure table' button is a checkbox for 'Missense/inframe indel' Click the only button to the right

4. Click 'Export variants to CSV' button

5. (optional) rename file to something like gnomADmis_GeneName_DATE.csv

6. upload csv to shiny app CliPEpy_1 to design epegRNA libraries

---

If you have any questions or run into issues with any of the shiny apps, please contact jeffrey [dot] calhoun [at] northwestern [dot] edu.

---

![image](https://github.com/calhoujd/calhoujd.github.io/blob/0e6b672a17881c58173847783af4cb406863f881/cliPE_Logo_small-01.png?raw=true)

