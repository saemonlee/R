# [패키지] ----
install.packages("ggplot2")      # Visualization : 시각화
install.packages("dplyr")        # Data Analysis and Handling
install.packages("tidyr")
install.packages("RColorBrewer") # Colors
install.packages("stringr")      # String
install.packages("prettyR")      # Mode, Correalation Analysis
install.packages("e1071")        # Skewness, Kurtosis, SVM
install.packages("psych")        # Descriptive Statistics = Summary statistics
install.packages("writexl")
library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyselect)
library(RColorBrewer)
library(stringr)
library(prettyR)
library(e1071)
library(psych)
library(writexl)

# [작업경로] ----
setwd("c://R/BigData/Project2")

# [작업] ----

# [train] ----

# 1. csv import ----

sales <- read.csv(file     = "train_fixed_2.csv",
                  header   = TRUE)
test  <- read.csv(file     = "test.csv",
                  header   = TRUE)
train <- read.csv(file     = "sales_train_v2.csv",
                  header   = TRUE)
shop  <- read.csv(file     = "shops.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
cats  <- read.csv(file     = "item_categories.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
item  <- read.csv(file     = "items.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
gdp   <- read.csv(file     = "russa_gdp.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
csm   <- read.csv(file     = "russa_private_consumption_expenditure.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
ern   <- read.csv(file     = "russa_monthly_earnings.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
unemp <- read.csv(file     = "russa_unemployment_rate.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
exr   <- read.csv(file     = "russa_exchange_rate.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
gdp11 <- read.csv(file     = "russa_gdp11.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
csm11 <- read.csv(file     = "russa_private_consumption_expenditure11.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
ern11 <- read.csv(file     = "russa_monthly_earnings11.csv",
                  header   = TRUE,
                  encoding = "UTF-8")
unemp11 <- read.csv(file   = "russa_unemployment_rate11.csv",
                    header = TRUE,
                    encoding = "UTF-8")
exr11 <- read.csv(file     = "russa_exchange_rate11.csv",
                  header   = TRUE,
                  encoding = "UTF-8")



# 2. train set 정리 ----

# train set에서 아웃라이어 및 이상치 전처리

train <- train[train$item_id != 6066, ]
train <- train[train$item_cnt_day < 1001, ]
train <- train[train$item_price > 0, ]

# train set에서 날짜 데이터 정리

train$date <- strptime(as.character(train$date), "%d.%m.%Y") # 날짜 서식 변환
train$month <- (train$date_block_num %% 12) + 1


# train set에서 전체 판매량 EDA

boxplot(train$item_cnt_day)

# train set 복제

train.d <- train



# 3. shop 정리 ----

# 3-1. region ----

# 1) shop의 shop name 컬럼에서 지역명을 추출

shop  <- tidyr::separate(data   = shop,             # 사용할 데이터 오브젝트
                         col    = shop_name,        # 분할할 컬럼명
                         sep    = " ",              # 분할 단위
                         into   = c("region_name"), # 분할 생성 후의 컬럼명
                         remove = FALSE)            # 분할 전 컬럼 삭제 여부

# 2) 이름이 이상한 행을 수정

shop[shop$region == "!Якутск", "region_name"] <- "Якутск"

# 3) 각 지역명에 고유 코드 부여

region_code               <- data.frame(unique(shop$region))         # shop의 region 컬럼의 unique값을 추출 후 OBT 생성
region_code$region_id     <- c(0:30)                                 # 해당 OBT에 컬럼을 생성하고 갯수만큼 번호 부여
colnames(region_code)     <- c("region_name", "region_id")                # 컬럼 이름 수정
shop                      <- merge(shop, region_code, by = "region_name") # 해당 OBT와 기존 shop을 조인
shop_code                 <- shop[ ,c("shop_id", "region_id")]            # 샵 번호와 지역 번호만 남김

# 4) csv로 저장

write.csv(shop,
          file      = "madeup/shop_id.csv",
          row.names = FALSE)

# 5) train set에 join

train <- merge(train, shop, by = "shop_id")



# 4. category 정리 ----

# 4-1. group, type ----

# 1) category의 category 컬럼에서 대분류와 소분류 추출
cats <- tidyr::separate(data   = cats,
                        col    = item_category_name,
                        sep    = " - ",
                        into   = c("type_name", "sub_name"),
                        remove = FALSE)

# 2) 각 대분류에 고유 코드 부여

type_code           <- data.frame(unique(cats$type_name))   # category의 type 컬럼의 unique 값을 추출 후 오브젝트 생성
type_code$type_id   <- c(0:19)                              # 해당 오브젝트에 컬럼을 생성하고 갯수만큼 번호 부여
colnames(type_code) <- c("type_name", "type_id")            # 컬럼 이름 수정

# 3) 대분류의 상위분류를 생성해 코드 부여

type_code$group_name <- c("PC",
                          "Accessories",
                          "Tickets(Digital)",
                          "Delivery",
                          "Game consoles",
                          "Games",
                          "Games",
                          "Games",
                          "Games",
                          "Payment cards",
                          "Payment cards",
                          "Culture",
                          "Culture",
                          "Culture",
                          "Additional Goods",
                          "Programs",
                          "Service",
                          "Clean media",
                          "Clean media",
                          "Batteries")
group_code           <- data.frame(unique(type_code$group_name))
group_code$group_id  <- c(0:12)
colnames(group_code) <- c("group_name", "group_id")

# 4) 상위분류와 대분류 조인

type      <- merge(type_code, group_code, by = "group_name")
type_code <- type_code[ ,c("type_name", "type_id")]     # join 후 type_code 내용을 원상복귀


# 4-2. subtype ----

# 1) 각 소분류에 고유 코드 부여

sub_code           <- data.frame(unique(cats$sub_name)) # category의 소분류 컬럼의 unique 값을 추출 후 오브젝트 생성 
sub_code$sub_id    <- c(0:60)                           # 해당 오브젝트에 컬럼을 생성하고 갯수만큼 번호 부여
colnames(sub_code) <- c("sub_name", "sub_id")           # 컬럼 이름 수정

# 2) 각 오브젝트 조인

cats <- merge(cats, type, by = "type_name")    # type 오브젝트와 category join
cats <- merge(cats, sub_code, by = "sub_name") # sub_code 오브젝트와 category join
cats <- cats[ , 
              c("group_name",
                "group_id",
                "type_name",
                "type_id",
                "sub_name",
                "sub_id",
                "item_category_name",
                "item_category_id")
              ]

# 7) csv로 저장

write.csv(group_code,
          file      = "madeup/group_code.csv",
          row.names = FALSE)
write.csv(type_code,
          file      = "madeup/type_code.csv",
          row.names = FALSE)
write.csv(sub_code,
          file      = "madeup/sub_code.csv",
          row.names = FALSE)
write.csv(cats,
          file      = "madeup/cats_id.csv",
          row.names = FALSE)

# 8) item set에 join

item <- item[ ,c("item_id", "item_category_id")]   # 아이템 이름은 길기 때문에 제거
item <- merge(item, cats, by = "item_category_id") # category를 item에 join

# 9) csv로 저장

write.csv(item,
          file      = "madeup/item.csv",
          row.names = FALSE)




# 5. train set 통합 ----

# 1) item set을 train set에 join

train <- merge(train, item, by = "item_id") # item을 train에 join
train <- train[ ,
                c("date",
                  "date_block_num",
                  "month",
                  "region_name",
                  "region_id",
                  "shop_name",
                  "shop_id",
                  "group_name",
                  "group_id",
                  "type_name",
                  "type_id",
                  "sub_name",
                  "sub_id",
                  "item_category_name",
                  "item_category_id",
                  "item_id",
                  "item_cnt_day",
                  "item_price")]

# 2) 다 합친 train set를 저장
write.csv(train,
          file      = "madeup/train_f.csv",
          row.names = FALSE)





# [matrix] ----

# 6. matrix 생성 ----

train2 <- train.d[ ,c("date_block_num", "shop_id", "item_id")]
matrix <- data.frame(unique(train2))




# 7. train 복제 ----

train.dd         <- train.d[ ,c("date_block_num", "shop_id", "item_id", "item_price", "item_cnt_day")]
train.dd$revenue <- (train.d$item_price * train.d$item_cnt_day) # 총 이익을 계산하는 컬럼 생성



# 8. 월/가게/아이템별 합계 ----

# 1) train.dd에서 group by로 값을 구해 오브젝트 생성

date_shop_item_cnt_month <- train.dd %>% 
  dplyr::group_by(date_block_num, shop_id, item_id) %>% 
  dplyr::summarise(date_shop_item_cnt_month = sum(item_cnt_day))

# 2) matrix에 join

matrix <- merge(matrix, date_shop_item_cnt_month, by = c("date_block_num", "shop_id", "item_id"))



# 9. 월/아이템별 평균 ----

# 1) train.dd에서 group by로 값을 구해 오브젝트 생성

date_item_avg_cnt_month <- train.dd %>% 
  dplyr::group_by(date_block_num, item_id) %>% 
  dplyr::summarise(date_item_avg_cnt_month = mean(item_cnt_day))

# 2) matrix에 join

matrix <- merge(matrix, date_item_avg_cnt_month, by = c("date_block_num", "item_id"))



# 10. item, shop 코드 ----

# 1) 아이템과 가게 정보에서 코드들만 추출해 오브젝트 생성

item_code <- item[ ,c("group_id", "type_id", "sub_id", "item_category_id", "item_id")]
shop_code <- shop[ ,c("region_id", "shop_id")]

# 2) 생성한 오브젝트들을 각각 train.dd와 matrix에 join

train.dd <- merge(train.dd, item_code, by = "item_id")
train.dd <- merge(train.dd, shop_code, by = "shop_id")
matrix   <- merge(matrix, item_code, by = "item_id")
matrix   <- merge(matrix, shop_code, by = "shop_id")



# 11. 월/가게/카테고리별 평균 ----

# 1) train.dd에서 group by로 월/가게/카테고리별 평균값을 구해 오브젝트 생성

date_shop_cat_avg_cnt_month <- train.dd %>% 
  dplyr::group_by(date_block_num, shop_id, item_category_id) %>% 
  dplyr::summarise(date_shop_cat_avg_cnt_month = mean(item_cnt_day))

# 2) matrix에 join

matrix <- merge(matrix,
                date_shop_cat_avg_cnt_month, 
                by = c("date_block_num", "shop_id", "item_category_id"))



# 12. 월간 정보 추가 ----

matrix$month <- (matrix$date_block_num %% 12) + 1

# 외부 데이터에서 필요한 컬럼만 추출
ern   <- ern[ ,c("date_block_num", "monthly_earnings")]
gdp   <- gdp[ ,c("date_block_num", "GDP")]
csm   <- csm[ ,c("date_block_num", "consume")]
unemp <- unemp[ ,c("date_block_num", "Unemployment.Rate")]
exr   <- exr[ ,c("date_block_num", "exchange_rate")]




# 13. 외부데이터 join ----

matrix <- merge(matrix, ern, by = "date_block_num")
matrix <- merge(matrix, gdp, by = "date_block_num")
matrix <- merge(matrix, csm, by = "date_block_num")
matrix <- merge(matrix, unemp, by = "date_block_num")
matrix <- merge(matrix, exr, by = "date_block_num")

# csv로 저장
write.csv(matrix,
          file      = "madeup/train_matrix.csv",
          row.names = FALSE)




# 추가 시도: 지난달 판매량 정보 추가 ----

# 지난달 판매량 정보를 포함한 오브젝트 생성

item_cnt_last_month                <- matrix[ ,c("date_block_num",
                                                 "shop_id",
                                                 "item_id",
                                                 "date_shop_item_cnt_month",
                                                 "date_item_avg_cnt_month",
                                                 "date_shop_cat_avg_cnt_month")] # matrix에서 필요한 컬럼만 추출
item_cnt_last_month$date_block_num <- item_cnt_last_month$date_block_num + 1     # 월 정보를 지난달 정보로 변경
item_cnt_last_month11              <- item_cnt_last_month                        # 오브젝트 복제

# 새 matrix에 지난달 판매량 정보를 join

matrix2 <- matrix[matrix$date_block_num > 0 , ]                                       # matrix에서 첫번째 달 정보 삭제
                                                                                      # 첫번째 달엔 지난달 정보 없음
item_cnt_last_month <- item_cnt_last_month[item_cnt_last_month$date_block_num < 34, ] # +1 때문에 생긴 11월 정보 삭제
                                                                                      # matrix에는 11월 정보가 없음
colnames(item_cnt_last_month) <- c("date_block_num",
                                   "shop_id","item_id",
                                   "date_shop_item_cnt_last_month",
                                   "date_item_avg_cnt_last_month",
                                   "date_shop_cat_avg_cnt_last_month")                # 컬럼명 변경
matrix2 <- merge(matrix2, item_cnt_last_month,
                 by = c("date_block_num", "shop_id", "item_id"),
                 all.x = TRUE)                                                        # left outer join

# NA값을 0으로 채움

matrix2[is.na(matrix2[, "date_shop_item_cnt_last_month"]),
        c("date_shop_item_cnt_last_month",
          "date_item_avg_cnt_last_month",
          "date_shop_cat_avg_cnt_last_month")] = 0

# csv로 저장

write.csv(matrix2,
          file      = "madeup/train_matrix2.csv",
          row.names = FALSE)





# [test] ----

# test set의 컬럼들을 matrix와 맞춰줌

test <- merge(test, item_code, by = "item_id")
test <- merge(test, shop_code, by = "shop_id")
test$date_block_num <- 34
test$month          <- 11

test$GDP               <- -2.495
test$Unemployment.Rate <- 5.791
test$monthly_earnings  <- 512.794
test$consume           <- 175261.7
test$exchange_rate     <- 65.03

item_cnt_last_month11 <- item_cnt_last_month11[item_cnt_last_month11$date_block_num == 34, ]
colnames(item_cnt_last_month11) <- c("date_block_num",
                                     "shop_id","item_id",
                                     "date_shop_item_cnt_last_month",
                                     "date_item_avg_cnt_last_month",
                                     "date_shop_cat_avg_cnt_last_month")
test <- merge(test, item_cnt_last_month11, by = c("date_block_num", "shop_id", "item_id"), all.x = TRUE)
test[is.na(test[, "date_shop_item_cnt_last_month"]), c("date_shop_item_cnt_last_month",
                                                       "date_item_avg_cnt_last_month",
                                                       "date_shop_cat_avg_cnt_last_month")] = 0

write.csv(test,
          file      = "madeup/test.csv",
          row.names = FALSE)
