#What are Splines ?

#Splines are used to add Non linearities to a Linear Model and it is a Flexible Technique 
#than Polynomial Regression.Splines Fit the data very smoothly in most of the cases where 
#polynomials would become wiggly and overfit the training data.Polynomials tends to get 
#wiggly and fluctuating at the tails which sometimes overfits the training data and doesn't
#generalizes well due to high variance at high degrees of polynomial.

#loading the Splines Packages
require(splines)
#ISLR contains the Dataset
require(ISLR)
attach(Wage)

agelims<-range(age)
#Generating Test Data
age.grid<-seq(from=agelims[1], to = agelims[2])


#Fitting a Cubic Spline with 3 Knots(Cutpoints)


#What It does is that it transforms the Regression Equation by transforming the Variables 
#with a truncated Basis Function- b(x), with continious derivatives upto order 2.

#The order of the continuity=(d???1), where d is the number of degrees of polynomial

#The Regression Equation Becomes
-
  
  #f(x)=yi=??+??1.b1(xi) +??2.b2(xi) + ....??k+3.bk+3(xi) +??i

#where bn(xi) is The Basis Function


#The idea here is to transform the variables and add a linear combination of the variables 
#using the Basis power function to the regression function f(x).

#3 cutpoints at ages 25 ,50 ,60
fit<-lm(wage ~ bs(age,knots = c(25,40,60)),data = Wage )
summary(fit)


#Plotting the Regression Line to the scatterplot   
plot(age,wage,col="grey",xlab="Age",ylab="Wages")
points(age.grid,predict(fit,newdata = list(age=age.grid)),col="darkgreen",lwd=2,type="l")
#adding cutpoints
abline(v=c(25,40,60),lty=2,col="darkgreen")

#The above Plot shows the smoothing 

#Smoothing Splines..

#These are mathematically more challenging but they are more smoother and flexible as well.
#It does not require the selection of the number of Knots , but require selection of only a 
#Roughness Penalty which accounts for the wiggliness(fluctuations) and controls the roughness
#of the function and variance of the Model.

fit1<-smooth.spline(age,wage,df=16)
plot(age,wage,col="grey",xlab="Age",ylab="Wages")
points(age.grid,predict(fit,newdata = list(age=age.grid)),col="darkgreen",lwd=2,type="l")
#adding cutpoints
abline(v=c(25,40,60),lty=2,col="darkgreen")
lines(fit1,col="red",lwd=2)
legend("topright",c("Smoothing Spline with 16 df","Cubic Spline"),col=c("red","darkgreen"),lwd=2)


#Implementing Cross Validation to select value of ?? and Implement Smoothing Splines.....

fit2<-smooth.spline(age,wage,cv = TRUE)

#It selects $\lambda=6.794596$ it is a Heuristic and can take various values for how rough the function is

plot(age,wage,col="grey")
#Plotting Regression Line
lines(fit2,lwd=2,col="purple")
legend("topright",("Smoothing Splines with 6.78 df selected by CV"),col="purple",lwd=2)


#This Model is also very Smooth and Fits the data well

