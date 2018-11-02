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
# 9. TS : Time Series, �ð迭


# 1. Vector ----
# �ϳ��� ��(column)�� �����Ǿ� ����. 1���� ����.
# �ϳ��� ������ ������ ����. ���ÿ� ���� �� ����.
# ������ �м��� �⺻ ����.

# 1-1. Vector ����� ----
# (1) �ϳ��� ��(element)���� �̷���� Vector
v1 <- 10
v2 <- "buillee"
v3 <- TRUE

# (2) �� �� �̻��� ������ �̷���� Vector
# i. c(element1, element2, ....)
# c : combine, concatenate�� ����
# numeric, character, logical vector�� ���� �� ����
# element�� ���� ��Ģ�� ���� ���
age <- c(26, 30, 32)
food <- c("�Ľ�Ÿ", "������ũ", "������ġ")
marry <- c(TRUE, FALSE, TRUE)

age2 <- c(27, 34, 27)
age3 <- c(age, age2)
age3

c(10, "Lee", FALSE) # ����. ���� character��
c(10, FALSE)        # ���� numeric��



# ii. :
# numeric vector���� �����
# start:end
# 1�� �����ǰų� �Ǵ� 1�� ���ҵǴ� ������ �̷���� vector
# start < end : 1�� ����
# start > end : 1�� ����
# start = end : start or end
# start�� �ִ� ���ں��� �����ؼ� end�� �ִ� ���ڸ� ���� ���� ������ 1�� ���� �Ǵ� 1�� ���ҵ�
1:5 # 1, 2, 3, 4, 5
1:100
5:1

# ����1
# -2.3:1�� �����? -2.3, -1.3, -0.3, 0.7
-2.3:1

# ����2
# 1:-2.3�� �����? 1, 0, -1, -2
1:-2.3


# iii. seq(from = , to = , by = )
# sequence�� ����
# :�� Ȯ��
# numeric vector���� �����
# from : start
# to   : end
# by   : ���� �Ǵ� ������ ��
# from�� �ִ� ���ں��� �����ؼ� to�� �ִ� ���ڸ� ���� ���� ������ by��ŭ ���� �Ǵ� ���ҵǴ� ���ڵ�� �̷���� Vector

seq(from = 1, to = 5, by = 0.5)

# ����3
# 5���� �����ؼ� 1�� ���� ���� ������ 0.5�� �����ϴ� vector
seq(from = 5, to = 1, by = -0.5)


# iv. sequence(number)
# numeric vector���� �����
# 1 ~ number ������ ������ �̷���� Vector
# number�� �����̸� error �߻�
sequence(5)
sequence(3.7)
sequence(1)
sequence(-3)

# ����4
# 1, 1, 2, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 6���� �̷���� vector�� ����ÿ�.
#
sequence(1:6)



# v. rep(vector, times = , each = )
# replicate�� ����
# rep �Լ� �ȿ� ������ vector�� times �Ǵ� each ������� �����ؼ� vector�� ����
# numeric, character, logical vector�� ���� �� ����.

rep(1, times = 10)
rep(1, each = 10)

rep(1:2, times = 5)
rep(1:2, each = 5)

# ����5
# "A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C"�� ������ vector�� ����ÿ�.

rep(c("A", "B", "C"), times = 4)

rep(1:3, time = 5, each = 3) # each�� ���� �۵�

# ����6
# 1 : 100��,
# 2 : 53��,
# 3 : 13���� �̷���� Vector�� ���弼��.
c(rep(1, times = 100), rep(2, times = 53), rep(3, times = 13))
rep(1:3, times = c(100, 53, 13))




# 1-2 Vector�� �Ӽ� ----
# (1) �������� ���� : length(vector)
length(age3)

# (2) element�� �̸� : names(vector)
income <- c(10000, 3500, 4000)
names(income)

# NULL : object�� ���ٴ� ��
# object : data, graph
names(income) <- c("����ȸ", "��μ�", "�����")
income
names(income) <- NULL


# 1-3 Vector�� Index ----
# ù ��° element�� 1�� �ν���. c, java, python�� 0���� �ν�.


# 1-4 Vector�� Slicing ----
# vector[index]
height <- c(170, 171, 178, 174, 180, 163, 181, 168, 168)
height[1]
height[3]

# ����7
# 1, 4, 5, 8��° ���� �� ���� ����������.
height[c(1, 4, 5, 8)]

# ����8
# 4 ~ 9��°�� ���� �� ���� ����������.
height[4:9]

# ����9
# ¦�� ��°�� ���� �� ���� ����������.
height[seq(from = 2, to = 9, by = 2)]
height[seq(from = 2, to = length(height), by = 2)]


# 1-5. Vector�� ���� ----
v1 <- 1:3
v2 <- 4:6
v1 + v2 # Vectorization : ����

