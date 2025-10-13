library(jsonlite)
library(dplyr)
library(lubridate)

data <- fromJSON("/Users/chengxianghuang/Downloads/taiwan_pet1009.json", flatten = TRUE)

data <- data %>%
  select(
    -animal_subid,
    -animal_place,
    -animal_foundplace,
    -animal_title,
    -animal_status,
    -animal_caption,
    -animal_closeddate,
    -shelter_name,
    -album_file,
    -album_update,
    -shelter_address,
    -shelter_tel
  )

#1.清理資料


# 把所有空白字串 ("") 轉為 NA
data[data == ""] <- NA

# 移除所有字串欄位的首尾空白後，再處理空白值、na
data <- data %>%
  mutate(across(where(is.character), ~ trimws(.))) %>%
  mutate(across(where(is.character), ~ na_if(., "")))

colSums(is.na(data))

data <- data %>% filter(!is.na(animal_colour),
                        !is.na(animal_Variety),
                        !is.na(animal_age),
                        !is.na(animal_opendate),
                        !is.na(animal_update),
                        !is.na(cDate))

#2.轉換日期欄位

date_cols <- c("animal_opendate", "animal_update", "animal_createtime", "cDate")

data <- data %>%
  mutate(across(all_of(date_cols), ymd))


summary(select(data, animal_opendate, animal_createtime, animal_update,cDate))

data <- data %>%
  mutate(year = year(animal_update))
names(data)

#3.建立新變數

data <- data %>%
  mutate(
    is_cat = ifelse(animal_kind == "貓", 1, 0),
    is_dog = ifelse(animal_kind == "狗", 1, 0),
    
    gender = case_when(
      animal_sex == "M" ~ 1,
      animal_sex == "F" ~ 0,
      TRUE ~ NA_real_
    ),
    
    is_sterilized = ifelse(animal_sterilization == "T", 1, 0),
    is_vaccinated = ifelse(animal_bacterin == "T", 1, 0),
    
    is_small = ifelse(animal_bodytype == "SMALL", 1, 0),
    
    animal_opendate = ymd(animal_opendate),
    days_since_open = as.numeric(Sys.Date() - animal_opendate),
    over_6_months  = ifelse(days_since_open >= 183, 1, 0),
    over_1_year = ifelse(days_since_open >= 365, 1, 0),
    over_2_years   = ifelse(days_since_open >= 730, 1, 0)
  )

#4.輸出清理後的資料

write.csv(data, "taiwan_pet1009.csv", row.names = FALSE)
