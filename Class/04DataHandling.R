##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
## Lecture : Data Handling = Data Pre-processing                                         ##
##                                                                                       ##
## Date    : October 8th, 2018                                                           ##
## Author  : Buil Lee                                                                    ##
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##

# ��Ű�� ��ġ/�ε��ϱ� ----
install.packages("ggplot2")
install.packages("DT")
install.packages("dplyr")
install.packages("writexl")
library(ggplot2)
library(DT)
library(dplyr)
library(writexl)

# �۾����� ----
setwd("c:/R/BigData/")


# ������ �о���� ----
# ggplot2::diamonds


# 1. ������ ��ü ���� ----
# 1-1. data ----
# console�� ����� ��
# �����Ͱ� ���� ���� �����
diamonds

# 1-2. View(data) ----
# editor window�� ����� ��
# �����Ͱ� ���� ���� �����
View(diamonds)

# 1-3. DT::datatable(data) ----
# web ���·� ����� ��
DT::datatable(diamonds)



# 2. �������� �Ϻ� ���� ----
# 2-1. head(data, n = 6) ----
# console�� ����� ��
head(diamonds) # ����Ʈ�� 6��
head(diamonds, n = 10)

# 2-2. tail(data, n - 6) ----
# console�� ����� ��
tail(diamonds)
tail(diamonds, n = 10)

# 2-3. View(head(data, n = 6) or tail(data, n = 6)) ----
# editor window�� ����� ��
View(head(diamonds, n = 10))
View(tail(diamonds, n = 10))

# 2-4. DT::datatable(head(data, n = 6) or tail(data, n = 6)) ----
# web ���·� ����� ��
DT::datatable(head(diamonds, n = 10))
DT::datatable(tail(diamonds, n = 10))


# 3. �������� ����(structure) ���� ----
# str(data)
str(diamonds)


# 4. �������� �Է¿��� üũ�ϱ� ----
# summary(data)
summary(diamonds) # factor�� ������ ���ֺ� ���谡 ������

id      <- 1:5
address <- c("�����", "������", "��걸", "������", "���ֽ�")
dwell   <- c(26, 20, 3, 1, 3)
home <- data.frame(id, address, dwell, stringsAsFactors = FALSE) #stringAsFactors : FALSE�� ��Ʈ���� ������ factor�� �ٲ��� ����� ǥ��. 
home
str(home)
summary(home)
home$address <- as.factor(home$address) # as.factor �ش翭�� ������ factor�� �ٲٴ� �Լ�


# 5. �������� �Ӽ� ----
# 5-1. ���� ���� : nrow(data) ----
# ��� : numeric vector
nrow(diamonds)

# 5-2. �� = ������ ���� : ncol(data) ----
# ��� : numeric vector
ncol(diamonds)

# 5-3. ���� �̸� : rownames(data) ----
# ��� : character vector
rownames(diamonds)

# 5-4. �� = ������ �̸� : colnames(data) ----
# ��� : character vector
colnames(diamonds)

# 5-5. ����(dimension) : dim(data) ----
# ��� : numeric vector
dim(diamonds)
dim(diamonds)[1] # ���� ����
dim(diamonds)[2] # ���� ����

# 5-6. ������ �̸� : dimnames(data) ----
# ��� : list
dimnames(diamonds)
dimnames(diamonds)[1] # ���� �̸� : List
dimnames(diamonds)[[1]] # ���� �̸� : Vector
dimnames(diamonds)[2] # ���� �̸� : List
dimnames(diamonds)[[2]] # ���� �̸� : Vector


# 6. �������� slicing ----
# data[rowIndex, colIndex]

# 6-1. �� = ���� ----
# data[ , colIndex]
# (1) �� = ������ ��ġ�� �� ��
diamonds[ , 1]
diamonds[ , 2]

# ����1
# 1, 9, 10��° ���� �� ���� ����������.
diamonds[ , c(1, 9, 10)]

# ����2
# 4-8��° ���� �� ���� ����������.
diamonds[ , 4:8]

# ����3
# Ȧ�� ��° ���� �� ���� ����������.
diamonds[ , seq(from = 1, to = ncol(diamonds), by = 2)]


# (2) �� = ������ �̸��� �� ��
diamonds[ , "carat"]
diamonds[ , "cut"]

# ����4
# x, y, z��� �� ���� ������ �� ���� ����������.
diamonds[ , c("x", "y", "z")]


