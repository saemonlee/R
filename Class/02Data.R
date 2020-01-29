##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
## Lecture : Data                                                                        ##
##                                                                                       ##
## Date    : October 5th, 2018                                                           ##
## Author  : Buil Lee                                                                    ##
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##

# 1. Vector      *****
# 2. Factor      **
# 3. Matrix
# 4. Array
# 5. Data.Frame  *****
# 6. List        **
# 7. Tibble
# 8. Data.Table
# 9. TS : Time Series, 시계열


# 1. Vector ----
# 하나의 열(column)로 구성되어 있음. 1차원 구조.
# 하나의 데이터 유형만 가짐. 동시에 가질 수 없음.
# 데이터 분석의 기본 단위.

# 1-1. Vector 만들기 ----
# (1) 하나의 값(element)으로 이루어진 Vector
v1 <- 10
v2 <- "buillee"
v3 <- TRUE

# (2) 두 개 이상의 값으로 이루어진 Vector
# i. c(element1, element2, ....)
# c : combine, concatenate의 약자
# numeric, character, logical vector를 만들 수 있음
# element들 간의 규칙이 없을 경우
age <- c(26, 30, 32)
food <- c("파스타", "스테이크", "샌드위치")
marry <- c(TRUE, FALSE, TRUE)

age2 <- c(27, 34, 27)
age3 <- c(age, age2)
age3

c(10, "Lee", FALSE) # 가능. 전부 character로
c(10, FALSE)        # 전부 numeric만



# ii. :
# numeric vector에만 적용됨
# start:end
# 1씩 증가되거나 또는 1씩 감소되는 값으로 이루어진 vector
# start < end : 1씩 증가
# start > end : 1씩 감소
# start = end : start or end
# start에 있는 숫자부터 시작해서 end에 있는 숫자를 넘지 않을 때까지 1씩 증가 또는 1씩 감소됨
1:5 # 1, 2, 3, 4, 5
1:100
5:1

# 문제1
# -2.3:1의 결과는? -2.3, -1.3, -0.3, 0.7
-2.3:1

# 문제2
# 1:-2.3의 결과는? 1, 0, -1, -2
1:-2.3


# iii. seq(from = , to = , by = )
# sequence의 약자
# :의 확장
# numeric vector에만 적용됨
# from : start
# to   : end
# by   : 증가 또는 감소의 폭
# from에 있는 숫자부터 시작해서 to에 있는 숫자를 넘지 않을 때까지 by만큼 증가 또는 감소되는 숫자들로 이루어진 Vector

seq(from = 1, to = 5, by = 0.5)

# 문제3
# 5부터 시작해서 1을 넘지 않을 때까지 0.5씩 감소하는 vector
seq(from = 5, to = 1, by = -0.5)


# iv. sequence(number)
# numeric vector에만 적용됨
# 1 ~ number 사이의 정수로 이루어진 Vector
# number가 음수이면 error 발생
sequence(5)
sequence(3.7)
sequence(1)
sequence(-3)

# 문제4
# 1, 1, 2, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 6으로 이루어진 vector를 만드시오.
#
sequence(1:6)



# v. rep(vector, times = , each = )
# replicate의 약자
# rep 함수 안에 지정된 vector를 times 또는 each 방식으로 복사해서 vector를 만듬
# numeric, character, logical vector를 만들 수 있음.

rep(1, times = 10)
rep(1, each = 10)

rep(1:2, times = 5)
rep(1:2, each = 5)

# 문제5
# "A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C"를 가지는 vector를 만드시오.

rep(c("A", "B", "C"), times = 4)

rep(1:3, time = 5, each = 3) # each가 먼저 작동

# 문제6
# 1 : 100개,
# 2 : 53개,
# 3 : 13개로 이루어진 Vector를 만드세요.
c(rep(1, times = 100), rep(2, times = 53), rep(3, times = 13))
rep(1:3, times = c(100, 53, 13))




# 1-2 Vector의 속성 ----
# (1) 데이터의 개수 : length(vector)
length(age3)

# (2) element의 이름 : names(vector)
income <- c(10000, 3500, 4000)
names(income)

# NULL : object가 없다는 뜻
# object : data, graph
names(income) <- c("김준회", "김민수", "김경태")
income
names(income) <- NULL


# 1-3 Vector의 Index ----
# 첫 번째 element를 1로 인식함. c, java, python은 0으로 인식.


# 1-4 Vector의 Slicing ----
# vector[index]
height <- c(170, 171, 178, 174, 180, 163, 181, 168, 168)
height[1]
height[3]

# 문제7
# 1, 4, 5, 8번째 값을 한 번에 가져오세요.
height[c(1, 4, 5, 8)]

# 문제8
# 4 ~ 9번째의 값을 한 번에 가져오세요.
height[4:9]

# 문제9
# 짝수 번째의 값을 한 번에 가져오세요.
height[seq(from = 2, to = 9, by = 2)]
height[seq(from = 2, to = length(height), by = 2)]


# 1-5. Vector의 연산 ----
v1 <- 1:3
v2 <- 4:6
v1 + v2 # Vectorization : 벡터

v3 <- 1:6
v1 + v3 # Recycling Rule : 재사용 규칙

v4 <- 1:8
v1 + v4



