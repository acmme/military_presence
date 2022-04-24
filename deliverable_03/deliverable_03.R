
knitr::opts_chunk$set(echo = TRUE)

options(scipen=999)
library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(rvest)

expenditure_url <- "https://en.wikipedia.org/wiki/Past_military_expenditure_by_country"

expenditure_tables <- expenditure_url %>% 
  read_html() %>% 
  html_table()

table1 <- expenditure_tables[[1]]
table2 <- expenditure_tables[[2]]
table3 <- expenditure_tables[[3]]
table4 <- expenditure_tables[[4]]

US_expenditure_data <- table1 %>%
  left_join(table2, by=c('Country'='Country')) %>% 
  left_join(table3, by=c('Country'='Country')) %>% 
  left_join(table4, by=c('Country'='Country'))

US_expenditure_data <- US_expenditure_data %>% 
  slice(19) %>% 
  select(-c(1))

US_expenditure_data <- US_expenditure_data %>% 
  pivot_longer(c(1:33))

US_expenditure_data <- US_expenditure_data %>% 
  rename("Year" = "name", "Millions_of_dollars" = "value")

military_presence_data <- read_csv("military_presence.csv")

military_presence_data <- military_presence_data %>% 
  mutate(
    Year = year(Date)
  )

total_active_duty <- military_presence_data %>% 
  group_by(Year) %>% 
  summarize(
    total_army = sum(Army_Active_Duty),
    total_navy = sum(Navy_Active_Duty),
    total_marine_corps = sum(Marine_Corps_Active_Duty),
    total_air_force = sum(Air_Force_Active_Duty),
    total_coast_guard = sum(Coast_Guard_Active_Duty),
    total_active_duty = total_army + total_navy + total_marine_corps + total_air_force + total_coast_guard
  )

ggplot() +
  geom_line(data = US_expenditure_data, aes(x = Year, y = Millions_of_dollars, group = 1)) +
  theme(
    axis.text.x = element_text(angle = 45,  hjust=1)
  ) +
  geom_line (data = total_active_duty, aes(x = Year, y = total_active_duty))