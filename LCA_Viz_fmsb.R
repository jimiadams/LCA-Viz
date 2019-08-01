#######################################################
# This file produces the fmsb version of our LCA radar plot visualization.
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
data <- rbind(rep(1,nrow(pd)) , rep(0,nrow(pd)) , t(pd))

par(mfrow=c(1,2), mai=c(0.1, 0.1, 0.1, 0.1))
#######################################################

####### Generating the Plots ##########################
## Code Chunk for Figure 1
library(fmsb)

radarchart( as.data.frame(data[1:6,])  , axistype=1 ,
            #custom polygon
            pcol=cols[1:4] , pfcol=cols[1:4] , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,1,5), cglwd=0.8,
            #custom labels
            vlcex=0.6
)
legend(x=.3, y=-0.9, legend = rownames(data[-c(1,2),]), bty = "n", pch=20 , border=brewer.pal(7, "Set2"), col=brewer.pal(7, "Set2"), text.col = "black", cex=.5, pt.cex=.5)

#par(fig=c(.66,1,0,1))
radarchart( as.data.frame(rbind(data[1:2,],data[7:9,]))  , axistype=1 ,
            #custom polygon
            pcol=cols[5:7] , pfcol=cols[5:7] , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,1,5), cglwd=0.8,
            #custom labels
            vlcex=0.6
)
par(mfrow=c(1,1))

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
