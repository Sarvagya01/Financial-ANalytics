print("My name is Ravi")
data = read.csv("C://Users/admin/Documents/Rcsv")
data1
x <- 10
y <- 20

x/y
x+y
x-y

log2(2)

# Vectors
v = c(1:100)
v1 = c(1:100)
d = v+v1
v = c(9,7,8,5,2,4)
d = sort(v)
d
v = c('a','d','c','b')
d = sort(v)
d
v1 = c(1:10)
v1[10]
v1[2:10]
v1[-9]
v1[3] = "Hi"
v1
v1[12] = 1
v1

# this is how we create a vector
c(1,2,3,4,5)

x <- c(1,2,3,4,5)

x[1]

x[5]

# print all the items except for the 1 index
x[-1]

x[-1:-3]

x[c(1,3,5)]

x <- c("Joe","Adam","Kevin")

typeof(x)

# integers are stored as doubles in R

b <- as(10,"integer")

typeof(b)

##Operators
#Arithmetic Operators
a = 10
b = 5
c = a+b

c

d = a*b
d
d = a/b

d
d = a^b

d
print(a%%b)
d
print(a%/%b)
#Relational Operators
a = 5
b = 10
print(a>b)
print(a==b)
print(a!=b)
print(b>=a)
#Logical Opeartor
a = TRUE
b = FALSE
print(a&b)
print(a|b)
print(!a)



# Lists
v =c("Hi", 1, 5L, TRUE)
v
class(v)
List = list("Hi", 1, 5L, TRUE)
List
class(List)
sorted_list = sort(List)
x <- list(name="John Doue", age=35, gender="male")

x

x$age

typeof(x$age)
#Merge
List1 = list(1,2,3,4,5)
List2 = list(2,4,6,8,10)

List3 = merge(List1, List2)
List3
List4 = c(List1, List2)
List4
List4[3]
print(1 in List1)
# Arrays
vtr1 = c(2,4,5,6,6,7,8,10)
vtr2 = c(3,4,5,6,7,8,5,9)
arr1 = array(c(vtr1))
arr1

arr2 = array(c(vtr1, vtr2), dim = c(5,5,3))
arr2
#Matrix
x <- matrix(c(1,2,3,4,5,6,7,8), nrow=2, ncol=4)
x

x[2,3]

# third column
x[,3]

#first row
x[1,]

dimnames(x) = list(c("row1","row2"), c("col1","col2","col3","col4"))

x

# we can reference the items like that
c["row2","col4"]

#Factors
# factors are important in statistics
v = c(1,1,1,1,1,2,2,2,2,3,3,3,4,4,4,5,5,5,5,5)
factorv = factor(v)
factorv
data <- c(1,2,2,3,1,2,3,2,2,1)

# time series number of products sold a day
# we have only 3 cases: 1 2 and 3

fdata <- factor(data)

# we have an additional 'level' feature

fdata

# for example can store characters very efficiently: each character is stored only once and data is strored as a 
# vector of integers

rdata <- factor(data, labels=c("a","b","c"))

rdata
# Data Frames
id = c(10:15)
name = c("Ravi", "Roger", "Rauf", "Romeo","Rashmi","Rajesh")
df = data.frame(id, name)
df

# data frame: list that contains multiple named vectors that are of the same length
# its like a database table

names <- c("Joe","Michael","Ana")
ages <- c(27,32,36)
genders <- c("male","male","female")

data <- data.frame(names,ages,genders)
data

data$names
typeof(data$names)
class(data$names)

data$ages

data$names[data$age < 30]
data$names[data$gender=="male"]
#If else
if( TRUE ) print("This is going to be printed out...")

if( FALSE ) print("Not printed out...")

x <- 5
y <- 10

x
y

if( x < y ) print(x) else print(y)

x <- 10
y <- 5

if( x < y ) print(x) else print(y)
#Loops


i <- 1;

repeat{ 
  
  if( i>=10 ) {
    break;
  } else {
    print(i);
    i <- i + 1;
  }
}

x <- 1

while( x < 10 ) {
  print(x);
  x <- x + 1;
}

j <- 1

# start, end, increment
seq(1,10,2)

for(j in seq(1,10,1)) {
  print(j);
}
# Functions


# custom functions

x <- c(1,2,3,4)
length(x)

# void functions

f <- function(name) {
  print(paste0("My name is: ", name))
}

f("Adam")

# return values

myMin <- function(x,y) {
  if( x < y) {
    return(x)
  } else {
    return(y)
  }
}

myMin(100,10)


