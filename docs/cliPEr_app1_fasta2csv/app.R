library(shiny)
library(bslib)

library(seqinr)

# this app converts fasta to csv
#read.fasta(NULL, as.string = TRUE)

# Define UI for slider demo app ----
ui <- page_sidebar(
  
  # App title ----
  title = "cliPEr_app1_fasta2csv",
  
  # Sidebar panel for inputs ----
  sidebar = sidebar(
    
    # Input: Select a file ----
    fileInput(
      "file1",
      "Choose fasta file",
      multiple = FALSE,
      accept = c(
        ".fa"
      )
    ),
    
    # Horizontal line ----
    tags$hr(),
    
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
    
    parsed = read.fasta(input$file1$datapath, as.string = TRUE)
    table = data.frame(unlist(parsed))
    table$counts <- sapply(parsed, attr, 'Annot')
    table$counts <- gsub('>', '', table$counts)
    colnames(table) <- c('kmer','counts')
    #write.csv(table,'/Users/jdc411/Downloads/test.csv',row.names = TRUE, col.names = FALSE)
    
    output$downloadData <- downloadHandler(
      filename = function() {
        paste("data-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(table, file)})
  })
    }

# Create Shiny app ----
shinyApp(ui, server)
