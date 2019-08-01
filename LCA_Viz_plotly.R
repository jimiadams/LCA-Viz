#######################################################
# This file produces the plotly version of our LCA radar plot visualization.
# author: jimi adams
# last updated: 2019-08-01
#######################################################

####### Data Prep #####################################
### Reading in the data & separating the rhos from the gammas.
ld <- read.csv("data/Lippert_Damaske.csv", header=T)

# This assumes the gamma is the last row on the file (comment out if not).
gamma <- ld[nrow(ld),] 
ld <- ld[-nrow(ld),]

### Creating an empty matrix with unique variables (since values are on separate lines)
#   (pd - "plotting data")
pd <- matrix(data=NA, nrow=length(unique(ld$Variable)), ncol=length(names(ld))-2, dimnames = list(as.character(unique(ld$Variable)), names(ld)[3:length(names(ld))]))
# NOTE - the rows are not in the same order as in ld
#######################################################

####### Data Presentation Modifications ###############
### Reverse coding the categories that need it
temp <- ld
# Count of Children in Respondent's care
cats4 <- which(temp$Variable==levels(ld$Variable)[4]) 
ld[cats4,] <- temp[rev(cats4),]
rm(temp, cats4) #getting rid of temp objects

### Normalizing the Varible values to range from 0-1 (on top of consistent coding from above)
for (i in 1:nrow(pd)){
  temp <- as.matrix(ld[which(ld$Variable==unique(ld$Variable)[i]),3:ncol(ld)])
  nlev <- length(which(ld$Variable==unique(ld$Variable)[i]))
  base <- nlev-1
  pd[which(rownames(pd)==unique(ld$Variable)[i]),] <- apply(c(0:base)/base * temp/100, 2, sum)
}
#######################################################

####### Setting up some aesthetic preferences #########
library(RColorBrewer)
addalpha <- function(colors, alpha=1.0) {
  r <- col2rgb(colors, alpha=T)
  # Apply alpha
  r[4,] <- alpha*255
  r <- r/255.0
  return(rgb(r[1,], r[2,], r[3,], r[4,]))
}
cols<- addalpha(brewer.pal(7, "Set2"), 0.33)
#######################################################

####### Generating the Plots ##########################
## Code Chunk for Figure 1
library(plotly)
library(dplyr)

# Specifying a radar plot
p <- plot_ly(
  type = 'scatterpolar',
  fill = 'toself',
  mode = 'lines'
) %>%
# Adding each of the traces (LCA classes)
  add_trace(
    r = c(pd[,1], pd[1,1]),
    theta = c(dimnames(pd)[[1]], dimnames(pd)[[1]][1]),
    name = dimnames(pd)[[2]][1]
  ) %>%
  add_trace(
    r = c(pd[,2], pd[1,2]),
    theta = c(dimnames(pd)[[1]], dimnames(pd)[[1]][1]),
    name = dimnames(pd)[[2]][2]
  ) %>%
  add_trace(
    r = c(pd[,3], pd[1,3]),
    theta = c(dimnames(pd)[[1]], dimnames(pd)[[1]][1]),
    name = dimnames(pd)[[2]][3]
  ) %>%
  add_trace(
    r = c(pd[,4], pd[1,4]),
    theta = c(dimnames(pd)[[1]], dimnames(pd)[[1]][1]),
    name = dimnames(pd)[[2]][4]
  ) %>%
  add_trace(
    r = c(pd[,5], pd[1,5]),
    theta = c(dimnames(pd)[[1]], dimnames(pd)[[1]][1]),
    name = dimnames(pd)[[2]][5]
  ) %>%
  add_trace(
    r = c(pd[,6], pd[1,6]),
    theta = c(dimnames(pd)[[1]], dimnames(pd)[[1]][1]),
    name = dimnames(pd)[[2]][6]
  ) %>%
  add_trace(
    r = c(pd[,7], pd[1,7]),
    theta = c(dimnames(pd)[[1]], dimnames(pd)[[1]][1]),
    name = dimnames(pd)[[2]][7]
  ) %>%
  layout(
    polar = list(
      radialaxis = list(
        visible = T,
        range = c(0,1)
      )
    )
  )
print(p)

## Code Chunk for Figure 2
gamma <- t(as.matrix(gamma[3:9]/100))
G <- apply(gamma, 2L, cumsum) - gamma / 2
sbp <- barplot(gamma,
               beside = F,
               legend=F,
                # Specifying the plotly colors used above
               col=as.vector(c("#FF7F0E", "#2CA02C", "#D62728", "#9467BD", "#8C564B", "#E377C2", "#7F7F7F")),
               ylab="gamma",
               names.arg=NA,
               horiz=T, xlim=c(0,1), ylim=c(0,.5), width=.5)
# Adding the bin-labels.
text(G, sbp, labels = paste0(100 * gamma, "%"))
#######################################################
