# Application Maker for hdnom  <a href="http://hdnom.org"><img src="http://nanx.me/images/project-hdnom.png" align="right" alt="logo" height="180" width="180" /></a>

The hdnom appmaker is a template Shiny app for hdnom and hdnom.io users to make
their own nomogram-based online prediction apps.

## Try it out

Start R, install the required packages:

```r
install.packages("hdnom")
install.packages("shiny")
```

Run the template app:

```r
shiny::runGitHub("road2stat/hdnom-appmaker")
```

If error happens when using `shiny::runGitHub`, please try to clone the
Shiny app to local machine manually:

```bash
git clone https://github.com/road2stat/hdnom-appmaker.git
```

then start R, use

```r
shiny::runApp("hdnom-appmaker")
```

to run the template app.

## Make your own nomogram app

1. Open `server.R` and follow the three steps to put your model and data
   in the right place.
2. Know [how to deploy](https://shiny.rstudio.com/deploy/) your application
   to shinyapps.io or your local Shiny server.
3. Enjoy!
