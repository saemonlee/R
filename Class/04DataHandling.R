##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
## Lecture : Data Handling = Data Pre-processing                                         ##
##                                                                                       ##
## Date    : October 8th, 2018                                                           ##
## Author  : Buil Lee                                                                    ##
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##

# 패키지 설치/로딩하기 ----
install.packages("ggplot2")
install.packages("DT")
install.packages("dplyr")
install.packages("writexl")
library(ggplot2)
library(DT)
library(dplyr)
library(writexl)

# 작업공간 ----
setwd("c:/R/BigData/")


# 데이터 읽어오기 ----
# ggplot2::diamonds


# 1. 데이터 전체 보기 ----
# 1-1. data ----
# console에 출력이 됨
# 데이터가 적을 때에 사용함
diamonds

# 1-2. View(data) ----
# editor window에 출력이 됨
# 데이터가 많을 때도 사용함
View(diamonds)

# 1-3. DT::datatable(data) ----
# web 형태로 출력이 됨
DT::datatable(diamonds)



# 2. 데이터의 일부 보기 ----
# 2-1. head(data, n = 6) ----
# console에 출력이 됨
head(diamonds) # 디폴트가 6개
head(diamonds, n = 10)

# 2-2. tail(data, n - 6) ----
# console에 출력이 됨
tail(diamonds)
tail(diamonds, n = 10)

# 2-3. View(head(data, n = 6) or tail(data, n = 6)) ----
# editor window에 출력이 됨
View(head(diamonds, n = 10))
View(tail(diamonds, n = 10))

# 2-4. DT::datatable(head(data, n = 6) or tail(data, n = 6)) ----
# web 형태로 출력이 됨
DT::datatable(head(diamonds, n = 10))
DT::datatable(tail(diamonds, n = 10))


# 3. 데이터의 구조(structure) 보기 ----
# str(data)
str(diamonds)


# 4. 데이터의 입력오류 체크하기 ----
# summary(data)
summary(diamonds) # factor로 만들어야 범주별 집계가 가능함

id      <- 1:5
address <- c("고양시", "강남구", "용산구", "강서구", "경주시")
dwell   <- c(26, 20, 3, 1, 3)
home <- data.frame(id, address, dwell, stringsAsFactors = FALSE) #stringAsFactors : FALSE면 스트링을 강제로 factor로 바꾸지 말라는 표시. 
home
str(home)
summary(home)
home$address <- as.factor(home$address) # as.factor 해당열을 강제로 factor로 바꾸는 함수


# 5. 데이터의 속성 ----
# 5-1. 행의 개수 : nrow(data) ----
# 결과 : numeric vector
nrow(diamonds)

# 5-2. 열 = 변수의 개수 : ncol(data) ----
# 결과 : numeric vector
ncol(diamonds)

# 5-3. 행의 이름 : rownames(data) ----
# 결과 : character vector
rownames(diamonds)

# 5-4. 열 = 변수의 이름 : colnames(data) ----
# 결과 : character vector
colnames(diamonds)

# 5-5. 차원(dimension) : dim(data) ----
# 결과 : numeric vector
dim(diamonds)
dim(diamonds)[1] # 행의 개수
dim(diamonds)[2] # 열의 개수

# 5-6. 차원의 이름 : dimnames(data) ----
# 결과 : list
dimnames(diamonds)
dimnames(diamonds)[1] # 행의 이름 : List
dimnames(diamonds)[[1]] # 행의 이름 : Vector
dimnames(diamonds)[2] # 행의 이름 : List
dimnames(diamonds)[[2]] # 행의 이름 : Vector


# 6. 데이터의 slicing ----
# data[rowIndex, colIndex]

# 6-1. 열 = 변수 ----
# data[ , colIndex]
# (1) 열 = 변수의 위치를 알 때
diamonds[ , 1]
diamonds[ , 2]

# 문제1
# 1, 9, 10번째 열을 한 번에 가져오세요.
diamonds[ , c(1, 9, 10)]

# 문제2
# 4-8번째 열을 한 번에 가져오세요.
diamonds[ , 4:8]

# 문제3
# 홀수 번째 열을 한 번에 가져오세요.
diamonds[ , seq(from = 1, to = ncol(diamonds), by = 2)]


# (2) 열 = 변수의 이름을 알 때
diamonds[ , "carat"]
diamonds[ , "cut"]

# 문제4
# x, y, z라는 세 개의 변수를 한 번에 가져오세요.
diamonds[ , c("x", "y", "z")]


# (3) 열 = 변수 이름에 규칙(패턴)이 있을 때
# grep(pattern, textData, value = TRUE or FALSE)
colnames(diamonds)

