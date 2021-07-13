install.packages("foreign")
library("foreign")

dt19 <- read.spss("C:/Users/lb1ue/Desktop/2019_Korean_S/2019_SPSS_RAW_KVALUE.sav", use.value.labels=FALSE, to.data.frame=TRUE)
#View(dt19)

dt <- NULL

#변수 일람

# ID 고유번호
dt$pid <- dt19$ID

# SQ2 성별
dt$sex <- dt19$SQ2

# SQ3_1 나이
dt$age <- dt19$SQ3_1


#2. 독립변수
# 자신의 실제 소득보다 자신의 경제적 지위를 낮게 생각하는 것
#문11-후문6
dt$thkclass <- dt19$Q11 #스스로 생각하는 경제적 지위 1) 중산층 미만 2) 중산층 3) 중산층 이상
dt$actincome <- dt19$DQ6 #실제 소득
dt$HMfam <- dt19$DQ4_1 # 가구 구성원 수

#summary(dt$HMfam) 자료상 가구 구성원 수 최대 7
dt$actincome


mid_income_2019 <- c(1707008, 2906528, 3760032, 4613536, 5467040, 6320544, 7174048)
mid_income_2019_50 <- mid_income_2019 * 0.5
mid_income_2019_150 <- mid_income_2019 * 1.5
cutpoint <- c(50, 125, 175, 225, 275, 350, 450, 550, 650, 750, 850)

for (i in 1:11){
    if(dt$actincome == i){
      dt$actincome_won = cutpoint[i]   
    } 
}
dt$actincome_won

dt$real_class_by_mid_income 
    <- if(dt$actincome[dt$HMfam] ) mid_income_2019[dt$HMfam]


#all$marn_c <- cut(all$marn, breaks=c(-Inf, 320000, Inf), labels=c("low", "high"))

#설문지는 100/150/200/250/300/400/500/600/700/800~ 단위로 묻고 있음.
#설문지 범위를 불가피하게 평균을 내서 통계처리를 하고자 함.
# 1번은 50, #2번(100~149)은 125, 3번은 175, 4번은 225, 5번은 275, 6번은 350, 7번은 450, 
#8번은 550, 9번은 650, 10번은 750, 11번은 어떤 기준에도 걸리지 않으므로 판정없이 고소득으로 분류(다만 값은 850)


#OECD는 1995년 기준 중위소득의 50~150을 중산층이라 정의했으나
#비현실적인 기준이라는 지적들(이후 구체서술)에 따라 홍석표 외(2003)에 따라
# 한계계층 50% 미만 / 서민층 50~100% / 중산층 100~150%  / 150% 이상 고소득층


#3. 종속변수
#경쟁/문19-3
#노사갈등/문20-2

#4. 통제변수
#




