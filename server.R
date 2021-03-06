server <- function(input, output, session) {
    dat <- reactive({
      sdist <- switch(input$survdist,
                     exp = sexp, wei = sweibull,
                     lnorm = slnorm, gamma = sgamma,
                     gompertz = sgompertz, llogis = sllogis,
                     gengamma = sgengamma)
      ddist <- switch(input$survdist,
                      exp = dexp, wei = dweibull,
                      lnorm = dlnorm, gamma = dgamma,
                      gompertz = dgompertz, llogis = dllogis,
                      gengamma = dgengamma) 
      hdist <- switch(input$survdist,
                      exp = hexp, wei = hweibull,
                      lnorm = hlnorm, gamma = hgamma,
                      gompertz = hgompertz, llogis = hllogis,
                      gengamma = hgengamma) 
      Hdist <- switch(input$survdist,
                      exp = Hexp, wei = Hweibull,
                      lnorm = Hlnorm, gamma = Hgamma,
                      gompertz = Hgompertz, llogis = Hllogis,
                      gengamma = Hgengamma) 
      if (input$survdist == "exp"){
          req(input$rate)
      } else if (input$survdist == "wei"){
          req(input$shape) 
          req(input$scale)
      } else if (input$survdist == "lnorm"){
          req(input$logmean) 
          req(input$logsd)
      } else if (input$survdist == "gamma"){
          req(input$gamma.shape)
          req(input$gamma.rate)
      } else if (input$survdist == "gompertz"){
          req(input$gompertz.shape)
          req(input$gompertz.rate)
      } else if (input$survdist == "llogis"){
          req(input$llogis.shape)
          req(input$llogis.scale)
      } else if (input$survdist == "gengamma"){
          req(input$gengamma.mu)
          req(input$gengamma.sigma)
          req(input$gengamma.Q)
      }
      pars <- switch(input$survdist,
                     exp = input$rate,
                     wei = c(input$shape, input$scale),
                     lnorm = c(input$logmean, input$logsd),
                     gamma = c(input$gamma.shape, input$gamma.rate),
                     gompertz = c(input$gompertz.shape, input$gompertz.rate),
                     llogis = c(input$llogis.shape, input$llogis.scale),
                     gengamma = c(input$gengamma.mu, input$gengamma.sigma, 
                                  input$gengamma.Q))
      arglist <- c(list(t), as.list(pars))
      surv <- data.table(t = t, surv = do.call(sdist,  arglist))
      den <- data.table(t = t, den = do.call(ddist, arglist))
      haz <- data.table(t = t, haz = do.call(hdist, arglist))
      Haz <- data.table(t = t, Haz = do.call(Hdist, arglist))
      return(list(surv = surv, den = den, haz = haz, Haz = Haz))
  })
  
  output$surv <- renderPlotly({
    surv <- dat()$surv
    surv <- surv[t >= input$t[1] & t <= input$t[2], ]
    x.axis <- list(title = "Time")
    y.axis <- list(title = "Survival probability")
    p <- plot_ly(data = surv, x = ~t, y = ~surv) %>%
      add_lines()  %>%
      config(displayModeBar = FALSE) %>%
      layout(xaxis = x.axis, yaxis = y.axis)
  })
  
  output$den <- renderPlotly({
    den <- dat()$den
    den <- den[t >= input$t[1] & t <= input$t[2], ]
    x.axis <- list(title = "Time")
    y.axis <- list(title = "Density")
    p <- plot_ly(data = den, x = ~t, y = ~den) %>%
      add_lines()  %>%
      config(displayModeBar = FALSE) %>%
      layout(xaxis = x.axis, yaxis = y.axis)
  })
  
  output$haz <- renderPlotly({
    haz <- dat()$haz
    haz <- haz[t >= input$t[1] & t <= input$t[2], ]
    haz$haz <- round(haz$haz, 6)
    x.axis <- list(title = "Time")
    y.axis <- list(title = "Hazard rate")
    p <- plot_ly(data = haz, x = ~t, y = ~haz) %>%
      add_lines()  %>%
      config(displayModeBar = FALSE) %>%
      layout(xaxis = x.axis, yaxis = y.axis)
  })
  
  output$Haz <- renderPlotly({
    Haz <- dat()$Haz
    Haz <- Haz[t >= input$t[1] & t <= input$t[2], ]
    x.axis <- list(title = "Time")
    y.axis <- list(title = "Cumulative hazard")
    p <- plot_ly(data = Haz, x = ~t, y = ~Haz) %>%
      add_lines()  %>%
      config(displayModeBar = FALSE) %>%
      layout(xaxis = x.axis, yaxis = y.axis)
  })
  
}

