CREATE TRIGGER TR_Aneks
    AFTER UPDATE OR DELETE ON Umowa
        FOR EACH ROW
        DECLARE 
    BEGIN
        IF UPDATING THEN
             INSERT INTO Aneks
                (Id_Aneks
                ,Id_Umowy
                ,Data_Modyfikacji
                ,Zmiana_Kwoty
                ,Zmiana_Terminu
                ,Stara_Kwota
                ,Stary_Termin
                )
                VALUES
                (SEQ_ANEKS.nextval
                ,:OLD.Id_Umowy
                ,SYSDATE
                ,:NEW.Kwota
                ,:NEW.Data_Wygasniecia
                ,:OLD.Kwota
                ,:OLD.Data_Wygasniecia
                );
        END IF;
        IF DELETING THEN
            DELETE FROM Aneks
            WHERE Id_Umowy = :OLD.Id_Umowy;
          END IF;
	END;
    