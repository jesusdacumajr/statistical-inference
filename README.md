## Statistical Inference

This is the project for the statistical inference class. In it, you will use simulation to explore inference and do some simple inferential data analysis. The project consists of two parts.

### A Simulation Exercise

In this report you will investigate the exponential distribution in R and compare it with the Central Limit Theorem. The exponential distribution can be simulated in R with `rexp(n, lambda)` where lambda is the rate parameter. The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda. Set lambda = 0.2 for all of the simulations. You will investigate the distribution of averages of 40 exponentials. Note that you will need to do a thousand simulations.

Illustrate via simulation and associated explanatory text the properties of the distribution of the mean of 40 exponentials.  You should
<ol>
<li>Show the sample mean and compare it to the theoretical mean of the distribution.</li>
<li>Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.</li>
<li>Show that the distribution is approximately normal.</li>
</ol>

In point 3, focus on the difference between the distribution of a large collection of random exponentials and the distribution of a large collection of averages of 40 exponentials. 

As a motivating example, compare the distribution of 1000 random uniforms
```
hist(runif(1000))
```

and the distribution of 1000 averages of 40 random uniforms
```
mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(runif(40)))
hist(mns)
```

This distribution looks far more Gaussian than the original uniform distribution!

This exercise is asking you to use your knowledge of the theory given in class to relate the two distributions.

#### Sample Project Report Structure

A sample set of headings that could be used to guide the creation of your report might be:

* Title (give an appropriate title) and Author Name
* Overview: In a few (2-3) sentences explain what is going to be reported on.
* Simulations: Include English explanations of the simulations you ran, with the accompanying R code. Your explanations should make clear what the R code accomplishes.
* Sample Mean versus Theoretical Mean: Include figures with titles. In the figures, highlight the means you are comparing. Include text that explains the figures and what is shown on them, and provides appropriate numbers.
* Sample Variance versus Theoretical Variance: Include figures (output from R) with titles. Highlight the variances you are comparing. Include text that explains your understanding of the differences of the variances.
* Distribution: Via figures and text, explain how one can tell the distribution is approximately normal.

### Basic Inferential Data Analysis

Now in the second report, we're going to analyze the ToothGrowth data in the R datasets package. Some evaluations to consider:

<ol>
<li>Load the ToothGrowth data and provide a basic summary of the data.</li>
<li>Perform some basic exploratory data analyses of at least a single plot or table highlighting basic features of the data.</li>
<li>Perform some relevant confidence intervals and/or hypothesis tests to compare tooth growth by `supp` and `dose`.</li>
<li>State your conclusions and describe the assumptions needed for your conclusions. </li>
</ol>