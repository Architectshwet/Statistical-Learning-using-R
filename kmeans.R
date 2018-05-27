
#This article consists the tutorial on how to cluster data in R. Clustering is a unsupervised learning 
#technique in which the dataset has no target variable $Y$. Clustering mainly aims at finding similarities
#between the features $X_i$ using a similarity metric and grouping them together into clusters/groups.

#K-Means clustering is a clustering algorithm which aims at clustering continious(numeric) data 
#into $K$ clusters which are needed to be specified before feeding data to the model.
#Scaling of features matter in k-means algorithm as it computes the euclidean distance between 
#the cluster centroid and the data points in each iteration, hence we need to standardize the 
#variables if they are skewed or unscaled.

#We solve for a objective in k-means i.e we want to minimize the within cluster variance, 
#which simply implies that the points within a cluster should be as close as possible to the cluster 
#centroid(mean for that cluster).

#The centroid value for a cluster is equal to the mean of the observations in that cluster.

#This simply means that we want to partition the observations into K-clusters such that the 
#total within-cluster variation ,summed over all K-clusters is as small as possible i.e 
#they are as close to each other as possible.

#The K-means algorithm

#1. Randomly assign a number 1 to K,to each of the observations. These serves as initial cluster assignments.
#2. Iterate until the cluster assignments stop changing :
     #2.a For each of the k-clusters compute the cluster __centroid__. 
          #The Kth cluster centroid is the mean for the observations in the Kth cluster.
     #2.b Assign each observation to the cluster whose __centroid__ is closest to it by calculating 
          #the distance between them.(where closest is defined by the distance metric-Euclidean distance).
#3. Stop:if cluster assignments stop changing , else go to : step 2).

#Implementing K-means in R

#setting seed
set.seed(101)
x=matrix(rnorm(100^2),100,2) # a 100 x 2 dim matrix
xmean = matrix(rnorm(8,sd=4),4,2) # a 4 x 2 dim matrix, as we want 4 clusters

which=sample(1:4,100,replace=T) #random sample 
x=x+xmean[which,]
x

#plotting the data
plot(x,col=which,pch=19)

#Now the plot above shows 4 clusters. We know the clusters but now let's feed the data to k-means 
#and check out its performance and how it clusters the data.

km.out<-kmeans(x,4,nstart=15)
km.out

#Let's plot the clusters made by K-means algorithm.

plot(x,col=km.out$cluster,cex=2,pch=1,lwd=2)
points(x,col=which,pch=19)
points(x,col=c(4,3,2,1)[which],pch=19)

#Now the inner circles represent the actual cluster assignments , whereas the 
#outer circles represent the cluster assignments by K-means algorithm. 
#So we can easily notice the mismatches.


#Conclusion.....

#K-means clustering is a nice method to cluster numeric data. 
#The only drawback is we need some domain knowledge to tell the 
#algorithm about the number to clusters we want a-priori. 
#Secondly, K-means is suited only for data which is normally distributed or either standardized. 
#So scaling of variables actually matter a lot in K-means clustering.






















