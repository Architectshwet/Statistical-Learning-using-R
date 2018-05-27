#Generalized Additive Models and their implementation in R

#This is also a famous and very flexible technique of fitting and Modelling Non Linear Functions 
#which are more flexible and fits data well. In this technique we simply add Non linear Functions 
#on different variables to the Regression equation. That Non linear function 
#can be anything - Cubic Spline , natural Spline ,Smoothing Splines and even polynomial function

#Requiring the 'gam' package which helps in fitting Generalized Additive Models.

#requiring the Package 
require(gam)

#ISLR package contains the 'Wage' Dataset
require(ISLR)
attach(Wage) #Mid-Atlantic Wage Data

?Wage # To search more on the dataset
head(Wage, 2)

gam1<-gam(wage~s(age,df=6)+s(year,df=6)+education ,data = Wage)
#in the above function s() is the shorthand for fitting smoothing splines in gam() function
summary(gam1)
#Plotting the Model
par(mfrow=c(1,3))
plot(gam1,se = TRUE)

#In the above Plots the Y-axis contains the Non Linear functions and x-axis contains the Predictors 
#used in the Model and the dashed lines Represent the Standard Error bands.
#The Whole Model is Additive in nature.


#We can also fit a Logistic Regression Model using gam()......

#logistic Regression Model
gam2<-gam(I(wage >250) ~ s(age,df=4) + s(year,df=4) +education , data=Wage,family=binomial)

plot(gam2,se=T)

#So we are plotting the logit of Probabilities of each variable as a saperate function
#but on the whole additive in nature.

###Now we can also check if we need Non linear Terms for Year variable or not?

#fitting the Additive Regression Model which is linear in Year
gam3<-gam(I(wage >250) ~ s(age,df=4)+ year + education , data =Wage, family = binomial)
plot(gam3)

#anova() function to test the goodness of fit and choose the best Model
#Using Chi-squared Non parametric Test due to Classification Problem and categorial Target
anova(gam2,gam3,test = "Chisq")

#As the above Test indicates that Model with Non linear terms for Year is not Significant.
#So we can neglect that Model.

###Now we can also fit a Additive Model using lm() function

lm1<-lm(wage ~ ns(age,df=4) + ns(year,df=4)+ education , data  = Wage)
#ns() is function used to fit a Natural Spline
lm1


#Now plotting the Model

plot.gam(lm1,se=T)
#Hence the Results are same
####So by using the lm() function too we can fit a Genaralized Additive Model.

##Conclusion.....

#Hence GAMs are a very nice technique and method to Model Non linearities and 
#Learn complex function other than just Linear functions.They are easily interpretable too.

####And the most basic idea behind learning Non Linearities is to transform the Data and 
#the variables which can capture and Learn and make sense of something more complicated 
#than just a linear relationship.



























