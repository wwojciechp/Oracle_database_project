CREATE or replace  PROCEDURE PR_Zmiana_W( v_operator VARCHAR2,v_edycja NUMBER,v_pracownik NUMBER )
AS
v_variable NUMBER;
BEGIN


    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; 
    
    IF v_operator  = '*'
       then 
        UPDATE Pracownik
            SET Wynagrodzenie = Wynagrodzenie * v_edycja
                WHERE v_pracownik = Id_Pracownika;
        
    ELSE IF v_operator  = '-' then
       
        UPDATE Pracownik
            SET Wynagrodzenie = Wynagrodzenie - v_edycja
                WHERE v_pracownik = Id_Pracownika;
       
    ELSE IF v_operator  = '+' then
        
        UPDATE Pracownik
            SET Wynagrodzenie = Wynagrodzenie + v_edycja
                WHERE v_pracownik = Id_Pracownika;
        
    ELSE
        
       raise_application_error(-20001, 'Niepoprawne dane');
    end if;
    end if; 
    end if;
       SELECT Wynagrodzenie into v_variable FROM Pracownik WHERE Id_Pracownika = v_pracownik;
    IF (v_variable<2500) then
     
        raise_application_error(-20001, 'Zbyt male wynagrodzenie!!!');
        ROLLBACK;
           
    END if;
    COMMIT WRITE BATCH;
END;


--set serveroutput on;