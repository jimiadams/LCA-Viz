# LCA-Viz
These files include the code for generating radar plots of posterior probabilities from LCA results, as described in my *Socius* paper with Adam Lippert.

What is included here is as follows:

## [Full Manuscript](https://jimiadams.github.io/LCA-Viz/)
This file is our penultimate version of the manuscript that was published in *Socius*. It alters the main inline visualization slightly from the published version. In the published version we use the [fmsb](https://cran.r-project.org/web/packages/fmsb/index.html) package for generating the radar plots. While those are easy to implement, they are optimized for print-based presentation. Here we also generate a more "interactive" version for online presentation using the [plotly](https://cran.r-project.org/web/packages/plotly/index.html) package.

## LCA-Viz_fmsb.R
This file is code for generating the published version of the visualization. It relies on the radar plots available in the [fmsb](https://cran.r-project.org/web/packages/fmsb/index.html) package.
	
## LCA-Viz_plotly.R
This file is code for generating the version of the visualization presented in the manuscript linked above. It relies on the radar plots available in the [plotly](https://cran.r-project.org/web/packages/plotly/index.html) package.

## data\Lippert_Damaske.csv 
This file includes the LCA results from Table 2 of Lippert & Damaske's [paper](https://academic.oup.com/sf/advance-article/doi/10.1093/sf/soy117/5253226) in *Social Forces*, which provides the substantive example we use in the paper.

NOTE: I'd *really* like to build a Shiny app that'll do these (so people who want to use the idea could just load up their data then check some option boxes, e.g., for color, reverse coding, normalization, etc. and have usable plots), but unfortunately I haven't yet found the time to learn how to do that. Maybe it'll happen someday (or by someone else).
