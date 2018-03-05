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

output$input_dimensions <- renderText({sprintf("%spx x %spx", max(rgbImage$x), max(rgbImage$y))})
output$num_pixels <- renderText({format(nrow(rgbImagedt), big.mark = ",")})
output$input_number_colors <- renderText({ format(nrow(unique(rgbImagedt)), big.mark = ",") })

output$input_count_colors <- renderPlot({
  colors <- as.data.table(rgb(rgbImagedt[,3:5]))
  colors <- colors[,.(count=.N), by  = V1][order(-count)] 
  
  ggplot(data = colors[1:50], aes (x = reorder(V1, -count), y = count)) + geom_col(fill = colors[1:50, V1])+
    labs(x = "Color", y = "Count") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
})

output$input_graph_cluster <- renderPlotly({
  
  colors <- rgbImagedt
  colors$color <- rgb(rgbImagedt[,3:5])
  colors <- colors[,.(count=.N), by = list(color, r,g,b)][order(-count)]

  plot_ly(colors[1:500,], showlegend = FALSE,
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

###########################
output$input_ui <- renderUI({
  column(6, class = "col-xs-4",
         div(plotOutput("input_plot")),
         div(span("Image Dimensions (px)"),
             textOutput("input_dimensions", inline = TRUE)),
         div(span("Pixels"),
             textOutput("num_pixels", inline = TRUE)),
         div(span("Number of Colors"),
             textOutput("input_number_colors", inline = TRUE)),
         plotOutput("input_count_colors"),
         plotly::plotlyOutput("input_graph_cluster")
  )
})