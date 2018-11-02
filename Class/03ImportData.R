##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##
## Lecture : Import Data                                                                 ##
##                                                                                       ##
## Date    : October 8th, 2018                                                           ##
## Author  : Buil Lee                                                                    ##
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##

# 1. txt
# 2. csv
# 3. excel
# 4. DB


# 1. txt ----
# 1-1. seperator : one blank ----
# data <- read.table(file   = "directory/filename.txt",
#                    header = TRUE,
#                    sep    = " ")
blank <- read.table(file   = "c:/R/BigData/blank.txt", 
                    header = TRUE,
                    sep    = " ")
blank # �ܺ� �����͸� �о���� ������ data.frame
mean(blank$age) # ��� ���ϱ�

# 1-2. seperator : comma ----
# data <- read.table(file   = "directory/filename.txt",
#                    header = TRUE,
#                    sep    = ",")
comma <- read.table(file   = "c:/R/BigData/comma.txt", 
                    header = TRUE,
                    sep    = ",")
comma
table(comma$food)

# 1-3. seperator : tab ----
# data <- read.table(file   = "directory/filename.txt",
#                    header = TRUE,
#                    sep    = "\t")
tab <- read.table(file   = "c:/R/BigData/tab.txt", 
                    header = TRUE,
                    sep    = "\t")
tab




# 2. csv ----
# Comma Seperated Value
# ������ Ư�� ����
# data <- read.csv(file   = "directory/filename.csv"
#                  header = TRUE)
company <- read.csv(file   = "c://R/BigData/company.csv",
                    header = TRUE)
company


# 3. excel ----
# �⺻ ��ɿ����� �� �о��
# �߰������ ��ġ�ϰ� �ε��ϸ� ��
# �߰���� : package
# "readxl" : ��鸮 ��ķ(��)

# 3-1. ��Ű�� ��ġ�ϱ� ----
# ��Ű�� ��ġ�� ���� ��ǻ�Ϳ����� �� �� ���� ��.
# �ٽ� ��ġ�Ѵٸ�, ��Ű���� ������Ʈ�Ǿ� ���� ��.
# install.packages("packageName")
install.packages("readxl")

# ���ͳ��� �ȵǴ� ���
# 1�ܰ� : ���ͳ��� �Ǵ� ��ǻ�ͷ� ��
# 2�ܰ� : USB�� ���� �ϵ忡 �ش� ��Ű�� �ٿ�ε�
# 3�ܰ� : ���Ȱ˻縦 ��ȭ�� �Ŀ� �ش� ��ǻ�Ϳ� ����
# 4�ܰ� : ��ġ
install.packages("c://R/BigData/antiword_1.1.zip", repose = NULL) 
# repos : ������ ��ġ = ������ �ּ�

# 3-2. ��Ű�� �ε��ϱ� ----
# RStudio�� ������ ������ �ʿ��ϸ� ���ɾ �����ؾ� ��
# library(packageName)
library(readxl)

# data <- readxl::read_excel(path      = "directory/filename.xlsx", / ���. file�� ����
#                            sheet     = "sheetName" or sheetIndex, / ��� ��Ʈ�� ����� ������
#                            col_names = TRUE)                      / header�� ����
reading <- readxl::read_excel(path      = "c://R/BigData/reading.xlsx",
                              sheet     = "data",
                              col_names = TRUE)

reading

reading2 <- readxl::read_excel(path      = "c://R/BigData/reading.xlsx",
                              sheet     = 1,
                              col_names = TRUE)

reading2

reading3 <- readxl::read_excel(path      = "reading.xlsx",
                               sheet     = 1,
                               col_names = TRUE)

reading3

# �۾�����(Working Directory) ----
# (1) ���� ������ �۾����� �˾Ƴ��� : getwd()
getwd()

# (2) ���Ӱ� �۾����� �����ϱ� : setwd("directory")
setwd("c://R/BigData/") # �۾������� �����ϸ� ������������ ��Ű�� ��ġ�� ������ ��θ� ������ ��� ������ �ʿ䰡 ����.