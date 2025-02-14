knitr::opts_chunk$set(echo = TRUE)

options(scipen=999)
library(tidyverse)
library(lubridate)

military_presence <- read_csv("military_presence.csv")

military_presence <- military_presence %>% 
  mutate(
    Year = year(Date),
    Month = month(Date, label = TRUE, abbr = FALSE)
  )

military_presence_2021 <- military_presence %>% 
  filter(Year == 2021)

#No government data on U.S. troop levels in Afghanistan have been made available since 2017. Government data returned to being made publicly available in December 2021.

military_presence_total_active <- military_presence_2021 %>% 
  group_by(Location, Date) %>% 
  summarize(
    total_army = sum(Army_Active_Duty),
    total_navy = sum(Navy_Active_Duty),
    total_marine_corps = sum(Marine_Corps_Active_Duty),
    total_air_force = sum(Air_Force_Active_Duty),
    total_coast_guard = sum(Coast_Guard_Active_Duty),
    total_active_duty = total_army + total_navy + total_marine_corps + total_air_force + total_coast_guard
  ) %>% 
  select(Location, Date, total_active_duty) %>% 
  arrange(Location, Date, .by_group = TRUE)

military_presence_total_reserve <- military_presence_2021 %>% 
  group_by(Location, Date) %>% 
  summarize(
    total_army = sum(Army_Reserve),
    total_navy = sum(Navy_Reserve),
    total_marine_corps = sum(Marine_Corps_Reserve),
    total_air_force = sum(Air_Force_Reserve),
    total_coast_guard = sum(Coast_Guard_Reserve),
    total_reserve = total_army + total_navy + total_marine_corps + total_air_force + total_coast_guard
  ) %>% 
  select(Location, Date, total_reserve) %>% 
  arrange(Location, Date, .by_group = TRUE)

military_presence_total_active <- military_presence_total_active[-1,]
military_presence_total_reserve <- military_presence_total_reserve[-1,]

#Remove Afghanistan because it's not relevant to our question.

military_presence_active_delta <- military_presence_total_active %>% 
  mutate(delta = total_active_duty - lag(total_active_duty)) %>% 
  select(-total_active_duty) %>% 
  mutate(
    Month = month(Date, label = TRUE, abbr = FALSE)
  )

military_presence_active_delta[is.na(military_presence_active_delta)] = 0

military_presence_reserve_delta <- military_presence_total_reserve %>% 
  mutate(delta = total_reserve - lag(total_reserve)) %>% 
  select(-total_reserve) %>% 
  mutate(
    Month = month(Date, label = TRUE, abbr = FALSE)
  )

military_presence_active_delta[is.na(military_presence_active_delta)] = 0
military_presence_reserve_delta[is.na(military_presence_reserve_delta)] = 0

ggplot() + geom_line(data=military_presence_reserve_delta, aes(x=Date, y=delta, group=Location, color=Location)) + theme(legend.position = "None")


