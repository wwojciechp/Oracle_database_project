/* WIDOKI */

drop view V_Pracownicy_Zarobki;

drop view V_Oddzial_Zestawienie;

drop view V_Przetargi_Umowy;

drop view V_Ukonczone_Drogi;

/* TRIGGERY */

drop trigger TR_Aneks;

drop trigger TR_ETAP;

drop trigger TR_WYNAGRODZENIE;

/* Procedury */

drop procedure PR_Zmiana_W;

drop procedure PR_STAN_DROG;

drop procedure PR_SERWIS;

/* Funkcje */

drop function FN_SREDNI_ODCINEK;

drop function FN_Firma;

drop function FN_Polecenie;

drop package Opakowanie;

/* SEKWENCJE */

drop sequence seq_aneks;

drop sequence seq_Wykonawca;

drop sequence seq_Umowa;

drop sequence seq_Przetarg;

drop sequence seq_Oddzial;

drop sequence seq_Pracownik;

drop sequence seq_Pojazd;

drop sequence seq_Zadanie;

drop sequence seq_Droga;

drop sequence seq_Etap;

/* TABELE */

drop table Aneks cascade constraints;

drop table Droga cascade constraints;

drop table Etap cascade constraints;

drop table Oddzial cascade constraints;

drop table Pojazd cascade constraints;

drop table Polecenie cascade constraints;

drop table Pracownik cascade constraints;

drop table Przetarg cascade constraints;

drop table Umowa cascade constraints;

drop table Wyjazd cascade constraints;

drop table Wykonawca cascade constraints;

drop table Zadanie cascade constraints;



