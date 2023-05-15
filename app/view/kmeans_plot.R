# app/view/kmeans_plot.R

box::use(
  shiny[fluidPage, headerPanel, mainPanel, moduleServer, NS, numericInput, plotOutput,
        reactive, renderPlot, renderUI, selectInput, sidebarPanel, tags, uiOutput, verbatimTextOutput],
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  fluidPage(
    # classic app
    headerPanel(ns("Iris k-means clustering")),
    sidebarPanel(
      selectInput(ns("xcol"), 'X Variable', names(datasets::iris)),
      selectInput(ns("ycol"), 'Y Variable', names(datasets::iris),
                  selected=names(datasets::iris)[[2]]),
      numericInput(ns("clusters"), 'Cluster count', 3,
                   min = 1, max = 9)
    ),
    mainPanel(
      plotOutput(ns("plot1"))
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    selectedData <- reactive({
      datasets::iris[, c(input$xcol, input$ycol)]
    })

    clusters <- reactive({
      stats::kmeans(selectedData(), input$clusters)
    })

    output$plot1 <- renderPlot({
      grDevices::palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                           "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

      graphics::par(mar = c(5.1, 4.1, 0, 1))
      plot(selectedData(),
           col = clusters()$cluster,
           pch = 20, cex = 3)
      graphics::points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })

  })
}
