# UI


fluidPage(
  title = "Clustering Images",
  h1("Cluistering Images"),
  column(3, id = "inputs_panel",class = "col-xs-3",
      fileInput("file", label = NULL),
      hr(),
      selectInput("model", label = h3("Select Model"), 
                  choices = list("Kmeans" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                  selected = 1),
      numericInput("cluster", label = h3("Number of clusters"), value = 10),
      actionButton("action", "Generate")
  ),
  column(9, class = "col-xs-9",
    uiOutput("input_ui"),
    uiOutput("output_ui")
  )
)