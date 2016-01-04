library('shiny')

shinyUI(navbarPage(
  title = 'Nomogram Title',
  windowTitle = 'Nomogram Title',
  theme = 'flatly.css',

  tabPanel(title = 'Home',

           fluidRow(

             column(width = 4, offset = 1,
                    sidebarPanel(width = 12,
                                 h4('Please answer the following questions:'),
                                 uiOutput('prediction_controls')
                    )
             ),

             column(width = 3,
                    sidebarPanel(width = 12,
                                 numericInput('pred_at',
                                              label = 'Prediction time point:',
                                              min = 0, value = 365),
                                 actionButton(inputId = 'calc_pred_button',
                                              label = 'Predict Survival Probability',
                                              icon = icon('wrench'), class = 'btn-primary')
                    )
             ),

             column(width = 3,
                    mainPanel(width = 12,
                              tabsetPanel(
                                tabPanel('Predicted Overall Survival Probability',
                                         h2(textOutput('print_pred')))
                              )))

           )

  ),

  tabPanel(title = 'About',

           fluidRow(
             column(width = 10, offset = 1,
                    includeMarkdown('about.md')
             )))

))
