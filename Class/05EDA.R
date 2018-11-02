##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
## Lecture : EDA(Explorary Data Analysis)                                                ##
##           Ž���� ������ �м�                                                          ##
## Date    : October 10th, 2018                                                          ##
## Author  : Buil Lee                                                                    ##
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##

# �����Ϳ� ������ ����(pattern) �Ǵ� Ư¡�� ã�Ƴ��� �۾�
# [��Ű��] ----
install.packages("ggplot2")      # Visualization : �ð�ȭ
install.packages("dplyr")        # Data Analysis and Handling
install.packages("RColorBrewer") # Colors
install.packages("stringr")      # String
install.packages("prettyR")      # Mode, Correalation Analysis
install.packages("e1071")        # Skewness, Kurtosis, SVM
install.packages("psych")        # Descriptive Statistics = Summary statistics
install.packages("writexl")
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(stringr)
library(prettyR)
library(e1071)
library(psych)
library(writexl)


# [�۾�����] ----
setwd("c:/R/BigData/")


# ������ �о���� ----
# ggplot2::diamonds


# �������� ����(������� ����)
# 1. ���� �ڷ� = ������ �ڷ� : ����(����) = character vector or factor, numeric vector
# 2. ���� �ڷ� : numeric vector


# diamonds
diamonds <- diamonds[ , 1:10]
# ���� �ڷ� : cut, color, clarity
# ���� �ڷ� : carat, depth, table, price, x, y, z

# 1. �Ϻ���(Uni-variate) ���� �ڷ��� �м� ----
# 1-1. ǥ = ��ǥ ----
# (1) ��(Frequency) ----
# table(data$variable)
table(diamonds$cut) # Numeric vector. ������������ ���� ����
sort(table(diamonds$cut), decreasing = TRUE)
head(sort(table(diamonds$cut), decreasing = TRUE), n = 3) # top3 ���͸� 1
sort(table(diamonds$cut), decreasing = TRUE)[1:3]         # top3 ���͸� 2. vector�� �����̽� Ȱ��

sort(table(diamonds$color), decreasing = TRUE)
sort(table(diamonds$clarity), decreasing = TRUE)

for(i in 2:4){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
} # ������ �� for���� �ִ� ���� Ŀ���� �ΰ� �� ��.

diamonds[ , 2] # cut
diamonds[ , 3] # color
diamonds[ , 4] # clarity



# (2) �����(Percent) ----
# prop.table(frequency) : ���� : 0 ~ 1
# prop.table(frequency)*100
prop.table(table(diamonds$cut))*100
sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE)
# ������� �Ҽ��� �ڸ����� Ư������ ������ �� �ڸ��� ǥ����
round(sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE), digits = 1)

# ����1
# for�� �̿��ؼ� �� ���� ���� �ڷῡ ���� ��, ������� ����Ͻÿ�.

for(i in 2:4){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ , i]))*100, decreasing = TRUE), digits = 1))
}

for(i in c("cut", "color", "clarity")){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ , i]))*100, decreasing = TRUE), digits = 1))
}

# 1-2. �׷��� ----
# (1) ����׷��� : ���� / ���� ----
#barplot(frequency or percent)
barplot(sort(table(diamonds$cut), decreasing = TRUE))

# i. ���� ���� : col = "color" ----
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = "purple")

barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = "magenta4")

# ����2
# ���� ������ �� �ٸ��� �Ͻÿ�.
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = c("purple", "magenta4", "green", "blue", "red"))


pal <- RColorBrewer::brewer.pal(n = 5, name = "BuGn") # n�� ������ ����
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = pal)

barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = rainbow(5))


# ii. ��Ʈ�� ���� : main = "title" ----
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col  = "magenta4",
        main = "Cut of Diamonds")

# iii. y�� ���� : ylab = "y axis's label" ----
# ylab : y label�� ����
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col  = "magenta4",
        main = "Cut of Diamonds",
        ylab = "Frequency")

# iv. y�� ���� : ylim = c(min, max) ----
# ylim : y limit�� ����
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col  = "magenta4",
        main = "Cut of Diamonds",
        ylab = "Frequency",
        ylim = c(0, 25000))

