library(shiny)
library(bslib)

library(seqinr)

parsed = read.fasta('/Users/jdc411/Downloads/CB1_R1_kmerCount.fa', as.string = TRUE)

table = data.frame(unlist(parsed))
table$counts <- sapply(parsed, attr, 'Annot')
table$counts <- gsub('>', '', table$counts)
colnames(table) <- c('kmer','counts')

#table = data.frame(unlist(parsed), row.names = sapply(parsed, attr, 'Annot'))
# Error in data.frame(unlist(parsed), row.names = sapply(parsed, attr, "Annot")) : 
# duplicate row.names: >73, >22, >29, >20
#row.names(table) <- gsub('>', '', row.names(table))

