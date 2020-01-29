##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
## Lecture : EDA(Explorary Data Analysis)                                                ##
##           탐색적 데이터 분석                                                          ##
## Date    : October 10th, 2018                                                          ##
## Author  : Buil Lee                                                                    ##
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##

# 데이터에 숨겨진 패턴(pattern) 또는 특징을 찾아내는 작업
# [패키지] ----
install.packages("ggplot2")      # Visualization : 시각화
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


# [작업공간] ----
setwd("c:/R/BigData/")


# 데이터 읽어오기 ----
# ggplot2::diamonds


# 데이터의 종류(통계적인 관점)
# 1. 질적 자료 = 범주형 자료 : 글자(문자) = character vector or factor, numeric vector
# 2. 양적 자료 : numeric vector


# diamonds
diamonds <- diamonds[ , 1:10]
# 질적 자료 : cut, color, clarity
# 양적 자료 : carat, depth, table, price, x, y, z

# 1. 일변량(Uni-variate) 질적 자료의 분석 ----
# 1-1. 표 = 빈도표 ----
# (1) 빈도(Frequency) ----
# table(data$variable)
table(diamonds$cut) # Numeric vector. 내림차순으로 정렬 가능
sort(table(diamonds$cut), decreasing = TRUE)
head(sort(table(diamonds$cut), decreasing = TRUE), n = 3) # top3 필터링 1
sort(table(diamonds$cut), decreasing = TRUE)[1:3]         # top3 필터링 2. vector의 슬라이싱 활용

sort(table(diamonds$color), decreasing = TRUE)
sort(table(diamonds$clarity), decreasing = TRUE)

for(i in 2:4){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
} # 실행할 땐 for문이 있는 곳에 커서를 두고 할 것.

diamonds[ , 2] # cut
diamonds[ , 3] # color
diamonds[ , 4] # clarity



# (2) 백분율(Percent) ----
# prop.table(frequency) : 비율 : 0 ~ 1
# prop.table(frequency)*100
prop.table(table(diamonds$cut))*100
sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE)
# 백분율의 소수점 자리수는 특별하지 않으면 한 자리를 표현함
round(sort(prop.table(table(diamonds$cut))*100, decreasing = TRUE), digits = 1)

# 문제1
# for를 이용해서 세 개의 질적 자료에 대한 빈도, 백분율을 출력하시오.

for(i in 2:4){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ , i]))*100, decreasing = TRUE), digits = 1))
}

for(i in c("cut", "color", "clarity")){
  print(sort(table(diamonds[ ,i]), decreasing = TRUE))
  print(round(sort(prop.table(table(diamonds[ , i]))*100, decreasing = TRUE), digits = 1))
}

# 1-2. 그래프 ----
# (1) 막대그래프 : 세로 / 가로 ----
#barplot(frequency or percent)
barplot(sort(table(diamonds$cut), decreasing = TRUE))

# i. 막대 색깔 : col = "color" ----
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = "purple")

barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = "magenta4")

# 문제2
# 막대 색깔을 다 다르게 하시오.
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = c("purple", "magenta4", "green", "blue", "red"))


pal <- RColorBrewer::brewer.pal(n = 5, name = "BuGn") # n은 색깔의 갯수
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = pal)

barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col = rainbow(5))


# ii. 차트의 제목 : main = "title" ----
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col  = "magenta4",
        main = "Cut of Diamonds")

# iii. y축 제목 : ylab = "y axis's label" ----
# ylab : y label의 약자
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col  = "magenta4",
        main = "Cut of Diamonds",
        ylab = "Frequency")

# iv. y축 눈금 : ylim = c(min, max) ----
# ylim : y limit의 약자
barplot(sort(table(diamonds$cut), decreasing = TRUE),
        col  = "magenta4",
        main = "Cut of Diamonds",
        ylab = "Frequency",
        ylim = c(0, 25000))

# v. 가로 막대그래프 : horiz = TRUE ----
# horiz : horizontal의 약자
barplot(sort(table(diamonds$cut), decreasing = FALSE),
        col  = "magenta4",
        main = "Cut of Diamonds",
        xlab = "Frequency",
        xlim = c(0, 25000),
        horiz = TRUE)

# 문제3
# for를 이용해서 세 개의 질적 자료에 대한 각각의 막대 그래프를 작성해보세요.
for(i in 2:4) {
  barplot(sort(table(diamonds[ , i]), decreasing = TRUE),
          col  = "magenta4",
          main = paste(stringr::str_to_title(colnames(diamonds)[i]), "of Diamonds"),
          xlab = "Frequency",
          xlim = c(0, 25000),
          horiz = TRUE)
}



