library(shiny)
library(bslib)

library(Biostrings)

# troubleshooting

# read in input file 1 ## this is the output from app 2 with enrichment/functional scores and SE
## oh shoot this is e37 ### need to find/make an e37 dictionary
df <- read.csv('/Users/jeffreycalhoun/Downloads/data-2024-12-20.csv')

# read in input file 2 ## this should be the dictionary file from cliPEpy_1 with variant names and k-mers
df2 <- read.csv('/Users/jeffreycalhoun/Downloads/TSC2_e37_kmer_dictionary.csv')


# initiate empty list
empty_list <- c()
counter <- 1
# convert to DNAstring to enable reverse complement function
for (i in df$kmer) {
  dna<-DNAString(x=i, start=1, nchar=NA)
  rev<-reverseComplement(dna)
  #print(dna)
  #print(rev)
  #print(as.character(rev))
  empty_list[counter] <- as.character(rev)
  counter = counter + 1
}

# works with no rev compl
df$kmer <- toupper(df$kmer)
merge_df <- merge(df,df2,by='kmer')

df$kmer <- empty_list
df$kmer <- toupper(df$kmer)
merge_df <- merge(df,df2,by='kmer')

