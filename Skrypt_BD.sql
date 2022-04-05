/* TABELE */
CREATE TABLE aneks (
    id_aneks          NUMBER NOT NULL,
    data_modyfikacji  DATE NOT NULL,
    zmiana_kwoty      FLOAT,
    zmiana_terminu    DATE,
    stara_kwota       FLOAT,
    stary_termin      DATE,
    id_umowy    NUMBER NOT NULL
);

ALTER TABLE aneks ADD CONSTRAINT aneks_pk PRIMARY KEY ( id_aneks );

COMMENT ON TABLE Aneks IS
'Zawierany jest przy zmiane daty czy tez kwoty na jaka byla podpisana umowa';

COMMENT ON COLUMN aneks.id_aneks IS
    'Numer identyfikujacy aneks';

COMMENT ON COLUMN aneks.data_modyfikacji IS
    'Data kiedy aneks zostal podpisany';

COMMENT ON COLUMN aneks.zmiana_kwoty IS
    'Kwota na jaka aneks zostal podpisany';

COMMENT ON COLUMN aneks.zmiana_terminu IS
    'Przedluzenie terminu trwania umowy';

COMMENT ON COLUMN aneks.stara_kwota IS
    'Wczesniejsza kwota widniejaca na umowie';

COMMENT ON COLUMN aneks.stary_termin IS
    'Wczesniejszy termin zakonczenia umowy';

CREATE TABLE droga (
    id_drogi     NUMBER NOT NULL,
    nazwa_drogi  VARCHAR2(3) NOT NULL,
    typ_drogi    VARCHAR2(3) NOT NULL CONSTRAINT CKC_TYPDROGI_DROGA CHECK (Typ_Drogi IN ('A','S','DK') AND Typ_Drogi = UPPER(Typ_Drogi))
);

COMMENT ON TABLE Droga IS
'Skladajaca sie z n etapow';

COMMENT ON COLUMN Droga.Id_Drogi IS
'Identyfikator Drogi';

COMMENT ON COLUMN Droga.Nazwa_Drogi IS
'Nazwa drogi przypisany jej numer, dla Autostrady z przedrostkiem A, dla drogi ekspresowej S';

COMMENT ON COLUMN Droga.Typ_Drogi IS
'Trzy typy drog Autostrada A, Droga Ekspresowa S, oraz droga krajowa DK';

ALTER TABLE droga ADD CONSTRAINT droga_pk PRIMARY KEY ( id_drogi );

CREATE TABLE etap (
    id_etapu            NUMBER NOT NULL,
    nazwa_etapu         VARCHAR2(50) NOT NULL,
    dlugosc             FLOAT NOT NULL,
    ilosc_wiaduktow     INTEGER NOT NULL,
    stan_etapu          VARCHAR2(1) DEFAULT 'N' NOT NULL
      CONSTRAINT CKC_STANETAPU_ETAP CHECK (Stan_Etapu IN ('N','U') AND Stan_Etapu = UPPER(Stan_Etapu)),
    id_oddzial  NUMBER,
    id_drogi      NUMBER NOT NULL
);

ALTER TABLE etap ADD CONSTRAINT etap_pk PRIMARY KEY ( id_etapu );

COMMENT ON TABLE Etap IS
'Etap ktory jest skladowa calej drogi';

COMMENT ON COLUMN Etap.Id_Etapu IS
'Identyfikator Etapu';

COMMENT ON COLUMN Etap.Id_Oddzial IS
'Identyfikator Oddzialu';

COMMENT ON COLUMN Etap.Id_Drogi IS
'Identyfikator Drogi';

COMMENT ON COLUMN Etap.Nazwa_Etapu IS
'Nazwa Etapu pewnej czesci drogi';

COMMENT ON COLUMN Etap.Dlugosc IS
'Dlugosc etapu wyrazana w kilometrach';

COMMENT ON COLUMN Etap.Ilosc_Wiaduktow IS
'Ilosc konstrukcji wznoszonych na dlugosci danego etapu';

COMMENT ON COLUMN Etap.Stan_Etapu IS
'Informacja czy etap jest ukoczyony tj oddany do uzytku czy tez nie';

