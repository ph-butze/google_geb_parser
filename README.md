# google_geb_parser
## Description 
* small perl script that reads the ics calendar files from google
* birthdays are in following format or similar. using some name and age
```
Name_Surname_Age
```
* parse the name and surname. extend the age by one. and extend the dtstart value by one year to generate all birthdays for the next calendar year
## Syntax:
```
geb.pl <file.ics> <year_to_prozess>
```