# v. ���� ����׷��� : horiz = TRUE ----
# horiz : horizontal�� ����
barplot(sort(table(diamonds$cut), decreasing = FALSE),
        col  = "magenta4",
        main = "Cut of Diamonds",
        xlab = "Frequency",
        xlim = c(0, 25000),
        horiz = TRUE)

# ����3
# for�� �̿��ؼ� �� ���� ���� �ڷῡ ���� ������ ���� �׷����� �ۼ��غ�����.
for(i in 2:4) {
  barplot(sort(table(diamonds[ , i]), decreasing = TRUE),
          col  = "magenta4",
          main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"),
          xlab = "Frequency",
          xlim = c(0, 25000),
          horiz = TRUE)
}



# *paste(character1, character2, ..., sep = ) : recycling rule�� vectorization�� �Ͼ ----
paste("Love", "is", "choice")
paste("Love", "is", "choice", sep = "-")
paste("Love", "is", "choice", sep = "")
paste("V", 1:10, sep = "")

paste("cut", "of Diamonds")
paste("color", "of Diamonds")
paste("clarity", "of Diamonds")


colnames(diamonds)[2]
colnames(diamonds)[3]
colnames(diamonds)[4]

paste(colnames(diamonds)[i], "of Diamonds")

tolower("Love is choice.") # �ҹ��ڷ� ����
toupper("Love is choice.") # �빮�ڷ� ����

stringr::str_to_title("love is choice.")


# (2) ���׷��� ----
# pie(frequency or percent)
pie(sort(table(diamonds$cut), decreasing = TRUE))
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col = pal)

# i. �������� ũ�� : radius = 0.8 ----
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col    = pal,
    radius = 1)

# ii. �ð� ���� : clockwise = TRUE ----
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col       = pal,
    radius    = 1,
    clockwise = TRUE)

# iii. ù° ������ ���� ���� : init.angle = ----
# �ð�ݴ���� : 0
# �ð� ����    : 90
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col        = pal,
    radius     = 1,
    clockwise  = TRUE,
    init.angle = 0)


# ����4
# ���� �ڷ� �� ���� ���� ������ ����/���׷����� �ۼ��Ͻÿ�.
# (��, ���� ��������)
for(i in 2:4) {
  barplot(sort(table(diamonds[ , i]), decreasing = TRUE),
          col   = "magenta4",
          main  = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"),
          xlab  = "Frequency",
          xlim  = c(0, 25000),
          horiz = TRUE)

  pie(sort(table(diamonds[ , i]), decreasing = TRUE),
      col        = pal,
      main       = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"),
      radius     = 1,
      clockwise  = TRUE,
      init.angle = 0)
}



# *�׷��� ȭ�� �����ϱ� ----
# par(mfrow = c(nrow, ncol)) : ����� ä����
# par(mfcol = c(nrow, ncol)) : ������ ä����
# mf : multi frame�� ����
par(mfrow = c(3, 2))

