# Datenaufbereitung "Risiko Rente"&nbsp;											(Online-Dossier "Alter!", ifp M�nchen)

F�r das Abschlussprojekt an der katholischen Journalistenschule ifp haben die Volont�re des Jahrgangs 2017 das Online-Dossier "Alter!" erarbeitet. Wir, das Autorenteam Janosch Beyer und Claudia Kohler, erz�hlen darin eine datengetriebene Geschichte �ber das "Risiko Rente". Hier k�nnt ihr Akquise und Aufbereitung der Daten nachvollziehen.


## Daten

Folgende Daten sind die Grundlage unserers Artikels und der interaktiven Grafiken. Sie liegen im Ordner Rohdaten.
+ Deutsches Zentrum f�r Altersfragen > Statistisches Informationssystem GeroStat > Warmmiete und Mietbelastung > 2014

	� GeroStat - Deutsches Zentrum f�r Altersfragen, Berlin. DOI 10.5156/GEROSTAT - Deutscher Alterssurvey (DEAS) - 1996, 2002, 2008, 2014

	https://www.gerostat.de/scheduler2.py?Att_1=REGION&Att_1=D&Att_2=ALTERSGR&Att_2=40-54&Att_3=GESCHLECHT&Att_3=I&Att_4=WELLE&Att_4=2014&Att_1=D&Att_2=40-54&Att_2=55-69&Att_2=70-85&Att_3=I&Att_4=2014&Att_5=MERKMAL&Att_5=DU_MIETE&Att_5=DU_MIETE&Att_5=ANTEIL_MIETE&Att_6=NULL&Att_7=NULL&VALUE_=D2%28QCode%2CFormat%2CWert%29&RESTRICT=YES&SUBMIT=Anfrage&TABLE_=AS4_WO_06__DE

+ Statistik der Deutschen Rentenversicherung > Rente 2017 (Band 212)

	https://statistik-rente.de/drv/extern/publikationen/aktuelle_statistikbaende/documents/Rente_2017.pdf

+ Statistische �mter des Bundes und der L�nder > Mikrozensus 2017 > Sonderauswertungen zu armutsgef�hrdeten Personen in Rentner- bzw. Pension�rshaushalten in Deutschland (angefordert von Matthias Birkwald und Gerd Bosbach)

	Dieser Datensatz wurden uns vom Statistischen Bundesamt auf Anfrage bereitgestellt.

+ Statistische �mter des Bundes und der L�nder > Mikrozensus 2017 > Armutsgef�hrdungsquoten nach soziodemografischen Merkmalen

	http://www.amtliche-sozialberichterstattung.de/A1armutsgefaehrdungsquoten.html
	
## Aufbereitung

Die Rohdaten wurden von uns mit der Programmiersprache R in der IDE R-Studio bereinigt. Unter anderem wurden Datenbereiche selektiert, Zahlenwerte von Zeichen befreit und die Werte so angeordnet, dass sie optimal visualisiert werden k�nnen. F�r jede Bereinigung wurde ein Skript erstellt - so k�nnen die einzelnen Schritte nachvollzogen und reproduziert werden. Die Skripte liegen auf der obersten Ebene des Repositorys, die bereinigten Datens�tze im Ordner Clean. Jeder Grafik unseres Artikels liegt einer dieser bereinigten Datens�tze zugrunde.
