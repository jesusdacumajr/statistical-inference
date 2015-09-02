---
title: "Statistical Inference Project - Part 2"
author: "Jesus Dacuma"
date: "August 23, 2015"
---

##Analyzing the ToothGrowth Dataset in R

###A Basic Summary of the Data
The ToothGrowth dataset in R contains data on the length of teeth in different guinea pigs that were given specific doses of different Vitamin C supplements. We can load and the dataset and display its structure.

```
data("ToothGrowth")
str(ToothGrowth)
```
```
## 'data.frame':    60 obs. of  3 variables:
##  $ len : num  4.2 11.5 7.3 5.8 6.4 10 11.2 11.2 5.2 7 ...
##  $ supp: Factor w/ 2 levels "OJ","VC": 2 2 2 2 2 2 2 2 2 2 ...
##  $ dose: num  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...
```

We can see that the data set contains the response `len` for tooth length, and the supplement type and dose as the factors. The supplement levels are apparent from the str function, and as shown in the code below, there are three levels of doses.

```
unique(ToothGrowth$dose)
```
```
## [1] 0.5 1.0 2.0
```

We can also take a sample of the top and bottom of the data. Since the dataset is small, just observing that the data shows that it contains 10 replications of each of the 6 different combinations of supplement and dose. 

```
head(ToothGrowth)
```
```
##    len supp dose
## 1  4.2   VC  0.5
## 2 11.5   VC  0.5
## 3  7.3   VC  0.5
## 4  5.8   VC  0.5
## 5  6.4   VC  0.5
## 6 10.0   VC  0.5
```
```
tail(ToothGrowth)
```
```
##     len supp dose
## 55 24.8   OJ    2
## 56 30.9   OJ    2
## 57 26.4   OJ    2
## 58 27.3   OJ    2
## 59 29.4   OJ    2
## 60 23.0   OJ    2
```

###Exploratory Data Analysis
For quick and dirty exploratory analysis, we can use a 5 point summary (including the mean) of the response.

```
summary(ToothGrowth$len)
```
```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    4.20   13.08   19.25   18.81   25.28   33.90
```

Boxplots help to compare the difference in response from the two separate factors. Figure 1 of the appendix shows the box plot for tooth length grouped by supplement, while Figure 2 does the same for dose. Figure 3 shows the box plots broken up by supplement/dose combination.

Lastly, we can use the histograms of Figures 4 and 5 to see that the distributions of tooth length by each factor somewhat resemble a normal distribution, so we can assume normality (as a t-test is robust to deviations from normality).

From the exploratory analysis, we can see that there is a difference, between supplement types, although its visually unclear if a significant statistical difference exists without further hypothesis testing. Also, the box plots for dose levels clearly show that increasing the dose (within the levels tested) will increase the response. However, Figure 3 shows that any differences in supplement types may diminish as the dose is increased. This is perhaps the most interesting phenomenon to explore.

###Hypothesis Testing

The ToothGrowth dataset can be tested using a two-sample test (since the test subjects were all different guinea pigs). Test 1 fails to reject the null hypothesis that the difference between the mean response from both supplements is zero. The test statistic is 1.92, and the null hypothesis (zero) lies within the confidence interval. One should note however, that the test statistic is very close to the 97.5% quantile and the null hypothesis is quite close to the lower bound of the confidence interval. Since Test 1 does not account for dose, there may be more to explore.

```
t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth) # Test 1
```
```
## 
##  Welch Two Sample t-test
## 
## data:  len by supp
## t = 1.9153, df = 55.309, p-value = 0.06063
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.1710156  7.5710156
## sample estimates:
## mean in group OJ mean in group VC 
##         20.66333         16.96333
```

Tests 2, 3 and 4 in the appendix are more two-sample tests at each dose level. Tests 2 and 3 have test statistics at 3.17 and 4.03, both of which are greater than 3, or approximately the 99.5% quantile. These tests give us strong evidence to reject the null hypothesis that the supplements at dose levels 0.5 and 1.0 mg are statistically different.

Test 4, however, shows the opposite. The test statistic is close to zero, and the null hypothesis lies almost directly in the center of the confidence interval. We fail to reject the null hypothesis that the means of the two supplements at dose level 2.0 mg is equal.

```
test2 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose==0.5,])
test3 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose==1,])
test4 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose==2,])
```
```
##        dose  statistic  CI_lower CI_upper mean_OJ mean_VC
## Test 2  0.5  3.1697328  1.719057 8.780943   13.23    7.98
## Test 3  1.0  4.0327696  2.802148 9.057852   22.70   16.77
## Test 4  2.0 -0.0461361 -3.798070 3.638070   26.06   26.14
```

###Conclusion

Assuming that the two supplements have inequal variance (the t-tests used the inequal variance method) and the distribution for tooth growth is normal, we can conclude that the Orange Juice supplements at 0.5 and 1.0 mg increases tooth growth more than supplements of ascorbic acid. However, when increasing the dose to 2.0 mg, there is no difference between supplements.

##Appendix

```
boxplot(len~supp, data=ToothGrowth, col=(c("orange","green")),
        main="Fig. 1: Tooth Growth by Supplement", xlab="Supplement Type", ylab="Tooth Length")

boxplot(len~dose, data=ToothGrowth, col=(c("green","yellow", "orange")),
        main="Fig. 2: Tooth Growth by Dose", xlab="Dose (mg)", ylab="Tooth Length")

boxplot(len~supp*dose, data=ToothGrowth, col=(c("orange","green")),
        main="Fig. 3: Tooth Growth by Supplement and Dose", xlab="Supplement Type and Dose (mg)", ylab="Tooth Length")

library(ggplot2)

ggplot(ToothGrowth, aes(x=len, fill=factor(dose))) +
  geom_histogram(binwidth=2.5, position="dodge") +
  labs(title='Fig. 4: Tooth Growth by Dose', y='Count', x='Tooth Length')

ggplot(ToothGrowth, aes(x=len, fill=supp)) +
  geom_histogram(binwidth=2.5, position="dodge") +
  labs(title='Fig. 5: Tooth Growth by Supplement', y='Count', x='Tooth Length')
```