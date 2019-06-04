library(tidyverse)
library(readxl)
library(data.table)

setwd("C:/Users/Veronika/Desktop/Korrektur/xlsx")

#Jedem Bundeslanddatensatz wird eine Rohvariable zugewiesen
Roh_Bund <- read_excel("A1.1.0 DE_Bund.xlsx")
Roh_BW <- read_excel("A1.1.01 BW_Bund.xlsx")
Roh_BY <-read_excel("A1.1.02 BY_Bund.xlsx")
Roh_BE <-read_excel("A1.1.03 BE_Bund.xlsx")
Roh_BB <- read_excel("A1.1.04 BB_Bund.xlsx")
Roh_HB <-read_excel("A1.1.05 HB_Bund.xlsx")
Roh_HH <- read_excel("A1.1.06 HH_Bund.xlsx")
Roh_HE <- read_excel("A1.1.07 HE_Bund.xlsx")
Roh_MV <- read_excel("A1.1.08 MV_Bund.xlsx")
Roh_NI <- read_excel("A1.1.09 NI_Bund.xlsx")
Roh_NW <- read_excel("A1.1.10 NW_Bund.xlsx")
Roh_RP <- read_excel("A1.1.11 RP_Bund.xlsx")
Roh_SL <- read_excel("A1.1.12 SL_Bund.xlsx")
Roh_SN <- read_excel("A1.1.13 SN_Bund.xlsx")
Roh_ST <- read_excel("A1.1.14 ST_Bund.xlsx")
Roh_SH <- read_excel("A1.1.15 SH_Bund.xlsx")
Roh_TH <-read_excel("A1.1.16 TH_Bund.xlsx")

#Grobe Auswahl der Daten, die in der interaktiven Grafik abgebildet werden sollen
# (Legende und das Jahr 2017; Altersgruppen)
#Einheitliche Bennenung der Spalten
Select_Bund <- Roh_Bund[16:25, c(1,14)]
colnames(Select_Bund) <- c("Legende", "Bund" )

Select_BW <- Roh_BW[16:25, c(1,14)]
colnames(Select_BW) <- c("Legende", "BW" )

Select_BY <- Roh_BY[16:25, c(1,14)]
colnames(Select_BY) <- c("Legende", "BY" )

Select_BE <- Roh_BE[16:25, c(1,14)]
colnames(Select_BE) <- c("Legende", "BE" )

Select_BB <- Roh_BB[16:25, c(1,14)]
colnames(Select_BB) <- c("Legende", "BB" )

Select_HB <- Roh_HB[16:25, c(1,14)]
colnames(Select_HB) <- c("Legende", "HB" )

Select_HH <- Roh_HH[16:25, c(1,14)]
colnames(Select_HH) <- c("Legende", "HH" )

Select_HE <- Roh_HE[16:25, c(1,14)]
colnames(Select_HE) <- c("Legende", "HE" )

Select_MV <- Roh_MV[16:25, c(1,14)]
colnames(Select_MV) <- c("Legende", "MV" )

Select_NI <- Roh_NI[16:25, c(1,14)]
colnames(Select_NI) <- c("Legende", "NI" )

Select_NW <- Roh_NW[16:25, c(1,14)]
colnames(Select_NW) <- c("Legende", "NW" )

Select_RP <- Roh_RP[16:25, c(1,14)]
colnames(Select_RP) <- c("Legende", "RP" )

Select_SL <- Roh_SL[16:25, c(1,14)]
colnames(Select_SL) <- c("Legende", "SL" )

Select_SN <- Roh_SN[16:25, c(1,14)]
colnames(Select_SN) <- c("Legende", "SN" )

Select_ST <- Roh_ST[16:25, c(1,14)]
colnames(Select_ST) <- c("Legende", "ST" )

Select_SH <- Roh_SH[16:25, c(1,14)]
colnames(Select_SH) <- c("Legende", "SH" )