# 2. Factor ----
# 하나의 열로 구성되어 있음. 1차원 구조
# 집단으로 인식함
# 범주형 자료 = 질적 자료 = 그룹 = 집단

# 2-1. Factor 만들기 ----
# Factor(vector, labels = , levels = , ordered = )
bt <- c("b", "ab", "b", "a", "o", "o", "ab")
bt

bt.factor1 <- factor(bt)
bt.factor1

bt.factor2 <- factor(bt,
                     labels = c("A형", "AB형", "B형", "O형"))
bt.factor2

bt.factor3 <- factor(bt,
                     levels = c("a", "b", "ab", "o"))
bt.factor3

bt.factor4 <- factor(bt,
                     levels = c("a", "b", "ab", "o"),         # 집단의 순서
                     labels = c("A형", "B형", "AB형", "O형")) # 집단을 표시
bt.factor4

bt.factor5 <- factor(bt,
                     levels  = c("a", "b", "ab", "o"),
                     labels  = c("A형", "B형", "AB형", "O형"),
                     ordered = TRUE)
bt.factor5
# ordered = FALSE : 명목형 자료, default로 설정되어 있음


# 2-2. Factor의 속성 ----
# 집단의 이름과 개수 : levels(factor)
levels(bt.factor5)

# factor의 집단의 이름은 글자로 보이지만 실질적으로는 숫자로 인식하고 있음
# 숫자는 글자보다 메모리를 덜 차지함

mode(bt.factor5)


# 3. Matrix ----
# 행과 열로 구성되어 있음. 2차원 구조
# 하나의 데이터 유형만 가짐.
# Vector의 확장

# 3-1. Matrix 만들기 ----
v1 <- 1:3
v2 <- 4:6
v3 <- 1:6

# (1) rbind(vector1, vector2, ...)
M1 <- rbind(v1, v2, v3)
M1
# (2) cbind(vector1, vector2, ...)
M2 <- cbind(v1, v2, v3)
M2

# (3) matrix(vector, nrow = , ncol = , byrow = TRUE)
matrix(1:4, nrow = 2, ncol = 2)
matrix(1:4, nrow = 2, ncol = 2, byrow = TRUE)


# 3-2. Matrix의 Slicing ----
# matrix[rowIndex , colIndex]
A <- matrix(1:9, nrow = 3, ncol = 3)
A
A[3, ]               # vector
A[3, , drop = FALSE] # matrix
A[c(1, 3), ]
A[ , 3]
A[ , 3, drop = FALSE]
A[ , c(1, 3)]
A[c(1,3), c(1,3)]
A[3,3, drop]


# 3-3. Matrix의 연산 ----
# (1) 덧셈과 뺄셈
A <- matrix(1:4, nrow = 2, ncol = 2)
B <- matrix(5:8, nrow = 2, ncol = 2)
A; B
A + B
A - B

# (2) 곱셈 : %*%
A * B
A %*% B
B %*% A


# (3) 역행렬(Inverse Matrix)
# solve(matrix)
solve(A)

A <- matrix(c(1, 1, -1, 1), nrow = 2, ncol = 2)
A
B <- matrix(c(3, 1), nrow = 2, ncol = 1)
B

solve(A) %*% B


# (4) 전치행렬(Transpose Matrix)
# 행과 열을 바꿈
# t(matrix)
A
t(A)


# 4. Array ----
# 다차원 구조
# 하나의 데이터 유형만 가짐
# vector, matrix의 확장

# 4-1. Array 만들기 ----
# array(vector, dim = ) / dim에다가 차원을 세팅. 1개면 1차원, 2개면 2차원...
array(1:4, dim = 10)         # array 이면서 (numeric) vector : 1차원 구조
array(1:9, dim = c(3, 3))    #array 이면서 matrix : 2차원 구조
array(1:9, dim = c(3, 3, 2)) #array : 3차원 구조


# 4-2. Array의 속성 ----
# dim(array) : 차원
dim(array(1:9, dim = c(3, 3, 2)))


# 5. Data.Frame ----
# 행과 열로 구성되어 있음. 2차원 구조.
# 여러 개의 데이터 유형을 가질 수 있음.
# 단, 하나의 열에는 하나의 데이터 유형만 가짐.
# R에서 기본적으로 데이터라고 하면 data.frame이다.
# Recycling Rule이 작동하지 않음.

# 5-1. Data.frame 만들기 ----
id      <- 1:3
hobby   <- c("영화감상", "자전거타기", "맨몸운동")
movie   <- c(1, 0.5, 10)
traffic <- c(100, 100, 40)
survey  <- data.frame(id, hobby, movie, traffic) # 각 벡터의 사이즈가 똑같아야 함. 리사이클룰이 적용되지 않기 때문
survey
View(survey)



# 6. List ----
# 가장 유연한 형태의 데이터
# element로 vector, factor, matrix, array, data.frame, list를 가질 수 있음
gender.factor <- factor(c("M", "M", "F", "M", "M"))

# 6-1. List 만들기 ----
# list(vector, factor, matrix, array, data.frame, list)
result <- list(hobby, gender.factor, survey)
result

result[1]   # 최종 결과 : List
result[[1]] # 최종 결과 : Vector

result[2]   # 최종 결과 : List
result[[2]] # 최종 결과 : Factor

result[3]   # 최종 결과 : List
result[[3]] # 최종 결과 : Data.Frame