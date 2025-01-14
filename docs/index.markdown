---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

![image](https://github.com/calhoujd/calhoujd.github.io/blob/cbedbd7c42b3d5d06731594f29379f6ec3284a10/docs/cliPE_methodOverview.jpg?raw=true)

# Welcome to the homepage for curated loci prime editing (cliPE) method resources!

## If you want to learn more about cliPE, here are some links:

1. Jeff's MSS24 talk archived on Youtube --> click [here](https://youtu.be/BRmVPsm1K7Y?si=jaTcJvBxC7rk4InR)

2. cliPE preprint available now on Arxiv (please note supplemental tables available at github repo) --> click [here](https://arxiv.org/abs/2501.04822)

3. cliPE Github repo --> click [here](https://github.com/calhoujd/calhoujd.github.io)

4. cliPE protocols.io resources --> hopefully coming soon

---

## CliPE companion Shiny apps:

Click [here](https://design.clipe-mave.org) to access the cliPEpy pegRNA Designer shiny app for designing your cliPE libraries and epegRNA architectures for screening (HUGE shoutout to Nico Bodkin for all his hard work building this Shiny app!)

Click [here](https://calhoujd12.shinyapps.io/cliPEr_app1_fasta2csv/) to access the cliPEr_app1_fasta2csv shiny app for converting the fasta output from jellyfish to csv

Click [here](https://calhoujd12.shinyapps.io/cliPEr_app2_kmers2variants/) to access the cliPEr_app2_kmers2variants for using dictionary file to annotate the jellyfish kmer count file with variant name

Click [here](https://calhoujd12.shinyapps.io/cliPEr_app3_random_effects_modeling/) to access the cliPEr_app3_random_effects_modeling shiny app for shiny app for performing final data analysis using random effect modeling of replicate experiments. Note: You can download 'Book2_e17_3xreps.csv' or 'Book2_e17_4xreps.csv' from github repo [here](https://github.com/calhoujd/calhoujd.github.io/tree/gh-pages) as example files with the correct formatting for the shiny app.

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

## Due to limitations in manuscript formatting, there are a few topics we were unable to cover in the above preprint. Please see below for additional information on cliPE which may be helpful as you design your experiment:

---
## Designing initial set of epegRNA architectures to screen, epegRNA libraries, and nicking gRNAs (cliPE Module 1)

We have provided a Shiny app to streamline prime editing design. In one step, the Shiny app designs epegRNA libraries based on user input and outputs files including candidate epegRNA libraries, archetypal epegRNAs, and nicking gRNAs. It is important to consider at this stage how many epegRNA libraries will be targeted for the eventual cliPE experiment. Each epegRNA library typically targets one 42-45 bp region which allows editing of up to 15 codons. We target a goal of 15-30% overall editing efficiency for epegRNA libraries; initially, we observed this in about 50% of archetypal epegRNAs screened for TSC2.6 Ongoing work in our lab suggests that highly efficient epegRNAs may comprise 20-50% of designs. Our recommendation is to screen a minimum of 12 archetypal epegRNAs which will produce on average 3-6 epegRNA libraries which will be usable for cliPE. It may be desirable to screen more than 12 archetypal epegRNAs upfront to increase the probability of attaining enough epegRNA designs to proceed with library cloning.

It is important that the regions targeted also include additional classes of variants, or a truth set which will be key for validation of the MAVE during data analysis. Overall, for most MAVEs, two truth sets comprised of positive and negative controls are used to assess assay validity, which will be referred to as the assay validation truth set and the clinical truth set (see Table 1). The assay validation truth set consists of (1) synonymous and missense variants found in the general population in databases such as gnomAD (negative controls) and (2) premature truncation codon (PTC) variants (positive controls). It is critical to set a threshold for allele count or allele frequency for gnomAD variants to filter out variants with variable expressivity or incomplete penetrance which might confound later analysis; this is context-dependent and will vary somewhat gene-to-gene. The clinical truth set similarly consists of negative and positive controls present in the ClinVar database.1 The negative controls in the clinical truth set are benign or likely benign (BLB) variants and the positive controls are pathogenic or likely pathogenic (PLP) missense variants. Brnich et al. provides guidance as to minimal truth set datasets for MAVEs: a minimum of 11 clinical truth set variants divided between BLB and PLP is necessary to achieve moderate evidence strength of benignity or pathogenicity in an ACMG variant classification framework.10 The exact number of variants needed to achieve moderate or greater evidence strength will vary by gene and depend largely, but not entirely, on the dynamic range of the individual MAVE. Our recommendation is to include at least 25-30 clinical truth set variants in a cliPE experiment. We note that some genes lack sufficient clinical truth set variants and MAVEs targeting these genes may need to rely more heavily on assay validation truth set variants.

The Shiny app takes basic information as input such as gene name and RefSeq transcript ID. The user will receive as output a set of documents containing: (1) archetypal epegRNA architectures for screening, (2) oligo libraries to generate epegRNA libraries, and (3) nicking gRNAs. Further, the script will also output sequences for the necessary primers for amplifying the single-stranded oligo pool into double-stranded DNA for cloning into the destination vector. epegRNA designs are based on DeepPrime predictions of optimal prime editing designs.11 Optionally, resources are provided for alternative resources for designing epegRNAs in Table 2. Missense variants from ClinVar and gnomAD are used to generate truth set and assay validation variants. Synonymous variants in gnomAD can optionally be used as additional negative control variants in the assay validation truth set. Custom code produces a TGA at each codon to produce PTC variants for assay validation. We provide examples based on TSC2 for all input and output files. Once the designs are complete, primers and oligo pools can be ordered from a preferred vendor such as Twist Biosciences, Agilent, or IDT. We typically order small IDT oPools for cliPE as the turnaround time is relatively fast and does not require waiting on a quote.

---

## Primer design: Sanger sequencing or low-depth LR sequencing

It is necessary to design primers using Primer3 (https://primer3.ut.ee/) or an equivalent primer design tool to amplify a relatively broad region containing  genome editing targets. These primers can be used to amplify these regions for subsequent sequencing to estimate editing rate. It is important to ensure that the primers do not bind too close to the site of editing, particularly for primer designs for Sanger sequencing, due to the extra noise in the first 25-35 bases of sequencing data. This is critical for the archetypal epegRNA screen (Module 2) and for validation of editing with subsequent epegRNAs. An amplicon size of 500-700 bp is optimal for Sanger sequencing, while amplicons of 800-1200 bp are optimal for LR sequencing. We routinely use Plasmidsaurus sequencing services for cost-effective LR sequencing with quick turnaround time, though other preferred vendors may offer similar services. Sanger sequencing reactions are typically less expensive ($4-5 per reaction), while LR sequencing ($15) provides a better estimate of prime editing efficiency.

## Primer design: high-depth amplicon sequencing

It is further necessary to design primers to amplify the region of interest specifically (region overlapping RT template of epegRNA pool). It is critical to constrain the total amplicon size to be less than 250 bp to maximize read depth of the target region. Also, as above, it is important to ensure the primers do not overlap the region of interest to detect any small insertions and deletions (indels). If sequencing with a vendor such as MGH CCIB DNA Core’s Complete Amplicon Sequencing service or GENEWIZ from Azenta Amplicon-EZ, it is important to review the sample submission guidelines specific to the respective service. If sequencing in multiplex at a core facility or outside vendor (Module 6 option B), it is necessary when ordering these primers to append the appropriate Illumina adaptors to enable the barcoding in step 6B.5: 

Primer 1: adapter + forward target primer (5’- TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG -forward_primer-3’).
Primer 2: adapter + reverse target primer (5’- GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG -reverse_primer-3’).

---

## A visual guide with additional information about ordering primers and oligo pools is available here via Google Slides: [link](https://docs.google.com/presentation/d/19ulsfNYrS6wXWAH6BziDBEWpf9DCic-j5-a2ZupwefA/edit?usp=sharing)

---

## Amplicon sequencing of human genomic DNA (cliPE Module 6)

If there are a small number of libraries to sequence, it can be economically advantageous to submit each library separately to an amplicon sequencing service such as MGH CCIB DNA Core’s Complete Amplicon Sequencing service or GENEWIZ from Azenta Amplicon-EZ rather than pooling indexed libraries for sequencing at a core facility or external sequencing vendor such as Novogene, BGI, etc. It is worth estimating the cost for each option to determine which method will be best. For example, our in-house Illumina MiniSeq runs cost approximately $1200 for 8M reads, sufficient to run up to ~32 libraries with a coverage target of 200,000 reads per sample. Based on current prices, it is more economical to multiplex libraries on the MiniSeq only when we have more than ~24 total libraries. Using an amplicon sequencing service has particular utility for QC of epegRNA plasmid libraries and initial MAVE optimization on a small number of epegRNA libraries. We recommend multiplexing when there are sufficient libraries, which will typically be a final pool of all of the biological replicates of selected and control conditions for multiple epegRNA libraries. As each library only requires a minimum of 200,000 reads, it is cost-effective to run up to hundreds of multiplexed libraries in a single sequencing run. 

---

## A note on resources to learn sufficient command line working knowledge for cliPE:

Our goal in designing the Shiny apps was to keep the barrier for entry for cliPE as low as possible. Still, some basic knowledge of the Unix command line and executing software on Linux operating systems is required. There are many primers that can be completed in 1-2 hours to learn the requisite knowledge for completing Module 7; a number are linked to here: https://github.com/nuitrcs/bash_hpc_workshops.

---

## If you have any questions or run into issues with any of the shiny apps, please contact jeffrey [dot] calhoun [at] northwestern [dot] edu. Alternativel, @calhoujd on Twitter/X, or @calhoujd.bsky.social on Bluesky

---

## Shout out section to thank folks:

### Carina Biar: Carina worked with me on developing cliPE as an NU undergrad and also a gap year technician. Much of what you see on this page and the preprints linked above are due to her hard work, thank you Carina!

### Nico Bodkin: As mentioned above, Nico did an awesome job designing and implementing the pegRNA Designer companion Shiny app. Check it out, link above. Also click [here](https://nicobodkin.com/) to check out Nico's webpage

### xinkblot: Valerie at xinkblot really knocked the cliPE logo design out of the park! If you want your very own awesome logo, check out the xinkblot Etsy store: [here](https://www.etsy.com/shop/xinkblot) 

### Funding: huge thank you to the [American Epilepsy Society] (https://aesnet.org/) for the Junior Investigator Award which funded our TSC2 MAVE and also cliPE development

### Others: thanks to awesome resources including Github, Plasmidsaurus, Heroku, shinyapps.io and others for streamlining our workflows and enabling the sharing of code and the cliPE companion Shiny apps

---

![image](https://github.com/calhoujd/calhoujd.github.io/blob/0e6b672a17881c58173847783af4cb406863f881/cliPE_Logo_small-01.png?raw=true)

