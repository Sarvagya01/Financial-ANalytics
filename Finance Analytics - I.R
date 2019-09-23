#==================================================#
#                                                  #
#2.2 - R warm-up: Introduction to Quantmod    #
#                                                  #
#==================================================#

#==================================================#
#Initial Setup
#==================================================#
rm(list = ls())  # cleanup the R environment
dev.off() # close graphical devices
cat("\014") # clear the console
setwd("") # Set the working directory
getwd() # Check current working directory


#==================================================#
#Download Quantmod
#==================================================#
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}

?quantmod
#==================================================#
#                                                  #
#Script2.3 - Equity: definition and prices download#
#                                                  #
#==================================================#

#==================================================#
#Download the time series for Apple (AAPL)
#==================================================#
start <- as.Date("2018-01-01")
end <- as.Date("2018-10-01")
getSymbols("AAPL", src = "yahoo", from = start, to = end)
#the result is a matrix called AAPL

#check element class
class(AAPL)

#view main information without opening it
head(AAPL)
View(AAPL)

#==================================================#
#Plot AAPL time series for closing prices
#==================================================#
plot(AAPL[, "AAPL.Close"], main = "AAPL")
#plot AAPL time series for opening prices
plot(AAPL[, "AAPL.Open"], main = "AAPL")

#==================================================#
#plot the candlechart for AAPL
#==================================================#
candleChart(AAPL[seq(1:10),], up.col = "white", dn.col = "red", theme = "black")










# #Download more than a single time series at the same time
getSymbols(c("MSFT", "GOOG"), src = "yahoo", from = start, to = end)
# 
# 
# #The as. command forces the object to change
stocks <- as.xts(data.frame(AAPL = AAPL[, "AAPL.Close"], MSFT = MSFT[, "MSFT.Close"], GOOG = GOOG[, "GOOG.Close"]))
head(stocks)
View(stocks)
# 
plot(as.zoo(stocks), screens = 1, lty = 1:3, xlab = "Date", ylab = "Price")
legend("right", c("AAPL", "MSFT", "GOOG"), lty = 1:3, cex = 0.5)
#==================================================#
#                                                  #
#Script2.4 - Modeling prices and returns           #
#                                                  #
#==================================================#

#==================================================#
#Arithmetic vs Geometric returns - Part A
#==================================================#
#Let
P1 <- 105
P0 <- 100

#Calculate the 10-days Arithmetic returns
R10 <- (P1-P0)/P0
print(R10)

#Calculate the 10-days Geometric returns
r10 <- log(P1/P0)
print(r10)

#Compare log and Arithmetic returns
R10 == r10
R10 >= r10

#From log-returns to simple
exp(r10)-1

#From simple returns to Geometric returns
log(1+R10)


#==================================================#
#Arithmetic vs Geometric returns - Part B
#==================================================#
# Download the time series for Apple (AAPL)
start <- as.Date("2018-01-01")
end <- as.Date("2018-10-01")
getSymbols("AAPL", src = "yahoo", from = start, to = end)

AAPL.returns <- allReturns(AAPL)

View(AAPL.returns)

AAPL.A.returns <- periodReturn(AAPL[, "AAPL.Adjusted"],period='daily',subset=NULL,type='arithmetic',leading=TRUE)
AAPL.G.returns <- periodReturn(AAPL[, "AAPL.Adjusted"],period='daily',subset=NULL,type='log',leading=TRUE)

View(AAPL.A.returns*100)
View(AAPL.G.returns*100)

min(AAPL.A.returns*100)
min(AAPL.G.returns*100)

# Histogram and Normal fit
par(mfrow=c(1,2))
aapl.hist1 = hist(AAPL.A.returns,plot=F,breaks=30)
hist(AAPL.A.returns,main="Arithmetic", col="cornflowerblue",
     xlab="returns",
     breaks=aapl.hist1$breaks)
xfit<-seq(min(AAPL.A.returns),max(AAPL.A.returns),length=40) 
yfit<-dnorm(xfit,mean=mean(AAPL.A.returns),sd=sd(AAPL.A.returns)) 
yfit <- yfit*diff(aapl.hist1$mids[1:2])*length(AAPL.A.returns) 
lines(xfit, yfit, col="red", lwd=2)

aapl.hist2 = hist(AAPL.G.returns,plot=F,breaks=30)
hist(AAPL.G.returns,main="Geometric", col="cornflowerblue",
     xlab="returns",
     breaks=aapl.hist2$breaks)
xfit<-seq(min(AAPL.G.returns),max(AAPL.G.returns),length=40) 
yfit<-dnorm(xfit,mean=mean(AAPL.G.returns),sd=sd(AAPL.G.returns)) 

yfit<-dnorm(xfit,mean=0,sd=0.01) 
yfit <- yfit*diff(aapl.hist2$mids[1:2])*length(AAPL.G.returns) 
lines(xfit, yfit, col="red", lwd=2)
#==================================================#
#                                                  #
#Script2.5 - Predictability of asset returns....   #
#                                                  #
#==================================================#

#==================================================#
#Monte Carlo - Throwing a dice
#==================================================#
#Dice throws
set.seed(80)
roll = sample(1:6, 10000, replace=T)
outcome <- as.data.frame(table(roll))
View(outcome)
barplot(t(as.matrix(table(roll))),col=rainbow(6),main="Dice throws",ylab="frequency")

#==================================================#
#Monte Carlo - Returns simulation
#==================================================#
mu=0.01
sigma=0.02
n=1000
m=100
set.seed(80)

#Generate m*n Gaussian simulations stored in matrix u (n*m)
u <- matrix(rnorm(n*m,0,1), n,m)
#Generate m returns paths of size n
Rt <- mu + sigma*u
#Plot
matplot(Rt,type = 'l')

#Simulate a Brownian Motion
#diffinv(c(1,2,3,4,5))
Wt<- apply(u,2, diffinv)
BM <- mu + sigma*Wt
matplot(BM,type = 'l')

#==================================================#
#                                                  #
#Script2.6 - Getting Practical: SPX                #
#                                                  #
#==================================================#

#==================================================#
#S&P500 Statistical Analysis
#==================================================#
#get prices from Yahoo for S&P500 (GSPC is the ticker)
start <- as.Date("2010-01-01")
end <- as.Date("2018-11-01")
getSymbols("^gspc", src = "yahoo", from = start, to = end)

#get information about S&P500
class(GSPC)
dim(GSPC)
head(GSPC)
View(GSPC)
GSPC.prices = na.omit(GSPC[, "GSPC.Adjusted"])
plot(GSPC.prices)
summary(GSPC.prices)

#Derive S&P500 returns -- only geometric
GSPC.returns <- periodReturn(GSPC.prices,period='daily',subset=NULL,type='log',leading=TRUE)

#Plot S&P500 returns
plot(GSPC.returns, main = "SPX")

#Histogram
GSPC.hist = hist(GSPC.returns,plot=F,breaks=10)
hist(GSPC.returns,main="SP500", col="cornflowerblue",
     xlab="returns",
     breaks=GSPC.hist$breaks)

#qqplot
qqnorm(GSPC.returns, main="SP500 Returns", col="slateblue1")
qqline(GSPC.returns)

#Autocorrelation
SPX.acorr=acf(GSPC.returns, main="Fz. autocorrelation SPX")

#Statistical summaries
summary(GSPC.returns)


