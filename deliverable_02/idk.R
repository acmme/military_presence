knitr::opts_chunk$set(echo = TRUE)

library(tidyverse)
library(lubridate)
library(readxl)

dec_2013 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/dec_2013.xlsx")
dec_2014 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/dec_2014.xlsx")
dec_2015 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/dec_2015.xlsx")
dec_2016 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/dec_2016.xlsx")
dec_2017 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/dec_2017.xlsx")
dec_2018 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/dec_2018.xlsx")
dec_2019 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/dec_2019.xlsx")

sept_2008 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2008.xlsx")
sept_2009 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2009.xlsx")
sept_2010 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2010.xlsx")
sept_2011 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2011.xlsx")
sept_2012 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2012.xlsx")
sept_2013 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2013.xlsx")
sept_2014 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2014.xlsx")
sept_2015 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2015.xlsx")
sept_2016 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2016.xlsx")
sept_2017 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2017.xlsx")
sept_2018 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2018.xlsx")
sept_2019 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/sept_2019.xlsx")

june_2014 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/june_2014.xlsx")
june_2015 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/june_2015.xlsx")
june_2016 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/june_2016.xlsx")
june_2017 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/june_2017.xlsx")
june_2018 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/june_2018.xlsx")
june_2019 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/june_2019.xlsx")

march_2014 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/march_2014.xlsx")
march_2015 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/march_2015.xlsx")
march_2016 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/march_2016.xlsx")
march_2017 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/march_2017.xlsx")
march_2018 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/march_2018.xlsx")
march_2019 <- read_xlsx("~/GitHub/military_presence/deliverable_02/unconsolidated_data/raw_data/march_2019.xlsx")

military_presence_data <- bind_rows(
  list("12-01-2013" = dec_2013, 
       "12-01-2014" = dec_2014, 
       "12-01-2015" = dec_2015, 
       "12-01-2016" = dec_2016, 
       "12-01-2017" = dec_2017, 
       "12-01-2018" = dec_2018, 
       "12-01-2019" = dec_2019, 
       "09-01-2008" = sept_2008, 
       "09-01-2009" = sept_2009, 
       "09-01-2010" = sept_2010, 
       "09-01-2011" = sept_2011, 
       "09-01-2012" = sept_2012, 
       "09-01-2013" = sept_2013, 
       "09-01-2014" = sept_2014, 
       "09-01-2015" = sept_2015, 
       "09-01-2016" = sept_2016, 
       "09-01-2017" = sept_2017, 
       "09-01-2018" = sept_2018, 
       "09-01-2019" = sept_2019, 
       "06-01-2014" = june_2014, 
       "06-01-2015" = june_2015, 
       "06-01-2016" = june_2016, 
       "06-01-2017" = june_2017, 
       "06-01-2018" = june_2018, 
       "06-01-2019" = june_2019, 
       "03-01-2014" = march_2014, 
       "03-01-2015" = march_2015, 
       "03-01-2016" = march_2016, 
       "03-01-2017" = march_2017, 
       "03-01-2018" = march_2018, 
       "03-01-2019" = march_2019), .id = 'Date')

military_presence_data <- military_presence_data %>% 
  select(-c(2, 9, 17, 23, 24, 25)) %>% 
  filter(!row_number() %in% c(1, 2, 3, 4)) %>% 
  rename(Location = c(2), 
         Army_Active_Duty = c(3), 
         Navy_Active_Duty = c(4), 
         Marine_Corps_Active_Duty = c(5),
         Air_Force_Active_Duty = c(6),
         Coast_Guard_Active_Duty = c(7),
         Army_National_Guard = c(8),
         Army_Reserve = c(9),
         Navy_Reserve = c(10),
         Marine_Corps_Reserve = c(11),
         Air_National_Guard = c(12),
         Air_Force_Reserve = c(13),
         Coast_Guard_Reserve = c(14),
         Army_APF_DOD_Civilian = c(15),
         Navy_APF_DOD_Civilian = c(16),
         Marine_Corps_APF_DOD_Civilian = c(17),
         Air_Force_APF_DOD_Civilian = c(18),
         Fourth_Estate_DOD = c(19)
         ) %>% 
  filter(!row_number() %in% c(1, 2))

military_presence_data <- military_presence_data %>% 
  drop_na(Location, Navy_Active_Duty)

i <- c(3:19)

military_presence_data[ , i] <- apply(military_presence_data[ , i], 2, function(x) as.numeric(as.character(x)))

military_presence_data$Date <- mdy(military_presence_data$Date)
