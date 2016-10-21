# SELECT PARAMETERS ------------------------------------------------------------
pars.exp <- conditionalPanel(
  condition = "input.survdist.indexOf('exp') != -1",
  numericInput("exp.pars", label = "Exponential rate", value = 1)
)

pars.wei <- conditionalPanel(
  condition = "input.survdist.indexOf('wei') != -1",
  numericInput("wei.shape", label = "Weibull shape", value = 1),
  numericInput("wei.scale", label = "Weiubll scale", value = 1)
)

# SURVIVAL CURVES --------------------------------------------------------------
select.survdist <- selectInput("survdist", label = "Survival Distribution", 
                              choices = c("Exponential" = "exp",
                                          "Weibull"  = "wei"), 
                              selected = 1) 


sidebar <- column(4, br(),
                      wellPanel(select.survdist, pars.exp, pars.wei))

#main <-  column(8, br())

layout <- fluidRow(sidebar)

tab.surv <- tabPanel("Survival Curves", layout)

# ABOUT ------------------------------------------------------------------------
tab.about <- tabPanel("About", fluidRow(column(12, includeMarkdown("about.md"))))

# NAV BAR ----------------------------------------------------------------------
fluidPage(tabsetPanel(tab.surv, tab.about))