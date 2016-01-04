
# hdnom-appmaker

The hdnom appmaker is a template Shiny app for hdnom and hdnom.io users to make
their own nomogram-based online prediction apps.

## Try it out

Install the required packages:

```r
install.packages("hdnom")
install.packages("shiny")
```

Run the template app locally:

```r
shiny::runGitHub("road2stat/hdnom-appmaker")
```

## Make your own nomogram app

1. Open `server.R` and follow the instructions to put your model and data
   in the right place.
2. Know [how to deploy](http://shiny.rstudio.com/deploy/) your application
   to shinyapps.io or your local server.
3. Enjoy!