for(i in 2:4){
  barplot(sort(table(diamonds[, i]), decreasing = FALSE),
          col = "magenta4",
          main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"),
          xlab = "Frequency",
          xlim = c(0, 25000),
          horiz = TRUE)
  
  pie(sort(table(diamonds[ , i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 0,
      main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"))
}


# �׷��� ȭ�� �ʱ�ȭ
# par(mfrow = c(1, 1))
par(mfrow = c(1, 1))


# *�׷����� pdf ���Ϸ� �����ϱ� ----
# pdf(file = "directory/filename.pdf) : ���� ����
# �׷��� �ۼ�
# dev.off() : ���� ��


pdf(file = "output1.pdf")

for(i in 2:4){
  barplot(sort(table(diamonds[, i]), decreasing = FALSE),
          col = "magenta4",
          main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"),
          xlab = "Frequency",
          xlim = c(0, 25000),
          horiz = TRUE)
  
  pie(sort(table(diamonds[ , i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 0,
      main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"))
}

dev.off()


# pdf �� �������� ���� ���� �׷����� �����ϱ�

pdf(file = "output2.pdf")
par(mfrow = c(3, 2))
for(i in 2:4){
  barplot(sort(table(diamonds[, i]), decreasing = FALSE),
          col = "magenta4",
          main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"),
          xlab = "Frequency",
          xlim = c(0, 25000),
          horiz = TRUE)
  
  pie(sort(table(diamonds[ , i]), decreasing = TRUE),
      col = pal,
      radius = 1,
      clockwise = TRUE,
      init.angle = 0,
      main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"))
}

dev.off()
par(mfrow = c(1, 1))


# *ggplot2 ��Ű���� �̿��ؼ� �׷����� �ۼ��ϱ� ----
# ggplot2::ggplot(data = , mapping = aes(x = variable)) + geom_bar() - aes : �׷����� ������

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut)) +
  geom_bar()

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) + # fill : ��ä���
  geom_bar()

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) +
  geom_bar() +
  theme_classic() # ����� �ٲ���

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) +
  geom_bar() +
  theme_classic() +
  facet_wrap(~color)

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) +
  geom_bar() +
  theme_classic() +
  facet_wrap(~color + clarity)

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) +
  geom_bar() +
  labs(title = "Cut of Diamonds",
       x = "Cut",
       y = "Frequency")


# 2. �Ϻ��� ���� �ڷ��� �м� ----
# 2-1. ǥ = ��ǥ ----
# *�ּҰ�, �ִ밪 ----
min(diamonds$price)
max(diamonds$price)
price.range <- max(diamonds$price) - min(diamonds$price)
price.range

interval.count <- 1 + 3.3*log10(length(diamonds$price))
interval.count

interval.width <- price.range / 17
interval.width

diamonds$price.group <- cut(diamonds$price,
                            breaks = seq(from = 0, to = 19000, by = 1000),
                            right = FALSE)
levels(diamonds$price.group)
# (1) ������ �� ----
sort(table(diamonds$price.group) , decreasing = TRUE)

# (2) ������ ����� ----
round(sort(prop.table(table(diamonds$price.group))*100 , decreasing = TRUE) , digit = 1)

# 2-2. �׷��� ----
# (1) ������׷�(Histogram) ----
# hist(data$variable, breaks = )
hist(diamonds$price)
hist(diamonds$price, xlim = c(0, 20000)) # ������ Sturges Fomular�� ����Ʈ�� �����
?hist
hist.result <- hist(diamonds$price) # list
hist.result$counts # vector
str(hist.result)

# list�� Slicing
# (1) list[index]
# (2) list[[index]]
# (3) list$index

hist(diamonds$price,
     breaks = seq(from = 0, to = 20000, by = 2000))

hist(diamonds$price, breaks = 10) # ������ ����


# (2) ���ڱ׸� ----
# �̻�ġ�� �ִ����� �ľ��� �� �ۼ���
# boxplot(data$variable, range = 1.5) range : IQR�� ���ϴ� ��
boxplot(diamonds$price)
boxplot(diamonds$price, range = 1) # �� ���� ���� �̻�ġ�� ��ڴٴ� ��
boxplot(diamonds$price, range = 2) # �� ���� ���� �̻�ġ�� ��ڴٴ� ��

# ���ܺ� ���ڱ׸�
# boxplot(data$variable ~ data$variable)
# boxplot(���� �ڷ� ~ ���� �ڷ�)
boxplot(diamonds$price ~ diamonds$cut)

# (3) ggplot2 ��Ű���� �̿��� ������׷�/���ڱ׸� ----
# i. ������׷� ----
ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram()

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) # binwidth : ������ ��

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) +
  facet_wrap(~cut) # cut ���� ������׷�


# ii. ���ڱ׸� ----
ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot() # ggplot�� ������ ���ڱ׸��� ǥ�� ����


# 2-3. �����跮 = �����跮 ----
# (1) �߽� = ��ǥ�� ----
# i. ���(Mean) : �̻�ġ�� ������ ���� ����. ----
# mean(data$variable, na.rm = TRUE) - na : missing value
meal.fee <- c(7200, 8000, 7000, NA)
mean(meal.fee)
mean(meal.fee, na.rm = TRUE)
mean(diamonds$price)
# ii. �������(Trimmed Mean) : �ִ�ġ�� �ּ�ġ ���ʿ��� �Ȱ��� ������ �߶� �� ����� ����. �������� �̻�ġ�� �����ϱ� ����. ----

