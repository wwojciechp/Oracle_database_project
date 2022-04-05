CREATE OR REPLACE FUNCTION FN_POLECENIE(v_id_zadania IN INTEGER, v_id_pracownika IN INTEGER)
RETURN VARCHAR2
IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_variable1 CHAR(50);
    v_variable2 CHAR(50);  

BEGIN

    SET TRANSACTION READ WRITE;
        
    SELECT Typ_Zadania INTO v_variable1 FROM Zadanie WHERE Id_Zadania = v_id_zadania;
    SELECT Stanowisko INTO v_variable2 FROM Pracownik WHERE Id_Pracownika = v_id_pracownika;
       
    INSERT INTO Polecenie(Id_Zadania, Id_Pracownika) VALUES(v_id_zadania, v_id_pracownika);
    
    
    IF (v_variable1 like '%N%' AND v_variable2 like '%Kierowca%' )
    
    THEN
    
    COMMIT WRITE;

    RETURN 'Zatwierdzono polecenie'; 
        
    ELSE
    
    ROLLBACK;
 
    RETURN 'Nie zatwierdzono polecenia';
        
    END IF ;
   
END ;