# (3) �� = ���� �̸��� ��Ģ(����)�� ���� ��
# grep(pattern, textData, value = TRUE or FALSE)
colnames(diamonds)

# i. ������ �߿��� t��� ���ڸ� �����ϴ� ��������?
# carat, cut, clarity, depts, table
# 1, 2, 4, 5, 6
grep("t", colnames(diamonds), value = TRUE)  # ������
grep("t", colnames(diamonds), value = FALSE) # �������� ��ġ
diamonds[ , grep("t", colnames(diamonds), value = TRUE)]
diamonds[ , grep("t", colnames(diamonds), value = FALSE)]

# ii. ������ �߿��� t��� ���ڷ� �����ϴ� ��������?
# table
# 6
grep("^t", colnames(diamonds), value = TRUE)  # ������
grep("^t", colnames(diamonds), value = FALSE) # �������� ��ġ
diamonds[ , grep("^t", colnames(diamonds), value = TRUE)]
diamonds[ , grep("^t", colnames(diamonds), value = FALSE)]

# iii. ������ �߿��� t��� ���ڷ� ������ ��������?
# carat, cut
# 1, 2
grep("t$", colnames(diamonds), value = TRUE)  # ������
grep("t$", colnames(diamonds), value = FALSE) # �������� ��ġ
diamonds[ , grep("t$", colnames(diamonds), value = TRUE)]
diamonds[ , grep("t$", colnames(diamonds), value = FALSE)]


# (4) dplyr::select(data, variable1, variable2, ...)
dplyr::select(diamonds, cut)
dplyr::select(diamonds, cut, color)
dplyr::select(diamonds, price:z)          # price���� z���� ������
dplyr::select(diamonds, -(price:z))       # �ش� ������ �� �������� ������
dplyr::select(diamonds, starts_with("t")) # t�� �����ϴ� ����
dplyr::select(diamonds, contains("t"))    # t�� �����ϰ� �ִ� ����
dplyr::select(diamonds, ends_with("t"))   # t�� ������ ����


# 6-2. �� ----
# data[rowIndex, ]

# (1) ���� ��ġ�� �� ��
diamonds[1 , ]
diamonds[c(1, 9, 10) , ]
diamonds[4:8 , ]
diamonds[seq(from = 1, to = nrow(diamonds), by = 100), ]

# (2) ������ �����ϴ� ���
# i. cut�� "Ideal"�� ������
diamonds[diamonds$cut == "Ideal" , ]

# ii. price�� 18000 �̻��� ������
diamonds[diamonds$price >= 18000 , ]

# iii. cut�� "Ideal"�̰�, price�� 18000 �̻��� ������
diamonds[(diamonds$cut == "Ideal") & (diamonds$price >= 18000) , ]

# iv. cut�� "Ideal" �Ǵ� price�� 18000 �̻��� ������
diamonds[(diamonds$cut == "Ideal") | (diamonds$price >= 18000) , ]

# ����5
# cut�� "Ideal" �Ǵ� "Good"�� ������
diamonds[(diamonds$cut == "Ideal") | (diamonds$cut == "Good") , ]
diamonds[diamonds$cut == c("Ideal", "Good") , ]   # Ʋ��
diamonds[diamonds$cut %in% c("Ideal", "Good") , ] # %in% : �κ����� ��ȣ ����


# (3) dplyr::filter(data, ����)
dplyr::filter(diamonds, cut == "Ideal")
dplyr::filter(diamonds, price >= 18000)
dplyr::filter(diamonds, cut == "Ideal", price >= 18000)
dplyr::filter(diamonds, cut == "Ideal" | price >= 18000)
dplyr::filter(diamonds, cut %in% c("Ideal", "Good"))


# 6-3. ��� �� ----
# data[rowIndex, colIndex]
# cut�� "Ideal"�̰�, price�� 18000�̻��� �������� x, y, z��� ����(��)�� ����������.

diamonds[(diamonds$cut == "Ideal") & (diamonds$price >= 18000) , c("x", "y", "z") ]

# (2) dplyr::filter(), dplyr::select() - filter�� ���� �;� ��. �����͸� ���� �����ؾ�.
diamonds2 <- dplyr::filter(diamonds, cut == "Ideal", price >= 18000)
dplyr::select(diamonds2, x:z)

