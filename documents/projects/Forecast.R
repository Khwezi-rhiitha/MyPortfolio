#N Malusi

#a Open the timeseries data an print 15 observations
#install.packages("readxl")
library(readxl)
(data1<-read_excel("data\\timeseries.xlsx"))
data1<-data.frame(data1)
attach(data1)
head(data1,15)

#b Determine by using plots if the series is stationary. if not, difference until stationary
library(forecast)
tsdisplay(x)
#OR
plot.ts(data1)
acf(data1)
pacf(data1)
#Considering the time series plot, the series appears to be non-stationary in the mean, there is an upward trend in the series. 
#The ACF (autocorrelation function) start at lag 0. The ACF will always have a "spike" equal to 1 at lag 0. #This is because the correlation of a value with itself is always 1. 
#The ACF also suggest a non-stationary time series. 
#The ACF of a stationary time series decline faster to near zero, whereas the ACF of a non-stationary series does so more slowly.

x1<-diff(x)
tsdisplay(x1)
#The time series plot of the differenced series, appears to be stationary in the mean. 
#Thus, differencing has helped to make the series stationary.  
#The series fluctuates randomly around a centre line, and the variance appears to remain mostly stable for all the time plots considered.
#Because both the ACF and PACF plots decreases with a damped sine wave it suggests p>0 and q>0 for the ARIMA model.

#c Determine the optimal order of the ARIMA model note p=3 and q=3.
model1<-Arima(x,c(0,1,0))
model2<-Arima(x,c(0,1,1))
model3<-Arima(x,c(0,1,2))
model4<-Arima(x,c(0,1,3))
model5<-Arima(x,c(1,1,0))
model6<-Arima(x,c(1,1,1))
model7<-Arima(x,c(1,1,2))
model8<-Arima(x,c(1,1,3))
model9<-Arima(x,c(2,1,0))
model10<-Arima(x,c(2,1,1))
model11<-Arima(x,c(2,1,2))
model12<-Arima(x,c(2,1,3))
model13<-Arima(x,c(3,1,0))
model14<-Arima(x,c(3,1,1))
model15<-Arima(x,c(3,1,2))
(model16<-Arima(x,c(3,1,3)))

#d Specify the order of the ARIMA model using Akaike’s Information Criterion (AIC)
mylist<-list(model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12,model13,model14,model15,model16)
(a<-sapply(mylist,with,aic))
which(a==min(a))
#Model 11: ARIMA(2,1,2)

#e Specify the order of the ARIMA model using Bayesian Information Criterion (BIC) 
(b<-sapply(mylist,with,bic))
which(b==min(b))
#Model 11: ARIMA(2,1,2)

#f Using function auto.arima() determine optimal order of ARIMA.
model<-auto.arima(x)
model
#ARIMA(2,1,2)

#g Determine whether the series follows a white noise process
acf(model11$residual, main="ACF of the residual series")
pacf(model11$residuals, main="PACF of the residual series")
#Considering the ACF and PACF plots, no bars are significantly different from zero. There are no significant correlations on the ACF and PACF plots.

#h  Considering lags 6,12,18,24,30,36 and 42. Test whether the residuals of the specified model are white noise.

#Test the model residuals for white noise. The Box-Ljung test is used: 
#Ho: Series of residuals is white noise 
Box.test(model11$residuals,12,type="Ljung")$p.value
for (i in seq(6,42,6))
  print(paste("i =", i, "p-value=", Box.test(model11$residuals,i,type="Ljung")$p.value))
#None of the p-values in the output are less than alpha=0.05, do not reject the null hypothesis. 
#According to this test the residual series can be considered as white noise. 
#Since we are satisfied that the ARIMA (2,1,2) model is appropriate for the series, we can forecast.

#i Forecast for the next 4 time units
predictions<-forecast(model11,h=4,level=0.95)
predictions
