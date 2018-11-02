# 주석 = comment = 설명, 한 줄만 주석 처리가 됨.
# ; = 명령어의 끝. 한 줄에 하나의 명령어만 있으면 생략해도 됨. 한 줄에 여러 개의 명령어가 있는 경우는 명령어와 명령어 사이에 삽입.
# 대소문자 구분함
# ctrl + enter : 명령어 실행
# enter : 다음 줄로 이동

# 1. 연산자(operator) ----
# 1-1. 산술 연산자 ----
# +, -, *, /, **, ^, %%, %/%
3 + 4    # 더하기
3 - 4    # 빼기
3 * 4    # 곱하기
3 / 4    # 나누기
3 ** 4   # 거듭제곱
3 ^ 4    # 거듭제곱
13 %% 4  # 나머지
13 %/% 4 # 몫

# 문제1
# 루트3을 위의 산술 연산자를 이용해서 구하시오.
3 ^ (1/2)
sqrt(3)

# 1-2. 할당 연산자 ----
# <-. =
# <- : 일반적인 할당 연산자
# =  : 함수의 argument를 설정할 때 사용하는 할당 연산자
x <- 10
y = 100

# 1-3. 비교 연산자 ----
# >, >=, <, <=, ==, !=, !
# 데이터의 슬라이싱(Slicing)
3 > 4     # 크다
3 >= 4    # 크거나 같다
3 < 4     # 작다
3 == 4    # 같다
3 != 4    # 같지 않다
!(3 == 4) # not

# 1-4. 논리 연산자 ----
# &, |
# & : and, 여러 개의 조건이 동시에 만족될 때 TRUE
# | : or, 여러 개의 조건 중에서 하나만 만족되도 TRUE
# 데이터의 슬라이싱(Slicing)
(3 > 4) & (5 > 4)
(3 > 4) | (5 > 4)

# 2. 데이터의 유형(type of Data) ----
# 2-1. 수치형(Numeric) ----
# (1) 정수(integer)
x1 <- 10

# (2) 실수(double)
x2 <- 10.2

# 2-2. 문자형(Character) ----
x3 <- 'Love is not feeling.'
x4 <- "Love is choice."

# 2-3. 논리형(Logical) ----
x5 <- FALSE # F
x6 <- TRUE  # T


# 3. 데이터 유형을 알아내기 ----
# 3-1. mode(data) ----
# mode의 최종적인 결과는 character
mode(x1)
mode(x3)
mode(x5)

# 3-2. is.xxxx(data) ----
is.numeric(x2)
is.character(x2)
is.logical(x6)


# 4. 강제적으로 데이터 유형을 변경하기 ----
# as.xxxx(data)
x7 <- "10"
as.numeric(x7) #따옴표 안에 숫자가 들어있거나 logical인 경우만 변환
x7 <- as.numeric(x7)
as.numeric(x3)
as.numeric(x4)
as.numeric(x5)
as.numeric(x6)

as.character(x1) # 다 바뀜
as.character(x2)
as.character(x5)
as.character(x6)

as.logical(x1)
as.logical(x2)
as.logical(x3)
as.logical(x4)

# 데이터 유형의 우선순위
# character > numeric > logical
# 0은 FALSE로 변경
# 0 이외의 숫자는 TRUE로 변경
