
# initialize a storage variable for Twitter tweets
mydata.vectors <- character(0)


# read a file line by line
conn <- file("master3
", "r")
while(length(line <- readLines(conn, 1)) > 0) {
    mydata.vectors <- c(line, mydata.vectors)	
}
close(conn)

# how many company tags
length(mydata.vectors)

#install.packages('tm')
#require(tm)
 
# build a corpus
mydata.corpus <- Corpus(VectorSource(mydata.vectors))
 
# make each letter lowercase
mydata.corpus <- tm_map(mydata.corpus, tolower)
 
# remove punctuation
mydata.corpus <- tm_map(mydata.corpus, removePunctuation)
 
# remove generic and custom stopwords
my_stopwords <- c(stopwords('english'))
mydata.corpus <- tm_map(mydata.corpus, removeWords, my_stopwords)
 
# build a term-document matrix
mydata.dtm <- TermDocumentMatrix(mydata.corpus)
 
# inspect the document-term matrix
mydata.dtm
 
# inspect most popular words
findFreqTerms(mydata.dtm, lowfreq=30)

# remove sparse terms to simplify the cluster plot
# Note: tweak the sparse parameter to determine the number of words.
# About 10-30 words is good.
mydata.dtm2 <- removeSparseTerms(mydata.dtm, sparse=0.95)
 
# convert the sparse term-document matrix to a standard data frame
mydata.df <- as.data.frame(inspect(mydata.dtm2))
 
# inspect dimensions of the data frame
nrow(mydata.df)
ncol(mydata.df)

mydata.df.scale <- scale(mydata.df)
d <- dist(mydata.df.scale, method = "euclidean") # distance matrix
fit <- hclust(d, method="ward")
plot(fit) # display dendogram?
 
groups <- cutree(fit, k=5) # cut tree into 5 clusters
# draw dendogram with red borders around the 5 clusters
rect.hclust(fit, k=5, border="red")