Select_TH <- Roh_TH[16:25, c(1,14)]
colnames(Select_TH) <- c("Legende", "TH" )

#Stichprobe, ob die Daten noch richtig zugeordnet sind
Roh_Bund[20, 14] == Select_Bund[5,2]
Roh_BW[20, 14] == Select_BW[5,2]
Roh_SL[20, 14] == Select_SL[5,2]

#Zusammenführen der Datensätze aller Bundesländer für das Jahr 2017
Zusammen <- cbind(Select_Bund, Select_BW, Select_BY, Select_BE, Select_BB, Select_HB, Select_HH, Select_HE, Select_MV, Select_NI, Select_NW, Select_RP, Select_SL, Select_SN, Select_ST, Select_SH, Select_TH)

#Löschen der überschüssingen Legendenspalten
#Einfügen einer einheitlichen Legende
Rohdaten <- Zusammen[ , -which(names(Zusammen) %in% c("Legende"))]
Rohdaten <- cbind(Zusammen$Legende, Rohdaten)

#Fein-Auswahl der Daten, die für die Grafik relevant sind
#Neue Bezeichnungen für die Spalten
Daten_1 <- Rohdaten[c(5,10), ]
Daten_1$`Zusammen$Legende` <- as.character(Daten_1$`Zusammen$Legende`)
Daten_1[1,1] <- "Männer, 65 Jahre und älter"
Daten_1[2,1] <- "Frauen, 65 Jahre und älter"

#Eingeklammerte Daten werden NA gesetzt. In den Rohdaten wird darauf hingewiesen, dass sie
#aufgrund des Hochrechnungsprozesses fehlerhaft sein können. Wir entscheiden uns, sie deshalb
#nicht abzubilden.
Daten_1["5", "HB"] <- NA


#Einzige Spalte mit Werten vom Typ character wird entfernt
Daten <- Daten_1[, -1]

# Spalte wird für späteres wiedereinfügen gesichert
Erste_Spalte <- c(unname(unlist(Daten_1[ ,1])),  "Differenz")

#Kombinierte Lösung innerhalb des Datenframes; neue Reihe mit rbind;
#Die Datentypen der beiden Reihen werden mit as.numeric umgewandelt und dann subtrahiert
#diese Differenz word in der neuen reihe abgebildet
Daten <- rbind(Daten, ( (as.numeric(Daten[2, ]) )- (as.numeric(Daten[1, ]) ) ))

#Erste SPalte wieder einfügen
Daten <- cbind(Erste_Spalte, Daten)


#Probe, ob die ausgewählten Spaltentitel den Abkürzungen der Bundesländer entsprechen
Probe <- rbind (Daten, c("Armutsgefährdungsquote_2017_nach.Alter.und.Geschlecht_gemessen.am.Bundesmedian_in.%", "Bundesrepublik Deutschland", "Baden-Württemberg", "Bayern", "Berlin", "Brandenburg", "Bremen", "Hamburg", "Hessen", "Mecklenburg-Vorpommern", "Niedersachsen", "Nordrhein-Westfalen", "Rheinland-Pfalz", "Saarland", "Sachsen", "Sachsen-Anhalt","Schleswig-Holstein", "Thüringen"))

#Spaltentitel werden gesetzt; ausgewählte Infos in Spaltentitel 1
colnames(Daten) <- c("Armutsgefährdungsquote_2017_nach.Alter.und.Geschlecht_gemessen.am.Bundesmedian_in.%", "Bundesrepublik Deutschland", "Baden-Württemberg", "Bayern", "Berlin", "Brandenburg", "Bremen", "Hamburg", "Hessen", "Mecklenburg-Vorpommern", "Niedersachsen", "Nordrhein-Westfalen", "Rheinland-Pfalz", "Saarland", "Sachsen", "Sachsen-Anhalt","Schleswig-Holstein", "Thüringen")

write.csv2(Daten, "Armutsgefaehrdungsquote_2017_BL_Alter_Geschlecht_clean.csv", row.names = FALSE)

