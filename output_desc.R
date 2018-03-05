
#Output Graph
output$output_plot <- renderPlot({
  qplot(data = rgbImage, x = x, y = -y, fill = rgb(ClusterColors), geom = "tile") +
    coord_equal() + scale_fill_identity(guide = "none")  +
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())
})

# Output Pixels
  output$output_dimensions <- renderText({sprintf("%spx x %spx", max(rgbImage$x), max(rgbImage$y))})
  output$output_number_colors <- renderText({ format(nrow(unique(ClusterColors)), big.mark = ",") })

#Output GraphCount
  output$output_count_colors <- renderPlot({
    colors <- as.data.table(rgb(ClusterColors))
    colors <- colors[,.(count=.N), by  = V1][order(-count)] 
    
    ggplot(data = colors[1:input$cluster], aes (x = reorder(V1, -count), y = count)) + geom_col(fill = colors[1:input$cluster, V1])+
      labs(x = "Color", y = "Count") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })

output$output_graph_cluster <- renderPlotly({
  colors <- rgbImagedt[,3:5] 
  colors$color <- rgb(ClusterColors)
  colors <- colors[,.(count=.N), by = list(color, r,g,b)][order(-count)]
  
  colors[, .SD[1:10], color]
    
  plot_ly(colors[, .SD[1:10], color], showlegend = FALSE,
    hoverinfo = "none",
    x = ~r, y = ~g, z = ~b) %>%
  add_markers(color = ~color, colors = ~color) %>%
  layout(
    scene = list(xaxis = list(title = 'Red',
                              range = c(0,1)),
                 yaxis = list(title = 'Green',
                              range = c(0,1)),
                 zaxis = list(title = 'Blue',
                              range = c(0,1))))
    
  })
  
  
  output$input_plot <- renderPlot(width = "auto", height = "auto", {
    qplot(data = rgbImage, x = x, y = -y, fill = rgb(rgbImage[, 3:5]), geom = "tile") +
      coord_equal() + scale_fill_identity(guide = "none")  +
      theme(axis.title.x=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.title.y=element_blank(),
            axis.text.y=element_blank(),
            axis.ticks.y=element_blank(),
            panel.border = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank())
  })

#############
output$output_ui <- renderUI({
    column(6, class = "col-xs-4",
           div(plotOutput("output_plot")),
           div(span("Image Dimensions (px)"),
               textOutput("output_dimensions", inline = TRUE)),
           div(span("Number of Colors"),
               textOutput("output_number_colors", inline = TRUE)),
           plotOutput("output_count_colors"),
           plotly::plotlyOutput("output_graph_cluster")
    )
  })