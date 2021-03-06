#Boosting

#Random Forests are actually used to reduce the variance of the Trees by averaging them.
#So it generates big Bushy trees and then averages them to get rid of variance.

#Boosting on other hand generates smaller simpler trees and goes at the Bias.
#So the Idea in Boosting is to convert a Weak learner to a Strong Learner by doing weighted averaging 
#of lots of Models generated on Harder Examples and using the Information from a previous Model.

#Harder Examples in the sense means the training Examples which were not classified correctly 
#or more generally which were not predicted correctly by the previous Model.

#Boosting is a Sequential Method. Each tree that's added into the mix is added to improve the 
#perfomance of previous collection of Trees.


#Implementing Gradient Boosting in R using gbm package
require(gbm)
require(MASS)

#Building the Boosted Trees on Boston Housing Dataset.


Boston.boost<-gbm(medv ~ .,data = Boston[-train,],distribution = "gaussian",n.trees = 10000,
                  shrinkage = 0.01, interaction.depth = 4)
Boston.boost

summary(Boston.boost) #Summary gives a table of Variable Importance and a plot of Variable Importance

#The above Boosted Model is a Gradient Boosted Model which generates 10000 trees and
#the shrinkage parameter $\lambda= 0.01$ which is also a sort of Learning Rate. 
#Next parameter is the interaction depth which is the total splits we want to do.
#So here each tree is a small tree with only 4 splits.

#The summary of the Model gives a Feature importance Plot. 
#And the 2 most important features which explaines the maximum variance in the Data set is 'lstat' and 'rm'.

###Let's plot the Partial Dependence Plots

#The partial Dependence Plots will tell us the relationship and dependence of the variables 
#with the Response variable.

plot(Boston.boost,i="lstat") #Plot of Response variable with lstat variable
#Inverse relation with lstat variable ie

plot(Boston.boost,i="rm") 
#as the average number of rooms increases the the price increases

#In the above plots, the y-axis contains the Response values and 
#the x-axis contains the variable values.So 'medv' is inversely related to the 'lstat' variable , 
#and the 'rm' variable is related directly to 'medv'.

# Prediction on the test data

n.trees <- seq(from = 100, to = 10000, by = 100)

#Generating a Prediction matrix for each Tree
predmatrix<-predict(Boston.boost,Boston[-train,],n.trees = n.trees)
dim(predmatrix) #dimentions of the Prediction Matrix

#Calculating The Mean squared Test Error
test.error<-with(Boston[-train,],apply( (predmatrix-medv)^2,2,mean))
head(test.error)
#Plotting 

plot(n.trees , test.error , pch=19,col="blue",xlab="Number of Trees",ylab="Test Error", 
     main = "Perfomance of Boosting on Test Set")

#adding the RandomForests Minimum Error line 
abline(h = min(test.error),col="red")
legend("topright",c("Minimum Test error Line for Random Forests"),col="red",lty=1,lwd=1)

#Boosting outperforms Random Forests on same Test dataset with lesser Mean squared Test Errors.

#In the above plot we can notice that if Boosting is done properly by selecting appropiate 
#Tuning parameters such as Shrinkage parameter $\lambda$ and secondly the Number of Splits we want,
#then it can outperform Random Forests most of the times.

#Both methods are amazingly good Ensembling Techniques and reduce Overfitting and 
#improve the perfomance of Statistical Models.