# *paste(character1, character2, ..., sep = ) : recycling rule과 vectorization이 일어남 ----
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

tolower("Love is choice.") # 소문자로 변경
toupper("Love is choice.") # 대문자로 변경

stringr::str_to_title("love is choice.")


# (2) 원그래프 ----
# pie(frequency or percent)
pie(sort(table(diamonds$cut), decreasing = TRUE))
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col = pal)

# i. 반지름의 크기 : radius = 0.8 ----
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col    = pal,
    radius = 1)

# ii. 시계 방향 : clockwise = TRUE ----
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col       = pal,
    radius    = 1,
    clockwise = TRUE)

# iii. 첫째 조각의 시작 각도 : init.angle = ----
# 시계반대방향 : 0
# 시계 방향    : 90
pie(sort(table(diamonds$cut), decreasing = TRUE),
    col        = pal,
    radius     = 1,
    clockwise  = TRUE,
    init.angle = 0)


# 문제4
# 질적 자료 세 개에 대한 각각의 막대/원그래프를 작성하시오.
# (단, 제목도 나오도록)
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



# *그래픽 화면 분할하기 ----
# par(mfrow = c(nrow, ncol)) : 행부터 채워짐
# par(mfcol = c(nrow, ncol)) : 열부터 채워짐
# mf : multi frame의 약자
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


# 그래프 화면 초기화
# par(mfrow = c(1, 1))
par(mfrow = c(1, 1))


# *그래프를 pdf 파일로 저장하기 ----
# pdf(file = "directory/filename.pdf) : 저장 시작
# 그래프 작성
# dev.off() : 저장 끝


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


# pdf 한 페이지에 여러 개의 그래프를 저장하기

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


# *ggplot2 패키지를 이용해서 그래프를 작성하기 ----
# ggplot2::ggplot(data = , mapping = aes(x = variable)) + geom_bar() - aes : 그래프의 설정값

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut)) +
  geom_bar()

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) + # fill : 색채우기
  geom_bar()

ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, fill = cut)) +
  geom_bar() +
  theme_classic() # 배경을 바꿔줌

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


# 2. 일변량 양적 자료의 분석 ----
# 2-1. 표 = 빈도표 ----
# *최소값, 최대값 ----
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
# (1) 구간의 빈도 ----
sort(table(diamonds$price.group) , decreasing = TRUE)

# (2) 구간의 백분율 ----
round(sort(prop.table(table(diamonds$price.group))*100 , decreasing = TRUE) , digit = 1)

# 2-2. 그래프 ----
# (1) 히스토그램(Histogram) ----
# hist(data$variable, breaks = )
hist(diamonds$price)
hist(diamonds$price, xlim = c(0, 20000)) # 구간은 Sturges Fomular가 디폴트로 적용됨
?hist
hist.result <- hist(diamonds$price) # list
hist.result$counts # vector
str(hist.result)

# list의 Slicing
# (1) list[index]
# (2) list[[index]]
# (3) list$index

hist(diamonds$price,
     breaks = seq(from = 0, to = 20000, by = 2000))

hist(diamonds$price, breaks = 10) # 구간의 개수


# (2) 상자그림 ----
# 이상치가 있는지를 파악할 때 작성함
# boxplot(data$variable, range = 1.5) range : IQR에 곱하는 값
boxplot(diamonds$price)
boxplot(diamonds$price, range = 1) # 더 많은 값을 이상치로 잡겠다는 것
boxplot(diamonds$price, range = 2) # 더 적은 값을 이상치로 잡겠다는 것

# 집단별 상자그림
# boxplot(data$variable ~ data$variable)
# boxplot(양적 자료 ~ 질적 자료)
boxplot(diamonds$price ~ diamonds$cut)

# (3) ggplot2 패키지를 이용한 히스토그램/상자그림 ----
# i. 히스토그램 ----
ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram()

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) # binwidth : 구간의 폭

ggplot2::ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 2000) +
  facet_wrap(~cut) # cut 별로 히스토그램


# ii. 상자그림 ----
ggplot2::ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot() # ggplot은 구간별 상자그림만 표현 가능


