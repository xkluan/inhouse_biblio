library(bibliometrix)
setwd("~/Documents/GitLab/inhouse_biblio/anesthea")

#data <- read.delim("./pubmed-Artificial-set2.txt", check.names = TRUE, stringsAsFactors = FALSE)
# set2 is manually checked, remove the 2024 articles.
# file<-"./pubmed-Artificial-set2.txt"
# M <- convert2df(file, dbsource = "pubmed", format = "pubmed")

# wos some infors are lost
#file <- "./wos/savedrecs1-1000.ciw"
# 将读取的数据转换为bibliometrix可以处理的数据框架
#M <- convert2df(file, dbsource = "wos", format = "endnote")

# scopus
file <- "./scopus/ffffff.csv"
# M <- convert2df(file, dbsource = "scopus", format = "bibtex")
M <- convert2df(file, dbsource = "scopus", format = "csv")

# 进行基本的文献计量学分析
# results <- biblioAnalysis(M)

## Main findings about the collection
#options(width=160)
results <- biblioAnalysis(M)
summary(results, k=10, pause=F, width=130)

#
plot(x=results, k=10, pause=F)

# Most Cited References
CR <- citations(M, field = "article", sep = ";")
cbind(CR$Cited[1:20])

# Article (References) co-citation analysis
NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ";")
net=networkPlot(NetMatrix, n = 50, Title = "Co-Citation Network", type = "fruchterman", size.cex=TRUE, size=20, remove.multiple=FALSE, labelsize=1,edgesize = 10, edges.min=5)

#Descriptive analysis of Article co-citation network characteristics

netstat <- networkStat(NetMatrix)
summary(netstat,k=10)


# Journal (Source) co-citation analysis
M2=metaTagExtraction(M,"CR_SO",sep=";")
NetMatrix2 <- biblioNetwork(M2, analysis = "co-citation", network = "sources", sep = ";")
net2=networkPlot(NetMatrix2, n = 50, Title = "Co-Citation Network", type = "auto", size.cex=TRUE, size=15, remove.multiple=FALSE, labelsize=1,edgesize = 10, edges.min=5)

netstat2 <- networkStat(NetMatrix2)
summary(netstat2,k=10)

# Section 3: Historiograph - Direct citation linkages
histResults <- histNetwork(M, sep = ";")

options(width = 130)
net3 <- histPlot(histResults, n=20, size = 5, labelsize = 4)


#Co-word Analysis through Keyword co-occurrences
NetMatrix4 <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")
net4=networkPlot(NetMatrix4, normalize="association", n = 50, Title = "Keyword Co-occurrences", type = "fruchterman", size.cex=TRUE, size=20, remove.multiple=F, edgesize = 10, labelsize=5,label.cex=TRUE,label.n=30,edges.min=2)

netstat4 <- networkStat(NetMatrix4)
summary(netstat4,k=10)

# Co-word Analysis through Correspondence Analysis
suppressWarnings(
  CS <- conceptualStructure(M, method="MCA", field="ID", minDegree=15, clust=5, stemming=FALSE, labelsize=15,documents=20)
)

# Section 5: Thematic Map
Map=thematicMap(M, field = "ID", n = 250, minfreq = 4,
                stemming = FALSE, size = 0.7, n.labels=5, repel = TRUE)
plot(Map$map)

Clusters=Map$words[order(Map$words$Cluster,-Map$words$Occurrences),]
library(dplyr)

CL <- Clusters %>% group_by(.data$Cluster_Label) %>% top_n(5, .data$Occurrences)
CL

# Author collaboration network
NetMatrix5 <- biblioNetwork(M, analysis = "collaboration",  network = "authors", sep = ";")
net5=networkPlot(NetMatrix5,  n = 50, Title = "Author collaboration",type = "auto", size=10,size.cex=T,edgesize = 3,labelsize=1)

netstat5 <- networkStat(NetMatrix5)
summary(netstat5,k=15)

# Edu collaboration network
NetMatrix6 <- biblioNetwork(M, analysis = "collaboration",  network = "universities", sep = ";")
net6=networkPlot(NetMatrix6,  n = 50, Title = "Edu collaboration",type = "auto", size=4,size.cex=F,edgesize = 3,labelsize=1)

netstat6 <- networkStat(NetMatrix6)
summary(netstat6,k=15)

# Country collaboration network
M7 <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix7 <- biblioNetwork(M7, analysis = "collaboration",  network = "countries", sep = ";")
net7=networkPlot(NetMatrix7,  n = dim(NetMatrix7)[1], Title = "Country collaboration",type = "circle", size=10,size.cex=T,edgesize = 1,labelsize=0.6, cluster="none")
net7=networkPlot(NetMatrix7, n = dim(NetMatrix7)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.8)
net7 = networkPlot(NetMatrix7, n = dim(NetMatrix7)[1], Title = "Country Collaboration", type = "circle", size=10, remove.multiple=FALSE, labelsize=1.0)

netstat7 <- networkStat(NetMatrix7)
summary(netstat7,k=15)

# M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
# NetMatrix <- biblioNetwork(M, analysis = "collaboration",  network = "countries", sep = ";")
# net=networkPlot(NetMatrix,  n = dim(NetMatrix)[1], Title = "Country collaboration",type = "circle", size=10,size.cex=T,edgesize = 1,labelsize=0.6, cluster="none")


# keywords
topKW=KeywordGrowth(M, Tag = "ID", sep = ";", top=5, cdf=TRUE)
topKW
install.packages("reshape2")
library(reshape2)
library(ggplot2)
DF=melt(topKW, id='Year')
ggplot(DF,aes(Year,value, group=variable, color=variable))+geom_line()
DF

# top authors' production over time
topAU <- authorProdOverTime(M, k = 10, graph = TRUE)

M8 <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix8 <- biblioNetwork(M8, analysis = "collaboration", network = "countries", sep = ";")

# Plot the network
net8=networkPlot(NetMatrix8, n = dim(NetMatrix8)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.7,cluster="none")



NetMatrix9 <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ";")

# Plot the network
net9=networkPlot(NetMatrix9, n = 30, Title = "Co-Citation Network", type = "fruchterman", size=T, remove.multiple=FALSE, labelsize=0.7,edgesize = 5)


# Create keyword co-occurrences network
NetMatrix10 <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net10=networkPlot(NetMatrix10, normalize="association", weighted=T, n = 30, Title = "Keyword Co-occurrences", type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)


CS <- conceptualStructure(M,field="ID", method="CA", minDegree=4, clust=5, stemming=FALSE, labelsize=10, documents=10)