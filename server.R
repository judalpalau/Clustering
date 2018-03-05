# Server

function(input, output, session) {
  
  Image <- readJPEG("Picture.jpg")
  longImage <- melt(Image)
  rgbImage <- reshape(longImage, timevar = "Var3",
                      idvar = c("Var1", "Var2"), direction = "wide")
  colnames(rgbImage) <- c("y","x","r","g","b")
  
  rgbImagedt <- as.data.table(rgbImage)
  setkey(rgbImagedt, r, g, b)
  source("input_desc.R",  local = TRUE)$value
  
 observeEvent(input$action, {
   kMeans <- kmeans(rgbImage[, 3:5], centers = input$cluster)
   ClusterColors <- as.data.table(kMeans$centers[kMeans$cluster, ])
   source("output_desc.R",  local = TRUE)$value   

 })
  
}

