library(tidyverse)

setwd(<Hier den Pfad zur working directory einfügen>)

Rohdaten <- read.csv2("Armutsgefaehrdungsquoten_Rentner_und_Pensionaere_2007_bis_2017_(Sonderauswertungen)_Tabelle_1.csv")
#Zusatzinformationen und unnötoge Reihen werden entfernt
Daten <- Rohdaten[-(c(1,2,4,6,9:15)), ]

#Spaltennamen werden gesetzt
colnames(Daten) <- (c("Armutsgefährdungsquote.Deutschland.gemessen_am_Bundesmedian.in_%", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"))

#Datentyp der ersten Spalte wird von factor in character geändert
Daten[,"Armutsgefährdungsquote.Deutschland.gemessen_am_Bundesmedian.in_%"] <- as.character(Daten[,"Armutsgefährdungsquote.Deutschland.gemessen_am_Bundesmedian.in_%"])

#Gegenchecken und nochmal reduzieren
Daten <- Daten[-1, ]

#Erste Spalte erhält sinnvolle Bezeichnungen
Daten["5", "Armutsgefährdungsquote.Deutschland.gemessen_am_Bundesmedian.in_%"] <-  "Personen in Rentner- oder Pensionärshaushalten"
Daten["7", "Armutsgefährdungsquote.Deutschland.gemessen_am_Bundesmedian.in_%"] <-  "Personen in Rentnerhaushalten"
Daten["8", "Armutsgefährdungsquote.Deutschland.gemessen_am_Bundesmedian.in_%"] <-  "Personen in Pensionärshaushalten"

#Eingeklammerte Daten werden NA gesetzt. In den Rohdaten wird darauf hingewiesen, dass sie
#aufgrund des Hochrechnungsprozesses fehlerhaft sein können. WIr entscheiden uns, sie deshalb
#nicht abzubilden.
Daten["8", "2007"] <- NA
Daten["8", "2009"] <- NA


write.csv2(Daten, file= "Armutsgefaehrdungsquote_Rentner_Pensionaere_clean.csv")



