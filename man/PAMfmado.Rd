\name{PAMfmado}
\alias{PAMfmado}

\title{Clustering of maxima}

\description{Clustering of times series of maxima based on the pam package tailored for the F-madogram distance}

\usage{
PAMfmado(x, K, J = 0, threshold = 0.99, max.min = 0)
}

\arguments{
  \item{x}{x a matrix of maxima. For example, number of stations = ncol(x) and time series length = nrow(x) for weekly maxima of precipitation.}
  \item{K}{number of clusters}
  \item{J}{number of resampling for which the stations are randomly moved to break the dependence. By default, \code{J=0} means no resampling.}
  \item{threshold}{Threshold corresponding to the quantile level for the resampling. The resulting quantile is stored via \code{sil.final <- quantile(sil.vec[sil.vec>0],probs=threshold)}.}
  \item{max.min}{A threshold to remove very small values. For example, some raingauges cannot go below 2 mm. By default, \code{max.min=0}.}
}

\details{
%%  ~~ If necessary, more details than the description above ~~
}

\value{
an object of class \code{"pam"} representing the clustering. See \code{?pam.object} for details.
}

\references{
Bernard E., Naveau P., Vrac M. and Mestre O. (2013).
Clustering of maxima: Spatial dependencies among heavy rainfall in France. 
\emph{Journal of Climate 26}, 7929--7937. 

Naveau, P., A. Guillou, D. Cooley, and J. Diebolt (2009).
Modeling pairwise dependence of maxima in space. 
\emph{Biometrika 96}(1).

Cooley, D., P. Naveau, and P. Poncet (2006).
Variograms for spatial max-stable random fields. 
In: Bertail, P., Soulier, P., Doukhan, P. (eds) \emph{Dependence in Probability and Statistics. Lecture Notes in Statistics}, vol 187. Springer, New York, NY .

Reynolds, A., Richards, G., de la Iglesia, B. and Rayward-Smith, V. (1992). 
Clustering rules: A comparison of partitioning and hierarchical clustering algorithms. 
\emph{Journal of Mathematical Modelling and Algorithms 5}, 475-504.
}

\author{
Philippe Naveau}

\seealso{
See the function  as \code{\link{pam}} in the package \code{cluster}
}

\examples{
# 
# Example for PAM 
#
library(cluster)
K= 5 # Number of clusters
#
# loading the data
#
data(PrecipFrance)
hourlymaxSeason <- PrecipFrance$precip
longitudes <- PrecipFrance$longitudes
latitudes <- PrecipFrance$latitudes

#
# clustering maxima
#
PAMmado <- PAMfmado(hourlymaxSeason,K)
medoids <- as.vector(PAMmado$medoid)
silmado <- silhouette(PAMmado) # computing the silhouette coeff
silmado.final <- silmado[silmado[,"sil_width"]>0.0,] # removing all stations with non-significatif silhouette coeff

#
# plotting the clusters over the French map
#
library(maps)
library(mapdata)
#
# preparing the maps of France  
#
old.par <- par(no.readonly = TRUE) 
colorK <- rainbow(K)
neighbors <- c("France", "Spain", "Germany", "Belgium", "Italy", "Switzerland", "Luxembourg", "Netherland", "Monaco", "Andorra")
latFrance <-c(41.5, 51); longFrance <- c(-5.0, 9.5)
bgOcean <- "gray90" #lightskyblue"
bgFrance <- "grey95"
map("worldHires", neighbors, col="white", fill=T, bg=bgOcean, xlim=longFrance, ylim=latFrance)
map("worldHires", "France", col=bgFrance, fill=T, add=T)
map.axes(); title(paste(" PAM with K=", K), xlab="Longitudes", ylab="Latitudes");grid()
points(longitudes, latitudes, col="black")

for(i in 1:K){
    selection <- as.integer(rownames(silmado[(silmado[,"cluster"]==i),]))
    selection.final <- as.integer(rownames(silmado.final[(silmado.final[,"cluster"]==i),]))
    strength <- silmado[(silmado[,"cluster"]==i),"sil_width"]
    
    for(j in 1:length(selection.final)){
      x.coord <- c(longitudes[medoids[i]],longitudes[selection.final[j]])
      y.coord <- c(latitudes[medoids[i]],latitudes[selection.final[j]])
      lines(x.coord,y.coord, col="grey")
    }
    
    points(longitudes[selection],latitudes[selection], pch= 23, col=0, bg=colorK[i],cex=1)
    points(longitudes[selection.final],latitudes[selection.final], pch= 23, col=0, bg=colorK[i],cex=1.5) #,cex=exp(strength))
  }
  points(longitudes[medoids],latitudes[medoids], pch= 5,cex=2)
par(old.par) 
}