# mean(data$variable, trim = 0.05, na.rm = TRUE)
mean(diamonds$price, trim = 0.05, na.rm = TRUE) # 5% �������(�������)
mean(diamonds$price, trim = 0.10, na.rm = TRUE) # 10% �������

# iii. ������ = ������(Median) : ������հ� �������� Robustness(���Ǽ�: � ���� ���� ������ �� �޴� ����)�� ����. ��հ� �������� ���̰� ���� ���� �̻����� ���ٴ� �� �� �� ����. ----
# median(data$variable, na.rm = TRUE)
median(diamonds$price)

# iv. �ֺ�� = �ֺ�(Mode) : ������ ���� ���� ���� �ִ� ��. �� �� �̻� ���;� ��. �� ���� ���� ���� �� ����. ---- 
# which.max(table(data$variable))
lunch.fee <- c(5000, 3500, 5000, 5000, 3300)
table(lunch.fee)
which.max(table(lunch.fee))
which.max(c(1000, 500, 100, 4000))

which.max(table(diamonds$price))

# prettyR::Mode(data$variable)
prettyR::Mode(diamonds$price)

# (2) ���� = ���� = �ٸ� **** ----
# ���� �ִ� ���ܿ� �ٸ��� �󸶳� �����ұ ��ġȭ�� ��.
# �� ���� ũ��   : ���� �ٸ���
# �� ���� ������ : ����ϴ�
# i. ����(Range) : �ִ밪 - �ּҰ� ----
# diff(range(data$variable))
# diff : difference�� ����
range(diamonds$price) # numeric vector, min, max
range(diamonds$price)[1] #min
range(diamonds$price)[2] #max

diff(c(326, 18823, 326)) # �ð迭 ������ ó���� ����
diff(range(diamonds$price))

# ii. ���������(IQR : Inter Quartile Range) : Q3-Q1. �������� �������� 50%. ----
# IQR(data$variable)
IQR(diamonds$price)

# iii. ǥ���� �л�(Variance) : ������ ������ ��ճ� ��. ������ ����� ���̳ʽ��� ������ ���� ������ ��ǥ�� �� ���� ����. ----
# var(data$variable, na.rm = TRUE)
var(diamonds$price)
# ���� : ��հ� ���� ���� �󸶳� ���̰� ������.
# iv. ǥ���� ǥ������(SD : Standard Deviation) : �л꿡 ��Ʈ�� ���� ��. �л��� ������ �޶����� ������ �� ������ ����. ----
# sd(data$variable, na.rm = TRUE)
sd(diamonds$price)
# ����� ���� : (x1 + x2 + x3) / ������(df : degree of freedom)
# ǥ���� �л�� ǥ������������ �������� n-1�� �ȴ�. ǥ���� �����ϴ� ������ ���ڴ� ǥ���� ����� �������� ��հ� �������� ���� �� ������ �����Ǿ� �������� ���� ����.
# v. ������ ���� ����(MAD : Median Absolute Deviation) : ǥ���������� �̻�ġ�� ������ �� �����鼭�� ��ǥ���� �󸶳� �ٸ��� �� �� �ְ� ��. ----
# �������� �������� ������ ���� �� �� ������ ���밪���� ��ȯ. �� �� �� ����� �������� ���ϸ� �װ� ������ ���� ����.
# mad(diamond$variable)
mad(diamonds$price)

# (3) ������ ��� ----
# i. �ֵ�(Skewness) : ������. ��Ī ���θ� �˷��ִ� ��. ----
# �ֵ� > 0 : �������� ����ִ� ���� / �ֵ� = 0 : �¿��Ī / �ֵ� < 0 : ���������� ����ִ� ����
# e1071::skewness(data$variable)
e1071::skewness(diamonds$price)

# ii. ÷��(Kurtosis) : �߽��� �󸶳� �����Ѱ��� �˷��ִ� ��. ������ �����͵��� �󸶳� �߽ɿ� �����ִ°�. ----
# ÷�� > 0 : �߽ɿ� �����Ͱ� ���� �������� / ÷�� = 0 : �¿��Ī�� ���� ������ ���� / ÷�� < 0 : ������̺��� ������
# e1071::kurtosis(data$variable)
e1071::kurtosis(diamonds$price)

