set.seed(31)

# Set the experimental parameters
lambda <- 0.2 # parameter for exponential random variable
i <- 40       # number of random variables generated per trial
n <- 1000     # number of trials

# Generate exponential random variables
Xi <- rexp(i, lambda) 
df <- data.frame(Xi)

# Compare the sample and theoretical means
X_bar <- mean(Xi) # sample mean of random variables
X <- 1/lambda # mean of an exponential distribution, also the standard deviation
df_x <- data.frame(means=c(X_bar, X), row.names = c("Sample Mean", "Theoretical Mean"))

library(ggplot2)

g1 <- ggplot(df, aes(x=Xi))
g1 <- g1 + geom_histogram(binwidth=4, color="black", aes(y=..density.., fill=..count..))
g1 <- g1 + geom_vline(data=df_x, aes(xintercept=means, show_guide = TRUE), 
                      color=c("green", "red"), linetype="dashed", size=1)
g1 <- g1 + stat_function(fun = dexp, color = "red", arg = list(rate = lambda), size = 1)
g1 <- g1 + geom_density(color = "green", size = 1)
g1 <- g1 + labs(title='Fig. 1: Distribution of 40 Sample Exponentials', x='Samples', y='Density')
print(g1)

# Generate averages of 40 exponential random variables
df_mns <- data.frame(means = numeric(n))
for(ii in 1:n){
  df_mns[ii,] = mean(rexp(i, lambda))
}

# Normalize the generated averages
SE <- X/sqrt(i)
df_mns$norm <- (df_mns$means - X) / SE

# Calculate the sample mean, sample variance, theoretical mean, and theoretical variance
X_mns_bar <- mean(df_mns$means)
Var_X <- X*X / i
S2 <- var(df_mns$means)
df_x_mns <- data.frame(mean = c(X_mns_bar, X), variance = c(S2, Var_X), row.names = c('sample', 'theoretical'))

g2 <- ggplot(df_mns, aes(x=norm))
g2 <- g2 + geom_histogram(binwidth=.3, color="black", aes(y=..density.., fill=..count..))
g2 <- g2 + geom_vline(data=df_x_mns, aes(xintercept=mean-X, show_guide = TRUE), color=c("green", "red"), linetype="dashed", size=1)
g2 <- g2 + stat_function(fun = dnorm, color = "red", size = 1)
g2 <- g2 + geom_density(color = "green", size = 1)
g2 <- g2 + labs(title='Fig. 2: Distribution of Mean of 40 Sample Exponentials', x='Means', y='Density')
print(g2)