CREATE TABLE oddzial (
    id_oddzial      NUMBER NOT NULL,
    nazwa_oddzialu  VARCHAR2(30) NOT NULL,
    kod_pocztowy    VARCHAR2(6) NOT NULL,
    poczta          VARCHAR2(50) NOT NULL,
    ulica           VARCHAR2(30) NOT NULL,
    nr_lokalu       VARCHAR2(15) NOT NULL
);

ALTER TABLE oddzial ADD CONSTRAINT oddzial_pk PRIMARY KEY ( id_oddzial );

COMMENT ON TABLE Oddzial IS
'Jedna z czeci tworzacych cale GDDKiA dzialajace w danym regionie';

COMMENT ON COLUMN Oddzial.Id_Oddzial IS
'Identyfikator Oddzialu';

COMMENT ON COLUMN Oddzial.Nazwa_Oddzialu IS
'Nazwa jednego z oddzialow Generalnej Dyrekcji Drog Krajowych i Autostrad';

COMMENT ON COLUMN Oddzial.Kod_Pocztowy IS
'Kod pocztowy o wzorcu xx-xxx';

COMMENT ON COLUMN Oddzial.Poczta IS
'Nazwa miejscowosci urzedu pocztowego';

COMMENT ON COLUMN Oddzial.Ulica IS
'Nazwa ulicy przy ktorej znajduje sie oddzial GDDKiA';

COMMENT ON COLUMN Oddzial.Nr_Lokalu IS
'Numer identyfikujacy lokal';

CREATE TABLE pojazd (
    id_pojazdu          NUMBER NOT NULL,
    nr_rejestracyjny    VARCHAR2(9) NOT NULL,
    typ_pojazdu         VARCHAR2(15) NOT NULL,
    ostatni_przeglad    FLOAT,
    aktualny_przebieg   FLOAT,
    stan                VARCHAR2(1),
    id_oddzial  NUMBER NOT NULL
);

ALTER TABLE pojazd ADD CONSTRAINT pojazd_pk PRIMARY KEY ( id_pojazdu );

COMMENT ON TABLE Pojazd IS
'Pojazd uzytkowy pozwalajacy na prace w terenie czy tez lokalnie';

COMMENT ON COLUMN Pojazd.Id_Pojazdu IS
'Numer identyfikujacy pojazd w bazie GDDKiA';

COMMENT ON COLUMN Pojazd.Id_Oddzial IS
'Identyfikator Oddzialu';

COMMENT ON COLUMN Pojazd.Nr_Rejestracyjny IS
'Numer rejestracyjny identyfikujacy pojazd w CEPIK';

COMMENT ON COLUMN Pojazd.Typ_Pojazdu IS
'Typ pojazdu: plug, ciezarowy, osobowy itd';

COMMENT ON COLUMN Pojazd.Ostatni_Przeglad IS
'Opisuje stan licznika podczas ostatniego badania diagnostycznego';

COMMENT ON COLUMN Pojazd.Aktualny_Przebieg IS
'Pracownik po dniu pracy zobowiazdany jest o modyfikacje przegbiegu na aktualny';

COMMENT ON COLUMN Pojazd.Stan IS
'Opisuje czy pojazd musi zostac poddany badaniu technicznemu jesli tak jego status to S';

CREATE TABLE polecenie (
    id_zadania       NUMBER NOT NULL,
    id_pracownika    NUMBER NOT NULL
);

ALTER TABLE polecenie ADD CONSTRAINT polecenie_pk PRIMARY KEY ( id_zadania,
                                                                id_pracownika );

COMMENT ON COLUMN Polecenie.Id_Zadania is
'Numer Identyfikujacy zadanie';

COMMENT ON COLUMN Polecenie.Id_Pracownika is
'Numer identyfikujacy pracownika';