# (4) ��Ÿ ----
# i. �ּҰ� : min(data$variable)
# ii. �ִ밪 : max(data$variable)


# (5) �����跮�� ���ϴ� ���� ������ �Լ��� ----
# i. summary(data$variable) or summary(data) ----
summary(diamonds$price)
# �� ��� �߿��� ��ո� ���� Five Numbers Summary : �ټ���ġ���, �ټ����ڿ��

summary(dplyr::select(diamonds, -(cut:clarity))) # ������ �ڷ���� �� ������ �ڷ���� ���
summary(dplyr::select(diamonds, carat, depth:z))


# ii. by(data$variable, data$variable, functionName) ----
#     by(���� �ڷ�,     ���� �ڷ�,     �Լ���)
# ���ܺ��� ���� �ڷḦ ó����
by(diamonds$price, diamonds$cut, mean)
by(diamonds$price, diamonds$cut, mean, trim = 0.05) # 5% �������
by(diamonds$price, diamonds$cut, sd)
by(diamonds$price, diamonds$cut, summary)
by(diamonds$price, diamonds$cut, hist)
par(mfrow = c(3, 2))
by(diamonds$price, diamonds$cut, hist, col = "blue")
par(mfrow = c(1, 1))


# iii. psych::describe(), describeBy() ----
# psych::describe(data$variable)
# psych::describe(data)
psych::describe(diamonds$price)              # ��������� ��� 10% ����Ʈ
psych::describe(diamonds$price, trim = 0.05) # 5% �������
psych::describe(dplyr::select(diamonds, carat, depth:z))

# psych::describeBy(data$variable, data$variable) - �׷캰 ���
# psych::describeBy(�����ڷ�,      �����ڷ�)
# psych::describeBy(data, data$variable)
psych::describeBy(diamonds$price, diamonds$cut)
psych::describeBy(dplyr::select(diamonds, carat, depth:z),
                  diamonds$cut)

price.by.cut.describe <- psych::describeBy(diamonds$price, diamonds$cut)
str(price.by.cut.describe)
price.by.cut.describe[[1]]

# ������ �����ϱ�
writexl::write_xlsx(price.by.cut.describe[[1]],
                    path = "output1.xlsx")


# iv. dplyr::summarise(data, variableName = fumctionName) ----
dplyr::summarise(diamonds,
                 n    = n(),
                 Mean = mean(price),
                 SD   = sd(price))

# ���ܺ� : dplyr::group_by(variable)
diamonds %>% 
  dplyr::group_by(cut) %>% 
  dplyr::summarise(n    = n(),
                   Mean = mean(price),
                   SD   = sd(price))

# Mean�� �������� �������� �����ϱ�
diamonds %>% 
  dplyr::group_by(cut) %>% 
  dplyr::summarise(n    = n(),
                   Mean = mean(price),
                   SD   = sd(price)) %>% 
  dplyr::arrange(desc(Mean))

# �� ����� ����׷����� ǥ���ϱ�
diamonds %>% 
  dplyr::group_by(cut) %>% 
  dplyr::summarise(n    = n(),
                   Mean = mean(price),
                   SD   = sd(price)) %>% 
  dplyr::arrange(desc(Mean)) %>% 
  ggplot2::ggplot(mapping = aes(x = cut, y = Mean)) +
  geom_bar(stat = "identity")


# ����
# cut�� "Good" �Ǵ� "Very Good"�̰�,
# carat�� 2 �̻��� diamond��
# xyz.sum�� ���ϰ�,
# cut���� xyz�� ���� ������׷��� �ۼ��Ͻÿ�.

diamonds %>% 
  dplyr::filter(cut %in% c("Good", "Very Good"), carat >= 2) %>% 
  dplyr::mutate(xyz.sum = (x + y + z)) %>% 
  ggplot2::ggplot(mapping = aes(x = xyz.sum)) +
  geom_histogram() +
  facet_wrap(~cut)


# cheat sheet ----
# www.rstudio.com

# ���ͳ� ����
# ������          : R����
# k-mooc          : R����
# ��豳����      : sti.kostat.go.kr
# - ���̹�����    : R����, RȰ��
# KRUG            : ���̽��� �׷�
# tidyverse korea : ���̽��� �׷�

# R Conference korea
# Kaggle

# RMarkdown