v3 <- 1:6
v1 + v3 # Recycling Rule : ���� ��Ģ

v4 <- 1:8
v1 + v4



# 2. Factor ----
# �ϳ��� ���� �����Ǿ� ����. 1���� ����
# �������� �ν���
# ������ �ڷ� = ���� �ڷ� = �׷� = ����

# 2-1. Factor ����� ----
# Factor(vector, labels = , levels = , ordered = )
bt <- c("b", "ab", "b", "a", "o", "o", "ab")
bt

bt.factor1 <- factor(bt)
bt.factor1

bt.factor2 <- factor(bt,
                     labels = c("A��", "AB��", "B��", "O��"))
bt.factor2

bt.factor3 <- factor(bt,
                     levels = c("a", "b", "ab", "o"))
bt.factor3

bt.factor4 <- factor(bt,
                     levels = c("a", "b", "ab", "o"),         # ������ ����
                     labels = c("A��", "B��", "AB��", "O��")) # ������ ǥ��
bt.factor4

bt.factor5 <- factor(bt,
                     levels  = c("a", "b", "ab", "o"),
                     labels  = c("A��", "B��", "AB��", "O��"),
                     ordered = TRUE)
bt.factor5
# ordered = FALSE : ������ �ڷ�, default�� �����Ǿ� ����


# 2-2. Factor�� �Ӽ� ----
# ������ �̸��� ���� : levels(factor)
levels(bt.factor5)

# factor�� ������ �̸��� ���ڷ� �������� ���������δ� ���ڷ� �ν��ϰ� ����
# ���ڴ� ���ں��� �޸𸮸� �� ������

mode(bt.factor5)


# 3. Matrix ----
# ��� ���� �����Ǿ� ����. 2���� ����
# �ϳ��� ������ ������ ����.
# Vector�� Ȯ��

# 3-1. Matrix ����� ----
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


# 3-2. Matrix�� Slicing ----
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


# 3-3. Matrix�� ���� ----
# (1) ������ ����
A <- matrix(1:4, nrow = 2, ncol = 2)
B <- matrix(5:8, nrow = 2, ncol = 2)
A; B
A + B
A - B

# (2) ���� : %*%
A * B
A %*% B
B %*% A


# (3) �����(Inverse Matrix)
# solve(matrix)
solve(A)

A <- matrix(c(1, 1, -1, 1), nrow = 2, ncol = 2)
A
B <- matrix(c(3, 1), nrow = 2, ncol = 1)
B

solve(A) %*% B


# (4) ��ġ���(Transpose Matrix)
# ��� ���� �ٲ�
# t(matrix)
A
t(A)


# 4. Array ----
# ������ ����
# �ϳ��� ������ ������ ����
# vector, matrix�� Ȯ��

# 4-1. Array ����� ----
# array(vector, dim = ) / dim���ٰ� ������ ����. 1���� 1����, 2���� 2����...
array(1:4, dim = 10)         # array �̸鼭 (numeric) vector : 1���� ����
array(1:9, dim = c(3, 3))    #array �̸鼭 matrix : 2���� ����
array(1:9, dim = c(3, 3, 2)) #array : 3���� ����


# 4-2. Array�� �Ӽ� ----
# dim(array) : ����
dim(array(1:9, dim = c(3, 3, 2)))


# 5. Data.Frame ----
# ��� ���� �����Ǿ� ����. 2���� ����.
# ���� ���� ������ ������ ���� �� ����.
# ��, �ϳ��� ������ �ϳ��� ������ ������ ����.
# R���� �⺻������ �����Ͷ�� �ϸ� data.frame�̴�.
# Recycling Rule�� �۵����� ����.

# 5-1. Data.frame ����� ----
id      <- 1:3
hobby   <- c("��ȭ����", "������Ÿ��", "�Ǹ��")
movie   <- c(1, 0.5, 10)
traffic <- c(100, 100, 40)
survey  <- data.frame(id, hobby, movie, traffic) # �� ������ ����� �Ȱ��ƾ� ��. ������Ŭ���� ������� �ʱ� ����
survey
View(survey)



# 6. List ----
# ���� ������ ������ ������
# element�� vector, factor, matrix, array, data.frame, list�� ���� �� ����
gender.factor <- factor(c("M", "M", "F", "M", "M"))

# 6-1. List ����� ----
# list(vector, factor, matrix, array, data.frame, list)
result <- list(hobby, gender.factor, survey)
result

result[1]   # ���� ��� : List
result[[1]] # ���� ��� : Vector

result[2]   # ���� ��� : List
result[[2]] # ���� ��� : Factor

result[3]   # ���� ��� : List
result[[3]] # ���� ��� : Data.Frame