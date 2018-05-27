#Logistic regression using glm() function-Generalized Linear models, followed by
# family = 'bionomial'

library(ISLR)
?Smarket
summary(Smarket)
head(Smarket, 5)
view(Smarket)

##Direction var -will be used as a Binary Response variable -to predict whether market will
#move Up or Down  on a given day

#Constructing a Scatterplot Matrix
pairs(Smarket, col = Smarket$Direction)
#By looking at the scatterplot matrix we can easily see that there are no Correlations
#between Variables - As it is a Stock market Data- No BIG Surprise!!

model1 <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data = Smarket, family = binomial )

#The model will compute the Prob values of Direction given  these inputs/predictors

summary(model1)
#Non of the variables have significant p-values , this only means that they are not 
#correlated or very correlated, and also suggest that none of the variables are related
#to the Response(Direction) variable, i.e H0 is true-no relations b/w predictor and Res
#and again for this kind of datasets it is not a big surprise.

#Still we can make Predictions and calculate Probabilities values
probs <- fitted(model1, 'response')
head(probs)
#Prob values nearby 0.5
probs = ifelse(probs >= 0.5, 'Up', 'Down')

#Forming a CONFUSION MATRIX to check the number of mismatches(misclassifications)
table( predicted = probs , True = Smarket$Direction)
#lots of mismatches
#Accuracy of the model
mean(probs==Smarket$Direction) 
#i.e The Model performs Slightly Better than chance , ie when Error Rate < 1/2 or 50%
# % of matches  = 52 %  , Error(mismatches)=47%
#We might be OVERFITTING with such high accuracy on TRAINING DATA

#NOW WE SEGREGATE INTO Training and Test Data and see if we do any better?

train <- Smarket$Year < 2005 
mod2<-glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume ,
          data =Smarket ,subset = train, family =binomial)

summary(mod2)

#Lets check the predictions of this model with Traiing data
#But we will generalize & predict Direction  on TEST DATA
prob1<-predict(mod2,newdata = subset(Smarket,!train),type='response')

mod2.pred<-ifelse(prob1>=0.5,'Up','Down')
head(mod2.pred)

#Dataframe of True Directions and Predicted Direction on TEST Data
pred.df<-data.frame(True_Direction = subset(Smarket,!train)$Direction , Predicted = mod2.pred)


#CONFUSION MATRIX:
table(Predicted = mod2.pred , Ture = Smarket$Direction[!train])
#Accuracy of the Model2-no of matches-correct classifications
mean(mod2.pred==subset(Smarket,!train)$Direction)
#accuracy decreases to 48%
#Hence the model performs poorer than 1st Model and also Overfits

#Smaller Model with Lesser Input variables
mod3<-glm(Direction ~ Lag1 + Lag2,data = Smarket,subset=train , family = binomial)
summary(mod3)

#PREDICTIONS ON TEST
prob1<-predict(mod3,newdata = subset(Smarket,!train),type='response')
mod3.pred<-ifelse(prob1>=0.5,'Up','Down')
head(mod3.pred)


#CONFUSION MATRIX:
table(Predicted = mod3.pred , Ture = Smarket$Direction[!train])
#Accuracy of the Model2-no of matches-correct classifications
mean(mod3.pred==subset(Smarket,!train)$Direction)
#Hence by taking Less predictors the Accuracy of the Model has improved to 56%