# %>% : pipe, chain - �߰��� ���ʿ��� �����͸� �������� �ʾ� �޸𸮸� ������ ���� / ctrl+shift+M
diamonds %>%
  dplyr::filter(cut == "Ideal", price >= 18000) %>%
  dplyr::select(x:z) %>% 
  head()


# 7. ���ο� ����(��) ����� ----
# data$newVariable <- �۾�

# 7-1. ���� ----
diamonds$xyz.mean  <- (diamonds$x + diamonds$y + diamonds$z) / 3 # x, y, z ���� ���
diamonds$xyz.mean2 <- rowMeans(diamonds[ , c("x", "y", "z")])   # x, y, z ���� ���2
# rowSums(), colMeans(), colSums()

# 7-2. ��ȯ(Transformation) ----
# Box-Cox Transformation

# (1) log ��ȯ  : ���Ī ������ �� �� ��Ī������ ��ҽ�ų �� ����
diamonds$price.log10 <- log10(diamonds$price)

# (2) root ��ȯ : log���ٴ� �� ����
diamonds$price.root <- sqrt(diamonds$price)

# (3) 1/y ��ȯ
diamonds$price.inverse <- 1 / diamonds$price

# 7-3. ������ ���� ----
# (1) cut()
# data$newVariable <- cut(data$variable,
#                         breaks = ������ ����,
#                         right  = TRUE or FALSE)
diamonds$price.group <- cut(diamonds$price,
                            breaks = seq(from = 0, to = 20000, by = 5000),
                            right = FALSE) # �̻� ~ �̸� ����
# cut() �Լ��� ����ϸ� ���ο� ������ ������ Factor�� ��
levels(diamonds$price.group)
levels(diamonds$price.group) <- c("5000�̸�",              # �� ������ �̸� ���̱�
                                  "5000�̻�~10000�̸�",
                                  "10000�̻�~15000�̸�",
                                  "15000�̻�")
table(diamonds$price.group)

# ����8
# carat -> carat.group
# 0   ~ 1.5 : 1.5 �̸�
# 1.5 ~ 3.0 : 1.5 �̻� ~ 3.0 �̸�
# 3.0 ~ 4.5 : 3.0 �̻� ~ 4.5 �̸�
# 4.5 ~ 6.0 : 4.5 �̻� ~ 6.0 �̸�
diamonds$carat.group <- cut(diamonds$carat,
                            breaks = seq(from = 0, to = 6, by = 1.5),
                            right = FALSE)

levels(diamonds$carat.group) <- c("1.5 �̸�",
                                  "1.5 �̻� ~ 3.0 �̸�",
                                  "3.0 �̻� ~ 4.5 �̸�",
                                  "6.0 �̸�")

# (2) ifelse()
# i. ������ ����
# price -> price.group2
# 0 �̻�    ~ 5000 �̸�  : Cheap
# 5000 �̻� ~ 20000 �̸� : Non-cheap
diamonds$price.group2 <- ifelse(diamonds$price < 5000,
                                "Cheap",
                                "Non-cheap")

# price -> price.group3
# 0 �̻� ~ 5000 �̸� : Cheap
# 5000 �̻� ~ 15000 �̸� : Medium
# 15000 �̻� ~ 20000 �̸� : Expensive
diamonds$price.group3 <- ifelse(diamonds$price < 5000,
                                "Cheap",
                                ifelse(diamonds$price < 15000,
                                       "Medium",
                                       "Expensive"))

# ii. �پ��� ���ָ� ����� ��
# cut       -> cut.group
# Fair      -> Non-Ideal
# Good      -> Non-Ideal
# Very Good -> Non-Ideal
# Premium   -> Non-Ideal
# Ideal     -> Ideal

# ifelse(����, ������ ���� �� ������ ��, ������ ������ �� ������ ��)
diamonds$cut.group <- ifelse(diamonds$cut == "Ideal",
                             "Ideal",
                             "Non-Ideal")


# 7-4. dplyr::mutate(data, newVariable = ����, ��ȯ ��) - ������ ���ο� ������ ���� ----
diamonds <- diamonds %>% 
  dplyr::mutate(carat.log = log10(carat))

diamonds <- diamonds %>% 
  dplyr::mutate(xyz.sum = x + y + z)


# 8. ���� �����ϱ� ----
# 8-1. Slicing ----
# diamonds <- diamonds[ , c("carat", "cut", "color")]

# 8-2. data$variable <- NULL
diamonds$cut.group    <- NULL
diamonds$price.group2 <- NULL
diamonds$price.group3 <- NULL


