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
blank # 외부 데이터를 읽어오면 무조건 data.frame
mean(blank$age) # 평균 구하기

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
# 엑셀의 특수 형태
# data <- read.csv(file   = "directory/filename.csv"
#                  header = TRUE)
company <- read.csv(file   = "c://R/BigData/company.csv",
                    header = TRUE)
company


# 3. excel ----
# 기본 기능에서는 못 읽어옴
# 추가기능을 설치하고 로딩하면 됨
# 추가기능 : package
# "readxl" : 헤들리 위캠(컴)

# 3-1. 패키지 설치하기 ----
# 패키지 설치는 동일 컴퓨터에서는 딱 한 번만 함.
# 다시 설치한다면, 패키지가 업데이트되어 있을 때.
# install.packages("packageName")
install.packages("readxl")

# 인터넷이 안되는 경우
# 1단계 : 인터넷이 되는 컴퓨터로 감
# 2단계 : USB나 외장 하드에 해당 패키지 다운로드
# 3단계 : 보안검사를 통화한 후에 해당 컴퓨터에 복사
# 4단계 : 설치
install.packages("c://R/BigData/antiword_1.1.zip", repose = NULL) 
# repos : 서버의 위치 = 서버의 주소

# 3-2. 패키지 로딩하기 ----
# RStudio를 실행할 때마다 필요하면 명령어를 실행해야 함
# library(packageName)
library(readxl)

# data <- readxl::read_excel(path      = "directory/filename.xlsx", / 경로. file과 같음
#                            sheet     = "sheetName" or sheetIndex, / 어느 시트를 사용할 것인지
#                            col_names = TRUE)                      / header랑 같음
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

# 작업공간(Working Directory) ----
# (1) 현재 설정된 작업공간 알아내기 : getwd()
getwd()

# (2) 새롭게 작업공간 설정하기 : setwd("directory")
setwd("c://R/BigData/") # 작업공간을 설정하면 오프라인으로 패키지 설치할 때마다 경로를 일일히 길게 정해줄 필요가 없음.