CREATE TABLE pracownik (
    id_pracownika       NUMBER NOT NULL,
    nazwisko            VARCHAR2(30) NOT NULL,
    imie                VARCHAR2(15) NOT NULL,
    pesel               VARCHAR2(11) NOT NULL,
    stanowisko          VARCHAR2(30) NOT NULL,
    data_urodzenia      DATE NOT NULL,
    plec                VARCHAR2(1) DEFAULT 'M' NOT NULL
      CONSTRAINT CKC_PLEC_PRACOWNI CHECK (Plec IN ('K','M') AND Plec = UPPER(Plec)),
    wynagrodzenie       INTEGER NOT NULL,
    id_oddzial  NUMBER NOT NULL
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( id_pracownika );

COMMENT ON TABLE Pracownik IS
'Osona fizyczna zatrudniona w GDDKiA na okreslonym stanowisku';

COMMENT ON COLUMN Pracownik.Id_Pracownika IS
'Numer identyfikujacy pracownika';

COMMENT ON COLUMN Pracownik.Id_Oddzial IS
'Identyfikator Oddzialu';

COMMENT ON COLUMN Pracownik.Nazwisko IS
'Nazwisko pracownika';

COMMENT ON COLUMN Pracownik.Imie IS
'Imie pracownika';

COMMENT ON COLUMN Pracownik.PESEL IS
'Numer PESEL pracownika';

COMMENT ON COLUMN Pracownik.Stanowisko IS
'Zajmowane stanowisko przez pracownika';

COMMENT ON COLUMN Pracownik.Data_Urodzenia IS
'Data Urodzenia pracownika';

COMMENT ON COLUMN Pracownik.Wynagrodzenie IS
'Placa Brutto pracownika  w PLN';

CREATE TABLE przetarg (
    id_przetargu         NUMBER NOT NULL,
    data_rozp_przetargu  DATE NOT NULL,
    data_zak_przetargu   DATE NOT NULL,
    id_oddzial   NUMBER NOT NULL,
    id_etapu        NUMBER NOT NULL
);

ALTER TABLE przetarg ADD CONSTRAINT przetarg_pk PRIMARY KEY ( id_przetargu );

COMMENT ON TABLE Przetarg IS
'Umowa nie moze zostac zawarta bez rozpoczecia na nia przetargu - warunek konieczny';

COMMENT ON COLUMN Przetarg.Id_Przetargu IS
'Numer identyfikujacy przetarg';

COMMENT ON COLUMN Przetarg.Id_Etapu IS
'Identyfikator Etapu';

COMMENT ON COLUMN Przetarg.Id_Oddzial IS
'Identyfikator Oddzialu';

COMMENT ON COLUMN Przetarg.Data_Rozp_Przetargu IS
'Data okreslajaca rozpoczecie przetargu';

COMMENT ON COLUMN Przetarg.Data_Zak_Przetargu IS
'Data okreslajaca zakonczenie przetargu';

CREATE TABLE umowa (
    id_umowy                NUMBER NOT NULL,
    kwota                   FLOAT NOT NULL,
    data_podpisania         DATE NOT NULL,
    data_wygasniecia        DATE NOT NULL,
    id_przetargu   NUMBER NOT NULL,
    id_wykonawcy  NUMBER NOT NULL
);

ALTER TABLE umowa ADD CONSTRAINT umowa_pk PRIMARY KEY ( id_umowy );

COMMENT ON TABLE Umowa IS
'Jest niezbedna do rozpoczecia budowy drogi';

COMMENT ON COLUMN Umowa.Id_Umowy IS
'Numer identyfikujacy umowe';

COMMENT ON COLUMN Umowa.Id_Wykonawcy IS
'Numer identyfikujacy wykonawce';

COMMENT ON COLUMN Umowa.Id_Przetargu IS
'Numer identyfikujacy przetarg';

COMMENT ON COLUMN Umowa.Kwota IS
'Kwota w PLN na jaka podpisywana jest umowa';

COMMENT ON COLUMN Umowa.Data_Podpisania IS
'Data zawarcia umowy';

COMMENT ON COLUMN Umowa.Data_Wygasniecia IS
'Data kiedy umowa zostaje rozwiazana';

CREATE TABLE wyjazd (
    id_pojazdu   NUMBER NOT NULL,
    id_zadania  NUMBER NOT NULL
);

ALTER TABLE wyjazd ADD CONSTRAINT wyjazd_pk PRIMARY KEY ( id_pojazdu,
                                                          id_zadania );

COMMENT ON COLUMN Wyjazd.Id_Pojazdu IS
'Numer identyfikujacy pojazd w bazie GDDKiA';

COMMENT ON COLUMN Wyjazd.Id_Zadania IS
'Numer Identyfikujacy zadanie';

CREATE TABLE wykonawca (
    id_wykonawcy  NUMBER NOT NULL,
    nazwa_firmy    VARCHAR2(50) NOT NULL
);

ALTER TABLE wykonawca ADD CONSTRAINT wykonawca_pk PRIMARY KEY ( id_wykonawcy );

COMMENT ON TABLE  Wykonawca IS
'Firma zajmujaca sie przedsiewzieciem';

COMMENT ON COLUMN  Wykonawca.Id_Wykonawcy IS
'Numer identyfikujacy wykonawce';

COMMENT ON COLUMN  Wykonawca.Nazwa_Firmy IS
'Nazwa Firmy podejmującej sie przedsiewziecia';

CREATE TABLE zadanie (
    id_zadania     NUMBER NOT NULL,
    nazwa_zadania  VARCHAR2(50) NOT NULL,
    typ_zadania    VARCHAR2(15) default 'N' NOT NULL
      CONSTRAINT CKC_TYPZADANIA_ZADANIE CHECK (Typ_Zadania IN ('S','N') AND Typ_Zadania = UPPER(Typ_Zadania))
);

ALTER TABLE zadanie ADD CONSTRAINT zadanie_pk PRIMARY KEY ( id_zadania );

COMMENT ON TABLE Zadanie IS
'Zadanie postawione przed pojzdem oraz pracownikiem';

COMMENT ON COLUMN Zadanie.Id_Zadania IS
'Numer Identyfikujacy zadanie';

COMMENT ON COLUMN Zadanie.Nazwa_Zadania IS
'Uproszczona nazwa zleconego zadania';

COMMENT ON COLUMN Zadanie.Typ_Zadania IS
'Typ zadania S stacjonarnie lub N nie stacjonarnie (wyjazd)';

ALTER TABLE aneks
    ADD CONSTRAINT aneks_umowa_fk FOREIGN KEY ( id_umowy )
        REFERENCES umowa ( id_umowy );

ALTER TABLE etap
    ADD CONSTRAINT etap_droga_fk FOREIGN KEY ( id_drogi )
        REFERENCES droga ( id_drogi );

ALTER TABLE etap
    ADD CONSTRAINT etap_oddzial_fk FOREIGN KEY ( id_oddzial )
        REFERENCES oddzial ( id_oddzial );

ALTER TABLE pojazd
    ADD CONSTRAINT pojazd_oddzial_fk FOREIGN KEY ( id_oddzial )
        REFERENCES oddzial ( id_oddzial );

ALTER TABLE polecenie
    ADD CONSTRAINT polecenie_pracownik_fk FOREIGN KEY ( id_pracownika )
        REFERENCES pracownik ( id_pracownika );

ALTER TABLE polecenie
    ADD CONSTRAINT polecenie_zadanie_fk FOREIGN KEY ( id_zadania )
        REFERENCES zadanie ( id_zadania );

ALTER TABLE pracownik
    ADD CONSTRAINT pracownik_oddzial_fk FOREIGN KEY ( id_oddzial )
        REFERENCES oddzial ( id_oddzial );

ALTER TABLE przetarg
    ADD CONSTRAINT przetarg_etap_fk FOREIGN KEY ( id_etapu )
        REFERENCES etap ( id_etapu );

ALTER TABLE przetarg
    ADD CONSTRAINT przetarg_oddzial_fk FOREIGN KEY ( id_oddzial )
        REFERENCES oddzial ( id_oddzial );

ALTER TABLE umowa
    ADD CONSTRAINT umowa_przetarg_fk FOREIGN KEY ( id_przetargu )
        REFERENCES przetarg ( id_przetargu );

ALTER TABLE umowa
    ADD CONSTRAINT umowa_wykonawca_fk FOREIGN KEY ( id_wykonawcy )
        REFERENCES wykonawca ( id_wykonawcy );

ALTER TABLE wyjazd
    ADD CONSTRAINT wyjazd_pojazd_fk FOREIGN KEY ( id_pojazdu )
        REFERENCES pojazd ( id_pojazdu );

ALTER TABLE wyjazd
    ADD CONSTRAINT wyjazd_zadanie_fk FOREIGN KEY ( id_zadania )
        REFERENCES zadanie ( id_zadania );
		
/* SEKWENCJE */

CREATE SEQUENCE seq_aneks
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

create sequence seq_Wykonawca
minvalue 1
start with 1
increment by 1
CACHE 10;

alter table Wykonawca
	modify Id_Wykonawcy default seq_Wykonawca.nextval;
	
create sequence seq_Umowa
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Umowa
	modify Id_Umowy default seq_Umowa.nextval;
	
create sequence seq_Przetarg
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Przetarg
	modify Id_Przetargu default seq_Przetarg.nextval;

create sequence seq_Oddzial
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Oddzial
	modify Id_Oddzial default seq_Oddzial.nextval;
	
create sequence seq_Pracownik
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Pracownik
	modify Id_Pracownika default seq_Pracownik.nextval;
	
create sequence seq_Pojazd
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Pojazd
	modify Id_Pojazdu default seq_Pojazd.nextval;
	
create sequence seq_Zadanie
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Zadanie
	modify Id_Zadania default seq_Zadanie.nextval;
	
create sequence seq_Etap
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Etap
	modify Id_Etapu default seq_Etap.nextval;
	
create sequence seq_Droga
start with 1
increment by 1
minvalue 1
CACHE 10;

alter table Droga
	modify Id_Drogi default seq_Droga.nextval;
	
/* WIDOKI */

create or replace view V_Pracownicy_Zarobki as
 select o.Id_Oddzial, o.Nazwa_Oddzialu , 
	
		(select count(pr.plec) 
			from pracownik pr
				join oddzial od on od.Id_Oddzial=pr.Id_Oddzial
				where pr.plec = 'K' 
                and o.Id_Oddzial = od.Id_Oddzial ) as "Ilosc K",
                
		round((select avg(pr.wynagrodzenie) 
			from pracownik pr
				join oddzial od on od.Id_Oddzial=pr.Id_Oddzial
				where pr.plec = 'K' 
                and o.Id_Oddzial = od.Id_Oddzial ),2) as "Srednie zarobki K [PLN]",
                
		(select count(pra.plec) 
			from pracownik pra
				join oddzial odd on odd.Id_Oddzial=pra.Id_Oddzial
				where pra.plec = 'M' 
                and o.Id_Oddzial = odd.Id_Oddzial ) as "Ilosc M",
                
		round((select avg(pr.wynagrodzenie) 
			from pracownik pr
				join oddzial od on od.Id_Oddzial=pr.Id_Oddzial
				where pr.plec = 'M' 
                and o.Id_Oddzial = od.Id_Oddzial ),2)as "Srednie zarobki M  [PLN]",
                
		(select count(pra.plec) 
			from pracownik pra
				join oddzial odd on odd.Id_Oddzial=pra.Id_Oddzial
				where  
                 o.Id_Oddzial = odd.Id_Oddzial ) as "Laczna Ilosc Pracownikow",
		
        round((select avg(pr.wynagrodzenie) 
			from pracownik pr
				join oddzial od on od.Id_Oddzial=pr.Id_Oddzial
				where
                o.Id_Oddzial = od.Id_Oddzial ),2) as "Srednie zarobki Pracownikow  [PLN]"
	from oddzial o 
		join pracownik p on o.Id_Oddzial = p.Id_Oddzial
group by o.Id_Oddzial, o.Nazwa_Oddzialu;

create or replace view V_Ukonczone_Drogi as
select o.Id_Oddzial, o.Nazwa_Oddzialu, 

		(select round(sum(et.dlugosc),3)
			from etap et
				join oddzial od on et.Id_Oddzial=od.Id_Oddzial
				join droga dr on dr.Id_Drogi=et.Id_Drogi
           where dr.Typ_Drogi = 'DK' 
				and od.Id_Oddzial=o.Id_Oddzial) as "Planowana Dlugosc DK",
                
		(select round(sum(ep.dlugosc),3)
			from etap ep
				join oddzial odd on ep.Id_Oddzial=odd.Id_Oddzial
				join droga dg on dg.Id_Drogi=ep.Id_Drogi
           where dg.Typ_Drogi = 'DK' 
				and ep.Stan_Etapu = 'U'
                and odd.Id_Oddzial=o.Id_Oddzial) as "Ukonczone DK",
                
		round((select round(sum(et.dlugosc),3)
			from etap et
				join oddzial od on et.Id_Oddzial=od.Id_Oddzial
				join droga dr on dr.Id_Drogi=et.Id_Drogi
           where dr.Typ_Drogi = 'DK' 
				and et.Stan_Etapu = 'U'
				and od.Id_Oddzial=o.Id_Oddzial)/
                (select round(sum(ep.dlugosc),3)
			from etap ep
				join oddzial odd on ep.Id_Oddzial=odd.Id_Oddzial
				join droga dg on dg.Id_Drogi=ep.Id_Drogi
           where dg.Typ_Drogi = 'DK' 
                and odd.Id_Oddzial=o.Id_Oddzial)*100,2) as "Ukonczone DK [%]",
                
                (select round(sum(et.dlugosc),3)
			from etap et
				join oddzial od on et.Id_Oddzial=od.Id_Oddzial
				join droga dr on dr.Id_Drogi=et.Id_Drogi
           where dr.Typ_Drogi = 'A' 
				and od.Id_Oddzial=o.Id_Oddzial) as "Planowana Dlugosc A",
                
		(select round(sum(ep.dlugosc),3)
			from etap ep
				join oddzial odd on ep.Id_Oddzial=odd.Id_Oddzial
				join droga dg on dg.Id_Drogi=ep.Id_Drogi
           where dg.Typ_Drogi = 'A' 
				and ep.Stan_Etapu = 'U'
                and odd.Id_Oddzial=o.Id_Oddzial) as "Ukonczone A",
                
		round((select round(sum(et.dlugosc),3)
			from etap et
				join oddzial od on et.Id_Oddzial=od.Id_Oddzial
				join droga dr on dr.Id_Drogi=et.Id_Drogi
           where dr.Typ_Drogi = 'A' 
				and et.Stan_Etapu = 'U'
				and od.Id_Oddzial=o.Id_Oddzial)/
                (select round(sum(ep.dlugosc),3)
			from etap ep
				join oddzial odd on ep.Id_Oddzial=odd.Id_Oddzial
				join droga dg on dg.Id_Drogi=ep.Id_Drogi
           where dg.Typ_Drogi = 'A' 
                and odd.Id_Oddzial=o.Id_Oddzial)*100,2) as "Ukonczone A [%]",
                
                (select round(sum(et.dlugosc),3)
			from etap et
				join oddzial od on et.Id_Oddzial=od.Id_Oddzial
				join droga dr on dr.Id_Drogi=et.Id_Drogi
           where dr.Typ_Drogi = 'S' 
				and od.Id_Oddzial=o.Id_Oddzial) as "Planowana Dlugosc S",
                
		(select round(sum(ep.dlugosc),3)
			from etap ep
				join oddzial odd on ep.Id_Oddzial=odd.Id_Oddzial
				join droga dg on dg.Id_Drogi=ep.Id_Drogi
           where dg.Typ_Drogi = 'S' 
				and ep.Stan_Etapu = 'U'
                and odd.Id_Oddzial=o.Id_Oddzial) as "Ukonczone S",
                
		round((select round(sum(et.dlugosc),3)
			from etap et
				join oddzial od on et.Id_Oddzial=od.Id_Oddzial
				join droga dr on dr.Id_Drogi=et.Id_Drogi
           where dr.Typ_Drogi = 'S' 
				and et.Stan_Etapu = 'U'
				and od.Id_Oddzial=o.Id_Oddzial)/
                (select round(sum(ep.dlugosc),3)
			from etap ep
				join oddzial odd on ep.Id_Oddzial=odd.Id_Oddzial
				join droga dg on dg.Id_Drogi=ep.Id_Drogi
           where dg.Typ_Drogi = 'S' 
                and odd.Id_Oddzial=o.Id_Oddzial)*100,2) as "Ukonczone S [%]"
           
	from oddzial o
		join etap e on o.Id_Oddzial=e.Id_Oddzial
        join droga d on d.Id_Drogi=e.Id_Drogi
group by o.Nazwa_Oddzialu, o.Id_Oddzial;

create or replace view V_Przetargi_Umowy as
select o.Id_Oddzial, o.Nazwa_Oddzialu,
			(select count(pr.Id_Przetargu) 
				from Przetarg pr 
				join Oddzial od on od.Id_Oddzial = pr.Id_Oddzial
            where o.Id_Oddzial = od.Id_Oddzial) as "Ilosc przetargow",
            
            (select round(avg((pr.data_zak_przetargu-pr.data_rozp_przetargu)/365),1)
				from przetarg pr
                join Oddzial od on od.Id_Oddzial = pr.Id_Oddzial
            where o.Id_Oddzial = od.Id_Oddzial) as "Sredni czas trwania przetargu [Y]",
            
            (select count(um.Id_Umowy) 
				from Umowa um 
                join Przetarg pr on pr.Id_Przetargu = um.Id_Przetargu
				join Oddzial od on od.Id_Oddzial = pr.Id_Oddzial
            where o.Id_Oddzial = od.Id_Oddzial) as "Ilosc umow",
            
            (select round(avg((um.data_wygasniecia-um.data_podpisania)/365),1)
				from umowa um
                join Przetarg pr on pr.Id_Przetargu = um.Id_Przetargu
                join Oddzial od on od.Id_Oddzial = pr.Id_Oddzial
            where o.Id_Oddzial = od.Id_Oddzial) as "Sredni czas trwania umowy [Y]",
            
            (select round(avg(um.Kwota),2)
				from Umowa um
                join Przetarg pr on pr.Id_Przetargu = um.Id_Przetargu
                join Oddzial od on od.Id_Oddzial = pr.Id_Oddzial
            where o.Id_Oddzial = od.Id_Oddzial) as "Srednia wartosc inwestycji [PLN]",
            
            (select count(wy.Id_Wykonawcy)
				from wykonawca wy
                join Umowa um on um.Id_Wykonawcy = wy.Id_Wykonawcy
                join Przetarg pr on pr.Id_Przetargu = um.Id_Przetargu
                join Oddzial od on od.Id_Oddzial = pr.Id_Oddzial
            where o.Id_Oddzial = od.Id_Oddzial) as "Zaangazowani wykonawcy"
                   
	from Oddzial o
		join przetarg p on p.Id_Oddzial = o.Id_Oddzial
        join umowa u on u.Id_Przetargu = p.Id_Przetargu
        join wykonawca w on w.Id_Wykonawcy = u.Id_Wykonawcy
group by o.Id_Oddzial, o.Nazwa_Oddzialu
order by 1;

create or replace view V_Oddzial_Zestawienie as
select o.Id_Oddzial, o.Nazwa_Oddzialu,
    (select count(po.Id_Pojazdu)
        from Pojazd po
            join Oddzial od on od.Id_Oddzial = po.Id_Oddzial
        where o.Id_Oddzial = od.Id_Oddzial) as "Ilosc pojazdow",
        
    (select count(pra.plec) 
        from pracownik pra
            join oddzial odd on odd.Id_Oddzial=pra.Id_Oddzial
        where o.Id_Oddzial = odd.Id_Oddzial ) as "Ilosc Pracownikow"
        
from Oddzial o
    join Pracownik p on p.Id_Oddzial = o.Id_Oddzial
    join Pojazd j on j.Id_Oddzial = o.Id_Oddzial
group by o.Id_Oddzial, o.Nazwa_Oddzialu
order by 1;

create or replace package opakowanie is
type wiersz is record(
    Id_Wykonawcy NUMBER,
    Wykonawca VARCHAR2(50),
    Laczna_Kwota NUMBER
);
type tablica is table of wiersz;
end;
  

