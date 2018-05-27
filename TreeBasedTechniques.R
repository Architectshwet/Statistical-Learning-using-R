#Desicion Trees in R ====================
#Requiring Packages

#Trees involve stratifying or sagmenting the Predictor($X_i$) space into a number of 
#simple Regions.The tree based Methods generate a set of $Splitting \ Rules$ which are
#used to sagment the Predictor Space.These techniques of sagmenting and stratifying data 
#into different Regions $R_j$ are called Decision Trees.Decision Trees are used in both 
#Regression and Classification Problems. These are Statistical Learning Techniques which 
#are easier to understand and Simpler in terms of interpretablity.

require(ISLR) #package containing data
require(ggplot2)
require(tree)

#Using the Carseats data set 

attach(Carseats)
?Carseats

head(Carseats)
#Checking the distribution of Sales

ggplot(aes(x = Sales),data = Carseats) + 
  geom_histogram(color="black",fill = 'purple',alpha = 0.6, bins=30) + 
  labs(x = "Unit Sales in Thousands", y = "Frequency")

#Making a Factor variable from Sales

HighSales<-ifelse(Sales <= 8,"No","Yes")
head(HighSales)

#Making a Data frame
Carseats<-data.frame(Carseats,HighSales)

#We will use the tree() function to fit a Desicion Tree
?tree

#Now we are going to fit a Tree to the Carseats Data to predict if we are going
#to have High Sales or not.The tree() function uses a Top-down Greedy approch to
#fit a Tree which is also known as Recursive Binary Splitting.It is Greedy because
#it dosen't finds the best split amongst all possible splits,but only the best splits 
#at the immediate place its looking i.e the best Split at that particular step.


#Excluding the Sales atrribute
CarTree<-tree(HighSales ~ . -Sales , data = Carseats,split = c("deviance","gini"))
#split argument split	to specify the splitting criterion to use.

CarTree #Outputs a Tree with various Splits at different Variables and Response at Terminals Nodes
#The numeric values within the braces are the Proportions of Yes and No for each split.

#Summary of the Decision Tree
summary(CarTree)

plot(CarTree)
#Adding Predictors as text to plot
text(CarTree ,pretty = 1 )

#This tree is quiet Complicated and hard to understand due to lots of Splits and 
#lots of variables included in the predictor space.The leaf nodes consists of the 
#Response value i.e __Yes / No __.


set.seed(1001)
#A training sample of 250  examples sampled without replacement
train<-sample(1:nrow(Carseats), 250)
#Fitting another Model
tree1<-tree(HighSales ~ .-Sales , data = Carseats, subset = train)
summary(tree1)
#Plotting
plot(tree1);text(tree1)

#Predicting the Class labels for Test set
pred<-predict(tree1, newdata = Carseats[-train,],type = "class")
head(pred)

#Confusion Matrix to check number of Misclassifications
with(Carseats[-train,],table(pred,HighSales))

#Misclassification Error Rate on Test Set
mean(pred!=Carseats[-train,]$HighSales)

mean(pred == Carseats[-train,]$HighSales)


#Pruning The tree using Cross Validation............

#10 fold CV
#Performing Cost Complexity Pruning
cv.tree1<-cv.tree(tree1, FUN=prune.misclass)
cv.tree1
plot(cv.tree1)
#Deviance minimum for tree size 15 i.e 15 Splits 


prune.tree1<-prune.misclass(tree1,best = 15)
plot(prune.tree1);text(prune.tree1)

pred1<-predict(prune.tree1 , Carseats[-train,],type="class")

#Confusion Matrix
with(Carseats[-train,],table(pred1,HighSales))

#Misclassification Rate
ErrorPrune<-mean(pred1!=Carseats[-train,]$HighSales)
ErrorPrune
#Error reduced to 25 %

mean(pred1 == Carseats[-train,]$HighSales)

#Conclusion

#As we can notice by the perfomance on Test Set the Pruned Tree dosen't performs better as the 
#Error rate reduced only by a factor of 0.1 % i.e from 26% to 25%. It's just that Pruning 
#lead us to a more simpler Tree with lesser Splits and a subset of predictors which is somewhat
#easier to interpret and understand.
#Usually Trees don't actually give good perfomance on Test Sets , and is called a Weak Learner.

#Applying Ensembling Techniques such as Random Forests , Bagging and Boosting improves the 
#Perfomance of Trees a lot by combining a lot of Trees trained on samples from training examples 
#and finally combining(averaging) the Trees to form a single Strong Tree which performs nicely.

#Hope you guys liked the article , make sure to share and like it.