# 2-3. 기술통계량 = 요약통계량 ----
# (1) 중심 = 대표값 ----
# i. 평균(Mean) : 이상치의 영향을 많이 받음. ----
# mean(data$variable, na.rm = TRUE) - na : missing value
meal.fee <- c(7200, 8000, 7000, NA)
mean(meal.fee)
mean(meal.fee, na.rm = TRUE)
mean(diamonds$price)
# ii. 절사평균(Trimmed Mean) : 최대치와 최소치 양쪽에서 똑같은 범위로 잘라낸 후 평균을 구함. 데이터의 이상치를 제외하기 위해. ----

# mean(data$variable, trim = 0.05, na.rm = TRUE)
mean(diamonds$price, trim = 0.05, na.rm = TRUE) # 5% 절사평균(절삭평균)
mean(diamonds$price, trim = 0.10, na.rm = TRUE) # 10% 절사평균

# iii. 중위수 = 중위값(Median) : 절사평균과 중위값은 Robustness(강건성: 어떤 값에 의해 영향을 덜 받는 성질)가 강함. 평균과 중위수가 차이가 많이 나면 이상차가 많다는 걸 알 수 있음. ----
# median(data$variable, na.rm = TRUE)
median(diamonds$price)

# iv. 최빈수 = 최빈값(Mode) : 동일한 값이 가장 많이 있는 것. 두 번 이상 나와야 함. 두 개의 값이 나올 수 있음. ---- 
# which.max(table(data$variable))
lunch.fee <- c(5000, 3500, 5000, 5000, 3300)
table(lunch.fee)
which.max(table(lunch.fee))
which.max(c(1000, 500, 100, 4000))

which.max(table(diamonds$price))

# prettyR::Mode(data$variable)
prettyR::Mode(diamonds$price)

# (2) 퍼짐 = 산포 = 다름 **** ----
# 관심 있는 집단에 다름이 얼마나 존재할까를 수치화한 값.
# 이 값이 크면   : 많이 다르다
# 이 값이 작으면 : 비슷하다
# i. 범위(Range) : 최대값 - 최소값 ----
# diff(range(data$variable))
# diff : difference의 약자
range(diamonds$price) # numeric vector, min, max
range(diamonds$price)[1] #min
range(diamonds$price)[2] #max

diff(c(326, 18823, 326)) # 시계열 데이터 처리에 유용
diff(range(diamonds$price))

# ii. 사분위범위(IQR : Inter Quartile Range) : Q3-Q1. 중위값을 기준으로 50%. ----
# IQR(data$variable)
IQR(diamonds$price)

# iii. 표본의 분산(Variance) : 편차의 제곱을 평균낸 것. 편차의 평균은 마이너스값 때문에 실제 편차를 대표할 수 없기 때문. ----
# var(data$variable, na.rm = TRUE)
var(diamonds$price)
# 편차 : 평균과 실제 값이 얼마나 차이가 나는지.
# iv. 표본의 표준편차(SD : Standard Deviation) : 분산에 루트를 씌운 것. 분산은 단위가 달라지기 때문에 잘 쓰이지 않음. ----
# sd(data$variable, na.rm = TRUE)
sd(diamonds$price)
# 평균의 개념 : (x1 + x2 + x3) / 자유도(df : degree of freedom)
# 표본의 분산과 표준편차에서는 자유도가 n-1이 된다. 표본을 구성하는 마지막 인자는 표본의 평균이 모집단의 평균과 같아지기 위해 한 가지로 강제되어 자유도가 없기 때문.
# v. 중위수 절대 편차(MAD : Median Absolute Deviation) : 표준편차보다 이상치의 영향을 덜 받으면서도 대표값과 얼마나 다른지 알 수 있게 함. ----
# 중위수와 데이터의 편차를 구한 후 그 편차를 절대값으로 변환. 그 후 그 결과의 중위수를 구하면 그게 중위수 절대 편차.
# mad(diamond$variable)
mad(diamonds$price)

# (3) 분포의 모양 ----
# i. 왜도(Skewness) : 기울어짐. 대칭 여부를 알려주는 값. ----
# 왜도 > 0 : 왼쪽으로 쏠려있는 형태 / 왜도 = 0 : 좌우대칭 / 왜도 < 0 : 오른쪽으로 쏠려있는 형태
# e1071::skewness(data$variable)
e1071::skewness(diamonds$price)