# i. 변수명 중에서 t라는 글자를 포함하는 변수명은?
# carat, cut, clarity, depts, table
# 1, 2, 4, 5, 6
grep("t", colnames(diamonds), value = TRUE)  # 변수명
grep("t", colnames(diamonds), value = FALSE) # 변수명의 위치
diamonds[ , grep("t", colnames(diamonds), value = TRUE)]
diamonds[ , grep("t", colnames(diamonds), value = FALSE)]

# ii. 변수명 중에서 t라는 글자로 시작하는 변수명은?
# table
# 6
grep("^t", colnames(diamonds), value = TRUE)  # 변수명
grep("^t", colnames(diamonds), value = FALSE) # 변수명의 위치
diamonds[ , grep("^t", colnames(diamonds), value = TRUE)]
diamonds[ , grep("^t", colnames(diamonds), value = FALSE)]

# iii. 변수명 중에서 t라는 글자로 끝나는 변수명은?
# carat, cut
# 1, 2
grep("t$", colnames(diamonds), value = TRUE)  # 변수명
grep("t$", colnames(diamonds), value = FALSE) # 변수명의 위치
diamonds[ , grep("t$", colnames(diamonds), value = TRUE)]
diamonds[ , grep("t$", colnames(diamonds), value = FALSE)]


# (4) dplyr::select(data, variable1, variable2, ...)
dplyr::select(diamonds, cut)
dplyr::select(diamonds, cut, color)
dplyr::select(diamonds, price:z)          # price부터 z까지 가져옴
dplyr::select(diamonds, -(price:z))       # 해당 변수를 뺀 나머지를 가져옴
dplyr::select(diamonds, starts_with("t")) # t로 시작하는 변수
dplyr::select(diamonds, contains("t"))    # t를 포함하고 있는 변수
dplyr::select(diamonds, ends_with("t"))   # t로 끝나는 변수


# 6-2. 행 ----
# data[rowIndex, ]

# (1) 행의 위치를 알 때
diamonds[1 , ]
diamonds[c(1, 9, 10) , ]
diamonds[4:8 , ]
diamonds[seq(from = 1, to = nrow(diamonds), by = 100), ]

# (2) 조건을 만족하는 경우
# i. cut이 "Ideal"인 데이터
diamonds[diamonds$cut == "Ideal" , ]

# ii. price가 18000 이상인 데이터
diamonds[diamonds$price >= 18000 , ]

# iii. cut은 "Ideal"이고, price는 18000 이상인 데이터
diamonds[(diamonds$cut == "Ideal") & (diamonds$price >= 18000) , ]

# iv. cut은 "Ideal" 또는 price는 18000 이상인 데이터
diamonds[(diamonds$cut == "Ideal") | (diamonds$price >= 18000) , ]

# 문제5
# cut이 "Ideal" 또는 "Good"인 데이터
diamonds[(diamonds$cut == "Ideal") | (diamonds$cut == "Good") , ]
diamonds[diamonds$cut == c("Ideal", "Good") , ]   # 틀림
diamonds[diamonds$cut %in% c("Ideal", "Good") , ] # %in% : 부분집합 부호 개념


# (3) dplyr::filter(data, 조건)
dplyr::filter(diamonds, cut == "Ideal")
dplyr::filter(diamonds, price >= 18000)
dplyr::filter(diamonds, cut == "Ideal", price >= 18000)
dplyr::filter(diamonds, cut == "Ideal" | price >= 18000)
dplyr::filter(diamonds, cut %in% c("Ideal", "Good"))


# 6-3. 행과 열 ----
# data[rowIndex, colIndex]
# cut이 "Ideal"이고, price는 18000이상의 데이터의 x, y, z라는 변수(열)를 가져오세요.

diamonds[(diamonds$cut == "Ideal") & (diamonds$price >= 18000) , c("x", "y", "z") ]

# (2) dplyr::filter(), dplyr::select() - filter가 먼저 와야 함. 데이터를 먼저 저장해야.
diamonds2 <- dplyr::filter(diamonds, cut == "Ideal", price >= 18000)
dplyr::select(diamonds2, x:z)

# %>% : pipe, chain - 중간에 불필요한 데이터를 생성하지 않아 메모리를 뺏기지 않음 / ctrl+shift+M
diamonds %>%
  dplyr::filter(cut == "Ideal", price >= 18000) %>%
  dplyr::select(x:z) %>% 
  head()


# 7. 새로운 변수(열) 만들기 ----
# data$newVariable <- 작업

# 7-1. 연산 ----
diamonds$xyz.mean  <- (diamonds$x + diamonds$y + diamonds$z) / 3 # x, y, z 열의 평균
diamonds$xyz.mean2 <- rowMeans(diamonds[ , c("x", "y", "z")])   # x, y, z 열의 평균2
# rowSums(), colMeans(), colSums()

# 7-2. 변환(Transformation) ----
# Box-Cox Transformation

