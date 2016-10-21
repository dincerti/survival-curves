server <- function(input, output, session) {
  # dat <- reactive({
  #   cdf <- switch(input$survdist,
  #                  exp = pexp, wei = pweibull)
  #   
  #   args <- switch(input$survdist,
  #                      exp = input$rate, wei = c(input$shape, input$scale))
  #   
  #   f <- formals(cdf);  f <- f[names(f)!="n"]; len <- min(length(f),3-1); f <- f[1:len]
  #   return(list(do.call(survdist,argList),names(f)))
  # })
}