# 9. �ܺ� �����ͷ� �����ϱ� ----
# 9-1. txt ----
# write.table(data,
#             File      = "directory/filename.txt",
#             sep       = ",",
#             row.names = FALSE) ���� �̸��� �������� ����
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


# 10. RData�� �����ϱ� ----
# save(data,
#      file = "directory/filename.RData")
save(diamonds, file = "diamonds_1010.RData")


# 11. RData �ҷ�����(�о����) ----
# load(file = "directory/filename.RData")
load(file = "diamonds_1010.RData")


# 12. �������� ��� ���� ----
# ����ڰ� ���� ������
# ls()
# ls : list segment�� ����
# ls()�� ����� character vector
ls()


# 13. ������ �����ϱ� ----
# 13-1. �ϳ� �Ǵ� �� ���� ������ �����ϱ� ----
# rm(data1, data2, ...)
# rm : remove�� ����

rm(traffic, tab, survey)

# 13-2. ��� ������ �����ϱ� ----
# rm(list = ls())
rm(list = ls())


# 14. �������� ���� ----
# 14-1. Vector�� ���� ----
# sort(vector, decreasing = FALSE) : default, ��������
# sort(vector, decreasing = TRUE)  : ��������
feet <- c(265, 285, 240, 270, 265)
feet
sort(feet)
sort(feet, decreasing = FALSE)
sort(feet, decreasing = TRUE)

# 14-2. Data.Frame�� ���� ----
# order(data$variable, decreasing = FALSE) : default, ��������
# order(data$variable, decreasing = TRUE)  : ��������
# data[order(data$variable, decreasing = FALSE), ]
# data[order(data$variable, decreasing = TRUE), ]
order(feet, decreasing = FALSE)
feet[order(feet, decreasing = FALSE)]
feet[order(feet, decreasing = TRUE)]

# cut : ��������
diamonds[order(diamonds$cut, decreasing = FALSE), ]

# cut : ��������
diamonds[order(diamonds$cut, decreasing = TRUE), ]

# cut : ��������, price : ��������
diamonds[order(diamonds$cut, diamonds$price, decreasing = FALSE), ]

# cut : ��������, price : ��������
diamonds[order(diamonds$cut, diamonds$price, decreasing = TRUE), ]

# cut : ��������, price : ��������
diamonds[order(diamonds$cut, -diamonds$price, decreasing = FALSE), ] # ���� ���ڷ� �Ǿ� ���� ���� -�� ���� �� ����

# cut : ��������, price : ��������
diamonds[order(diamonds$cut, -diamonds$price, decreasing = TRUE), ]

# cut : ��������, color : ��������
# R�� �⺻ ��ɿ����� ����
# dplyr::arrange(data, variable, desc(variable))
dplyr::arrange(diamonds, cut, desc(color))
diamonds %>% 
  dplyr::arrange(cut, desc(color))


# xyz.mean�̶�� ���ο� ������ �����,
# �� ���� �������� �������� ������ ������,
# ���� 5���� ���̵��� �Ͻÿ�.

diamonds %>% mutate(xyz.mean = (x + y + z)/3) %>% 
  dplyr::arrange(desc(xyz.mean)) %>%
  head(n = 5)


# 15. ������ ��ġ�� ----
# 15-1. rbind(data1, data2) ----
# �����͸� ��/�Ʒ��� ��ħ
# �������� ������, ������ ��ġ�� �����ؾ� ��
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
# �����͸� ����/���������� ��ħ
# ������ ���̾�� ��
DF4 <- data.frame(id  = c("����ȸ", "�̹μ�", "�����"),
                  age = c(27, 26, 27),
                  bt  = c("O", "B", "O"))

DF5 <- data.frame(address = c("��õ��", "�����", "������"),
                  company = c("�λ���Ʈ���̴�", "�Ｚ����", "�Ｚ����"))

DF6 <- cbind(DF4, DF5)
DF6

# 15-3. merge(data1, data2, by = ) ----
DF7 <- data.frame(id     = c(1, 2, 4, 5),
                  age    = c(10, 20, 40, 50),
                  gender = c("M", "M", "F", "F"))

DF8 <- data.frame(id    = c(1, 4, 7, 8, 9),
                  money = c(1000, 4000, 7000, 8000, 9000),
                  food  = c("����", "��Ʈ��", "AUDI7", "����", "�︮����"))

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