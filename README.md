# Datenaufbereitung "Risiko Rente"&nbsp;											(Online-Dossier "Alter!", ifp München)

Für das Abschlussprojekt an der katholischen Journalistenschule ifp haben die Volontäre des Jahrgangs 2017 das Online-Dossier "Alter!" erarbeitet. Wir, das Autorenteam Janosch Beyer und Claudia Kohler, erzählen darin eine datengetriebene Geschichte über das "Risiko Rente". Hier könnt ihr Akquise und Aufbereitung der Daten nachvollziehen.


## Daten

Folgende Daten sind die Grundlage unserers Artikels und der interaktiven Grafiken. Sie liegen im Ordner Rohdaten.
+ Deutsches Zentrum für Altersfragen > Statistisches Informationssystem GeroStat > Warmmiete und Mietbelastung > 2014

	© GeroStat - Deutsches Zentrum für Altersfragen, Berlin. DOI 10.5156/GEROSTAT - Deutscher Alterssurvey (DEAS) - 1996, 2002, 2008, 2014

	https://www.gerostat.de/scheduler2.py?Att_1=REGION&Att_1=D&Att_2=ALTERSGR&Att_2=40-54&Att_3=GESCHLECHT&Att_3=I&Att_4=WELLE&Att_4=2014&Att_1=D&Att_2=40-54&Att_2=55-69&Att_2=70-85&Att_3=I&Att_4=2014&Att_5=MERKMAL&Att_5=DU_MIETE&Att_5=DU_MIETE&Att_5=ANTEIL_MIETE&Att_6=NULL&Att_7=NULL&VALUE_=D2%28QCode%2CFormat%2CWert%29&RESTRICT=YES&SUBMIT=Anfrage&TABLE_=AS4_WO_06__DE

+ Statistik der Deutschen Rentenversicherung > Rente 2017 (Band 212)

	https://statistik-rente.de/drv/extern/publikationen/aktuelle_statistikbaende/documents/Rente_2017.pdf

+ Statistische Ämter des Bundes und der Länder > Mikrozensus 2017 > Sonderauswertungen zu armutsgefährdeten Personen in Rentner- bzw. Pensionärshaushalten in Deutschland (angefordert von Matthias Birkwald und Gerd Bosbach)

	Dieser Datensatz wurden uns vom Statistischen Bundesamt auf Anfrage bereitgestellt.

+ Statistische Ämter des Bundes und der Länder > Mikrozensus 2017 > Armutsgefährdungsquoten nach soziodemografischen Merkmalen

	http://www.amtliche-sozialberichterstattung.de/A1armutsgefaehrdungsquoten.html
	
## Aufbereitung

Die Rohdaten wurden von uns mit der Programmiersprache R in der IDE R-Studio bereinigt. Unter anderem wurden Datenbereiche selektiert, Zahlenwerte von Zeichen befreit und die Werte so angeordnet, dass sie optimal visualisiert werden können. Für jede Bereinigung wurde ein Skript erstellt - so können die einzelnen Schritte nachvollzogen und reproduziert werden. Die Skripte liegen auf der obersten Ebene des Repositorys, die bereinigten Datensätze im Ordner Clean. Jeder Grafik unseres Artikels liegt einer dieser bereinigten Datensätze zugrunde.
