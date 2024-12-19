library(shiny)
library(bslib)

# this was working ## now its not ### not sure whyyyyy T_T
## I literally just copied and pasted to a new file and working again... no idea why...

# Define UI for slider demo app ----
ui <- page_sidebar(
  
  # App title ----
  title = "cliPEr_app3_random_effects_modeling",
  
  # Sidebar panel for inputs ----
  sidebar = sidebar(
    
    # Input: Select a file ----
    fileInput(
      "file1",
      "Choose CSV File",
      multiple = FALSE,
      accept = c(
        ".csv"
      )
    ),
    
    # Horizontal line ----
    tags$hr(),
    
    # Input: Select number of rows to display ----
    radioButtons(
      "reps",
      "Number of biological replicates (currently only 3 or 4 supported)",
      choices = c(
        Three = "Three",
        Four = "Four"
      ),
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
    
    df <- read.csv(
      input$file1$datapath)
    
    print(head(df)) # troubleshooting ## seems to work
    
    if (input$reps=="Three"){
      # add version of code for 3 reps
      # use /downloads/Book2_e17_3xreps.csv to test this code
      library(metafor)
      
      # subset to 2x df, separate for unsort and sort ## remove unneeded AF columns
      unsort_df<-as.data.frame(cbind(df$counts_control_rep1,df$counts_control_rep2,df$counts_control_rep3))
      colnames(unsort_df)<-c('counts_control_rep1','counts_control_rep2','counts_control_rep3')
      sort_df<-as.data.frame(cbind(df$counts_selected_rep1,df$counts_selected_rep2,df$counts_selected_rep3))
      colnames(sort_df)<-c('counts_selected_rep1','counts_selected_rep2','counts_selected_rep3')
      
      # sum each counts column ## this using og dataframe but that's fine
      shared_counts_unsort=c(sum(df$counts_control_rep1),sum(df$counts_control_rep2),sum(df$counts_control_rep3))#+0.5
      shared_counts_highPS6=c(sum(df$counts_selected_rep1),sum(df$counts_selected_rep2),sum(df$counts_selected_rep3))#+0.5
      shared_counts=shared_counts_unsort+shared_counts_highPS6
      
      #ratios = np.log(df[["c_0", c_last]].values + 0.5) - np.log(shared_counts)
      ratios_unsort <- as.data.frame(matrix(nrow=length(df$X),ncol=3))
      colnames(ratios_unsort) = c(1,2,3)
      
      for (i in seq(1,length(unsort_df$counts_control_rep1))){
        ratios_unsort[i,] = log(unsort_df[i,]) - log(shared_counts_unsort)
      }
      
      str(ratios_unsort)
      
      ratios_highPS6 <- as.data.frame(matrix(nrow=length(df$X),ncol=3))
      colnames(ratios_unsort) = c(1,2,3)
      
      for (i in seq(1,length(unsort_df$counts_control_rep1))){
        ratios_highPS6[i,] = log(sort_df[i,]) - log(shared_counts_highPS6)
      }
      
      str(ratios_highPS6)
    
    
    logratio = ratios_highPS6 - ratios_unsort
    str(logratio) # sanity check, second variant should be -0.13564237 -0.01022789  0.07969339  0.05442497
    ratios_df = as.data.frame(logratio)
    
    shared_variance = sum(1.0 / shared_counts)
    
    rep1_variance <- (1/(df$counts_control_rep1+df$counts_selected_rep1+0.5)) + shared_variance
    rep2_variance <- (1/(df$counts_control_rep2+df$counts_selected_rep2+0.5)) + shared_variance
    rep3_variance <- (1/(df$counts_control_rep3+df$counts_selected_rep3+0.5)) + shared_variance
    
    ratios_df$rep1_variance<-rep1_variance
    ratios_df$rep2_variance<-rep2_variance
    ratios_df$rep3_variance<-rep3_variance
    
    beta_vec<-c()
    se_vec<-c()
    for (i in seq(1,length(ratios_df$V1))) {
      sigma2i=c(ratios_df$rep1_variance[i],ratios_df$rep2_variance[i],ratios_df$rep3_variance[i])
      y=c(ratios_df$V1[i],ratios_df$V2[i],ratios_df$V3[i])
      #print(rma(yi=y,vi=sigma2i))
      rmod1<-rma(yi=y,vi=sigma2i)
      beta_vec[i]<-rmod1$beta
      se_vec[i]<-rmod1$se
    }
    
    str(beta_vec)
    str(se_vec)
    
    # maybe also add allele Frequency columns for each replicate
    df$AF_control_rep1<-unsort_df$counts_control_rep1 / shared_counts_unsort[1]
    df$AF_control_rep2<-unsort_df$counts_control_rep2 / shared_counts_unsort[2]
    df$AF_control_rep3<-unsort_df$counts_control_rep3 / shared_counts_unsort[3]
    df$beta_re<-beta_vec
    df$se_re<-se_vec
    
    print(df$AF_control_rep1)
    print(df$beta_re)
    
    # i think this may have broken app before...
    ## wow it worked and I was able to download proper output!!!!
    output$downloadData <- downloadHandler(
      filename = function() {
        paste("data-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(df, file)
      }
    )
    }
    
    if (input$reps=="Four"){
      # add version of code for 4 reps
      # use /downloads/Book2_e17_4xreps.csv to test this code
      library(metafor)
      
      # subset to 2x df, separate for unsort and sort ## remove unneeded AF columns
      unsort_df<-as.data.frame(cbind(df$counts_control_rep1,df$counts_control_rep2,df$counts_control_rep3,df$counts_control_rep4))
      colnames(unsort_df)<-c('counts_control_rep1','counts_control_rep2','counts_control_rep3','counts_control_rep4')
      sort_df<-as.data.frame(cbind(df$counts_selected_rep1,df$counts_selected_rep2,df$counts_selected_rep3,df$counts_selected_rep4))
      colnames(sort_df)<-c('counts_selected_rep1','counts_selected_rep2','counts_selected_rep3','counts_selected_rep4')
      
      # sum each counts column ## this using og dataframe but that's fine
      shared_counts_unsort=c(sum(df$counts_control_rep1),sum(df$counts_control_rep2),sum(df$counts_control_rep3),sum(df$counts_control_rep4))#+0.5
      shared_counts_highPS6=c(sum(df$counts_selected_rep1),sum(df$counts_selected_rep2),sum(df$counts_selected_rep3),sum(df$counts_selected_rep4))#+0.5
      shared_counts=shared_counts_unsort+shared_counts_highPS6
      
      #ratios = np.log(df[["c_0", c_last]].values + 0.5) - np.log(shared_counts)
      ratios_unsort <- as.data.frame(matrix(nrow=length(df$X),ncol=4))
      colnames(ratios_unsort) = c(1,2,3,4)
      
      for (i in seq(1,length(unsort_df$counts_control_rep1))){
        ratios_unsort[i,] = log(unsort_df[i,]) - log(shared_counts_unsort)
      }
      
      str(ratios_unsort)
      
      ratios_highPS6 <- as.data.frame(matrix(nrow=length(df$X),ncol=4))
      colnames(ratios_unsort) = c(1,2,3,4)
      
      for (i in seq(1,length(unsort_df$counts_control_rep1))){
        ratios_highPS6[i,] = log(sort_df[i,]) - log(shared_counts_highPS6)
      }
      
      str(ratios_highPS6)
    
    
    logratio = ratios_highPS6 - ratios_unsort
    str(logratio) # sanity check, second variant should be -0.13564237 -0.01022789  0.07969339  0.05442497
    ratios_df = as.data.frame(logratio)
    
    shared_variance = sum(1.0 / shared_counts)
    
    rep1_variance <- (1/(df$counts_control_rep1+df$counts_selected_rep1+0.5)) + shared_variance
    rep2_variance <- (1/(df$counts_control_rep2+df$counts_selected_rep2+0.5)) + shared_variance
    rep3_variance <- (1/(df$counts_control_rep3+df$counts_selected_rep3+0.5)) + shared_variance
    rep4_variance <- (1/(df$counts_control_rep4+df$counts_selected_rep4+0.5)) + shared_variance
    
    ratios_df$rep1_variance<-rep1_variance
    ratios_df$rep2_variance<-rep2_variance
    ratios_df$rep3_variance<-rep3_variance
    ratios_df$rep4_variance<-rep4_variance
    
    beta_vec<-c()
    se_vec<-c()
    for (i in seq(1,length(ratios_df$V1))) {
      sigma2i=c(ratios_df$rep1_variance[i],ratios_df$rep2_variance[i],ratios_df$rep3_variance[i],ratios_df$rep4_variance[i])
      y=c(ratios_df$V1[i],ratios_df$V2[i],ratios_df$V3[i],ratios_df$V4[i])
      #print(rma(yi=y,vi=sigma2i))
      rmod1<-rma(yi=y,vi=sigma2i)
      beta_vec[i]<-rmod1$beta
      se_vec[i]<-rmod1$se
    }
    
    str(beta_vec)
    str(se_vec)
    
    # maybe also add allele Frequency columns for each replicate
    df$AF_control_rep1<-unsort_df$counts_control_rep1 / shared_counts_unsort[1]
    df$AF_control_rep2<-unsort_df$counts_control_rep2 / shared_counts_unsort[2]
    df$AF_control_rep3<-unsort_df$counts_control_rep3 / shared_counts_unsort[3]
    df$AF_control_rep4<-unsort_df$counts_control_rep4 / shared_counts_unsort[4]
    df$beta_re<-beta_vec
    df$se_re<-se_vec
    
    print(df$AF_control_rep1)
    print(df$beta_re)
    
    # i think this may have broken app before...
    ## wow it worked and I was able to download proper output!!!!
    output$downloadData <- downloadHandler(
      filename = function() {
        paste("data-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(df, file)
      }
    )

    }})}

# Create Shiny app ----
shinyApp(ui, server)
