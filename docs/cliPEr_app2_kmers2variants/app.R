library(shiny)
library(bslib)
#library(BiocManager)
library(Biostrings)

# this app matches k-mers to a dictionary and annotates with variant name

# Define UI for slider demo app ----
ui <- page_sidebar(
  
  # App title ----
  title = "cliPEr_app2_kmers2variants",
  
  # Sidebar panel for inputs ----
  sidebar = sidebar(
    
    # Input: Select a file ----
    fileInput(
      "file1",
      "Choose csv file | input the output from cliPEr_app1_fasta2csv with kmers and counts",
      multiple = FALSE,
      accept = c(
        ".csv"
      )
    ),
    fileInput(
      "file2",
      "Choose csv file | input the gene_RTT_table.csv dictionary file from the cliPE pegRNA designer companion shiny app with unique variant IDs and k-mers",
      multiple = FALSE,
      accept = c(
        ".csv"
      )
    ),
    # Horizontal line ----
    tags$hr(),
    fluidPage(
      radioButtons("rb", "Depending on whether the epegRNA targets the + or - strand of the reference genome,
                   you may need to reverse complement k-mers to enable matching with variant:kmer dictionary. Choose one:",
                   choiceNames = list("No reverse complement","With reverse complement"),
                   choiceValues = list("No","Yes"),
                   ),
      textOutput("txt")
    ),
    fluidPage(
      #tags$head(tags$script(src = "message-handler.js")),
      actionButton("do", "Click Me")
    ),
    fluidPage(
      downloadButton("downloadData", "Download")
    )
  ))

# Define server logic to read selected file ----
server <- function(input, output, session) {
  observeEvent(input$do, {
    #session$sendCustomMessage(type = 'testmessage',
    #                          message = 'Thank you for clicking')
    #print(input$reps) # troubleshooting ## seems to work
    
    req(input$file1)
    
    # pseudocode
    
    # read in input file 1 ## this is the output from app 2 with enrichment/functional scores and SE
    df = read.csv(input$file1$datapath)
    
    # read in input file 2 ## this should be the dictionary file from cliPEpy_1 with variant names and k-mers
    df2 = read.csv(input$file2$datapath)
    
    # currently everything is lower case ## if needs to be case-sensitive and upper-case, may need to find function for that
    
    # if normal
    if (input$rb == 'No'){
      
      # merge
      df$kmer <- toupper(df$kmer)
      df2$kmer <- toupper(df2$kmer)
      merge_df <- merge(df,df2,by='kmer')
      
      output$downloadData <- downloadHandler(
        filename = function() {
          paste("data-", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
          write.csv(merge_df, file)})
    }
    # if rev compl
    if (input$rb == 'Yes'){
      
      # need to reverse complement the correct column
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
      
      # replace with rev compl
      df$kmer <- empty_list
      
      # merge
      df$kmer <- toupper(df$kmer)
      df2$kmer <- toupper(df2$kmer)
      merge_df <- merge(df,df2,by='kmer')
      
      output$downloadData <- downloadHandler(
        filename = function() {
          paste("data-", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
          write.csv(merge_df, file)})
    }
    
    
  })
}

# Create Shiny app ----
shinyApp(ui, server)
