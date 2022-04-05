create or replace FUNCTION FN_SREDNI_ODCINEK
		(v_nazwa in VARCHAR2)
		RETURN FLOAT
	IS
		v_dlugosc FLOAT;
		v_ilosc NUMBER;
		v_wynik FLOAT;
begin
	SELECT count(*) into v_ilosc FROM etap e 
		join droga d on e.id_drogi=d.id_drogi
			WHERE d.nazwa_drogi = v_nazwa;

	SELECT SUM(e.dlugosc) into v_dlugosc FROM etap e 
		join droga d on e.id_drogi=d.id_drogi
			WHERE d.nazwa_drogi = v_nazwa;

	SELECT round( v_dlugosc/v_ilosc,3) as Srednia 
		into v_wynik from dual;
		
	return v_wynik;
end;