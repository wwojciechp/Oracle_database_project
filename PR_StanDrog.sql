Create or replace PROCEDURE PR_STAN_DROG
as 
    v_ilosc_s NUMBER;
    v_ilosc_dk NUMBER;
    v_ilosc_a NUMBER;
begin

    SELECT count(id_drogi) into v_ilosc_dk 
        from Droga 
            where typ_drogi = 'DK';
            
    SELECT count(id_drogi) into v_ilosc_a 
        from Droga 
            where typ_drogi = 'A';
            
    SELECT count(id_drogi) into v_ilosc_s 
        from Droga 
            where typ_drogi = 'S';
    
    dbms_output.put_line('Ilosc drog DK ' ||  v_ilosc_dk);
    
    dbms_output.put_line('Ilosc drog A ' || v_ilosc_a);
    
    dbms_output.put_line('Ilosc drog S ' || v_ilosc_s);

end;

--set serveroutput on;