# (1) log 변환  : 비대칭 정보를 좀 더 대칭적으로 축소시킬 수 있음
diamonds$price.log10 <- log10(diamonds$price)

# (2) root 변환 : log보다는 덜 변함
diamonds$price.root <- sqrt(diamonds$price)

# (3) 1/y 변환
diamonds$price.inverse <- 1 / diamonds$price

# 7-3. 구간의 정보 ----
# (1) cut()
# data$newVariable <- cut(data$variable,
#                         breaks = 구간의 정보,
#                         right  = TRUE or FALSE)
diamonds$price.group <- cut(diamonds$price,
                            breaks = seq(from = 0, to = 20000, by = 5000),
                            right = FALSE) # 이상 ~ 미만 구간
# cut() 함수를 사용하면 새로운 변수는 무조건 Factor가 됨
levels(diamonds$price.group)
levels(diamonds$price.group) <- c("5000미만",              # 각 구간에 이름 붙이기
                                  "5000이상~10000미만",
                                  "10000이상~15000미만",
                                  "15000이상")
table(diamonds$price.group)

# 문제8
# carat -> carat.group
# 0   ~ 1.5 : 1.5 미만
# 1.5 ~ 3.0 : 1.5 이상 ~ 3.0 미만
# 3.0 ~ 4.5 : 3.0 이상 ~ 4.5 미만
# 4.5 ~ 6.0 : 4.5 이상 ~ 6.0 미만
diamonds$carat.group <- cut(diamonds$carat,
                            breaks = seq(from = 0, to = 6, by = 1.5),
                            right = FALSE)

levels(diamonds$carat.group) <- c("1.5 미만",
                                  "1.5 이상 ~ 3.0 미만",
                                  "3.0 이상 ~ 4.5 미만",
                                  "6.0 미만")

# (2) ifelse()
# i. 구간의 정보
# price -> price.group2
# 0 이상    ~ 5000 미만  : Cheap
# 5000 이상 ~ 20000 미만 : Non-cheap
diamonds$price.group2 <- ifelse(diamonds$price < 5000,
                                "Cheap",
                                "Non-cheap")

# price -> price.group3
# 0 이상 ~ 5000 미만 : Cheap
# 5000 이상 ~ 15000 미만 : Medium
# 15000 이상 ~ 20000 미만 : Expensive
diamonds$price.group3 <- ifelse(diamonds$price < 5000,
                                "Cheap",
                                ifelse(diamonds$price < 15000,
                                       "Medium",
                                       "Expensive"))

# ii. 다양한 범주를 축소할 때
# cut       -> cut.group
# Fair      -> Non-Ideal
# Good      -> Non-Ideal
# Very Good -> Non-Ideal
# Premium   -> Non-Ideal
# Ideal     -> Ideal

# ifelse(조건, 조건이 참일 때 가지는 값, 조건이 거짓일 때 가지는 값)
diamonds$cut.group <- ifelse(diamonds$cut == "Ideal",
                             "Ideal",
                             "Non-Ideal")


# 7-4. dplyr::mutate(data, newVariable = 연산, 변환 등) - 없었던 새로운 변수가 생김 ----
diamonds <- diamonds %>% 
  dplyr::mutate(carat.log = log10(carat))

diamonds <- diamonds %>% 
  dplyr::mutate(xyz.sum = x + y + z)


# 8. 변수 삭제하기 ----
# 8-1. Slicing ----
# diamonds <- diamonds[ , c("carat", "cut", "color")]

# 8-2. data$variable <- NULL
diamonds$cut.group    <- NULL
diamonds$price.group2 <- NULL
diamonds$price.group3 <- NULL


# 9. 외부 데이터로 저장하기 ----
# 9-1. txt ----
# write.table(data,
#             File      = "directory/filename.txt",
#             sep       = ",",
#             row.names = FALSE) 행의 이름을 저장하지 않음
write.table(diamonds,
            file      = "diamonds_1010.txt",
            sep       = ",",
            row.names = FALSE)


# 9-2. csv ----
# write.csv(data,
#           file      = "directory/filename.txt",
#           row.names = FALSE)
write.csv(diamonds,
          file      = "diamonds_1010.csv",
          row.names = FALSE)


# 9-3. excel ----
# writexl::write_xlsx(data,
#                     path = "directory/filename.xlsx")
writexl::write_xlsx(diamonds,
                    path = "diamonds_1010.xlsx")


# 10. RData로 저장하기 ----
# save(data,
#      file = "directory/filename.RData")
save(diamonds, file = "diamonds_1010.RData")


# 11. RData 불러오기(읽어오기) ----
# load(file = "directory/filename.RData")
load(file = "diamonds_1010.RData")


# 12. 데이터의 목록 보기 ----
# 사용자가 만든 데이터
# ls()
# ls : list segment의 약자
# ls()의 결과는 character vector
ls()


