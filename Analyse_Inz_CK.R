
library(ndjson)
library(tidyverse)
library(jsonlite)
library(R.utils)
library(lubridate)
library(zoo)
library(gridExtra)
library(dplyr)


####################################### Fallzahl-Daten ################################################

data <- read.csv("./matrix_fallzahlen_7tage.csv", check.names = FALSE)
kreise <- read.csv("./Kreise_Dtl_2019.csv",check.names = FALSE, colClasses = c(Ags = "character"), fileEncoding="UTF-8" )

####### Format Datum

data$datenstand <- ymd(data$datenstand)
data$meldewochenbeginn <- ymd(data$meldewochenbeginn) 

####### Get rid of Berlin !?!?

data <- data %>% mutate(tag_nach_7tage = meldewochenbeginn + 7, .after=1)


####################################### Inzidenzen ################################################

ags <- kreise$Ags
data_inz <- data %>% select(c(datenstand,tag_nach_7tage)) 

for(i in 1:length(ags)) {
  
  col = ags[i]
  
  data_new <- data %>% select(c(datenstand,tag_nach_7tage,col))
  names(data_new)[3] <- "fallzahl"
  
  
  kreis <- kreise %>% filter(., ags == col)
  pop <- as.numeric(kreis[,8])
  
  data_new <- data_new %>% mutate(., inz = (fallzahl/pop*100000))%>% select(c(datenstand,tag_nach_7tage,inz))
  names(data_new)[3] <- col
  
  data_inz <- inner_join(data_inz,data_new, by = c("datenstand"="datenstand","tag_nach_7tage"="tag_nach_7tage"))
  
}

####################################### Differenzen ################################################

rki_namen <- kreise %>% select(.,c("Ags","Rkiname") )
data_long <- data_inz %>% gather("Ags", "Inzidenz", 3:414) %>%
             left_join(., rki_namen, by = "Ags")


######## Vergleich: Inzidenzen Datenstand vs. Inzidenzen neu (27.04.2021)

data_vg <- data_long %>% mutate(Ind = case_when(datenstand == tag_nach_7tage  ~ "Datenstand", 
                                                datenstand == "2021-04-27" ~ "Neu")) %>%
                        filter(., !is.na(Ind)) %>%
                        select(., -datenstand) %>%
                        spread(., Ind, Inzidenz )


######### Inzidenzen nach 1/ 3 / 7 /14 Tagen

data_diff <- data_long %>% mutate(Ind = case_when(datenstand == tag_nach_7tage  ~ "Datenstand",
                                                  datenstand-tag_nach_7tage == 1 ~ "nach_1_Tag",
                                                  (datenstand-tag_nach_7tage == 3) ~ "nach_3_Tagen",
                                                  (datenstand-tag_nach_7tage == 7) ~ "nach_7_Tagen",
                                                  (datenstand-tag_nach_7tage == 14) ~ "nach_14_Tagen")) %>%
                            filter(., !is.na(Ind)) %>%
                            select(., -datenstand) %>%
                            spread(., Ind, Inzidenz ) %>%
                            mutate(., delta_1 = nach_1_Tag-Datenstand, delta_3 = nach_3_Tagen-Datenstand, 
                                      delta_7 = nach_7_Tagen-Datenstand,delta_I4=nach_14_Tagen-Datenstand)
                               

####################################### Differenzen - Aggregiert ####################################


data_diff_lk <- data_diff %>%
  group_by(Ags,Rkiname) %>%
  summarise_at(vars(delta_1,delta_3, delta_7,delta_I4), funs(mean, median, max, min), na.rm = TRUE)

data_diff_d <- data_diff %>%
  group_by(tag_nach_7tage) %>%
  summarise_at(vars(delta_1,delta_3, delta_7,delta_I4), funs(mean, median, max, min), na.rm = TRUE)

####################################### PLOTS ################################################

######## Inzidenzen Datenstand vs. Inzidenzen neu (27.04.2021)

# Such einen Kreis aus, bsp. Schwabach
lk = "LK Ansbach"
lk = rki_namen[200,2]

# So unterscheidet sich die Inzidenz zum Datenstand und die "reale" Inzidenz:
data_vg %>%
  filter(Rkiname == lk) %>%
  ggplot() +
  geom_line(aes(x=tag_nach_7tage,y=Neu), color="red") +
  geom_line(aes(x=tag_nach_7tage,y=Datenstand), colour="blue") +
  xlab("Datum") + ylab("Inzidenz") +
  ggtitle(lk, "rot = nach aktuellem Datenstand, blau = nach hist. Datenstand")                                                

######## Verteilung Differenzen nach 3/7 Tagen ~ Tag

data_diff %>% 
  gather("Art", "Delta", 9:12) %>%
  ggplot(aes(x=tag_nach_7tage,y=Delta, group=Art))+
  geom_point(aes(color=Art)) +
  facet_grid(Art~.)    

data_diff %>% 
  gather("Art", "Delta", 9:12) %>%
  ggplot(aes(x=tag_nach_7tage,y=Delta, group=Art))+
  geom_boxplot(aes(fill=Art)) +
  facet_grid(.~Art)

######## Verteilung Differenzen nach 3/7 Tagen ~ LK

data_diff %>% 
  gather("Art", "Delta", 9:12) %>%
  ggplot(aes(x=Ags,y=Delta, group=Art))+
  geom_point(aes(color=Art)) +
  facet_grid(Art~.)    

data_diff %>% 
  gather("Art", "Delta", 9:12) %>%
  ggplot(aes(x=Ags,y=Delta, group=Art))+
  geom_boxplot(aes(fill=Art)) +
  facet_grid(.~Art)

######## Verteilung Median Differenz nach 1/3/7/14 Tagen ~ LK

data_diff_lk %>% 
  gather("Art", "Delta_Med", 7:10) %>%
  ggplot(aes(x=Ags,y=Delta_Med, group=Art))+
  geom_point(aes(color=Art)) +
  facet_grid(Art~.)    

data_diff_lk %>% 
  gather("Art", "Delta_Med", 7:10) %>%
  ggplot(aes(x=Ags,y=Delta_Med, group=Art))+
  geom_boxplot(aes(fill=Art)) +
  facet_grid(.~Art)
  
######## Verteilung Median Differenz nach 1/3/7/14 Tagen ~ Tag

data_diff_d %>% 
  gather("Art", "Delta_Med", 6:9) %>%
  ggplot(aes(x=tag_nach_7tage,y=Delta_Med, group=Art))+
  geom_point(aes(color=Art)) +
  geom_smooth()+
  facet_grid(Art~.)    

data_diff_d %>% 
  gather("Art", "Delta_Med", 6:9) %>%
  ggplot(aes(x=tag_nach_7tage,y=Delta_Med, group=Art))+
  geom_boxplot(aes(fill=Art)) +
  facet_grid(.~Art)
