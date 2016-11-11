# SELECT PARAMETERS ------------------------------------------------------------
pars.exp <- conditionalPanel(
  condition = "input.survdist == 'exp'",
  numericInput("rate", label = "Rate", value = 1, step = .1)
)

pars.wei <- conditionalPanel(
  condition = "input.survdist == 'wei'",
  numericInput("shape", label = "Shape", value = 1, step = .1),
  numericInput("scale", label = "Scale", value = 1, step = .1)
)

pars.gamma <- conditionalPanel(
  condition = "input.survdist == 'gamma'",
  numericInput("gamma.shape", label = "Shape", value = 2, step = .1),
  numericInput("gamma.rate", label = "Rate", value = 1, step = .1)
)

pars.lnorm <- conditionalPanel(
  condition = "input.survdist == 'lnorm'",
  numericInput("logmean", label = "Mean (log scale)", value = 2, step = .1),
  numericInput("logsd", label = "Standard deviation (log scale)", value = 1, step = .1)
)

pars.gompertz <- conditionalPanel(
  condition = "input.survdist == 'gompertz'",
  numericInput("gompertz.shape", label = "Shape", value = .1, step = .1),
  numericInput("gompertz.rate", label = "Rate", value = 1, step = .1)
)

pars.llogis <- conditionalPanel(
  condition = "input.survdist == 'llogis'",
  numericInput("llogis.shape", label = "Shape", value = 2, step = .1),
  numericInput("llogis.scale", label = "Scale", value = 1, step = .1)
)

pars.gengamma <- conditionalPanel(
  condition = "input.survdist == 'gengamma'",
  numericInput("gengamma.mu", label = "Location", value = 0, step = .1),
  numericInput("gengamma.sigma", label = "Scale", value = 1, step = .1),
  numericInput("gengamma.Q", label = "Shape", value = 1, step = .1)
)

# SURVIVAL CURVES --------------------------------------------------------------
select.survdist <- selectInput("survdist", label = "Survival Distribution", 
                              choices = c("Exponential" = "exp",
                                          "Weibull"  = "wei",
                                          "Lognormal" = "lnorm",
                                          "Gamma" = "gamma",
                                          "Gompertz" = "gompertz",
                                          "Log-logistic" = "llogis",
                                          "Generalized gamma" = "gengamma"), 
                              selected = 1) 
slider.time <- sliderInput("t", label = "Survival time",
                           value = c(0, 30), min = 0, max = 100)

sidebar <- column(4, br(),
                      wellPanel(select.survdist, slider.time,
                                pars.exp, pars.wei, pars.lnorm, pars.gamma,
                                pars.gompertz, pars.llogis, pars.gengamma))

main1 <-  column(4, plotlyOutput("surv", height = "280"), 
                 br(), plotlyOutput("haz", height = "280"))
main2 <- column(4, plotlyOutput("den", height = "280"),
                br(), plotlyOutput("Haz", height = "280"))

layout <- fluidRow(sidebar, main1, main2)

tab.surv <- tabPanel("Survival Curves", layout)

# ABOUT ------------------------------------------------------------------------
withMathJax(helpText("Some math here $$\\alpha+\\beta$$"))
tab.about <- tabPanel("About", fluidRow(column(12, includeMarkdown("about.md"))))

# NAV BAR ----------------------------------------------------------------------
fluidPage(withMathJax(),tabsetPanel(tab.surv, tab.about))