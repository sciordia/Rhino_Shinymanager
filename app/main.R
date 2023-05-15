box::use(
  shiny[fluidPage, moduleServer, NS],
  shinymanager,
)

# Modules
box::use(
  app/view/kmeans_plot,
)

# Define your `check_credentials` function.
check_credentials <- shinymanager$check_credentials(
  data.frame(user = "admin", password = "admin")
)

#' @export
ui <- function(id) {
  ns <- NS(id)

  shinymanager$secure_app(

    kmeans_plot$ui(ns("kmeans_plot"))

  )

}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    shinymanager$secure_server(check_credentials)
    kmeans_plot$server("kmeans_plot")

  })
}
