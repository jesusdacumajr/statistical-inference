data("ToothGrowth")
str(ToothGrowth)
?ToothGrowth

head(ToothGrowth)
tail(ToothGrowth)
unique(ToothGrowth$dose, 3)
unique(ToothGrowth$supp, 3)

summary(ToothGrowth$len)

boxplot(len~supp, data=ToothGrowth, col=(c("orange","green")),
        main="Fig. 1: Tooth Growth by Supplement", xlab="Supplement Type", ylab="Tooth Length")

boxplot(len~dose, data=ToothGrowth, col=(c("green","yellow", "orange")),
        main="Fig.2: Tooth Growth by Dose", xlab="Dose (mg)", ylab="Tooth Length")

boxplot(len~supp*dose, data=ToothGrowth, col=(c("orange","green")),
        main="Fig. 3: Tooth Growth by Supplement and Dose", xlab="Supplement Type and Dose (mg)", ylab="Tooth Length")

library(ggplot2)

ggplot(ToothGrowth, aes(x=len, fill=factor(dose))) +
  geom_histogram(binwidth=2.5, position="dodge") +
  labs(title='Tooth Growth by Dose', y='Count', x='Tooth Length')

ggplot(ToothGrowth, aes(x=len, fill=supp)) +
  geom_histogram(binwidth=2.5, position="dodge") +
  labs(title='Tooth Growth by Supplement', y='Count', x='Tooth Length')

test1 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth) # Test 1
test2 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose==0.5,]) # Test 2
test3 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose==1,]) # Test 3
test4 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose==2,]) # Test 4

test2data <- c(dose=0.5, statistic = test2$statistic, 
               CI_lower = test2$conf.int[1], CI_upper = test2$conf.int[2], 
               OJ = test2$estimate[1], VC = test2$estimate[2])
test3data <- cbind(dose=1.0, statistic = test3$statistic, 
               CI_lower = test3$conf.int[1], CI_upper = test3$conf.int[2], 
               OJ = test3$estimate[1], VC = test3$estimate[2])
test4data <- cbind(dose=2.0, statistic = test4$statistic, 
                   CI_lower = test4$conf.int[1], CI_upper = test4$conf.int[2], 
                   OJ = test4$estimate[1], VC = test4$estimate[2])
tests <- data.frame()
tests <- rbind(tests, "Test 2" = test2data, "Test 3" = test3data, "Test 4" = test4data)