# 13. 데이터 삭제하기 ----
# 13-1. 하나 또는 몇 개의 데이터 삭제하기 ----
# rm(data1, data2, ...)
# rm : remove의 약자

rm(traffic, tab, survey)

# 13-2. 모든 데이터 삭제하기 ----
# rm(list = ls())
rm(list = ls())


# 14. 데이터의 정렬 ----
# 14-1. Vector의 정렬 ----
# sort(vector, decreasing = FALSE) : default, 오름차순
# sort(vector, decreasing = TRUE)  : 내림차순
feet <- c(265, 285, 240, 270, 265)
feet
sort(feet)
sort(feet, decreasing = FALSE)
sort(feet, decreasing = TRUE)

# 14-2. Data.Frame의 정렬 ----
# order(data$variable, decreasing = FALSE) : default, 오름차순
# order(data$variable, decreasing = TRUE)  : 내림차순
# data[order(data$variable, decreasing = FALSE), ]
# data[order(data$variable, decreasing = TRUE), ]
order(feet, decreasing = FALSE)
feet[order(feet, decreasing = FALSE)]
feet[order(feet, decreasing = TRUE)]

# cut : 오름차순
diamonds[order(diamonds$cut, decreasing = FALSE), ]

# cut : 오름차순
diamonds[order(diamonds$cut, decreasing = TRUE), ]

# cut : 오름차순, price : 오름차순
diamonds[order(diamonds$cut, diamonds$price, decreasing = FALSE), ]

# cut : 내림차순, price : 내림차순
diamonds[order(diamonds$cut, diamonds$price, decreasing = TRUE), ]

# cut : 오름차순, price : 내림차순
diamonds[order(diamonds$cut, -diamonds$price, decreasing = FALSE), ] # 값이 숫자로 되어 있을 때만 -를 붙일 수 있음

# cut : 내림차순, price : 오름차순
diamonds[order(diamonds$cut, -diamonds$price, decreasing = TRUE), ]

# cut : 오름차순, color : 내림차순
# R의 기본 기능에서는 못함
# dplyr::arrange(data, variable, desc(variable))
dplyr::arrange(diamonds, cut, desc(color))
diamonds %>% 
  dplyr::arrange(cut, desc(color))


# xyz.mean이라는 새로운 변수를 만들고,
# 이 값을 기준으로 내림차순 정렬한 다음에,
# 상위 5개만 보이도록 하시오.

diamonds %>% mutate(xyz.mean = (x + y + z)/3) %>% 
  dplyr::arrange(desc(xyz.mean)) %>%
  head(n = 5)


# 15. 데이터 합치기 ----
# 15-1. rbind(data1, data2) ----
# 데이터를 위/아래로 합침
# 데이터의 변수명, 변수의 위치가 동일해야 함
DF1 <- data.frame(id     = 1:3,
                  age    = c(10, 20, 30),
                  gender = c("F", "F", "M"))

DF2 <- data.frame(id     = 4:7,
                  age    = c(40, 50, 60, 70),
                  gender = c("F", "M", "F", "M"))
DF1; DF2
DF3 <- rbind(DF1, DF2)
DF3

# 15-2. cbind(data1, data2) ----
# 데이터를 왼쪽/오른쪽으로 합침
# 동일한 행이어야 함
DF4 <- data.frame(id  = c("김준회", "이민수", "김경태"),
                  age = c(27, 26, 27),
                  bt  = c("O", "B", "O"))

DF5 <- data.frame(address = c("부천시", "시흥시", "강남구"),
                  company = c("인사이트마이닝", "삼성전자", "삼성전자"))

DF6 <- cbind(DF4, DF5)
DF6

# 15-3. merge(data1, data2, by = ) ----
DF7 <- data.frame(id     = c(1, 2, 4, 5),
                  age    = c(10, 20, 40, 50),
                  gender = c("M", "M", "F", "F"))

DF8 <- data.frame(id    = c(1, 4, 7, 8, 9),
                  money = c(1000, 4000, 7000, 8000, 9000),
                  food  = c("맥주", "노트북", "AUDI7", "맥주", "헬리콥터"))

DF7; DF8

# (1) inner join
# merge(data1, data2, by = "primaryKey")
DF9 <- merge(DF7, DF8, by = "id")
DF9

# (2) outer join : full join
# merge(data1, data2, by = "primaryKey", all = TRUE)
DF10 <- merge(DF7, DF8, by = "id", all = TRUE)
DF10

# (3) outer join : left join
# merge(data1, data2, by = "primaryKey", all.x = TRUE)
DF11 <- merge(DF7, DF8, by = "id", all.x = TRUE)
DF11

# (4) outer join : right join
# merge(data1, data2, by = "primaryKey", all.y = TRUE)
DF12 <- merge(DF7, DF8, by = "id", all.y = TRUE)
DF12
