create TRIGGER TR_WYNAGRODZENIE
BEFORE INSERT OR UPDATE OF Wynagrodzenie
ON Pracownik FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.Wynagrodzenie < 0 
            THEN
            raise_application_error(-20001, 'Kwota nie może być ujemna');
        ELSIF
            :NEW.Wynagrodzenie = 0 
            THEN
            raise_application_error(-20001, 'Kwota nie może być równa 0');
        ELSIF :NEW.Wynagrodzenie < 2400
            THEN
            raise_application_error(-20001, 'Minimalne wynagrodzenie to 2400');
        END IF;
    END IF;
    IF UPDATING THEN
        IF :NEW.Wynagrodzenie < 0 
            THEN
            raise_application_error(-20001, 'Kwota nie może być ujemna');
        ELSIF
            :NEW.Wynagrodzenie = 0 
            THEN
            raise_application_error(-20001, 'Kwota nie może być równa 0');
        ELSIF :NEW.Wynagrodzenie < 2400
            THEN
            raise_application_error(-20001, 'Minimalne wynagrodzenie to 2400');
        ELSIF :NEW.Wynagrodzenie = :OLD.Wynagrodzenie
            THEN
            raise_application_error(-20001, 'Nie dokonano zmian w wynagrodzeniu!!!');
        END IF;
    END IF;
END;