#Steps of  Fitting ARIMA Model
#Create Time Series Data
#Plot Time Series Object
#Decompose Time Series
#Smoothed Time Series
#Forcasted Time Series

#Importing Packages
library(quantmod)
library(forecast)


#Choosing closing price column(Facebook Data)
FB <- na.omit(getSymbols('FB',src = "yahoo",from ="2015-01-01" ,auto.assign=F)[,4])
View(FB)
plot(FB)

#Plotting close price of stock
chartSeries(FB)

#ADF Test (Agumented Dickey-Fuller Test)

adf.test(FB, alternative = "stationary")


#Fitting ARIMA
fit <- auto.arima(FB$FB.Close,ic="bic")
View(fit)
fit
#ARIMA(0,1,0) 

#sigma^2 estimated as 7.32:  log likelihood=-2865.72
#AIC=5733.43   AICc=5733.43   BIC=5738.51


#Plotting data
lines(fitted(fit),col= 'red')

#Forecasting Future values
fit.forecast <- forecast(fit)
fit.forecast
plot(fit.forecast)

#Forecasting the Retuns
FB_RETURN <- diff(FB$FB.Close)/lag(FB$FB.Close,k=-1)*100
head(FB_RETURN)
hist(FB_RETURN)

