library('shiny')
library('hdnom')

# To make your own nomogram app, please do the three following things:

# 1. Put the downloaded `hdnom-model.Rdata` under the `mode/` folder
load('model/hdnom-model.Rdata')

# 2. Choose the delimiter type of your data from 'comma', 'tab', and 'semi':
sep_type = 'comma'

# then put the data used to build the model under the `data/` folder:
# If you chose 'comma', then x.csv and y.csv (comma-separated)
# If you chose 'tab',   then x.tsv and y.tsv (tab-separated)
# If you chose 'semi',  then x.txt and y.txt (semicolon-separated)

# 3. Edit the app title in `ui.R` and edit `about.md`.

# That's it. Enjoy!

switch (sep_type,
        comma = {
          x = read.table('data/x.csv', header = TRUE, sep = ',', as.is = TRUE)
          y = read.table('data/y.csv', header = TRUE, sep = ',', as.is = TRUE)
        },
        tab = {
          x = read.table('data/x.tsv', header = TRUE, sep = '\t', as.is = TRUE)
          y = read.table('data/y.tsv', header = TRUE, sep = '\t', as.is = TRUE)
        },
        semi = {
          x = read.table('data/x.txt', header = TRUE, sep = ';', as.is = TRUE)
          y = read.table('data/y.txt', header = TRUE, sep = ';', as.is = TRUE)
        }
)

x = as.matrix(x)

shinyServer(function(input, output, session) {

  output$prediction_controls = renderUI({

    varinfo = hdnom.varinfo(hdnom_model, x)

    var_ui_gen = function(varinfo) {

      nvar = length(varinfo[['name']])
      ui_list = vector('list', nvar)

      for (i in 1L:nvar) {

        if (varinfo[['type']][i] == 'logical') {
          choices_list = list('name1' = as.character(varinfo[['domain']][[i]][1L]),
                              'name2' = as.character(varinfo[['domain']][[i]][2L]))
          choices_list = setNames(choices_list,
                                  c(as.character(varinfo[['domain']][[i]][1L]),
                                    as.character(varinfo[['domain']][[i]][2L])))
          ui_list[[i]] = selectInput(paste0('pred_var_', varinfo[['name']][i]),
                                     label = paste0(varinfo[['name']][i], ' (',
                                                    as.character(varinfo[['domain']][[i]][1L]),
                                                    ', ', as.character(varinfo[['domain']][[i]][2L]), ')'),
                                     choices = choices_list)
        }

        if (varinfo[['type']][i] == 'categorical') {
          ui_list[[i]] = numericInput(paste0('pred_var_', varinfo[['name']][i]),
                                      label = paste0(varinfo[['name']][i], ' (',
                                                     as.character(varinfo[['domain']][[i]][1L]),
                                                     ' ~ ', as.character(varinfo[['domain']][[i]][2L]), ')'),
                                      min = varinfo[['domain']][[i]][1L],
                                      max = varinfo[['domain']][[i]][2L],
                                      value = varinfo[['domain']][[i]][1L])
        }

        if (varinfo[['type']][i] == 'continuous') {
          ui_list[[i]] = numericInput(paste0('pred_var_', varinfo[['name']][i]),
                                      label = paste0(varinfo[['name']][i], ' (',
                                                     as.character(varinfo[['domain']][[i]][1L]),
                                                     ' ~ ', as.character(varinfo[['domain']][[i]][2L]), ')'),
                                      min = varinfo[['domain']][[i]][1L],
                                      max = varinfo[['domain']][[i]][2L],
                                      value = varinfo[['domain']][[i]][1L])
        }

      }

      ui_list

    }

    var_ui_list = var_ui_gen(varinfo)
    var_ui_list

  })

  calc_pred = eventReactive(input$calc_pred_button, {

    varinfo = hdnom.varinfo(hdnom_model, x)

    newx = matrix(0, nrow = 1L, ncol = ncol(x))
    colnames(newx) = colnames(x)
    for (i in varinfo[['name']]) newx[1L, i] = as.numeric(input[[paste0('pred_var_', i)]])

    pred_prob = format(predict(hdnom_model, x, y, newx, input$pred_at)[1L, 1L], digits = 4L)
    names(pred_prob) = NULL

    pred_prob

  })

  output$print_pred = renderText({
    pred = calc_pred()
    pred
  })

})