# ii. 첨도(Kurtosis) : 중심이 얼마나 뾰족한가를 알려주는 값. 양적인 데이터들이 얼마나 중심에 몰려있는가. ----
# 첨도 > 0 : 중심에 데이터가 몰려 뾰족해짐 / 첨도 = 0 : 좌우대칭에 보통 정도의 높이 / 첨도 < 0 : 보통높이보다 낮아짐
# e1071::kurtosis(data$variable)
e1071::kurtosis(diamonds$price)

# (4) 기타 ----
# i. 최소값 : min(data$variable)
# ii. 최대값 : max(data$variable)


# (5) 기술통계량을 구하는 데에 유용한 함수들 ----
# i. summary(data$variable) or summary(data) ----
summary(diamonds$price)
# 이 결과 중에서 평균만 빼면 Five Numbers Summary : 다섯수치요약, 다섯숫자요약

summary(dplyr::select(diamonds, -(cut:clarity))) # 질적인 자료들을 뺀 양적인 자료들의 요약
summary(dplyr::select(diamonds, carat, depth:z))


# ii. by(data$variable, data$variable, functionName) ----
#     by(양적 자료,     질적 자료,     함수명)
# 집단별로 양적 자료를 처리함
by(diamonds$price, diamonds$cut, mean)
by(diamonds$price, diamonds$cut, mean, trim = 0.05) # 5% 절사평균
by(diamonds$price, diamonds$cut, sd)
by(diamonds$price, diamonds$cut, summary)
by(diamonds$price, diamonds$cut, hist)
par(mfrow = c(3, 2))
by(diamonds$price, diamonds$cut, hist, col = "blue")
par(mfrow = c(1, 1))


# iii. psych::describe(), describeBy() ----
# psych::describe(data$variable)
# psych::describe(data)
psych::describe(diamonds$price)              # 절사평균의 경우 10% 디폴트
psych::describe(diamonds$price, trim = 0.05) # 5% 절사평균
psych::describe(dplyr::select(diamonds, carat, depth:z))

# psych::describeBy(data$variable, data$variable) - 그룹별 요약
# psych::describeBy(양적자료,      질적자료)
# psych::describeBy(data, data$variable)
psych::describeBy(diamonds$price, diamonds$cut)
psych::describeBy(dplyr::select(diamonds, carat, depth:z),
                  diamonds$cut)

price.by.cut.describe <- psych::describeBy(diamonds$price, diamonds$cut)
str(price.by.cut.describe)
price.by.cut.describe[[1]]

# 엑셀에 저장하기
writexl::write_xlsx(price.by.cut.describe[[1]],
                    path = "output1.xlsx")


# iv. dplyr::summarise(data, variableName = fumctionName) ----
dplyr::summarise(diamonds,
                 n    = n(),
                 Mean = mean(price),
                 SD   = sd(price))

# 집단별 : dplyr::group_by(variable)
diamonds %>% 
  dplyr::group_by(cut) %>% 
  dplyr::summarise(n    = n(),
                   Mean = mean(price),
                   SD   = sd(price))

# Mean을 기준으로 내림차순 정렬하기
diamonds %>% 
  dplyr::group_by(cut) %>% 
  dplyr::summarise(n    = n(),
                   Mean = mean(price),
                   SD   = sd(price)) %>% 
  dplyr::arrange(desc(Mean))

# 이 결과를 막대그래프로 표현하기
diamonds %>% 
  dplyr::group_by(cut) %>% 
  dplyr::summarise(n    = n(),
                   Mean = mean(price),
                   SD   = sd(price)) %>% 
  dplyr::arrange(desc(Mean)) %>% 
  ggplot2::ggplot(mapping = aes(x = cut, y = Mean)) +
  geom_bar(stat = "identity")


# 문제
# cut은 "Good" 또는 "Very Good"이고,
# carat은 2 이상인 diamond의
# xyz.sum을 구하고,
# cut별로 xyz에 대한 히스토그램을 작성하시오.

diamonds %>% 
  dplyr::filter(cut %in% c("Good", "Very Good"), carat >= 2) %>% 
  dplyr::mutate(xyz.sum = (x + y + z)) %>% 
  ggplot2::ggplot(mapping = aes(x = xyz.sum)) +
  geom_histogram() +
  facet_wrap(~cut)


# cheat sheet ----
# www.rstudio.com

# 인터넷 교육
# 유투브          : R강의
# k-mooc          : R강의
# 통계교육원      : sti.kostat.go.kr
# - 사이버강의    : R기초, R활용
# KRUG            : 페이스북 그룹
# tidyverse korea : 페이스북 그룹

# R Conference korea
# Kaggle

# RMarkdown