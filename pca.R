#Unsupervised learning is a machine learning technique in which the dataset has no target variable 
#or no response value Y.The data is unlabelled. Simply saying,there is no target value to supervise
#the learning process of a learner unlike in Supervised learning where we had training examples which had
#both input variables X and target variable Y and by looking and learning from the 
#training examples the learner used to generate a mapping function(also called a hypothesis)
#$f : x -> y which mapped x values to $y$ and learned the relationship between input variables 
#and target variable so that we could generalize it to some random unseen test examples and predict the 
#target value.

#The best example of unsupervised learning is when a small child given some unlabelled pictures of cats 
#and dogs , so by only looking at the structural similarities and disimilarities between the images, 
#he classifies one as a dog and other as cat.

#There are lots of examples of unsupervised learning around us.

#Unsupervised learning is mostly used as a preprocessing tool for supervised learning.
#e.g-like PCA could be used to select a linear combination of predictors- X which explains
#the most variability in the data , and reduce a high-dimentional dataset to a lower dimentional 
#view with only most relevant and important features which can be used as inputs 
#in a supervised learning model.

#e.g If we have a dataset with 100 predictors and we wanted to generate a model,it would be highly 
#inefficient to use all those 100 predictors because that would increase the variance and complexity 
#of the model and which in turn would lead to overfitting.Instead what PCA does is 
#find 10 most correlated variables and linearly combine them to generate a principal component - Z.


##Principal Components Analysis

#PCA introduces a lower-dimentional representation of the dataset.It finds a sequence of linear combination 
#of the variables called the principal components-$Z_1,Z_2...Z_m$ that explain the maximum variance 
#in the data and are mutually uncorrelated.

#What we try to do is find most relevant set of variables and simply linearly combine the set of variables 
#into a single variable-$Z_m$.

#1) The first principal component $PC_1$ has the highest variance across data.

#2)The second principal component $PC_2$ is uncorrelated with $PCA_1$ which also has high variance.

#We have tons of correlated variables in a high dimentional dataset and what PCA tries to do is pair 
#and combine them to a set of some important variables that summarize all information in the data.

#PCA will give us new set of variables called principal components which could be further be used as 
#inputs in a supervised learning model. So now we have lesser and most important set of variables 
#paired together to form a new single variable which explains most variance in data. 
#This technique is often termed as Dimentionality Reduction which is famous technique to do 
#feature selection and use only relevant features in the Model.

?USArrests
#dataset which contains Violent Crime Rates by US State
dim(USArrests)
dimnames(USArrests)
head(USArrests)
#finding mean of all 
apply(USArrests,2,mean)
apply(USArrests,2,var) 

#There is a lot of difference in variances of each variables. In PCA mean does not playes a role
#,but variance plays a major role in defining PC so very large differences in variance value of a
#variable will definately dominate the PC. We need to standardize the variable so as to get mean 
#0 and variance as 1

#The function prcomp() will do the needful of standardizing the variables.

pca.out<-prcomp(USArrests,scale=TRUE)
pca.out
#summary of the PCA
summary(pca.out)
names(pca.out)

#Now as we can see maximum % of variance is explained by PC1, and all PCs are mutually 
#uncorrelated. Around 62 % of variance is explained by PC1.

#Let's build a biplot to understand better.

biplot(pca.out,scale = 0, cex=0.65)

#Now in the above plot red colored arrows represent the variables and each direction 
#represent the direction which explains the most variation. eg for all the countries in the 
#direction of 'UrbanPop' are countries with most urban-population and opposite to tht direction 
#are the countries with least . So this is how we interpret our Biplot.

##Conclusion

#PCA is a great preprocessing tool for picking out the most relevant linear combination 
#of variables and use them in our predictive model.It helps us find out the variables 
#which explain the most variation in the data and only use them.PCA plays a major role
#in the data analysis process before going for advanced analytics.PCA only looks the 
#input variables and them pair them.

#The only drawback PCA has is that it generates the principal components in a 
#unsupervised manner i.e without looking the target values ,hence the principal components
#which explain the most variation in dataset without target-$Y$ variable,may or may not 
#explain good percentage of variance in the response variable$Y$ which could affect the 
#perfomance of the predictive model.






