# LCA-Viz
These files include the code for generating radar plots of posterior probabilities from LCA results, as described in my [*Socius* paper](https://journals.sagepub.com/doi/10.1177/2378023119873498) with Adam Lippert.

What is included here is as follows:

## [Full Manuscript](https://jimiadams.github.io/LCA-Viz/)
This file is our penultimate version of the manuscript that was published in *Socius*. It alters the main inline visualization slightly from the published version. In the published version we use the [fmsb](https://cran.r-project.org/web/packages/fmsb/index.html) package for generating the radar plots. While those are easy to implement, they are optimized for print-based presentation. Here we also generate a more "interactive" version for online presentation using the [plotly](https://cran.r-project.org/web/packages/plotly/index.html) package.

## LCA-Viz_fmsb.R
This file is code for generating the published version of the visualization. It relies on the radar plots available in the [fmsb](https://cran.r-project.org/web/packages/fmsb/index.html) package.
	
## LCA-Viz_plotly.R
This file is code for generating the version of the visualization presented in the manuscript linked above. It relies on the radar plots available in the [plotly](https://cran.r-project.org/web/packages/plotly/index.html) package.

## data\Lippert_Damaske.csv 
This file includes the LCA results from Table 2 of Lippert & Damaske's [paper](https://academic.oup.com/sf/advance-article/doi/10.1093/sf/soy117/5253226) in *Social Forces*, which provides the substantive example we use in the paper.

## NOTE: 
If you like the idea, but wading into R code is beyond your comfort level, [here's the online version of plotly](https://plot.ly/create/?fid=RPlotBot:5272#/) one of the packages we use. It may be adaptible for your pruposes until/if we get around to developing a shiny app version of our approach.
